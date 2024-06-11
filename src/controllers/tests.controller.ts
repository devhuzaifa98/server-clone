import { Request, Response } from "express";
import prisma from "../clients/prisma";
import AppError from "../utilities/AppError";

// route that will throw a test error to make sure sentry is working
// this route only works for about space owners and moderators
export const sentry = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;

  const about = await prisma.space.findFirstOrThrow({
    where: {
      name: "about",
    },
    select: {
      id: true,
    },
  });

  const user = await prisma.spaceMember.findFirstOrThrow({
    where: {
      userId,
      spaceId: about.id,
      roles: {
        hasSome: ["OWNER", "MODERATOR"],
      },
    },
  });

  if (!user) {
    throw new AppError("You are not authorized to perform this action.");
  } else {
    throw new Error("My first Sentry error!");
  }
};
