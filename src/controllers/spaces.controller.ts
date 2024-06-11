import prisma from "../clients/prisma";
import stripe from "../clients/stripe";
import { Request, Response } from "express";
import { getS3ObjectURL } from "../clients/s3";
import { returnUserObjectDto } from "./users.controller";
import AppError from "../utilities/AppError";
import stringToSlug from "../helpers/stringToSlug";
import emitNotificationCount from "../utilities/emitNotificationCount";
import {
  getUnauthorizedSpaceIds,
  getUnauthorizedFactiiiIds,
  getUnauthorizedUserIds,
} from "../helpers/moderation";
import { getIoInstance } from "../clients/socket";

export const returnSpaceObjectDto = async (
  userId: number,
  unauthorizedUserIds: number[],
  spaceId: number,
  unauthorizedFactiiiIds: number[],
) => {
  const [space, membersCount, banned] = await Promise.all([
    //space
    prisma.space.findFirst({
      where: {
        id: spaceId,
      },
      select: {
        id: true,
        name: true,
        slug: true,
        description: true,
        types: true,
        createdAt: true,
        updatedAt: true,
        pinnedPostId: true,
        banner: true,
        bannerId: true,
        robohash: true,
        avatar: true,
        avatarId: true,
        status: true,
        rules: {
          orderBy: {
            createdAt: "asc",
          },
          where: {
            factiiiId: {
              equals: null,
            },
          },
        },
        members: {
          where: {
            roles: {
              hasSome: ["OWNER", "MODERATOR"],
            },
          },
          select: {
            roles: true,
            user: {
              select: {
                id: true,
                name: true,
                username: true,
                avatar: true,
                robohash: true,
              },
            },
          },
        },
        factiiis: {
          where: {
            id: {
              notIn: unauthorizedFactiiiIds,
            },
          },
          take: 10,
          select: {
            id: true,
          },
          orderBy: {
            createdAt: "desc",
          },
        },
        pinnedFactiiis: {
          where: {
            id: {
              notIn: unauthorizedFactiiiIds,
            },
            status: "APPROVED",
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
            avatar: {
              select: {
                key: true,
              },
            },
            requirements: true,
          },
        },
      },
    }),
    //membersCount
    prisma.spaceMember.count({
      where: {
        spaceId,
        userId: {
          notIn: unauthorizedUserIds,
        },
      },
    }),
    //banned
    prisma.ban.findFirst({
      where: {
        spaceId,
        userId,
        expiresAt: {
          gte: new Date(),
        },
      },
    }),
  ]);

  if (!space) return Promise.reject("No space found with that ID");

  const owners = space.members
    .filter((x) => x.roles.includes("OWNER"))
    .map((x) => {
      return x.user;
    })
    .map((y) => {
      return {
        ...y,
        avatar: getS3ObjectURL(y.avatar?.key),
      };
    });

  //if this is the about space then place the factiii rules in the rules array
  if (space.slug === "about") {
    const rules = await prisma.space.findFirstOrThrow({
      where: {
        slug: "factiii",
      },
      select: {
        rules: true,
      },
    });

    space.rules = rules.rules;
  }

  return {
    id: space.id,
    name: space.name,
    slug: space.slug,
    description: space.description,
    types: space.types,
    createdAt: space.createdAt,
    updatedAt: space.updatedAt,
    pinnedPostId: space.pinnedPostId,
    banner: getS3ObjectURL(space.banner?.key),
    avatar: space.avatar?.key
      ? getS3ObjectURL(space.avatar?.key)
      : `https://robohash.org/${space.robohash}?bgset=bg2`,
    owners,
    rules: space.rules
      ? space.rules
          .sort(
            (a, b) =>
              new Date(a.createdAt).getTime() - new Date(b.createdAt).getTime(),
          )
          .map((x) => {
            return {
              ...x,
              spaceId: undefined,
            };
          })
      : 0,
    membersCount,
    banned: banned ? true : false,
    factiiiIds: space.factiiis.map((x) => x.id),
    ...(space.slug === "about" && {
      totalMembersCount: await prisma.user.count({
        where: {
          id: {
            notIn: unauthorizedUserIds,
          },
        },
      }),
    }),
    pinnedFactiiis: space.pinnedFactiiis.map((factiii) => ({
      id: factiii.id,
      name: factiii.name,
      slug: factiii.slug,
      spaceSlug: factiii.space?.slug,
      avatar: factiii?.avatar?.key
        ? getS3ObjectURL(factiii.avatar.key)
        : undefined,
      requirements: factiii.requirements,
    })),
    robohash: space.robohash,
  };
};

export const returnSpaceCardDto = async (spaceId: number) => {
  const space = await prisma.space.findFirstOrThrow({
    where: {
      id: spaceId,
    },
    select: {
      id: true,
      robohash: true,
      avatar: {
        select: {
          key: true,
        },
      },
      name: true,
      slug: true,
      description: true,
    },
  });

  return {
    id: space.id,
    avatar: space.avatar?.key
      ? getS3ObjectURL(space.avatar?.key)
      : `https://robohash.org/${space.robohash}?bgset=bg2`,
    name: space.name,
    slug: space.slug,
    description: space.description,
  };
};

export const getSpace = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { slug } = req.params;

  const unauthorizedSpaceIds = await getUnauthorizedSpaceIds(userId);

  const [spaceId, unauthorizedUserIds, unauthorizedFactiiiIds] =
    await Promise.all([
      //spaceId
      prisma.space.findFirst({
        where: {
          //moderation
          id: {
            notIn: unauthorizedSpaceIds,
          },
          //query
          slug,
          status: "ACTIVE",
        },
        select: {
          id: true,
          types: true,
        },
      }),
      //unauthorizedUserIds
      getUnauthorizedUserIds(userId),
      //unauthorizedFactiiiIds
      getUnauthorizedFactiiiIds(userId),
    ]);

  if (!spaceId)
    throw new AppError("No space exists with that slug. Please try again.");

  const space = await returnSpaceObjectDto(
    userId,
    unauthorizedUserIds,
    spaceId.id,
    unauthorizedFactiiiIds,
  );

  return res.send({
    ...space,
  });
};

