import { Request, Response } from "express";
import prisma from "../clients/prisma";
import { getS3ObjectURL } from "../clients/s3";
import {
  getSpaceRuleIds,
  getUnauthorizedFactiiiIds,
  getUnauthorizedSpaceIds,
  getUnauthorizedUserIds,
} from "../helpers/moderation";
import { returnPostObjectDto } from "./posts.controller";
import { returnSpaceCardDto } from "./spaces.controller";
import { returnUserObjectDto } from "./users.controller";

export const searchUsers = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { page = 0 } = req.query;
  const userIds = String(req.query.users)
    .split(",")
    .map(Number)
    .filter(Boolean);
  
  const queryWords = String(req.query.query)
    .split(",")
    .map(String)
    .filter(Boolean);

  const unauthorizedUserIds = await getUnauthorizedUserIds(userId);

  const fetchUsers = await prisma.user.findMany({
    where: {
      id: {
        notIn: unauthorizedUserIds,
      },
      ...userIds.length > 0 && {
        id: {
          in: userIds
        }
      },
      NOT: [
        {
          blockedBy: {
            some: {
              id: userId,
            },
          },
        },
      ],
      ...(queryWords[0] !== "undefined") && !(userIds.length > 0) && {
        OR: queryWords.map((word) => ({
          name: {
            contains: word,
            mode: "insensitive",
          },
          username: {
            contains: word,
            mode: "insensitive",
          },
        })),
      },
    },
    select: {
      id: true,
    },
    skip: 10 * Number(page),
    take: 10,
  });

  return res.send({
    users: await Promise.all(
      fetchUsers.map(async (user) => returnUserObjectDto(user.id, userId)),
    ),
    currentPage: page,
  });
};

export const searchPosts = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { page = 0 } = req.query;
  const userIds = String(req.query.users)
    .split(",")
    .map(Number)
    .filter(Boolean);

  const spaceIds = String(req.query.spaces)
    .split(",")
    .map(Number)
    .filter(Boolean);
  
  const factiiiIds = String(req.query.factiiis)
    .split(",")
    .map(Number)
    .filter(Boolean);

  const queryWords = String(req.query.query)
    .split(",")
    .map(String)
    .filter(Boolean);

  const [
    unauthorizedSpaceIds,
    unauthorizedUserIds,
    unauthorizedFactiiiIds,
    spaceRuleIds,
  ] = await Promise.all([
    getUnauthorizedSpaceIds(userId),
    getUnauthorizedUserIds(userId),
    getUnauthorizedFactiiiIds(userId),
    getSpaceRuleIds(userId),
  ]);

  const postIds = await prisma.post.findMany({
    where: {
      // moderation
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
      userId: {
        notIn: unauthorizedUserIds,
      },
      ...userIds.length > 0 && {
        userId: {
          in: userIds,
        },
      },
      ...spaceIds.length > 0 && {
        spaceId: {
          in: spaceIds
        }
      },
      ...factiiiIds.length > 0 && {
        factiiis: {
          some: {
            factiii: {
              id: {
                in :factiiiIds
              }
            }
          }
        }
      },
      ...(queryWords[0] !== "undefined") && {
        OR: queryWords.map((word) => ({
          content: {
            contains: word,
            mode: "insensitive",
          },
        })),
      },
    },
    select: {
      id: true,
    },
    orderBy: [{ trendingRank: "desc" }, { id: "desc" }],
    skip: 10 * Number(page),
    take: 10,
  });

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
    currentPage: page,
  });
};

