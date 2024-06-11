import { Factiii, FactiiiGoalType, Upload } from "@prisma/client";
import { Request, Response } from "express";
import prisma from "../clients/prisma";
import { getS3ObjectURL } from "../clients/s3";
import {
  getSpaceRuleIds,
  getUnauthorizedFactiiiIds,
  getUnauthorizedSpaceIds,
  getUnauthorizedUserIds,
} from "../helpers/moderation";
import { PostFactiiiTag, processFactiiis } from "../helpers/processFactiiis";
import stringToSlug from "../helpers/stringToSlug";
import AppError from "../utilities/AppError";
import { returnPostObjectDto } from "./posts.controller";

export const getFactiiiPreferences = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;

  //TODO make an admin job to check if users have factiiis in their preferences that they do not have access to

  const preferences = await prisma.userPreference.findUnique({
    where: {
      userId,
    },
    select: {
      factiiis: {
        select: {
          factiii: {
            select: {
              id: true,
              name: true,
              slug: true,
              requirements: true,
              avatar: {
                select: {
                  key: true,
                },
              },
              space: {
                select: {
                  slug: true,
                },
              },
            },
          },
        },
      },
    },
  });

  if (!preferences) {
    return res.send({
      factiiis: [],
    });
  }

  return res.send({
    factiiis: preferences.factiiis.map((factiii) => ({
      id: factiii.factiii.id,
      name: factiii.factiii.name,
      factiiiSlug: factiii.factiii.slug,
      spaceSlug: factiii.factiii.space?.slug,
      requirements: factiii.factiii.requirements,
      avatar: getS3ObjectURL(factiii.factiii.avatar?.key),
    })),
  });
};

export const putFactiiiPreferences = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const factiiiIds = req.body.factiiiIds;

  const unauthorizedFactiiiIds = await getUnauthorizedFactiiiIds(userId);
  const unauthorizedSpaceIds = await getUnauthorizedSpaceIds(userId);

  const factiiis = await prisma.factiii.findMany({
    where: {
      //moderation
      id: {
        notIn: unauthorizedFactiiiIds,
        in: factiiiIds, //query
      },
    },
    select: {
      id: true,
      name: true,
    },
  });

  // TODO The user sent a factiiiId they do not have access to, suggest logging this
  if (factiiis.length !== factiiiIds.length) {
    throw new AppError("Invalid factiiis, Try again.");
  }

  //delete all entries
  await prisma.factiiiPreferences.deleteMany({
    where: {
      userPreferenceUserId: userId,
    },
  });

  let index = factiiis.length;
  for (const factiii of factiiis) {
    await prisma.factiiiPreferences.create({
      data: {
        factiiiId: factiii.id,
        userPreferenceUserId: userId,
        orderNumber: index,
      },
    });
    index--;
  }

  return res.send({
    status: "success",
  });
};