export const getSpaceOptions = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { slug } = req.params;

  const space = await prisma.space.findFirst({
    where: {
      id: {
        notIn: await getUnauthorizedSpaceIds(userId),
      },
      slug,
      status: "ACTIVE",
      members: {
        some: {
          userId,
          roles: {
            has: "OWNER",
          },
        },
      },
    },
    select: {
      name: true,
      types: true,
    },
  });

  if (!space)
    throw new AppError("No space exists with that slug. Please try again.");

  return res.send(space);
};

export const updateSpaceOptions = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { name, types } = req.body;
  const { slug } = req.params;

  const checkSpace = await prisma.space.findFirst({
    where: {
      slug,
      members: {
        some: {
          userId,
          roles: {
            has: "OWNER",
          },
        },
      },
    },
    select: {
      id: true,
      name: true,
    },
  });

  if (!checkSpace) {
    throw new AppError("No such space found or you do not have permissions.");
  }

  let space;
  if (name !== checkSpace.name) {
    const slug: string = name
      .toLowerCase()
      .replaceAll(" ", "-")
      .replaceAll(/[^A-Za-z0-9-]+/g, "")
      .replace(/-$/, "");

    space = await prisma.space.update({
      where: {
        id: checkSpace.id,
      },
      data: {
        name,
        slug,
        types,
      },
      select: {
        id: true,
        slug: true,
      },
    });
  } else {
    space = await prisma.space.update({
      where: {
        id: checkSpace.id,
      },
      data: {
        types,
      },
      select: {
        id: true,
        slug: true,
      },
    });
  }

  if (!space.id) {
    throw new AppError("Error while updating space. Please try again.");
  }

  if (types.includes("PAID")) {
    const checkBetaAccess = await prisma.userPreference.findFirst({
      where: {
        userId,
      },
      select: {
        betaAccess: true,
      },
    });

    if (!checkBetaAccess) {
      throw new AppError(
        "You need to have beta access to create a paid space.",
      );
    }
  }

  if (name != checkSpace.name) {
    return res.send({
      updated: true,
      slug: space.slug,
    });
  } else {
    return res.send({
      updated: true,
    });
  }
};

export const createSpace = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { name, types = [] } = req.body;

  if (name.length > 21 || name.length < 3)
    throw new AppError(
      "Space name should be at least 3 characters and at most 21 characters long.",
    );

  if (types.includes("PAID")) {
    const checkBetaAccess = await prisma.userPreference.findFirst({
      where: {
        userId,
      },
      select: {
        betaAccess: true,
      },
    });

    if (!checkBetaAccess) {
      throw new AppError(
        "You need to have beta access to create a paid space.",
      );
    }
  }

  const slug = stringToSlug(name);

  const checkSpace = await prisma.space.findFirst({
    where: {
      slug,
    },
    select: {
      id: true,
    },
  });

  if (checkSpace)
    throw new AppError(
      "A space already exists with that name. Choose a different name.",
    );

  const spacesPerUserLimit = await prisma.siteSettings.findFirst({
    where: { id: 1 },
    select: {
      maxSpacesPerUser: true,
    },
  });

  if (spacesPerUserLimit) {
    const spacesByUserCount = await prisma.space.count({
      where: {
        members: {
          some: {
            userId,
            roles: {
              has: "OWNER",
            },
          },
        },
      },
    });

    if (spacesByUserCount >= spacesPerUserLimit.maxSpacesPerUser)
      throw new AppError(
        `You can only create ${spacesPerUserLimit.maxSpacesPerUser} spaces for now`,
      );
  }

  const space = await prisma.space.create({
    data: {
      name,
      slug,
      types,
    },
  });

  await prisma.spaceMember.create({
    data: {
      userId,
      spaceId: space.id,
      roles: ["MEMBER", "OWNER", "MODERATOR"],
    },
  });

  return res.send({
    space: space,
  });
};