export const searchSpaces = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { page = 0 } = req.query;
  const spaceIds = String(req.query.spaces)
    .split(",")
    .map(Number)
    .filter(Boolean);

  const queryWords = String(req.query.query)
    .split(",")
    .map(String)
    .filter(Boolean);

    const fetchSpaces = await prisma.space.findMany({
    where: {
      //moderation
      id: {
        notIn: await getUnauthorizedSpaceIds(userId),
      },
      //query
      ...spaceIds.length > 0 && {
        id: {
          in: spaceIds
        },
      },
      ...!(queryWords[0] === "undefined") && {
        OR: queryWords.map((word) => ({
          name: {
            contains: word,
            mode: "insensitive",
          },
          description: {
            contains: word, 
            mode: "insensitive"
          }
        })),
      },
    },
    select: {
      id: true,
    },
    skip: 10 * Number(page),
    take: 10,
  });

  return res.send({
    spaces: await Promise.all(
      fetchSpaces.map(async (space) => returnSpaceCardDto(space.id)),
    ),
    currentPage: page,
  });
};

export const searchFactiiis = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { page = 0, ignoredIds } = req.query;

  const factiiiIds = String(req.query.factiiis)
    .split(",")
    .map(Number)
    .filter(Boolean);

  const queryWords = String(req.query.query)
    .split(",")
    .map(String)
    .filter(Boolean);

  const ignoredIdsArray =
    ignoredIds
      ?.toString()
      .split(",")
      .map((x) => Number(x)) ?? [];
  const unauthorizedFactiiiIds = await getUnauthorizedFactiiiIds(userId);

  const fetchFactiiis = await prisma.factiii.findMany({
    where: {
      space: {
        members: {
          some: {
            userId,
          },
        },
      },
      id: {
        notIn: [...new Set(unauthorizedFactiiiIds.concat(ignoredIdsArray))],
      },
      ...factiiiIds.length > 0 && {
        id: {
          in: factiiiIds
        }
      },
      ...(queryWords[0] !== "undefined") && {
        OR: queryWords.map((word) => ({
          name: {
            contains: word,
            mode: "insensitive",
          }
        })),
      },
    },
    select: {
      id: true,
      name: true,
      slug: true,
      space: {
        select: {
          slug: true,
        },
      },
      userPreferences: {
        where: {
          userPreferenceUserId: userId,
        },
        select: {
          factiiiId: true,
        },
      },
      avatar: {
        select: {
          key: true,
        },
      },
    },
    skip: 10 * Number(page),
    take: 10,
  });

  const remapFactiiis = fetchFactiiis.map((factiii) => {
    return {
      ...factiii,
      isSelected: factiii.userPreferences.length > 0,
      factiiiSlug: factiii.slug,
      spaceSlug: factiii.space?.slug,
      avatar: getS3ObjectURL(factiii.avatar?.key),
    };
  });

  return res.send({
    factiiis: remapFactiiis,
    currentPage: page,
  });
};

export const searchGoals = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { query } = req.query;

  const unauthorizedFactiiiIds = await getUnauthorizedFactiiiIds(userId);

  const factiiis = await prisma.factiii.findMany({
    where: {
      id: {
        notIn: [...unauthorizedFactiiiIds],
      },
      name: {
        contains: query?.toString(),
        mode: "insensitive",
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
      slug: true,
      space: {
        select: {
          slug: true,
        },
      },
      status: true,
      avatar: {
        select: {
          key: true,
        },
      },
      requirements: true,
    },
    take: 10,
  });

  return res.send({
    factiiis: factiiis.map((factiii) => {
      return {
        id: factiii.id,
        name: factiii.name,
        username: factiii.user.username,
        slug: factiii.slug,
        spaceSlug: factiii.space?.slug,
        status: factiii.status,
        avatar: getS3ObjectURL(factiii.avatar?.key),
        requirements: factiii.requirements,
      };
    }),
  });
};

export const searchScrapes = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { query, page = 0 } = req.query as { query: string; page: string };

  if (!query) return;

  const scrapes = await prisma.scrape.findMany({
    where: {
      userId,
      status: "PENDING",
      url: {
        contains: query.toString(),
        mode: "insensitive",
      },
    },
    select: {
      id: true,
      url: true,
      status: true,
      plannedAt: true,
    },
    skip: 10 * Number(page),
    take: 10,
  });

  return res.send({
    scrapes,
  });
};