export const getInitialItems = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;

  const [userFacttiiis, factiii] = await Promise.all([
    //userFacttiiis
    prisma.factiiiPreferences.findMany({
      where: {
        userPreferenceUserId: userId,
      },
      take: 10,
      select: {
        factiii: {
          select: {
            id: true,
          },
        },
      },
    }),
    //factiii
    prisma.space.findUniqueOrThrow({
      where: {
        slug: "factiii",
      },
      select: {
        id: true,
        factiiis: {
          select: {
            id: true,
          },
        },
      },
    }),
  ]);

  const factiiiIds = [
    ...new Set(
      factiii.factiiis
        .map((factiii) => factiii.id)
        .concat(userFacttiiis.map((factiii) => factiii.factiii.id)),
    ),
  ];

  const factiiis = await prisma.factiii.findMany({
    where: {
      id: {
        in: factiiiIds,
      },
    },
    take: 10,
    select: {
      id: true,
      name: true,
      slug: true,
      requirements: true,
      status: true,
      createdAt: true,
      updatedAt: true,
      space: {
        select: {
          slug: true,
        },
      },
      avatar: {
        select: {
          key: true,
        },
      },
      user: {
        select: {
          username: true,
        },
      },
    },
  });

  const myFactiiis = await prisma.postFactiii.findMany({
    where: {
      userId,
    },
    take: 10,
    select: {
      id: true,
      anonymous: true,
      data: true,
      factiiiId: true,
      spaceTimes: true,
    },
  });

  const remappedFactiiis = factiiis.map((factiii) => ({
    id: factiii.id,
    name: factiii.name,
    slug: factiii.slug,
    factiiiSlug: factiii.slug,
    spaceSlug: factiii.space?.slug,
    status: factiii.status,
    avatar: getS3ObjectURL(factiii.avatar?.key),
    requirements: factiii.requirements,
    username: factiii.user.username,
    createdAt: factiii.createdAt,
    updatedAt: factiii.updatedAt,
    postFactiiis: [
      {
        data: myFactiiis?.find(
          (factiiiPost) => factiiiPost.factiiiId === factiii.id,
        )?.data,
        spaceTimes: myFactiiis?.find(
          (factiiiPost) => factiiiPost.factiiiId === factiii.id,
        )?.spaceTimes,
        anonymous:
          myFactiiis?.find(
            (factiiiPost) => factiiiPost.factiiiId === factiii.id,
          )?.anonymous ?? false,
      },
    ],
  }));

  return res.send({
    factiiiList: remappedFactiiis,
  });
};

export const getFactiiiItems = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const factiiiIds = String(req.query.factiiiIds)
    .split(",")
    .map(Number)
    .filter(Boolean);
  const factiiiName = String(req.query.factiiiName);
  const factiiiSlug = String(req.query.factiiiSlug);
  const spaceSlug = String(req.query.spaceSlug);
  const skipIds = String(req.query.skipIds)
    .split(",")
    .map(Number)
    .filter(Boolean);

  const [unauthorizedFactiiiIds] = await Promise.all([
    //unauthorizedFactiiiIds
    getUnauthorizedFactiiiIds(userId),
  ]);

  const factiiis = await prisma.factiii.findMany({
    where: {
      //moderation
      id: {
        notIn: unauthorizedFactiiiIds,
      },
      //query
      ...(factiiiIds.length > 0 && {
        id: {
          in: factiiiIds,
        },
      }),
      ...(factiiiName !== "undefined" && {
        name: factiiiName,
      }),
      ...(factiiiSlug !== "undefined" && {
        slug: factiiiSlug,
      }),
      ...(spaceSlug !== "undefined" && {
        space: {
          slug: spaceSlug,
        },
      }),
      ...(skipIds.length > 0 && {
        id: {
          notIn: skipIds,
        },
      }),
    },
    select: {
      id: true,
      name: true,
      slug: true,
      requirements: true,
      status: true,
      space: {
        select: {
          slug: true,
        },
      },
      avatar: {
        select: {
          key: true,
        },
      },
      user: {
        select: {
          username: true,
        },
      },
    },
  });

  const remappedFactiiis = factiiis.map((factiii) => ({
    id: factiii.id,
    name: factiii.name,
    username: factiii.user.username,
    slug: factiii.slug,
    spaceSlug: factiii.space?.slug,
    status: factiii.status,
    avatar: getS3ObjectURL(factiii.avatar?.key),
    requirements: factiii.requirements,
  }));

  return res.send({
    factiiiList: remappedFactiiis,
  });
};