export const updateSpace = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { description, factiiiId, avatarId, bannerId, robohash, requirements } =
    req.body;
  const { slug } = req.params;

  const checkSpace = await prisma.space.findFirst({
    where: {
      slug,
      members: {
        some: {
          userId,
          roles: {
            has: "OWNER",
          },
        },
      },
    },
    select: {
      id: true,
      description: true,
      robohash: true,
      avatarId: true,
      bannerId: true,
    },
  });

  // if (!checkSpace) {
  //     throw new AppError("No such space found or you do not have permissions.");
  // }

  let reply;
  if (factiiiId) {
    const factiii = await prisma.factiii.update({
      where: {
        id: factiiiId,
      },
      data: {
        description,
        avatarId: avatarId === "__removeAvatarNULL" ? null : avatarId,
        bannerId,
        requirements,
      },
      select: {
        description: true,
        avatar: {
          select: {
            key: true,
          },
        },
        banner: {
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
    });

    if (!factiii)
      throw new AppError("Error while updating factiii. Please try again.");

    reply = {
      ...factiii,
      avatar: getS3ObjectURL(factiii.avatar?.key),
      banner: getS3ObjectURL(factiii.banner?.key),
      slug: factiii.space?.slug,
    };
  } else if (checkSpace) {
    const space = await prisma.space.update({
      where: {
        id: checkSpace.id,
      },
      data: {
        description,
        avatarId: avatarId === "__removeAvatarNULL" ? null : avatarId,
        bannerId,
        robohash: robohash ? robohash : undefined,
      },
      select: {
        description: true,
        avatar: {
          select: {
            key: true,
          },
        },
        banner: {
          select: {
            key: true,
          },
        },
        robohash: true,
        slug: true,
      },
    });

    if (!space)
      throw new AppError("Error while updating space. Please try again.");

    reply = {
      ...space,
      avatar: space.avatar?.key
        ? getS3ObjectURL(space.avatar?.key)
        : `https://robohash.org/${space.robohash}?bgset=bg2`,
      banner: getS3ObjectURL(space.banner?.key),
    };

    // Add the updated item(s) to the History model
    if (description && description !== checkSpace.description) {
      await prisma.history.create({
        data: {
          spaceId: checkSpace.id,
          column: "description",
          value: checkSpace.description ? checkSpace.description : "null",
        },
      });
    }
    if (robohash && robohash !== checkSpace.robohash) {
      await prisma.history.create({
        data: {
          spaceId: checkSpace.id,
          column: "robohash",
          value: checkSpace.robohash as any,
        },
      });
    }
    if (avatarId && avatarId !== checkSpace.avatarId) {
      await prisma.history.create({
        data: {
          spaceId: checkSpace.id,
          column: "avatarId",
          value: checkSpace.avatarId ? checkSpace.avatarId : "null",
        },
      });
    }
    if (bannerId && bannerId !== checkSpace.bannerId) {
      await prisma.history.create({
        data: {
          spaceId: checkSpace.id,
          column: "bannerId",
          value: checkSpace.bannerId ? checkSpace.bannerId : "null",
        },
      });
    }
  }

  return res.send({
    ...reply,
  });
};

export const updateRule = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { description, title, ruleId, factiiiSlug } = req.body;
  const { slug } = req.params;

  const check = await prisma.space.findFirst({
    where: {
      slug,
      members: {
        some: {
          userId,
          roles: {
            has: "OWNER",
          },
        },
      },
    },
    select: {
      id: true,
    },
  });

  if (!check) {
    throw new AppError("No such space found or you do not have permissions.");
  }

  if (ruleId) {
    const rule = await prisma.rule.findFirst({
      where: {
        id: ruleId,
      },
    });
    if (!rule) {
      throw new AppError("No such rule found or you do not have permissions.");
    }

    await prisma.spaceRuleEditHistory.create({
      data: {
        ruleId: rule.id,
        description: rule.description,
        title: rule.title,
      },
    });
    const ruleData = await prisma.rule.update({
      where: {
        id: ruleId,
      },
      data: {
        title,
        description,
        edited: true,
      },
      select: {
        id: true,
        title: true,
        description: true,
        edited: true,
      },
    });

    return res.send({
      updated: true,
      rule: ruleData,
    });
  } else {
    const ruleData = await prisma.rule.create({
      data: {
        title,
        description,
        spaceId: check.id,
        ...(factiiiSlug && {
          factiiiId: await prisma.factiii
            .findFirst({
              //TODO: make this a findUnique which requires the requirements to be submitted
              where: {
                spaceId: check.id,
                slug: factiiiSlug,
              },
              select: {
                id: true,
              },
            })
            .then((factiii) => factiii?.id),
        }),
      },
      select: {
        id: true,
        title: true,
        description: true,
      },
    });

    return res.send({
      updated: true,
      rule: ruleData,
    });
  }
};

export const membersList = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { slug } = req.params;
  const { page = 0 } = req.query;

  const unauthorizedUserIds = await getUnauthorizedUserIds(userId);

  const space = await prisma.space.findFirst({
    where: {
      id: {
        notIn: unauthorizedUserIds,
      },
      slug,
    },
    select: {
      id: true,
      slug: true,
    },
  });

  if (!space) throw new AppError("Invalid request. Please try again.");

  let members;
  let count;
  if (space.slug === "about") {
    count = await prisma.user.count({
      where: {
        id: {
          notIn: unauthorizedUserIds,
        },
      },
    });

    members = await prisma.user.findMany({
      where: {
        id: {
          notIn: unauthorizedUserIds,
        },
      },
      select: {
        id: true,
        username: true,
        name: true,
        bio: true,
        avatar: true,
        robohash: true,
      },
      skip: 10 * Number(page),
      take: 10,
    });
    members = members.map((member) => ({ user: member }));
  } else {
    count = await prisma.spaceMember.count({
      where: {
        spaceId: space.id,
        user: {
          id: {
            notIn: unauthorizedUserIds,
          },
        },
      },
    });

    members = await prisma.spaceMember.findMany({
      where: {
        spaceId: space.id,
        user: {
          id: {
            notIn: unauthorizedUserIds,
          },
        },
      },
      select: {
        user: {
          select: {
            id: true,
          },
        },
      },
      skip: 10 * Number(page),
      take: 10,
    });
  }

  return res.send({
    users: await Promise.all(
      members.map((x) => returnUserObjectDto(x.user.id, userId)),
    ),
    count,
    currentPage: page,
  });
};

