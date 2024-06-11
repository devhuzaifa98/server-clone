import { UserTag } from ".prisma/client";
import brcrypt from "bcrypt";
import { Request, Response } from "express";
import { sendNotifications } from "../clients/expo";
import prisma from "../clients/prisma";
import { getS3ObjectURL } from "../clients/s3";
import { sendUserDeactivationEmail } from "../clients/ses";
import { getIoInstance } from "../clients/socket";
import isSlug from "../helpers/isSlug";
import {
  getUnauthorizedFactiiiIds,
  getUnauthorizedSpaceIds,
  getUnauthorizedUserIds,
} from "../helpers/moderation";
import { createPushNotificationItems } from "../utilities";
import AppError from "../utilities/AppError";
import emitNotificationCount from "../utilities/emitNotificationCount";

export const returnUserObjectDto = async (userId: number, refUser?: number) => {
  let following: boolean | null = false;

  const user = await prisma.user.findFirst({
    where: {
      id: userId,
    },
    select: {
      id: true,
      name: true,
      username: true,
      bio: true,
      avatar: true,
      robohash: true,
      banner: true,
    },
  });

  if (!user) return Promise.reject(`No user was found with the ID: ${userId}`);

  if (refUser) {
    const check = await prisma.follows.count({
      where: {
        followerId: refUser,
        followingId: user.id,
      },
    });
    following = check === 1;
  }

  if (refUser === user.id) {
    following = null;
  }

  return {
    id: user.id,
    name: user.name,
    username: user.username,
    bio: user.bio,
    avatar: user?.avatar?.key
      ? getS3ObjectURL(user.avatar?.key)
      : `https://robohash.org/${user.robohash}?bgset=bg2`,
    banner: getS3ObjectURL(user.banner?.key),
    following,
  };
};

export const details = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const unauthorizedFactiiiIds = await getUnauthorizedFactiiiIds(userId);

  const [
    user,
    premiumExpires,
    followersCount,
    followingCount,
    spaces,
    factiiiIds,
    pendingNotificationsCount,
    invites,
  ] = await Promise.all([
    prisma.user.findUnique({
      where: {
        id: userId,
      },
      include: {
        avatar: true,
        preferences: true,
        banner: true,
        blockedUsers: true,
        filters: true,
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
          take: 25,
        },
      },
    }),
    //premiumExpires
    prisma.spaceMember.findFirst({
      where: {
        userId,
        space: {
          slug: "premium",
        },
      },
      select: {
        premiumAccessExpires: true,
      },
    }),
    //premiumExpires
    prisma.follows.count({
      where: {
        followingId: userId,
      },
    }),
    //premiumExpires
    prisma.follows.count({
      where: {
        followerId: userId,
      },
    }),
    //premiumExpires
    prisma.spaceMember.findMany({
      where: {
        userId,
      },
      include: {
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
          take: 25,
        },
        space: {
          select: {
            id: true,
            slug: true,
          },
        },
      },
      take: 25, // TODO: Pagination
    }),
    prisma.factiii.findMany({
      where: {
        userId,
      },
      select: {
        id: true,
      },
      take: 25, // Fetch only the first 25 Factiii IDs
    }),
    //pendingNotificationsCount
    prisma.notification.count({
      where: {
        targetUserId: userId,
        read: false,
      },
    }),
    //invites
    prisma.spaceInvite.findMany({
      where: {
        userId,
        joined: false,
      },
      select: {
        space: {
          select: {
            id: true,
            slug: true,
          },
        },
      },
    }),
  ]);

  if (!user) {
    throw new AppError("No account found with that ID");
  }

  return res.send({
    id: user.id,
    name: user.name ?? "Factiii User",
    preferences: user.preferences,
    username: user.username,
    email: user.email,
    emailVerificationStatus: user.emailVerificationStatus,
    bio: user.bio,
    twoFaEnabled: user.twoFaEnabled,
    avatar: user?.avatar?.key
      ? getS3ObjectURL(user.avatar?.key)
      : `https://robohash.org/${user.robohash}?bgset=bg2`,
    banner: getS3ObjectURL(user.banner?.key),
    coinsBalance: user.coinsBalance,
    tronsBalance: Number(user.tronsBalance),
    followersCount,
    followingCount,
    premiumExpires: premiumExpires?.premiumAccessExpires ?? null,
    isModerator: spaces.length > 0,
    pendingNotificationsCount,
    spaces: spaces.map((x) => ({
      id: x.spaceId,
      slug: x.space.slug,
      roles: x.roles,
      expires: x.premiumAccessExpires,
      pinnedFactiiis: x.pinnedFactiiis.map((factiii) => ({
        id: factiii.id,
        name: factiii.name,
        slug: factiii.slug,
        spaceSlug: factiii.space?.slug,
        avatar: factiii?.avatar?.key
          ? getS3ObjectURL(factiii.avatar.key)
          : undefined,
        requirements: factiii.requirements,
      })),
    })),
    invitedSpaces: invites.map((x) => ({
      id: x.space.id,
      slug: x.space.slug,
    })),
    factiiiIds: factiiiIds.map((x) => x.id),
    blockedUsers: user.blockedUsers.map((user) => user.username),
    spaceFilterIds: user.filters.map((x) => x.spaceId),
    pinnedFactiiis: user.pinnedFactiiis.map((factiii) => ({
      id: factiii.id,
      name: factiii.name,
      slug: factiii.slug,
      spaceSlug: factiii.space?.slug,
      avatar: factiii?.avatar?.key
        ? getS3ObjectURL(factiii.avatar.key)
        : undefined,
      requirements: factiii.requirements,
    })),
  });
};
export const setSocketId = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const refreshToken: string = req.body.auth.refresher;
  const { socketId }: { socketId: string | undefined } = req.body;

  if (userId === 0) {
    //User not logged in so do nothing
    return res.send();
  }

  await prisma.session.update({
    where: {
      userId,
      refreshToken,
    },
    data: {
      socketId,
    },
  });

  return res.send();
};