//This is a list of factiiis the user can tag
export const myFactiiiTags = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { page = 0 } = req.query;
  const { postId } = req.params;

  const unauthorizedSpaceIds = await getUnauthorizedSpaceIds(userId);

  const [
    unauthorizedFactiiiIds,
    checkPost,
    factiiiPreferences,
    factiii,
    spaces,
  ] = await Promise.all([
    //unauthorizedFactiiiIds
    getUnauthorizedFactiiiIds(userId),
    //checkPost
    prisma.post.findFirst({
      where: {
        //moderation
        OR: [
          {
            spaceId: { notIn: unauthorizedSpaceIds },
          },
          {
            spaceId: null,
          },
        ],
        //query
        uuid:
          postId === "tempId" ? "00000000-0000-0000-0000-000000000000" : postId,
      },
      select: {
        id: true,
      },
    }),
    //factiiiPreferences
    prisma.factiiiPreferences.findMany({
      where: {
        userPreferenceUserId: userId,
      },
      select: {
        factiiiId: true,
        orderNumber: true,
      },
    }),
    //factiii
    prisma.space.findUniqueOrThrow({
      where: {
        slug: "factiii",
      },
      select: {
        id: true,
        name: true,
      },
    }),
    //spaces
    prisma.spaceMember.findMany({
      where: {
        userId,
      },
      select: {
        spaceId: true,
      },
    }),
  ]);

  //newPost sends a postId of 'tempId' to the server. Do not need to check if a newPost has an id since it doesn't.
  if (postId !== "tempId") {
    if (!checkPost) throw new AppError("No post found. Try again.");
  }
  const [factiiis, myFactiiis] = await Promise.all([
    //factiiis
    prisma.factiii.findMany({
      where: {
        //moderation
        id: {
          notIn: unauthorizedFactiiiIds,
        },
        //query
        status: "APPROVED",
        //User Defined set
        ...(factiiiPreferences.length > 0 && {
          id: {
            in: factiiiPreferences.map((factiii) => factiii.factiiiId),
          },
        }),
        //Default set
        ...(factiiiPreferences.length === 0 && {
          OR: [
            {
              spaceId: {
                in: spaces.map((s) => s.spaceId),
              },
            },
            {
              userId,
            },
            {
              spaceId: factiii.id,
            },
          ],
        }),
      },
      take: 10,
      skip: 10 * Number(page),
      select: {
        id: true,
        name: true,
        avatar: { select: { key: true } },
        requirements: true,
      },
    }),
    //myFactiiis
    prisma.postFactiii.findMany({
      where: {
        postId: postId === "tempId" ? 0 : checkPost?.id,
        userId,
      },
      select: {
        id: true,
        anonymous: true,
        data: true,
        factiiiId: true,
        spaceTimes: true,
        uploads: true,
      },
    }),
  ]);

  const factiiiOrderMap = new Map(
    factiiiPreferences.map((pref) => [pref.factiiiId, pref.orderNumber]),
  );

  // Sort factiiis based on the order defined in factiiiPreferences
  factiiis.sort((a, b) => {
    return (factiiiOrderMap.get(a.id) || 0) - (factiiiOrderMap.get(b.id) || 0);
  });

  // Get factiii ids
  const userTagIds = myFactiiis?.map((factiii) => factiii.factiiiId) || [];

  //mark factiiis user has already tagged
  const transformedFactiiis = factiiis.map((factiii) => {
    return {
      id: factiii.id,
      name: factiii.name,
      avatar: getS3ObjectURL(factiii.avatar?.key),
      requirements: factiii.requirements,
      isSelected: userTagIds.includes(factiii.id),
      postFactiii: {
        data: myFactiiis?.find(
          (factiiiPost) => factiiiPost.factiiiId === factiii.id,
        )?.data,
        spaceTimes: myFactiiis?.find(
          (factiiiPost) => factiiiPost.factiiiId === factiii.id,
        )?.spaceTimes,
        anonymous:
          myFactiiis?.find(
            (factiiiPost) => factiiiPost.factiiiId === factiii.id,
          )?.anonymous ?? false,
        uploads: myFactiiis
          ?.find((factiiiPost) => factiiiPost.factiiiId === factiii.id)
          ?.uploads.map((upload) => ({
            id: upload.id,
            url: getS3ObjectURL(upload.key),
            type: upload.type,
            name: upload.name,
            size: upload.size,
          })),
      },
    };
  });

  return res.send({
    factiiiTags: transformedFactiiis,
  });
};