export const joinSpace = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { slug } = req.params;

  const unauthorizedSpaceIds = await getUnauthorizedSpaceIds(userId);

  const check = await prisma.spaceMember.findFirst({
    where: {
      spaceId: {
        notIn: unauthorizedSpaceIds,
      },
      userId: userId,
      space: {
        slug,
      },
    },
    select: {
      userId: true,
      spaceId: true,
      roles: true,
    },
  });

  if (check && !check.roles.includes("FORMER_MEMBER"))
    throw new AppError("You have already joined this space.");

  const space = await prisma.space.findFirst({
    where: {
      id: {
        notIn: unauthorizedSpaceIds,
      },
      slug,
    },
    select: {
      id: true,
      types: true,
    },
  });

  if (!space)
    throw new AppError(
      "Space does not exists or you do not have permissions to join.",
    );
  if (space.types.includes("INVITE")) {
    const checkInvitation = await prisma.spaceInvite.findFirst({
      where: {
        userId,
        spaceId: space.id,
        joined: {
          not: true,
        },
      },
    });
    if (!checkInvitation)
      throw new AppError(
        "You cannot join this space since this is an invite-only space.",
      );

    await prisma.spaceInvite.updateMany({
      where: {
        userId,
        spaceId: space.id,
      },
      data: {
        joined: true,
      },
    });
  }

  const previousMember = await prisma.spaceMember.findUnique({
    where: {
      userId_spaceId: {
        userId,
        spaceId: space.id,
      },
    },
    select: {
      roles: true,
    },
  });

  if (previousMember && previousMember.roles.includes("FORMER_MEMBER")) {
    await prisma.spaceMember.update({
      where: {
        userId_spaceId: {
          userId,
          spaceId: space.id,
        },
      },
      data: {
        roles: ["MEMBER"],
      },
    });
  } else if (!previousMember || !previousMember.roles.includes("MEMBER")) {
    await prisma.spaceMember.create({
      data: {
        userId,
        spaceId: space.id,
      },
    });
  }

  //Send notification to all the users devices
  const sessions = await prisma.session.findMany({
    where: {
      userId,
    },
    select: {
      refreshToken: true,
      socketId: true,
    },
  });

  //Do not do this if user has 1 session as no other devices need updated
  if (sessions.length > 1) {
    const io = getIoInstance();
    const refreshToken = req.body.auth.refresher;
    const filteredSessions = sessions
      .filter((x) => x.refreshToken !== refreshToken && x.socketId !== null)
      .map((x) => x.socketId as string);
    for (const socketId of filteredSessions) {
      io.to(socketId).emit("refreshUser");
    }
  }

  return res.send({
    joined: true,
  });
};

export const leaveSpace = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { slug } = req.params;

  const spaceMember = await prisma.spaceMember.findFirst({
    where: {
      userId: userId,
      space: {
        slug,
      },
    },
    select: {
      userId: true,
      spaceId: true,
      subscription: {
        select: {
          subscriptionId: true,
          type: true,
        },
      },
    },
  });

  if (!spaceMember) {
    throw new AppError("You have not joined this space.");
  }

  const space = await prisma.space.findFirst({
    where: {
      slug,
    },
    select: {
      id: true,
      types: true,
    },
  });

  if (!space)
    throw new AppError("Error while leaving space. Please try again.");

  const isOwner = await prisma.spaceMember.findFirst({
    where: {
      userId,
      spaceId: space.id,
      roles: {
        has: "OWNER",
      },
    },
  });

  if (isOwner) throw new AppError("The owner cannot leave the space");

  //TODO cancel Apple and Google too
  //TODO test this
  if (spaceMember.subscription && spaceMember.subscription.type === "STRIPE") {
    // await stripe.subscriptions.del(check.subscription.id);
    await stripe.subscriptions.cancel(spaceMember.subscription.subscriptionId);
  }

  await prisma.spaceMember.update({
    where: {
      userId_spaceId: {
        userId,
        spaceId: space.id,
      },
    },
    data: {
      roles: ["FORMER_MEMBER"],
    },
  });

  const sessions = await prisma.session.findMany({
    where: {
      userId,
    },
    select: {
      refreshToken: true,
      socketId: true,
    },
  });

  //Do not do this if user has 1 session as no other devices need updated
  if (sessions.length > 1) {
    const io = getIoInstance();
    const refreshToken = req.body.auth.refresher;
    const filteredSessions = sessions
      .filter((x) => x.refreshToken !== refreshToken && x.socketId !== null)
      .map((x) => x.socketId as string);
    for (const socketId of filteredSessions) {
      io.to(socketId).emit("refreshUser");
    }
  }

  return res.send({
    left: true,
  });
};

export const mySpaces = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { page = 0 } = req.query;

  const spaces = await prisma.space.findMany({
    where: {
      members: {
        some: {
          userId,
        },
      },
    },
    select: {
      id: true,
    },
    take: 10,
    skip: 10 * Number(page),
  });

  return res.send({
    spaces: await Promise.all(
      spaces.map((space) => returnSpaceCardDto(space.id)),
    ),
  });
};

export const suggestedSpaces = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { page = 0 } = req.query;

  const spaces = await prisma.space.findMany({
    where: {
      id: {
        notIn: await getUnauthorizedSpaceIds(userId),
      },
      members: {
        none: {
          userId,
        },
      },
    },
    orderBy: [
      {
        members: {
          _count: "desc",
        },
      },
    ],
    select: {
      id: true,
    },
    skip: 10 * Number(page),
    take: 10,
  });

  return res.send({
    spaces: await Promise.all(
      spaces.map((space) => returnSpaceCardDto(space.id)),
    ),
  });
};