export const publicDetails = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { username }: { username?: string } = req.params;

  const unauthorizedUserIds = await getUnauthorizedUserIds(userId);
  const unauthorizedFactiiiIds = await getUnauthorizedFactiiiIds(userId);

  const publicUser = await prisma.user.findFirst({
    where: {
      id: {
        notIn: unauthorizedUserIds,
      },
      username,
    },
    select: {
      id: true,
      username: true,
      name: true,
      bio: true,
      avatar: true,
      banner: true,
      robohash: true,
      preferences: {
        select: {
          hideProfileHistory: true,
          privatePinnedFactiiis: true,
        },
      },
      blockedBy: {
        where: {
          id: userId,
        },
        select: {
          id: true,
        },
      },
      blockedUsers: {
        where: {
          id: userId,
        },
        select: {
          id: true,
        },
      },
      mutedUsers: {
        where: {
          muterId: userId,
        },
        select: {
          mutedUserId: true,
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
          description: true,
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
  });

  if (!publicUser) {
    throw new AppError("No user found with that username");
  }

  const [followersCount, followingCount] = await Promise.all([
    //followersCount
    prisma.follows.count({
      where: {
        AND: [
          { followingId: publicUser.id },
          {
            followerId: {
              notIn: unauthorizedUserIds,
            },
          },
        ],
      },
    }),
    //followingCount
    prisma.follows.count({
      where: {
        AND: [
          { followerId: publicUser.id },
          {
            followingId: {
              notIn: unauthorizedUserIds,
            },
          },
        ],
      },
    }),
  ]);

  const [checkFollowing, checkMute] = await Promise.all([
    //checkFollowing
    prisma.follows.count({
      where: {
        followerId: userId,
        followingId: publicUser.id,
      },
    }),
    //checkMute
    prisma.userMute.count({
      where: {
        muterId: userId,
        mutedUserId: publicUser.id,
      },
    }),
  ]);

  return res.send({
    id: publicUser.id,
    username: publicUser.username,
    name: publicUser.name ?? "Factiii User",
    bio: publicUser.bio ?? "",
    avatar: publicUser?.avatar?.key
      ? getS3ObjectURL(publicUser.avatar?.key)
      : `https://robohash.org/${publicUser.robohash}?bgset=bg2`,
    banner: getS3ObjectURL(publicUser.banner?.key),
    followersCount,
    followingCount,
    following: checkFollowing === 1,
    muted: checkMute === 1,
    blocked: publicUser.blockedUsers.length > 0,
    blockedByUser: publicUser.blockedBy.length > 0,
    pinnedFactiiis: publicUser.preferences?.privatePinnedFactiiis
      ? []
      : publicUser.pinnedFactiiis.map((factiii) => ({
          id: factiii.id,
          name: factiii.name,
          slug: factiii.slug,
          description: factiii.description,
          spaceSlug: factiii.space?.slug,
          avatar: factiii?.avatar?.key
            ? getS3ObjectURL(factiii.avatar.key)
            : undefined,
          requirements: factiii.requirements,
        })),
  });
};

export const deactivate = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { password }: { password: string } = req.body;

  const user = await prisma.user.findFirst({
    where: {
      id: userId,
    },
    select: {
      id: true,
      email: true,
      username: true,
      password: true,
    },
  });

  if (!user) {
    throw new AppError("Invalid user auth data.");
  }

  const isMatch = await brcrypt.compare(password, user.password);
  if (!isMatch) {
    throw new AppError(
      "The current password you provided is wrong. Try again.",
    );
  }

  await Promise.all([
    prisma.user.updateMany({
      where: {
        id: userId,
        status: "ACTIVE",
      },
      data: {
        status: "DEACTIVATED",
      },
    }),
    prisma.session.updateMany({
      where: {
        userId: userId,
      },
      data: {
        revokedAt: new Date(),
      },
    }),
    sendUserDeactivationEmail(user.email, user.username),
  ]);

  return res.send({
    deactivated: true,
  });
};

export const updateUser = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { name, bio, avatarId, bannerId, robohash } = req.body;

  const check = await prisma.user.findFirst({
    where: {
      id: userId,
    },
    select: {
      id: true,
      name: true,
      bio: true,
      avatarId: true,
      bannerId: true,
      robohash: true,
    },
  });

  if (!check) {
    throw new AppError("No such account found.");
  }

  const user = await prisma.user.update({
    where: {
      id: check.id,
    },
    data: {
      name,
      bio,
      avatarId: avatarId === "__removeAvatarNULL" ? null : avatarId,
      bannerId,
      robohash: robohash ? robohash : undefined,
    },
    select: {
      name: true,
      bio: true,
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
    },
  });

  // Add the updated item(s) to the History model
  if (name && name !== check.name) {
    await prisma.history.create({
      data: {
        userId,
        column: "name",
        value: check.name,
      },
    });
  }
  if (bio && bio !== check.bio) {
    await prisma.history.create({
      data: {
        userId,
        column: "bio",
        value: check.bio ? check.bio : "null",
      },
    });
  }
  if (robohash && robohash !== check.robohash) {
    await prisma.history.create({
      data: {
        userId,
        column: "robohash",
        value: check.robohash as any,
      },
    });
  }
  if (bannerId && bannerId !== check.bannerId) {
    await prisma.history.create({
      data: {
        userId,
        column: "bannerId",
        value: check.bannerId ? check.bannerId : "null",
      },
    });
  }
  if (avatarId && avatarId !== check.avatarId) {
    if (check.avatarId === null) {
      await prisma.history.create({
        data: {
          userId,
          column: "robohash",
          value: check.robohash as any,
        },
      });
    } else {
      await prisma.history.create({
        data: {
          userId,
          column: "avatarId",
          value: check.avatarId as any,
        },
      });
    }
  }

  return res.send({
    name: user.name,
    bio: user.bio,
    avatar: user.avatar?.key
      ? getS3ObjectURL(user.avatar?.key)
      : `https://robohash.org/${user.robohash}?bgset=bg2`,
    banner: getS3ObjectURL(user.banner?.key),
    robohash: user.robohash,
  });
};

