import { Request, Response } from "express";
import { getS3ObjectURL } from "../clients/s3";
import prisma from "../clients/prisma";
import { returnPostObjectDto } from "./posts.controller";
import { returnSpaceCardDto } from "./spaces.controller";
import {
  getUnauthorizedFactiiiIds,
  getSpaceRuleIds,
  getUnauthorizedUserIds,
} from "../helpers/moderation";

export const getNotifications = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { page = 0 } = req.query;

  const [unauthorizedUserIds, unauthorizedFactiiiIds, spaceRuleIds] =
    await Promise.all([
      getUnauthorizedUserIds(userId),
      getUnauthorizedFactiiiIds(userId),
      getSpaceRuleIds(userId),
    ]);

  const count = await prisma.notification.count({
    where: {
      targetUserId: userId,
    },
  });

  const notifications = await prisma.notification.findMany({
    where: {
      targetUserId: userId,
    },
    select: {
      id: true,
      type: true,
      read: true,
      referenceUser: {
        select: {
          username: true,
          name: true,
          id: true,
          avatar: true,
        },
      },
      targetUser: {
        select: {
          username: true,
          name: true,
          id: true,
          avatar: true,
        },
      },
      repost: {
        select: {
          id: true,
        },
      },
      referenceSpace: {
        select: {
          id: true,
        },
      },
    },
    orderBy: {
      createdAt: "desc",
    },
    skip: 10 * Number(page),
    take: 10,
  });

  await prisma.notification.updateMany({
    where: {
      targetUserId: userId,
      read: false,
    },
    data: {
      read: true,
    },
  });

  return res.send({
    count,
    notifications: await Promise.all(
      notifications.map(async (n) => {
        return {
          id: n.id,
          type: n.type,
          read: n.read,
          targetUser: {
            id: n.targetUser.id,
            username: n.targetUser.username,
            name: n.targetUser.name,
            avatar: getS3ObjectURL(n.targetUser.avatar?.key),
          },
          referenceUser: {
            id: n.referenceUser.id,
            username: n.referenceUser.username,
            name: n.referenceUser.name,
            avatar: getS3ObjectURL(n.referenceUser.avatar?.key),
          },
          repost: n.repost
            ? await returnPostObjectDto(
                n.repost.id,
                userId,
                unauthorizedUserIds,
                unauthorizedFactiiiIds,
                spaceRuleIds,
              )
            : undefined,
          referenceSpace: n.referenceSpace
            ? await returnSpaceCardDto(n.referenceSpace.id)
            : undefined,
        };
      }),
    ),
    currentPage: page,
  });
};

export const markAllAsRead = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;

  await prisma.notification.updateMany({
    where: {
      targetUserId: userId,
      read: false,
    },
    data: {
      read: false,
    },
  });

  return res.send({
    completed: true,
  });
};