export const addModerator = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { username } = req.body;
  const { slug } = req.params;

  const check = await prisma.space.findFirst({
    where: {
      slug,
      members: {
        some: {
          userId,
          roles: {
            has: "OWNER",
          },
        },
      },
    },
    select: {
      id: true,
    },
  });

  if (!check)
    throw new AppError("No such space found or you do not have permissions.");

  const user = await prisma.user.findFirst({
    where: {
      username,
    },
    select: {
      id: true,
    },
  });

  if (!user) throw new AppError("Invalid request made.");

  const membershipCheck = await prisma.spaceMember.findMany({
    where: {
      userId: user.id,
      spaceId: check.id,
      roles: {
        has: "MEMBER",
      },
    },
  });

  if (membershipCheck.length === 0) {
    await prisma.spaceMember.create({
      data: {
        userId: user.id,
        spaceId: check.id,
        roles: ["MEMBER", "MODERATOR"],
      },
    });
  } else {
    await prisma.spaceMember.updateMany({
      where: {
        userId: user.id,
        spaceId: check.id,
      },
      data: {
        roles: ["MEMBER", "MODERATOR"],
      },
    });
  }

  return res.send({
    success: true,
  });
};

export const factiiisList = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { slug } = req.params;
  const { page = 0 } = req.query;

  const check = await prisma.space.findFirst({
    where: {
      slug,
      members: {
        some: {
          userId,
          roles: {
            has: "OWNER",
          },
        },
      },
    },
    select: {
      id: true,
    },
  });

  if (!check)
    throw new AppError("No such space found or you do not have permissions.");

  const factiiis = await prisma.factiii.findMany({
    where: {
      spaceId: check.id,
      status: "APPROVED",
    },
    select: {
      id: true,
    },
    skip: 10 * Number(page),
    take: 10,
  });

  return res.send({
    factiiis,
  });
};

export const removeModerator = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { slug, username } = req.params;

  const check = await prisma.space.findFirst({
    where: {
      slug,
      members: {
        some: {
          userId,
          roles: {
            has: "OWNER",
          },
        },
      },
    },
    select: {
      id: true,
    },
  });

  if (!check)
    throw new AppError("No such space found or you do not have permissions.");

  const user = await prisma.user.findFirst({
    where: {
      username,
    },
    select: {
      id: true,
    },
  });

  if (!user) throw new AppError("Invalid request made.");

  if (user.id === userId)
    throw new AppError("You cannot remove yourself as a moderator");

  await prisma.spaceMember.deleteMany({
    where: {
      userId: user.id,
      spaceId: check.id,
    },
  });

  return res.send({
    success: true,
  });
};

export const moderatorsList = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { slug } = req.params;
  const { page = 0 } = req.query;

  const space = await prisma.space.findFirst({
    where: {
      id: {
        notIn: await getUnauthorizedSpaceIds(userId),
      },
      slug,
    },
    select: {
      id: true,
    },
  });

  if (!space) throw new AppError("Invalid request. Please try again.");

  const count = await prisma.spaceMember.count({
    where: {
      spaceId: space.id,
      OR: [
        {
          roles: {
            has: "OWNER",
          },
        },
        {
          roles: {
            has: "MODERATOR",
          },
        },
      ],
    },
  });

  const members = await prisma.spaceMember.findMany({
    where: {
      spaceId: space.id,
      OR: [
        {
          roles: {
            has: "OWNER",
          },
        },
        {
          roles: {
            has: "MODERATOR",
          },
        },
      ],
    },
    select: {
      user: {
        select: {
          id: true,
        },
      },
    },
    skip: 10 * Number(page),
    take: 10,
  });

  return res.send({
    users: await Promise.all(
      members.map((x) => returnUserObjectDto(x.user.id, req.body.auth?.userId)),
    ),
    count,
    currentPage: page,
  });
};

export const banUser = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { username }: { username: string } = req.body;
  const { slug } = req.params;

  //check if the user is the owner or moderator of the space
  const checkSpace = await prisma.space.findFirst({
    where: {
      slug,
      members: {
        some: {
          userId,
          roles: {
            hasSome: ["MODERATOR", "OWNER"],
          },
        },
      },
    },
    select: {
      id: true,
    },
  });

  if (!checkSpace)
    throw new AppError("No such space found or you do not have permissions.");

  //get the user to be banned
  const bannedUser = await prisma.user.findFirst({
    where: {
      username,
    },
    select: {
      id: true,
    },
  });

  if (!bannedUser) throw new AppError("Invalid request made.");

  if (bannedUser.id === userId) throw new AppError("You cannot ban yourself");

  //make sure the user is not the owner of the space
  const member = await prisma.spaceMember.findFirst({
    where: {
      userId: bannedUser.id,
      spaceId: checkSpace.id,
      roles: {
        hasSome: ["OWNER"],
      },
    },
  });
  if (member) throw new AppError("You cannot ban the owner");

  //count how many times user banned from space
  const count = await prisma.ban.count({
    where: {
      userId: bannedUser.id,
      spaceId: checkSpace.id,
    },
  });

  //days to be banned, first time gets 1 day after that 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024
  const banDays = count === 0 ? 1 : 2 ^ count;

  await prisma.ban.create({
    data: {
      userId: bannedUser.id,
      spaceId: checkSpace.id,
      expiresAt: new Date(Date.now() + 1000 * 60 * 60 * 24 * banDays),
    },
  });

  return res.send({
    banned: true,
  });
};

export const bannedUsersList = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { slug } = req.params;
  const { page = 0 } = req.query;

  const space = await prisma.space.findFirst({
    where: {
      id: {
        notIn: await getUnauthorizedSpaceIds(userId),
      },
      slug,
    },
    select: {
      id: true,
    },
  });

  if (!space) throw new AppError("Invalid request. Please try again.");

  const members = await prisma.ban.findMany({
    where: {
      spaceId: space.id,
      expiresAt: {
        gte: new Date(),
      },
    },
    select: {
      user: {
        select: {
          id: true,
        },
      },
    },
    skip: 10 * Number(page),
    take: 10,
  });

  return res.send({
    users: await Promise.all(
      members.map((x) => returnUserObjectDto(x.user.id, req.body.auth?.userId)),
    ),
    currentPage: page,
  });
};