//TODO verify the addFactiiis type PostFactiii[] matches exactly to the front end addFactiiiis type PostFactiii[]
export const tagPost = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { postId } = req.params;
  const {
    addFactiiis,
    removeFactiiiIds,
    attachments,
  }: {
    addFactiiis: PostFactiiiTag[];
    removeFactiiiIds: number[];
    attachments: Upload[];
  } = req.body;

  const checkPost = await prisma.post.findUniqueOrThrow({
    where: {
      uuid: postId,
    },
    select: {
      id: true,
      userId: true,
    },
  });

  processFactiiis(
    userId,
    { id: checkPost.id, userId: checkPost.userId },
    addFactiiis,
    removeFactiiiIds,
  );

  if (attachments && attachments.length > 0) {
    const uploadsToConnect = await Promise.all(
      attachments.map(async (x: { id: string }) => {
        const attachmentExists = await prisma.upload.findUnique({
          where: { id: x.id },
          select: { id: true },
        });
        return attachmentExists ? { id: x.id } : null;
      }),
    );

    // Filter out any null values to ensure we only try to connect existing uploads
    const validUploadsToConnect = uploadsToConnect.filter(
      (upload): upload is { id: string } => upload !== null,
    );

    // Assuming checkPost.id is the ID of the post you want to update
    if (validUploadsToConnect.length > 0) {
      await prisma.post.update({
        where: { id: checkPost.id },
        data: {
          uploads: {
            connect: validUploadsToConnect,
          },
        },
      });
    }
  }

  return res.send({
    status: "ok",
  });
};

export const getFactiiiQuery = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { factiiiQuery } = req.params as { factiiiQuery: string };
  const { page = 0, type = "trending" } = req.query;

  if (!factiiiQuery) throw new AppError("Factiii not found");

  const unauthorizedFactiiiIds = await getUnauthorizedFactiiiIds(userId);

  const rootFactiii = await prisma.factiii.findFirst({
    where: {
      //moderation
      id: {
        notIn: unauthorizedFactiiiIds,
      },
      //query
      slug: {
        equals: stringToSlug(factiiiQuery.toString()),
        mode: "insensitive",
      },
      requirements: {
        hasSome: ["NO_POST_DUPLICATES", "NONE"],
      },
    },
    select: {
      id: true,
    },
  });

  if (!rootFactiii) throw new Error("Factiii not found");

  type FactiiiGroup = { factiii_group: number[] };
  const factiiiGroups: FactiiiGroup[] = await prisma.$queryRaw<FactiiiGroup[]>`
    WITH factiii_groups AS (
      SELECT
        pf."postId",
        ARRAY_AGG(DISTINCT f.id ORDER BY f.id) AS factiii_group
      FROM
        "PostFactiii" pf
        JOIN "Factiii" f ON pf."factiiiId" = f.id
      WHERE
        f.id <> ALL (ARRAY[${unauthorizedFactiiiIds.join("::bigint,")}::bigint])
        AND f.requirements && ARRAY['NO_POST_DUPLICATES', 'NONE']::"FactiiiRequirement"[]
        AND EXISTS (
          SELECT 1
          FROM "PostFactiii" pf2
          WHERE pf2."postId" = pf."postId"
            AND pf2."factiiiId" = ${rootFactiii.id}
        )
      GROUP BY pf."postId"
    ),
    distinct_factiii_groups AS (
      SELECT DISTINCT
        factiii_group
      FROM
        factiii_groups
    ),
    ranked_factiii_groups AS (
      SELECT
        factiii_group,
        DENSE_RANK() OVER (
      ORDER BY 
        ${
          type === "new"
            ? 'MAX(p."createdAt") DESC, p.id DESC'
            : type === "trending"
              ? 'MAX(p."trendingRank") DESC, p.id DESC'
              : 'MAX(p."voteCount") DESC, p.id DESC'
        }
    ) AS rank
      FROM
        distinct_factiii_groups
        JOIN "PostFactiii" pf ON ARRAY[pf."factiiiId"] <@ factiii_group
        JOIN "Post" p ON pf."postId" = p.id
      GROUP BY factiii_group
    )
    SELECT
      factiii_group
    FROM
      ranked_factiii_groups
    WHERE
      rank > ${10 * Number(page)}
    ORDER BY
      rank
    LIMIT
      10;
    `;

  // Convert the result to an array of arrays of factiiiIds
  const processedFactiiiGroups = factiiiGroups.map(
    (group) => group.factiii_group,
  );
  // Move the root factiii to the front of the array if it exists
  const rootFactiiiGroupIndex = processedFactiiiGroups.findIndex(
    (group) => group.length === 1 && group.includes(rootFactiii.id),
  );
  if (rootFactiiiGroupIndex !== -1) {
    processedFactiiiGroups.splice(rootFactiiiGroupIndex, 1);
    processedFactiiiGroups.unshift([rootFactiii.id]);
  }

  return res.send({
    rootFactiiiId: rootFactiii.id,
    factiiiGroups: processedFactiiiGroups,
  });
};

