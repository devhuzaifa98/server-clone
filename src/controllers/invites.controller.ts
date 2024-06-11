import { Request, Response } from "express";
import prisma from "../clients/prisma";
import paid from "../helpers/paid";

export const getInvites = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { page = 0 } = req.query;

  const count = await prisma.user.count({
    where: {
      referredById: userId,
    },
  });

  const invites = await prisma.user.findMany({
    where: {
      referredById: userId,
    },
    select: {
      username: true,
      avatar: {
        select: {
          key: true,
        },
      },
      createdAt: true,
      id: true,
    },
    skip: 10 * Number(page),
    take: 10,
  });
  //TODO add other price stats to reward even more, send email to user about the reward, complete user awards
  return res.send({
    invites: await Promise.all(
      invites.map(async (user) => {
        return {
          ...user,
          joinedAt: user.createdAt,
          state: (await paid(userId)) > 10000 ? "purchased" : "joined",
        };
      }),
    ),
    count,
    currentPage: page,
  });
};
//     const { token } = req.params;
//     const checkReferral = await prisma.referral.findFirst({
//         where: {
//             identifier: token,
//             joinedAt: null,
//         }
//     });

//     if (!checkReferral) throw new AppError("No such invite token found.");

//     return res.send({
//         email: checkReferral.email,
//         identifier: checkReferral.identifier,
//     });
// };