export const follow = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { username } = req.params;

  const fromUser = await prisma.user.findFirst({
    where: {
      id: {
        notIn: await getUnauthorizedUserIds(userId),
        equals: userId,
      },
    },
    select: {
      id: true,
      username: true,
      name: true,
      avatar: true,
      robohash: true,
    },
  });

  if (!fromUser) throw new AppError("Invalid request. Please try again.");

  if (!username) throw new AppError("Invalid request. Please try again.");

  const user = await prisma.user.findFirst({
    where: {
      username,
    },
    select: {
      id: true,
      username: true,
      sessions: {
        where: {
          refreshToken: req.body.auth.refresher,
        },
        select: {
          socketId: true,
        },
      },
    },
  });

  if (!user?.id) throw new AppError("Invalid request. Please try again.");

  if (user.id === userId) throw new AppError("You cannot follow yourself.");

  await prisma.follows.create({
    data: {
      followerId: userId,
      followingId: user.id,
    },
  });

  await prisma.notification.create({
    data: {
      targetUserId: user.id,
      referenceUserId: userId,
      type: "FOLLOWED",
    },
  });
  if (user.sessions.length === 1 && user.sessions[0].socketId) {
    await emitNotificationCount(user.id, user.sessions[0].socketId);
  }

  const pushItems = await createPushNotificationItems(
    user.id,
    `@${fromUser.username} just followed you.`,
    undefined,
    {
      screen: "Profile",
      data: {
        username: fromUser.username,
        name: fromUser.name,
        avatar: fromUser?.avatar?.key
          ? getS3ObjectURL(fromUser.avatar?.key)
          : `https://robohash.org/${fromUser.robohash}?bgset=bg2`,
      },
    },
  );
  await sendNotifications(pushItems);

  return res.send({
    followed: true,
  });
};

