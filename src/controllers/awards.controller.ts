import { Request, Response } from "express";
import { getS3ObjectURL } from "../clients/s3";
import prisma from "../clients/prisma";
import AppError from "../utilities/AppError";

export const getAwards = async (req: Request, res: Response) => {
  const findAwards = await prisma.product.findMany({
    where: {
      type: "COIN",
    },
    select: {
      id: true,
      title: true,
      images: {
        select: {
          key: true,
        },
      },
    },
  });

  return res.send({
    awards: findAwards.map((award) => {
      return {
        id: award.id,
        image: getS3ObjectURL(award.images[0].key),
        coin: {
          awardTitle: award.title,
        },
      };
    }),
  });
};

export const getItems = async (req: Request, res: Response) => {
  const findAwards = await prisma.product.findMany({
    orderBy: {
      price: "asc",
    },
    where: {
      active: true,
      type: "COIN",
    },
    select: {
      id: true,
      title: true,
      images: {
        select: {
          key: true,
        },
      },
      coin: {
        select: {
          premiumDays: true,
          quantity: true,
        },
      },
    },
  });
  const awards = findAwards.map((award) => {
    return {
      id: award.id,
      image: getS3ObjectURL(award.images[0]?.key),
      coin: {
        ...award.coin,
        title: award.title,
      },
    };
  });

  return res.send({
    awards,
  });
};

export const awardPost = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { awardId } = req.params;
  const { postId, anonymous } = req.body;

  const checkPost = await prisma.post.findFirst({
    where: {
      uuid: postId,
    },
    select: {
      userId: true,
      id: true,
    },
  });

  if (!checkPost)
    throw new AppError("No post found with that ID. Please try again");

  const checkAward = await prisma.product.findFirst({
    where: {
      id: +awardId,
    },
    select: {
      id: true,
      coin: {
        select: {
          quantity: true,
          premiumDays: true,
        },
      },
    },
  });

  if (!checkAward || !checkAward.coin)
    throw new AppError("No award item found with that ID. Please try again");

  const fromUser = await prisma.user.findFirst({
    where: {
      id: userId,
    },
    select: {
      coinsBalance: true,
      id: true,
    },
  });

  if (!fromUser)
    throw new AppError("No user found with that ID. Please try again");

  if (checkAward.coin.quantity > fromUser.coinsBalance)
    throw new AppError("Coins not available to award the post");

  await prisma.user.update({
    where: {
      id: fromUser.id,
    },
    data: {
      coinsBalance: {
        decrement: checkAward.coin.quantity,
      },
    },
  });
  const toUser = await prisma.user.findFirst({
    where: {
      id: checkPost.userId,
    },
    select: {
      id: true,
    },
  });
  if (!toUser) throw new AppError("User not found.");

  const siteSettings = await prisma.siteSettings.findMany({
    orderBy: {
      createdAt: "desc",
    },
    take: 1,
    select: {
      coinTronRatio: true,
      coinTransferRatio: true,
    },
  });
  const coinsTransfered = Math.floor(
    checkAward.coin.quantity / siteSettings[0].coinTransferRatio,
  );
  await prisma.user.update({
    where: {
      id: toUser.id,
    },
    data: {
      tronsBalance: {
        increment: coinsTransfered * siteSettings[0].coinTronRatio,
      },
      coinsBalance: {
        increment: coinsTransfered,
      },
    },
  });

  const premiumSpace = await prisma.space.findFirstOrThrow({
    where: {
      slug: "premium",
    },
    select: {
      id: true,
      products: {
        where: {
          title: "Factiii Premium",
          type: "MONTHLY_SUBSCRIPTION",
        },
        select: {
          id: true,
        },
      },
    },
  });

  const spaceMember = await prisma.spaceMember.upsert({
    where: {
      userId_spaceId: {
        userId: toUser.id,
        spaceId: premiumSpace.id,
      },
    },
    create: {
      userId: toUser.id,
      spaceId: premiumSpace.id,
    },
    update: {}, // Do nothing if it exists
    select: {
      premiumAccessExpires: true,
    },
  });

  let date = new Date();
  const today = new Date();
  if (spaceMember.premiumAccessExpires) {
    if (spaceMember.premiumAccessExpires < today) {
      date.setDate(today.getDate() + checkAward.coin.premiumDays);
    } else {
      date.setDate(
        spaceMember.premiumAccessExpires.getDate() +
          checkAward.coin.premiumDays,
      );
    }
  } else {
    date.setDate(today.getDate() + checkAward.coin.premiumDays);
  }
  await prisma.spaceMember.update({
    where: {
      userId_spaceId: {
        userId: toUser.id,
        spaceId: premiumSpace.id,
      },
    },
    data: {
      premiumAccessExpires: date,
    },
  });

  const create = await prisma.postAward.create({
    data: {
      userId: fromUser.id,
      postId: checkPost.id,
      coinId: checkAward.id,
      private: anonymous ? anonymous : false,
    },
  });

  return res.send({
    awarded: true,
    id: create.id,
  });
};

export const history = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const data = await prisma.postAward.findMany({
    where: {
      OR: [
        {
          userId,
        },
        {
          post: {
            userId,
          },
        },
      ],
    },
    include: {
      coin: true,
    },
    orderBy: {
      createdAt: "desc",
    },
  });

  const history = data.map((x) => {
    return {
      date: x.createdAt,
      type: x.userId === userId ? "SENT" : "RECEIVED",
      private: x.private,
      quantity: x.coin.quantity,
      post: x.postId,
    };
  });

  return res.send({ history });
};

export const postAwards = async (req: Request, res: Response) => {
  const { postId } = req.params;

  const checkPost = await prisma.post.findFirstOrThrow({
    where: {
      uuid: postId,
    },
    select: {
      id: true,
    },
  });
  const data = await prisma.postAward.findMany({
    where: {
      postId: checkPost.id,
      private: false,
      user: {
        preferences: {
          awardsVisibilityPrivate: false,
        },
      },
    },
    select: {
      user: {
        select: {
          avatar: true,
          name: true,
          username: true,
        },
      },
      coin: {
        select: {
          quantity: true,
          product: {
            select: {
              title: true,
            },
          },
        },
      },
      createdAt: true,
    },
    orderBy: {
      createdAt: "desc",
    },
  });

  return res.send({
    data: data.map((x) => {
      return {
        user: {
          avatar: getS3ObjectURL(x.user.avatar?.key),
          name: x.user.name,
          username: x.user.username,
        },
        award: {
          coin: {
            title: x.coin.product.title,
            quantity: x.coin.quantity,
          },
          date: x.createdAt,
        },
      };
    }),
  });
};
