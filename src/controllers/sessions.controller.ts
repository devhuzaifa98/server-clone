import { Request, Response } from "express";
import AppError from "../utilities/AppError";
import prisma from "../clients/prisma";
import { getIoInstance } from "../clients/socket";

export const getSessions = async (req: Request, res: Response) => {
  const id: number = req.body.auth?.userId;
  const currentRefreshToken: string = req.body.auth.refresher;

  const sessions = await prisma.session.findMany({
    where: {
      userId: id,
      revokedAt: null,
    },
    select: {
      id: true,
      browserName: true,
      lastUsed: true,
      refreshToken: true,
      device: {
        select: {
          createdAt: true,
          id: true,
        },
      },
    },
    orderBy: {
      lastUsed: "desc",
    },
  });

  return res.send({
    sessions: sessions.map((session) => {
      return {
        id: session.id,
        browserName: session.browserName,
        lastUsed: session.lastUsed,
        thisDevice: session.refreshToken === currentRefreshToken,
        identifier: session.refreshToken,
        device: session.device,
      };
    }),
  });
};

export const endAllSessions = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const refreshToken: string = req.body.auth.refresher;
  const { skipCurrentSession } = req.query;

  endAllSessionsFcn(userId, refreshToken, skipCurrentSession === "true");

  return res.send({
    deleted: true,
  });
};

export const deleteSession = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const refreshToken: string = req.body.auth?.refresher ?? "";

  const { id: sessionId } = req.params;

  const session = await prisma.session.findFirst({
    where: {
      id: Number(sessionId),
      userId: userId,
      revokedAt: null,
    },
    select: {
      id: true,
      socketId: true,
    },
  });

  if (!session) throw new AppError("Error while deleting session");

  await prisma.session.updateMany({
    where: {
      id: session.id,
      userId: userId,
      revokedAt: null,
    },
    data: {
      revokedAt: new Date(),
    },
  });

  if (session.socketId) {
    const io = getIoInstance();
    io.to(session.socketId).emit("logout");
  }

  const user = await prisma.user.findFirst({
    where: {
      id: userId,
    },
    select: {
      twoFaEnabled: true,
    },
  });

  const remainingSessions = await prisma.session.count({
    where: {
      userId,
      revokedAt: null,
      device: {
        isNot: null,
      },
    },
  });

  if (remainingSessions === 0 && user?.twoFaEnabled) {
    await prisma.user.update({
      where: {
        id: userId,
      },
      data: {
        twoFaEnabled: false,
      },
    });

    await prisma.session.update({
      where: {
        refreshToken,
      },
      data: {
        twoFaSecret: null,
      },
    });
  }

  return res.send({
    deleted: true,
  });
};

export const endAllSessionsFcn = async (
  userId: number,
  refreshToken: string,
  skipCurrentSession: boolean = true,
  isFromMobile: boolean = false,
) => {
  const sessionsToRevoke = await prisma.session.findMany({
    where: {
      userId,
      revokedAt: null,
      ...(skipCurrentSession === true && {
        NOT: {
          refreshToken,
        },
      }),
    },
    select: {
      socketId: true,
    },
  });

  await prisma.session.updateMany({
    where: {
      userId,
      revokedAt: null,
      ...(skipCurrentSession === true && {
        NOT: {
          refreshToken,
        },
      }),
    },
    data: {
      revokedAt: new Date(),
    },
  });

  const user = await prisma.user.findFirst({
    where: {
      id: userId,
    },
    select: {
      twoFaEnabled: true,
    },
  });

  const io = getIoInstance();
  sessionsToRevoke.forEach((session) => {
    if (session.socketId) {
      io.to(session.socketId).emit("logout");
    }
  });

  if (user?.twoFaEnabled && !isFromMobile) {
    await prisma.user.update({
      where: {
        id: userId,
      },
      data: {
        twoFaEnabled: false,
      },
    });

    await prisma.session.update({
      where: {
        refreshToken,
      },
      data: {
        twoFaSecret: null,
      },
    });
  }
};