export const getSourceItem = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { name } = req.body;

  const unauthorizedFactiiiIds = await getUnauthorizedFactiiiIds(userId);

  const search = await prisma.factiii.findMany({
    where: {
      //moderation
      id: {
        notIn: unauthorizedFactiiiIds,
      },
      //query
      requirements: {
        hasSome: [
          "ANONYMOUS_SOURCE",
          "ENTERPRISE_SOURCE",
          "HUMAN_SOURCE",
          "GOVERNMENT_SOURCE",
        ],
      },
      name: {
        contains: name,
        mode: "insensitive",
      },
    },
    take: 5,
    select: {
      name: true,
      requirements: true,
      id: true,
    },
  });

  return res.send({
    results: search,
  });
};

export const getFactiiiPosts = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { page = 0, type = "trending" } = req.query;
  const factiiiIds =
    typeof req.query.factiiiIds === "string"
      ? req.query.factiiiIds.split(",").map((id) => parseInt(id))
      : [];

  const [
    unauthorizedSpaceIds,
    spaceRuleIds,
    unauthorizedUserIds,
    unauthorizedFactiiiIds,
  ] = await Promise.all([
    getUnauthorizedSpaceIds(userId),
    getSpaceRuleIds(userId),
    getUnauthorizedUserIds(userId),
    getUnauthorizedFactiiiIds(userId),
  ]);

  const postIds = await prisma.post.findMany({
    where: {
      //Moderation
      OR: [
        {
          spaceId: {
            notIn: unauthorizedSpaceIds,
          },
        },
        {
          spaceId: null,
        },
      ],
      // Query
      AND: factiiiIds.map(
        (factiiiId) => ({
          factiiis: {
            some: {
              factiiiId: factiiiId,
            },
          },
        }),
        {
          NOT: {
            userId: {
              in: unauthorizedUserIds,
            },
          },
        },
      ),
    },
    select: {
      id: true,
    },
    ...(type === "new" && {
      orderBy: [{ createdAt: "desc" }, { id: "desc" }],
    }),
    ...(type === "trending" && {
      orderBy: [{ trendingRank: "desc" }, { id: "desc" }],
    }),
    ...(type === "popular" && {
      orderBy: [{ voteCount: "desc" }, { id: "desc" }],
    }),
    skip: 10 * Number(page),
    take: 10,
  });

  //These are the old queires and are very complicated. I am keeping to reference later.
  // let postIds: { id: number }[];
  // if (factiiiIds.length === 1) {
  //   const queryResult: { id: number }[] = await prisma.$queryRaw`
  //       SELECT p.id
  //       FROM "Post" p
  //       JOIN (
  //           SELECT pf."postId"
  //           FROM "PostFactiii" pf
  //           JOIN "Factiii" f ON pf."factiiiId" = f.id
  //           WHERE 'NO_POST_DUPLICATES' = ANY(f.requirements) OR 'NONE' = ANY(f.requirements)
  //           GROUP BY pf."postId"
  //           HAVING COUNT(*) = 1 AND MAX(pf."factiiiId") = ${Number(factiiiIds[0])}::integer
  //       ) subquery ON p.id = subquery."postId"
  //       WHERE NOT (p."spaceId"::text = ANY(${unauthorizedSpaceIds.map((id) => `'${id}'::text`)})) OR p."spaceId" IS NULL OR p."status" = 'PRIVATE'
  //       ORDER BY
  //       ${
  //         type === "new"
  //           ? 'MAX(p."createdAt") DESC, p.id DESC'
  //           : type === "trending"
  //             ? 'MAX(p."trendingRank") DESC, p.id DESC'
  //             : 'MAX(p."voteCount") DESC, p.id DESC'
  //       }
  //       OFFSET ${10 * Number(page)}
  //       LIMIT 10;
  //   `;
  //   postIds = queryResult.map((item) => ({ id: item.id }));
  // } else {
  //   // Get posts that have the factiiiId and the refFactiiiId
  //   postIds = await prisma.post.findMany({
  //     where: {
  //       //Moderation
  //       OR: [
  //         {
  //           spaceId: {
  //             notIn: unauthorizedSpaceIds,
  //           },
  //         },
  //         {
  //           spaceId: null,
  //         },
  //       ],
  //       // Query
  //       AND: factiiiIds.map((factiiiId) => ({
  //         factiiis: {
  //           some: {
  //             factiiiId: factiiiId,
  //           },
  //         },
  //       })),
  //     },
  //     select: {
  //       id: true,
  //     },
  //     ...(type === "new" && {
  //       orderBy: [{ createdAt: "desc" }, { id: "desc" }],
  //     }),
  //     ...(type === "trending" && {
  //       orderBy: [{ trendingRank: "desc" }, { id: "desc" }],
  //     }),
  //     ...(type === "popular" && {
  //       orderBy: [{ voteCount: "desc" }, { id: "desc" }],
  //     }),
  //     skip: 10 * Number(page),
  //     take: 10,
  //   });
  // }

  const posts = await Promise.all(
    postIds.map(
      async (item) =>
        await returnPostObjectDto(
          item.id,
          userId,
          unauthorizedUserIds,
          unauthorizedFactiiiIds,
          spaceRuleIds,
        ),
    ),
  );

  return res.send({
    posts,
  });
};