export const unfollow = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { username } = req.params;

  if (!username) throw new AppError("Invalid request. Please try again.");

  const user = await prisma.user.findFirst({
    where: {
      username,
    },
    select: {
      id: true,
    },
  });

  if (!user?.id) throw new AppError("Invalid request. Please try again.");

  await prisma.follows.deleteMany({
    where: {
      followerId: userId,
      followingId: user.id,
    },
  });

  await prisma.notification.deleteMany({
    where: {
      targetUserId: user.id,
      referenceUserId: userId,
    },
  });

  return res.send({
    unfollowed: true,
  });
};

export const followersList = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { username } = req.params;
  const { page = 0 } = req.query;

  const unauthorizedUserIds = await getUnauthorizedUserIds(userId);

  const publicUser = await prisma.user.findFirst({
    where: {
      id: {
        notIn: unauthorizedUserIds,
      },
      username,
    },
    select: {
      id: true,
    },
  });

  if (!publicUser) throw new AppError("Invalid user. Please try again.");

  const followers = await prisma.follows.findMany({
    where: {
      followingId: publicUser.id,
      followerId: {
        notIn: unauthorizedUserIds,
      },
    },
    select: {
      follower: {
        select: {
          id: true,
        },
      },
    },
    skip: 10 * Number(page),
    take: 10,
  });

  if (!publicUser) throw new AppError("Invalid request. Please try again.");

  return res.send({
    users: await Promise.all(
      followers.map((x) => returnUserObjectDto(x.follower.id, userId)),
    ),
  });
};

export const followingList = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { username } = req.params;
  const { page = 0 } = req.query;

  const unauthorizedUserIds = await getUnauthorizedUserIds(userId);

  const publicUser = await prisma.user.findFirst({
    where: {
      id: {
        notIn: unauthorizedUserIds,
      },
      username,
    },
    select: {
      id: true,
    },
  });

  if (!publicUser) throw new AppError("Invalid user. Please try again.");

  const following = await prisma.follows.findMany({
    where: {
      followerId: publicUser.id,
      followingId: {
        notIn: unauthorizedUserIds,
      },
    },
    select: {
      following: {
        select: {
          id: true,
        },
      },
    },
    skip: 10 * Number(page),
    take: 10,
  });

  if (!publicUser) throw new AppError("Invalid request. Please try again.");

  return res.send({
    users: await Promise.all(
      following.map((x) =>
        returnUserObjectDto(x.following.id, req.body.auth?.userId),
      ),
    ),
    currentPage: page,
  });
};