export const unbanUser = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { slug, username } = req.params;

  const check = await prisma.space.findFirst({
    where: {
      id: {
        notIn: await getUnauthorizedSpaceIds(userId),
      },
      slug,
      members: {
        some: {
          userId,
          roles: {
            hasSome: ["MODERATOR", "OWNER"],
          },
        },
      },
    },
    select: {
      id: true,
    },
  });

  if (!check)
    throw new AppError("No such space found or you do not have permissions.");

  const user = await prisma.user.findFirst({
    where: {
      username,
    },
    select: {
      id: true,
    },
  });

  if (!user) throw new AppError("Invalid request made.");

  await prisma.ban.deleteMany({
    where: {
      userId: user.id,
      spaceId: check.id,
      expiresAt: {
        gte: new Date(),
      },
    },
  });

  return res.send({
    unbanned: true,
  });
};

export const addFilter = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { slug } = req.params;
  let space;

  const spaceCheck = await prisma.space.findFirst({
    where: {
      slug: slug,
    },
    select: {
      id: true,
    },
  });

  if (spaceCheck) {
    space = await prisma.space.findFirst({
      where: {
        id: {
          notIn: await getUnauthorizedSpaceIds(spaceCheck.id),
        },
        slug,
      },
      select: {
        id: true,
      },
    });
  }

  if (!space) {
    throw new AppError("You have already joined this space.");
  }

  await prisma.spaceFilter.create({
    data: {
      userId,
      spaceId: space.id,
    },
  });

  return res.send({
    added: true,
  });
};

export const removeFilter = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { slug } = req.params;

  if (slug === "factiii")
    throw new AppError(`You cannot remove s/factiii as your filter`);

  const spaceCheck = await prisma.space.findFirst({
    where: {
      id: {
        notIn: await getUnauthorizedSpaceIds(userId),
      },
      slug,
    },
    select: {
      id: true,
    },
  });

  if (!spaceCheck) {
    throw new AppError("This space does not exists.");
  }

  await prisma.spaceFilter.deleteMany({
    where: {
      userId,
      spaceId: spaceCheck.id,
    },
  });

  return res.send({
    added: true,
  });
};

export const listFilteredSpaces = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId;
  const { page = 0 } = req.query;

  const spaceFilters = await prisma.spaceFilter.findMany({
    where: {
      userId,
    },
    select: {
      spaceId: true,
    },
    skip: 10 * Number(page),
    take: 10,
  });

  return res.send({
    spaces: await Promise.all(
      spaceFilters.map(async (spaceFilter) =>
        returnSpaceCardDto(spaceFilter.spaceId),
      ),
    ),
  });
};

export const pinPost = async (req: Request, res: Response) => {
  const { postId, slug } = req.params;
  const userId: number = req.body.auth?.userId ?? 0;

  const checkRole = await prisma.spaceMember.findFirst({
    where: {
      space: {
        slug,
      },
      userId,
      roles: {
        has: "MODERATOR",
      },
    },
  });

  if (!checkRole)
    throw new AppError("You do not have the permissions to do that");

  const checkPost = await prisma.post.findFirstOrThrow({
    where: {
      uuid: postId,
    },
    select: {
      id: true,
    },
  });

  await prisma.space.update({
    where: {
      slug,
    },
    data: {
      pinnedPostId: checkPost.id,
    },
  });

  return res.send({
    pinned: true,
  });
};

export const unpinPost = async (req: Request, res: Response) => {
  const { slug } = req.params;
  const userId: number = req.body.auth?.userId ?? 0;

  const checkRole = await prisma.spaceMember.findFirst({
    where: {
      space: {
        slug,
      },
      userId,
      roles: {
        has: "MODERATOR",
      },
    },
  });

  if (!checkRole)
    throw new AppError("You do not have the permissions to do that");

  await prisma.space.update({
    where: {
      slug,
    },
    data: {
      pinnedPostId: null,
    },
  });

  return res.send({
    unpinned: true,
  });
};

//TODO check this works
// export const joinPaidSpace = async (req: Request, res: Response) => {
//     const userId: number = req.body.auth?.userId ?? 0;
//     const { slug } = req.params;

//     const space = await prisma.space.findFirst({
//         where: {
//             id: {
//                 notIn: await getUnauthorizedSpaceIds(userId),
//             },
//             slug,
//             types: {
//                 has: 'PAID',
//             }
//         },
//         select: {
//             id: true,
//             slug: true,
//             products: {
//                 where: {
//                     title: `s/${slug} membership`,
//                     type: "MONTHLY_SUBSCRIPTION",
//                 },
//                 select: {
//                     id: true,
//                     price: true,
//                 }
//             }
//         }
//     });

//     const user = await prisma.user.findFirst({
//         where: {
//             id: userId,
//         },
//     });

//     if (!user || !space) throw new AppError("Invalid request. Please check the request user.");

//     //prevent spamming failed payments
//     const prevFailedTxnsCount = await prisma.payment.count({
//         where: {
//             userId: user.id,
//             completed: null,
//             createdAt: {
//                 gt: new Date(new Date().getTime() - 5 * 60 * 1000).toISOString(),
//             }
//         },
//     });

//     if (prevFailedTxnsCount >= 5 && process.env.ENV != 'development') throw new AppError("You have made a lot of purchase requests. Please try again in a few minutes.");

//     const paymentIntent = await stripe.paymentIntents.create({
//         amount: space.products[0].price,
//         currency: "usd",
//         automatic_payment_methods: {
//             enabled: true,
//         },
//     });