export const getFactiiis = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { slug, type } = req.params;
  const { page = 0 } = req.query;

  const unauthorizedFactiiiIds = await getUnauthorizedFactiiiIds(userId);

  const factiiis = await prisma.factiii.findMany({
    where: {
      id: {
        notIn: unauthorizedFactiiiIds,
      },
      ...(type === "SPACE"
        ? {
            space: {
              slug,
            },
          }
        : {}),
      ...(type === "USER"
        ? {
            user: {
              username: slug,
            },
          }
        : {}),
    },
    take: 10,
    skip: 10 * Number(page),
    orderBy: {
      createdAt: "desc",
    },
    select: {
      id: true,
    },
  });

  const factiiiIds = factiiis.map((factiii) => factiii.id);

  res.send({
    factiiiIds,
  });
};

export const addFactiii = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { factiiiName, types, spaceSlug, factiiiRequirements } = req.body;

  const checkSpace = await prisma.space.findFirst({
    where: {
      id: {
        notIn: await getUnauthorizedUserIds(userId),
      },
      ...(spaceSlug && {
        slug: spaceSlug,
      }),
      members: {
        some: {
          userId,
          roles: {
            hasSome: ["OWNER"],
          },
        },
      },
    },
    select: {
      id: true,
    },
  });
  if (!checkSpace)
    throw new AppError("You do not have permissions to make a factiii.");

  const checkFactiii = await prisma.factiii.findFirst({
    where: {
      slug: stringToSlug(factiiiName),
      spaceId: checkSpace.id,
    },
    select: {
      id: true,
    },
  });

  if (checkFactiii)
    throw new AppError("A factiii with this name already exists.");

  const newFactiii = await prisma.factiii.create({
    data: {
      name: factiiiName as string,
      slug: stringToSlug(factiiiName),
      types,
      requirements: factiiiRequirements,
      ...(spaceSlug && {
        space: {
          connect: {
            id: checkSpace.id,
          },
        },
      }),
      user: {
        connect: {
          id: userId,
        },
      },
    },
    select: {
      id: true,
      name: true,
      user: {
        select: {
          username: true,
        },
      },
      description: true,
      slug: true,
      status: true,
      types: true,
      avatar: {
        select: {
          key: true,
        },
      },
      requirements: true,
      space: {
        select: {
          slug: true,
        },
      },
    },
  });

  return res.send({
    id: newFactiii.id,
    name: newFactiii.name,
    username: newFactiii.user.username,
    description: newFactiii.description,
    slug: newFactiii.slug,
    factiiiSlug: newFactiii.slug,
    status: newFactiii.status,
    types: newFactiii.types,
    avatar: getS3ObjectURL(newFactiii.avatar?.key),
    requirements: newFactiii.requirements,
    postFactiiis: [],
    spaceSlug: newFactiii.space?.slug,
  });
};