// If you edit this MAKE SURE to update preferences.ts in DOMAIN
type Preferences = {
  awardsVisibilityPrivate: boolean;
  allowProfanity: boolean;
  betaAccess: boolean;
  allowPoliticalContent: boolean;
  allowNSFWContent: boolean;
  hidePostsOnProfile: boolean;
  hideProfileHistory: boolean;
  privatePinnedFactiiis: boolean;
};

export const updatePreferences = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const payload = req.body.payload as Preferences;

  await prisma.userPreference.update({
    where: {
      userId,
    },
    data: payload,
  });

  return res.send({
    updated: true,
  });
};

export const muteUser = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { username } = req.params;

  if (!username) throw new AppError("Invalid request. Please try again.");

  const user = await prisma.user.findFirst({
    where: {
      username,
    },
    select: {
      id: true,
      username: true,
    },
  });

  if (!user?.id) throw new AppError("Invalid request. Please try again.");

  if (user.id === userId) throw new AppError("You cannot mute yourself.");

  await prisma.userMute.create({
    data: {
      muterId: userId,
      mutedUserId: user.id,
    },
  });

  return res.send({
    muted: true,
  });
};

export const unmuteUser = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { username } = req.params;

  if (!username) throw new AppError("Invalid request. Please try again.");

  const user = await prisma.user.findFirst({
    where: {
      username,
    },
    select: {
      id: true,
      username: true,
    },
  });

  if (!user?.id) throw new AppError("Invalid request. Please try again.");

  await prisma.userMute.deleteMany({
    where: {
      muterId: userId,
      mutedUserId: user.id,
    },
  });

  return res.send({
    unmuted: true,
  });
};

export const pinPost = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { postId } = req.params;

  const checkPost = await prisma.post.findFirstOrThrow({
    where: {
      uuid: postId,
    },
    select: {
      id: true,
    },
  });

  await prisma.user.update({
    where: {
      id: userId,
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
  const userId: number = req.body.auth?.userId ?? 0;

  await prisma.user.update({
    where: {
      id: userId,
    },
    data: {
      pinnedPostId: null,
    },
  });

  return res.send({
    unpinned: true,
  });
};

export const registerPushToken = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const refresher: string = req.body.auth?.refresher ?? "";
  const token = req.body.token as string;

  const checkDevice = await prisma.device.findFirst({
    where: {
      pushToken: token,
      sessions: {
        some: {
          refreshToken: refresher,
        },
      },
      users: {
        some: {
          id: userId,
        },
      },
    },
    select: {
      id: true,
    },
  });

  if (!checkDevice) {
    const device = await prisma.device.upsert({
      where: {
        pushToken: token,
      },
      create: {
        pushToken: token,
        sessions: {
          connect: {
            refreshToken: refresher,
          },
        },
        users: {
          connect: {
            id: userId,
          },
        },
      },
      update: {
        sessions: {
          connect: {
            refreshToken: refresher,
          },
        },
        users: {
          connect: {
            id: userId,
          },
        },
      },
    });
  }

  return res.send({
    registered: true,
  });
};

export const deregisterPushToken = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { token } = req.body;

  const device = await prisma.device.findFirst({
    where: {
      users: {
        some: {
          id: userId,
        },
      },
      pushToken: token,
    },
    select: {
      id: true,
    },
  });

  if (device) {
    await prisma.device.update({
      where: {
        id: device.id,
      },
      data: {
        pushToken: undefined,
      },
    });
  }

  return res.send({
    deregistered: true,
  });
};

export const block = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { username } = req.params;

  if (!username) throw new AppError("Invalid request. Please try again.");

  const user = await prisma.user.findFirst({
    where: {
      username,
    },
    select: {
      id: true,
      username: true,
    },
  });

  if (!user?.id) throw new AppError("Invalid request. Please try again.");

  if (user.id === userId) throw new AppError("You cannot block yourself.");

  await Promise.all([
    prisma.user.update({
      where: {
        id: userId,
      },
      data: {
        blockedUsers: {
          connect: {
            username,
          },
        },
      },
    }),
    prisma.follows.deleteMany({
      where: {
        follower: {
          username,
        },
        followingId: userId,
      },
    }),
  ]);

  return res.send({
    blocked: true,
  });
};

