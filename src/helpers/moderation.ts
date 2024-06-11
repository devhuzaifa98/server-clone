import prisma from "../clients/prisma";
import AppError from "../utilities/AppError";

export const getUnauthorizedFactiiiIds = async (userId: number) => {
  const unauthorizedFactiiis: { id: number }[] = await prisma.factiii.findMany({
    where: {
      OR: [
        {
          types: {
            has: "PRIVATE",
          },
          userId: {
            not: userId,
          },
        },
      ],
    },
    select: {
      id: true,
    },
  });

  return unauthorizedFactiiis.map((space) => space.id);
};

export const getUnauthorizedSpaceIds = async (userId: number) => {
  const unauthorizedPrivateSpaces = await prisma.space.findMany({
    where: {
      types: {
        has: "PRIVATE",
      },
      members: {
        none: {
          userId,
        },
      },
    },
    select: {
      id: true,
    },
  });

  //Premium lock is based off of factiii space
  const premiumId = await prisma.space.findFirstOrThrow({
    where: {
      slug: "premium",
    },
    select: {
      id: true,
    },
  });
  const factiiiPremium = await prisma.spaceMember.findFirst({
    where: {
      spaceId: premiumId.id,
      userId,
      subscription: {
        expires: {
          gte: new Date(),
        },
      },
    },
    select: {
      spaceId: true,
    },
  });
  const unauthorizedPremiumSpaces = factiiiPremium
    ? []
    : await prisma.space.findMany({
        where: {
          types: {
            has: "PREMIUM",
          },
          members: {
            none: {
              userId,
            },
          },
        },
        select: {
          id: true,
        },
      });

  const spaceIds: number[] = [
    ...unauthorizedPrivateSpaces,
    ...unauthorizedPremiumSpaces,
  ].map((space) => space.id);

  return [...spaceIds];
};

export const getUnauthorizedUserIds = async (userId: number) => {
  const [unauthorizedUsers, bannedUsers, blockedByIds] = await Promise.all([
    //unauthorizedUsers
    prisma.user.findMany({
      where: {
        id: {
          not: userId,
        },
        OR: [
          {
            //Hand users who are not active
            NOT: {
              status: "ACTIVE",
            },
          },
          {
            //Handle private users
            types: {
              has: "PRIVATE",
            },
          },
          {
            //Handle blocked users
            blockedUsers: {
              some: {
                id: userId,
              },
            },
          },
        ],
      },
      select: {
        id: true,
      },
    }),
    //bannedUsers
    getBannedUsersListFromSpaceFilter(userId || 0),
    //blockedByIds
    getBlockedByUserIds(userId || 0),
  ]);

  //Set deduplicates the arrays
  return [
    ...new Set(
      unauthorizedUsers
        .map((user) => user.id)
        .concat(bannedUsers)
        .concat(blockedByIds),
    ),
  ];
};

export const getBlockedByUserIds = async (
  userId: number,
): Promise<number[]> => {
  let filters;

  filters = await prisma.user.findMany({
    where: {
      id: userId,
    },
    select: {
      blockedBy: {
        select: {
          id: true,
        },
      },
    },
  });

  const blockedByIds =
    userId == 0 ? [] : filters[0]?.blockedBy.map((user) => user.id);

  return blockedByIds;
};

export const getMutedUserIds = async (userId: number): Promise<number[]> => {
  let filters;

  filters = await prisma.userMute.findMany({
    where: {
      muterId: userId,
    },
    select: {
      mutedUserId: true,
    },
  });

  const mutedUserIds =
    userId == 0 ? [] : filters?.map((user) => user.mutedUserId);
  return mutedUserIds;
};

export const getBannedUsersListFromSpaceFilter = async (userId: number) => {
  let bannedUsers: number[] = [];
  if (userId === 0) {
    const factiiiSpace = await prisma.space.findFirstOrThrow({
      where: {
        slug: "factiii",
      },
      select: {
        id: true,
      },
    });
    const bannedUserIds = await prisma.ban.findMany({
      where: {
        spaceId: factiiiSpace.id,
        expiresAt: {
          gte: new Date(),
        },
      },
      select: {
        userId: true,
      },
    });
    bannedUsers = bannedUserIds.map((ban) => ban.userId);
  } else {
    const user = await prisma.user.findFirst({
      where: {
        id: userId,
      },
      select: {
        id: true,
        filters: {
          select: {
            space: {
              select: {
                banned: {
                  where: {
                    expiresAt: {
                      gte: new Date(),
                    },
                  },
                  select: {
                    userId: true,
                  },
                },
              },
            },
          },
        },
      },
    });
    if (!user) throw new AppError("Invalid request");

    const list = user.filters.map((x) => x.space.banned.map((y) => y.userId));
    bannedUsers = list.flat(3) || [];
  }

  return bannedUsers;
};

export const getSpaceRuleIds = async (userId: number): Promise<number[]> => {
  const filters =
    // If userId is 0 then user is logged out
    // Use the factiii space as the default filter space when logged out
    userId === 0
      ? await prisma.spaceFilter.findMany({
          where: {
            space: {
              slug: "factiii",
            },
          },
          select: {
            spaceId: true,
          },
        })
      : await prisma.spaceFilter.findMany({
          where: {
            userId,
          },
          select: {
            spaceId: true,
          },
        });
  const filterIds = filters.map((filter) => filter.spaceId);

  const rules = await prisma.rule.findMany({
    where: {
      spaceId: {
        in: filterIds.length > 0 ? filterIds : [1],
      },
    },
  });
  return rules.map((rule) => rule.id);
};