export const deleteFactiii = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { factiiiId, space_slug } = req.params;
  const id = parseInt(factiiiId);

  const check = await prisma.factiii.findUnique({
    where: {
      id: id,
      ...(space_slug
        ? {
            space: {
              slug: space_slug,
              members: {
                some: {
                  userId,
                  roles: {
                    hasSome: ["OWNER"],
                  },
                },
              },
            },
          }
        : {}),
    },
    select: {
      id: true,
    },
  });

  if (!check)
    throw new AppError("No factiii found or you do not have permissions.");

  await prisma.factiii.update({
    where: {
      id: check.id,
    },
    data: {
      status: "RETIRED",
    },
  });

  return res.send({
    success: true,
  });
};

export const reactivateFactiii = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { factiiiId, space_slug } = req.params;
  const id = parseInt(factiiiId);

  const check = await prisma.factiii.findUnique({
    where: {
      id: id,
      ...(space_slug
        ? {
            space: {
              slug: space_slug,
              members: {
                some: {
                  userId,
                  roles: {
                    hasSome: ["OWNER"],
                  },
                },
              },
            },
          }
        : {}),
    },
    select: {
      id: true,
    },
  });

  if (!check)
    throw new AppError("No factiii found or you do not have permissions.");

  await prisma.factiii.update({
    where: {
      id: check.id,
    },
    data: {
      status: "APPROVED",
    },
  });

  return res.send({
    success: true,
  });
};

export const getGoals = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { page = 0 } = req.query;

  const goals = await prisma.factiiiGoal.findMany({
    where: {
      userId,
    },
    take: 10,
    skip: 10 * Number(page),
    select: {
      id: true,
      factiiiId: true,
      factiii: {
        select: {
          name: true,
          avatar: {
            select: {
              key: true,
            },
          },
        },
      },
      type: true,
      data: true,
    },
  });

  return res.send({
    goals: goals.map((goal) => ({
      id: goal.id,
      name: goal.factiii.name,
      avatar: getS3ObjectURL(goal.factiii.avatar?.key),
      factiiiId: goal.factiiiId,
      type: goal.type,
      data: goal.data,
    })),
  });
};

type Goal = {
  id: number;
  name: string;
  avatar: string;
  factiiiId: number;
  type: FactiiiGoalType;
  data: string;
};

export const updateGoals = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const goals: Goal[] = req.body.goals;

  if (!goals || goals.length === 0) {
    return res.status(400).json({ message: "No goals provided" });
  }

  for (const goal of goals) {
    await prisma.factiiiGoal.upsert({
      where: {
        factiiiId_userId_type: {
          factiiiId: goal.factiiiId,
          userId,
          type: goal.type,
        },
      },
      update: {
        data: goal.data,
      },
      create: {
        userId: userId,
        factiiiId: goal.factiiiId,
        type: goal.type,
        data: goal.data,
      },
    });
  }

  return res.send({});
};