export const unblock = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { username } = req.params;

  if (!username) throw new AppError("Invalid request. Please try again.");

  const user = await prisma.user.findFirst({
    where: {
      username,
    },
    select: {
      id: true,
      username: true,
    },
  });

  if (!user?.id) throw new AppError("Invalid request. Please try again.");

  await Promise.all([
    prisma.user.update({
      where: {
        id: userId,
      },
      data: {
        blockedUsers: {
          disconnect: {
            username,
          },
        },
      },
    }),
    prisma.userMute.deleteMany({
      where: {
        muterId: userId,
        mutedUserId: user.id,
      },
    }),
  ]);

  return res.send({
    unblocked: true,
  });
};

export const getProfileHistory = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { username }: { username?: string } = req.params;

  const checkUser = await prisma.user.findFirst({
    where: {
      id: {
        notIn: await getUnauthorizedUserIds(userId),
      },
      username,
    },
    select: {
      username: true,
      name: true,
      bio: true,
      avatar: true,
      banner: true,
      robohash: true,
      preferences: {
        select: {
          hideProfileHistory: true,
        },
      },
    },
  });

  if (!checkUser) throw new AppError("No user exists with that username");

  if (checkUser.preferences?.hideProfileHistory)
    throw new AppError(
      `HIST_DISABLED: @${username} has disabled their profile history`,
    );

  const history = await prisma.history.findMany({
    where: {
      user: {
        username,
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
      username: checkUser.username,
      name: checkUser.name,
      bio: checkUser.bio,
      avatar: checkUser.avatar?.key
        ? getS3ObjectURL(checkUser.avatar?.key)
        : `https://robohash.org/${checkUser.robohash}?bgset=bg2`,
      banner: getS3ObjectURL(checkUser.banner?.key),
      robohash: checkUser.robohash,
    },
  });
};

export const mutedUsers = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId;
  const { page = 0 } = req.query;

  const [user, users] = await Promise.all([
    prisma.user.findFirst({
      where: {
        id: userId,
      },
      select: {
        id: true,
      },
    }),

    prisma.user.findMany({
      where: {
        mutedBy: {
          some: {
            muterId: userId,
          },
        },
      },
      select: {
        id: true,
      },
      skip: 10 * Number(page),
      take: 10,
    }),
  ]);

  if (!user) throw new AppError("Invalid request. Please try again.");

  return res.send({
    users: await Promise.all(
      users.map((x) => returnUserObjectDto(x.id, req.body.auth?.userId)),
    ),
  });
};

export const blockedUsersList = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId;
  const { page = 0 } = req.query;

  const user = await prisma.user.findFirst({
    where: {
      id: userId,
    },
    select: {
      id: true,
      blockedUsers: {
        select: {
          id: true,
        },
      },
    },
  });

  if (!user) throw new AppError("Invalid request. Please try again.");

  const count = user.blockedUsers.length;

  const users = user.blockedUsers.slice(10 * Number(page), 10);

  return res.send({
    users: await Promise.all(
      users.map((x) => returnUserObjectDto(x.id, req.body.auth?.userId)),
    ),
    count,
    currentPage: page,
  });
};

export const getUserFactiii = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { username, factiiiSlug } = req.params;

  const [unauthorizedFactiiiIds, unauthorizedUserIds] = await Promise.all([
    getUnauthorizedFactiiiIds(userId),
    getUnauthorizedUserIds(userId),
  ]);

  const [factiii, factiiis, owners, membersCount] = await Promise.all([
    //factiii
    prisma.factiii.findFirst({
      where: {
        slug: factiiiSlug,
        user: {
          username: username,
        },
      },
      select: {
        id: true,
        data: true,
        rules: true,
        types: true,
        createdAt: true,
        name: true,
        slug: true,
        space: {
          select: {
            slug: true,
          },
        },
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
        user: {
          username: username,
        },
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
        user: {
          username: username,
        },
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
        user: {
          username: username,
        },
        userId,
      },
      select: {
        roles: true,
        subscription: {
          select: {
            id: true,
            expires: true,
          },
        },
      },
    }),
    //membersCount
    prisma.spaceMember.count({
      where: {
        user: {
          username: username,
        },
        userId: {
          notIn: unauthorizedUserIds,
        },
      },
    }),
  ]);

  if (!factiii) {
    throw new Error("Factiii not found");
  }

  return res.send({
    id: factiii.id,
    data: factiii.data,
    rules: factiii.rules,
    types: factiii.types,
    createdAt: factiii.createdAt,
    name: factiii.name,
    description: factiii.description,
    factiiiIds: factiiis.map((x) => x.id),
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
    membersCount,
    requirements: factiii.requirements,
    factiiiSlug: factiii.slug,
    spaceSlug: factiii.space?.slug,
  });
};