//     const productCheck = await prisma.product.findFirst({
//         where: {
//             spaceId: space.id,
//             title: 'premium',
//         },
//         select: {
//             id: true,
//         },
//     });

//     if (!productCheck) throw new AppError("Invalid request. Please check the request space.");

//     await prisma.order.create({
//         data: {
//             userId,
//             total: space.products[0].price,
//             payments: {
//                 create: {
//                     paymentIntent: paymentIntent.id,
//                     amount: space.products[0].price,
//                     userId,
//                     type: "STRIPE",
//                 }
//             },
//             items: {
//                 create: {
//                     price: space.products[0].price,
//                     product: {
//                         connect: {
//                             id: productCheck.id,
//                         }
//                     },
//                 }
//             }
//         }
//     });

//     return res.send({
//         success: true,
//         secret: paymentIntent.client_secret,
//     });
// };

export const cancelSpaceSubscription = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { slug } = req.params;

  const space = await prisma.space.findUnique({
    where: {
      slug,
      types: {
        has: "PAID",
      },
    },
    select: {
      id: true,
    },
  });

  if (!space) throw new AppError("Invalid Request.");

  const spaceMember = await prisma.spaceMember.findUnique({
    where: {
      userId_spaceId: {
        userId,
        spaceId: space.id,
      },
      subscription: {
        expires: {
          gte: new Date(),
        },
      },
    },
    select: {
      userId: true,
      spaceId: true,
      subscription: {
        select: {
          subscriptionId: true,
        },
      },
    },
  });

  if (!spaceMember || !spaceMember.subscription) {
    throw new AppError("Invalid request.");
  }

  const isOwner = await prisma.spaceMember.findFirst({
    where: {
      userId,
      spaceId: space.id,
      roles: {
        has: "OWNER",
      },
    },
  });

  if (isOwner) throw new AppError("The owner cannot leave the space");

  await stripe.subscriptions.cancel(spaceMember.subscription.subscriptionId);

  await prisma.spaceMember.update({
    where: {
      userId_spaceId: {
        userId: userId,
        spaceId: space.id,
      },
    },
    data: {
      roles: ["FORMER_MEMBER"],
      subscription: {
        update: {
          nextPayment: null,
        },
      },
    },
  });

  return res.send({
    unsubscribed: true,
  });
};

export const getSpaceHistory = async (req: Request, res: Response) => {
  const { slug }: { slug?: string } = req.params;

  const checkSpace = await prisma.space.findFirst({
    where: {
      slug,
      status: "ACTIVE",
    },
    select: {
      name: true,
      description: true,
      avatar: true,
      banner: true,
      robohash: true,
      slug: true,
    },
  });

  if (!checkSpace) throw new Error("No space exists with that slug");

  const history = await prisma.history.findMany({
    where: {
      space: {
        slug,
        status: "ACTIVE",
      },
    },
    orderBy: {
      createdAt: "desc",
    },
  });

  return res.send({
    history: await Promise.all(
      history.map(async (item) => {
        let value = item.value;

        if (item.column === "avatarId" || item.column === "bannerId") {
          const mediaItem = await prisma.upload.findFirst({
            where: {
              id: item.value,
            },
          });

          if (!mediaItem) return null;

          const url = getS3ObjectURL(mediaItem.key);

          if (!url) return null;

          value = url;
        }

        return {
          key: item.column.replace("Id", ""),
          value,
          date: item.createdAt,
        };
      }),
    ),
    currentData: {
      name: checkSpace.name,
      description: checkSpace.description,
      avatar: getS3ObjectURL(checkSpace.avatar?.key),
      banner: getS3ObjectURL(checkSpace.banner?.key),
      robohash: checkSpace.robohash,
      slug: checkSpace.slug,
    },
  });
};

export const inviteUserToSpace = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { slug } = req.params;
  const { targetUsername } = req.body;

  const check = await prisma.space.findFirst({
    where: {
      slug,
      members: {
        some: {
          userId,
          roles: {
            hasSome: ["OWNER", "MODERATOR"],
          },
        },
      },
    },
    select: {
      id: true,
    },
  });

  if (!check) {
    throw new AppError("No such space found or you do not have permissions.");
  }

  const checkUser = await prisma.user.findFirst({
    where: {
      username: targetUsername,
    },
    select: {
      id: true,
      sessions: {
        where: {
          socketId: req.body.auth?.socketId,
        },
      },
    },
  });

  if (!checkUser)
    throw new AppError("No such user found. Please check the username");

  const checkMembership = await prisma.spaceMember.findFirst({
    where: {
      userId: checkUser.id,
      space: {
        slug,
      },
    },
  });

  if (checkMembership)
    throw new AppError("This user is already a member of this space");

  const checkInvite = await prisma.spaceInvite.findFirst({
    where: {
      userId: checkUser.id,
      space: {
        slug,
      },
    },
  });

  if (checkInvite)
    throw new AppError("This user has already been invited this space");

  await prisma.spaceInvite.create({
    data: {
      inviterId: userId,
      userId: checkUser.id,
      spaceId: check.id,
    },
  });
  await prisma.notification.create({
    data: {
      targetUserId: checkUser.id,
      referenceUserId: userId,
      type: "SPACE_INVITES",
      referenceSpaceId: check.id,
    },
  });
  if (checkUser.sessions.length === 1 && checkUser.sessions[0].socketId) {
    await emitNotificationCount(checkUser.id, checkUser.sessions[0].socketId);
  }

  return res.send({
    ok: true,
  });
};

export const ruleEditHistory = async (req: Request, res: Response) => {
  const { ruleId } = req.params;

  const edits = await prisma.spaceRuleEditHistory.findMany({
    where: {
      ruleId: +ruleId,
    },
    select: {
      id: true,
      createdAt: true,
      title: true,
      description: true,
    },
    orderBy: {
      createdAt: "desc",
    },
  });

  return res.send({
    edits,
  });
};