export const pinFactiii = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { factiiiId } = req.params;
  const { spaceSlug, type, target } = req.body;
  let isPinned;

  if (type === "SPACE") {
    const checkSpace = await prisma.space.findFirst({
      where: {
        slug: spaceSlug,
      },
      select: {
        id: true,
        slug: true,
        members: {
          where: {
            roles: {
              has: "OWNER",
            },
          },
          select: {
            userId: true,
          },
        },
        pinnedFactiiis: {
          select: {
            id: true,
          },
        },
      },
    });

    if (!checkSpace)
      throw new AppError(
        "You do not have permissions to unpin a factiii or the factiii does not exist.",
      );

    const spaceMember = await prisma.spaceMember.findUnique({
      where: {
        userId_spaceId: {
          spaceId: checkSpace.id,
          userId,
        },
      },
      select: {
        pinnedFactiiis: true,
      },
    });

    if (!spaceMember) throw new AppError("You are not a member of this space.");

    const isOwner =
      target === "SPACE" &&
      checkSpace.members.some((member) => member.userId === userId);

    if (isOwner) {
      isPinned = checkSpace.pinnedFactiiis.some(
        (f) => f.id === parseInt(factiiiId),
      );

      await prisma.space.update({
        where: {
          id: checkSpace.id,
        },
        data: {
          pinnedFactiiis: {
            [isPinned ? "disconnect" : "connect"]: {
              id: parseInt(factiiiId),
            },
          },
        },
      });
    } else {
      isPinned = spaceMember.pinnedFactiiis.some(
        (f) => f.id === parseInt(factiiiId),
      );
      if (checkSpace.pinnedFactiiis.some((f) => f.id === parseInt(factiiiId)))
        throw new AppError(
          isPinned
            ? "This factiii is pinned by the owner and cannot be unpinned."
            : "This factiii is already pinned by the owner",
        );

      await prisma.spaceMember.update({
        where: {
          userId_spaceId: {
            userId,
            spaceId: checkSpace.id,
          },
        },
        data: {
          pinnedFactiiis: {
            [isPinned ? "disconnect" : "connect"]: {
              id: parseInt(factiiiId),
            },
          },
        },
      });
    }
  } else if (type === "USER") {
    const userFacttiiis = await prisma.user.findFirst({
      where: {
        id: userId,
      },
      select: {
        pinnedFactiiis: true,
      },
    });

    isPinned = userFacttiiis?.pinnedFactiiis.some(
      (f) => f.id === parseInt(factiiiId),
    );

    await prisma.user.update({
      where: {
        id: userId,
      },
      data: {
        pinnedFactiiis: {
          [isPinned ? "disconnect" : "connect"]: {
            id: parseInt(factiiiId),
          },
        },
      },
    });
  }

  return res.send({
    status: isPinned ? "UNPINNED" : "PINNED",
  });
};

export const getAllFactiiis = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { spaceSlug } = req.params;
  const { page = 0 } = req.query;
  const unauthorizedFactiiiIds = await getUnauthorizedFactiiiIds(userId);

  const factiiis = await prisma.$queryRaw<Factiii[]>`
    SELECT f.*
        FROM "Factiii" f
        LEFT JOIN "Space" s ON f."spaceId" = s.id
        WHERE f."userId" = ${userId}
        OR f."spaceId" IN (
            SELECT s.id
            FROM "Space" s
            JOIN "SpaceMember" sm ON sm."spaceId" = s.id
            WHERE sm."userId" = ${userId}
        ) OR f."spaceId" = 1
        AND f.id NOT IN (SELECT unnest(ARRAY[${unauthorizedFactiiiIds.join(", ")}]::int[]))
        ORDER BY 
            CASE 
                WHEN s."slug" = ${spaceSlug} THEN 0
                ELSE 1
            END,
            f.id
        LIMIT 10
        OFFSET ${10 * Number(page)};
    `;

  res.send({
    factiiiIds: factiiis.map((f) => f.id),
  });
};