export const addFactiii = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { space_slug, factiii_slug } = req.params;
  const { name, rules, types } = req.body;

  const checkSpace = await prisma.space.findFirst({
    where: {
      id: {
        notIn: await getUnauthorizedSpaceIds(userId),
      },
      slug: space_slug,
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

  if (!checkSpace)
    throw new AppError("No space found or you do not have permissions.");

  if (!isSlug(factiii_slug)) throw new AppError("Invalid factiii slug.");

  const newFactiii = await prisma.factiii.create({
    data: {
      name: name as string,
      slug: factiii_slug,
      types: types,
      space: {
        connect: {
          id: checkSpace.id,
        },
      },
      user: {
        connect: {
          id: userId,
        },
      },
    },
    select: {
      id: true,
      name: true,
      slug: true,
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

  if (rules.length > 0) {
    await prisma.rule.create({
      data: {
        title: rules[0].title,
        description: rules[0].description,
        factiiiId: newFactiii.id,
      },
    });
  }

  return res.send({
    id: newFactiii.id,
    name: newFactiii.name,
    factiiiSlug: newFactiii.slug,
    spaceSlug: newFactiii.space?.slug,
    avatar: getS3ObjectURL(newFactiii.avatar?.key),
    requirements: newFactiii.requirements,
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

export const waitList = async (req: Request, res: Response) => {
  const { email } = req.body;

  const checkUser = await prisma.user.findFirst({
    where: {
      email,
    },
    select: {
      id: true,
    },
  });

  if (checkUser) {
    throw new AppError("This email is already registered.");
  }

  const count = await prisma.user.count({
    where: {
      tag: UserTag.WAITLIST,
    },
  });

  await prisma.user.create({
    data: {
      username: `waitlist-${count + 1}`,
      password: "waitlistRANDOM123!@#",
      email: email,
      tag: UserTag.WAITLIST,
    },
  });

  return res.send({
    ok: true,
  });
};

export const pingHandler = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;

  await prisma.user.findFirstOrThrow({
    where: {
      id: userId,
    },
  });

  await prisma.user.update({
    where: {
      id: userId,
    },
    data: {
      lastActive: new Date(Date.now()),
    },
  });

  const user = await prisma.user.findFirst({
    where: {
      id: userId,
    },
    select: {
      lastActive: true,
    },
  });

  let conversations = await prisma.conversation.findMany({
    where: {
      participants: {
        some: {
          userId: {
            equals: userId,
          },
        },
      },
    },
    select: {
      id: true,
    },
  });

  if (conversations) {
    const io = getIoInstance();
    conversations.forEach((conversation) => {
      io.to(`conversation-${conversation.id}`).emit(
        "activity",
        { userId, lastActive: user?.lastActive },
        conversation.id,
      );
    });
  }
  return res.send({
    ok: true,
  });
};

export const togglePinnedFactiiisVisibility = async (
  req: Request,
  res: Response,
) => {
  const userId: number = req.body.auth?.userId ?? 0;

  const user = await prisma.user.findFirstOrThrow({
    where: {
      id: userId,
    },
    select: {
      preferences: {
        select: {
          privatePinnedFactiiis: true,
        },
      },
    },
  });

  await prisma.user.update({
    where: {
      id: userId,
    },
    data: {
      preferences: {
        update: {
          privatePinnedFactiiis: !user.preferences?.privatePinnedFactiiis,
        },
      },
    },
  });

  return res.send({
    isPrivate: !user.preferences?.privatePinnedFactiiis,
  });
};