export const getFactiii = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { spaceSlug, factiiiSlug } = req.params;

  const [unauthorizedFactiiiIds, unauthorizedUserIds, space] =
    await Promise.all([
      getUnauthorizedFactiiiIds(userId),
      getUnauthorizedUserIds(userId),
      prisma.space.findUniqueOrThrow({
        where: {
          slug: spaceSlug,
        },
        select: {
          id: true,
          types: true,
        },
      }),
    ]);

  const [factiii, factiiis, owners, members, membersCount] = await Promise.all([
    //factiii
    prisma.factiii.findFirstOrThrow({
      //TODO make this findUniqueOrThrow which requires requirements to be sent
      where: {
        spaceId: space.id,
        slug: factiiiSlug,
      },
      select: {
        id: true,
        data: true,
        rules: true,
        types: true,
        createdAt: true,
        name: true,
        slug: true,
        description: true,
        avatar: {
          select: {
            key: true,
          },
        },
        banner: {
          select: {
            key: true,
          },
        },
        requirements: true,
      },
    }),
    //factiiis
    prisma.factiii.findMany({
      where: {
        spaceId: space.id,
        id: {
          notIn: unauthorizedFactiiiIds,
        },
      },
      select: {
        id: true,
      },
      take: 10,
      orderBy: {
        createdAt: "desc",
      },
    }),
    //owners
    prisma.spaceMember.findMany({
      where: {
        userId: {
          notIn: unauthorizedUserIds,
        },
        spaceId: space.id,
        roles: {
          hasSome: ["OWNER", "MODERATOR"],
        },
      },
      select: {
        roles: true,
        user: {
          select: {
            id: true,
            name: true,
            username: true,
            avatar: true,
            robohash: true,
          },
        },
      },
    }),
    //members
    prisma.spaceMember.findMany({
      where: {
        spaceId: space.id,
        userId,
      },
      select: {
        roles: true,
        premiumAccessExpires: true,
      },
    }),
    //membersCount
    prisma.spaceMember.count({
      where: {
        spaceId: space.id,
        userId: {
          notIn: unauthorizedUserIds,
        },
      },
    }),
  ]);

  if (!factiii) {
    throw new Error("Factiii not found");
  }

  let isInvited = false;
  if (space.types.includes("INVITE")) {
    const checkInvitation = await prisma.spaceInvite.findFirst({
      where: {
        spaceId: space.id,
        userId,
        joined: {
          not: true,
        },
      },
    });

    if (checkInvitation) isInvited = true;
  }

  const isOwner = members.some((x: any) => x.roles.includes("OWNER"));
  const isMember = members.some((x: any) => x.roles.includes("MEMBER"));
  const isModerator = members.some((x: any) => x.roles.includes("MODERATOR"));
  const isBanned = members.some((x: any) => x.status === "BANNED");
  const isActive = members.some((x: any) => x.status === "ACTIVE");
  const isExpired = members.some((x: any) =>
    x.expires ? new Date(x.expires).getTime() < new Date().getTime() : false,
  );
  const expires = members[0]?.premiumAccessExpires
    ? members[0].premiumAccessExpires
    : null;

  const membership = {
    member: isOwner ? true : !isExpired && (isOwner || isMember || isModerator),
    role: isOwner
      ? "OWNER"
      : isModerator
        ? "MODERATOR"
        : isMember
          ? "MEMBER"
          : null,
    status: isBanned ? "BANNED" : isActive ? "ACTIVE" : null,
    expiresOn: expires,
    invited: isInvited,
  };

  return res.send({
    id: factiii.id,
    data: factiii.data,
    rules: factiii.rules,
    types: factiii.types,
    createdAt: factiii.createdAt,
    name: factiii.name,
    spaceSlug,
    factiiiSlug: factiii.slug,
    description: factiii.description,
    factiiiIds: factiiis.map((x: any) => x.id),
    avatar: getS3ObjectURL(factiii.avatar?.key),
    banner: getS3ObjectURL(factiii.banner?.key),
    owners: owners
      .filter((x: any) => x.roles.includes("OWNER"))
      .map((x: any) => {
        return x.user;
      })
      .map((y: any) => {
        return {
          ...y,
          avatar: getS3ObjectURL(y.avatar?.key),
        };
      }),
    membership,
    membersCount,
    requirements: factiii.requirements,
  });
};

export const deleteFactiii = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { space_slug, factiii_slug } = req.params;

  const check = await prisma.factiii.findFirst({
    where: {
      slug: factiii_slug,
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

export const transferOwnership = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { username } = req.body;
  const { slug } = req.params;

  const check = await prisma.space.findFirst({
    where: {
      slug,
      members: {
        some: {
          userId,
          roles: {
            has: "OWNER",
          },
        },
      },
    },
    select: {
      id: true,
    },
  });

  if (!check)
    throw new AppError("No such space found or you do not have permissions.");

  const user = await prisma.user.findFirst({
    where: {
      username,
    },
    select: {
      id: true,
    },
  });

  if (!user) throw new AppError("Invalid request made.");

  await prisma.spaceMember.update({
    where: {
      userId_spaceId: {
        userId: user.id,
        spaceId: check.id,
      },
    },
    data: {
      roles: ["MEMBER","OWNER"],
    },
  });

  await prisma.spaceMember.update({
    where: {
      userId_spaceId: {
        userId: userId,
        spaceId: check.id,
      },
    },
    data: {
      roles: ["MEMBER"],
    },
  });

  return res.send({
    success: true,
  });
};
