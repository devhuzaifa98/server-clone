import { Factiii, ReportType } from "@prisma/client";
import prisma from "../clients/prisma";

export const submitReport = async (
  factiii: Factiii,
  postId: number,
  userId: number,
) => {
  const rule = await prisma.rule.upsert({
    where: {
      factiiiId_spaceId: {
        factiiiId: factiii.id,
        spaceId: factiii.spaceId ?? 0,
      },
    },
    update: {},
    create: {
      factiiiId: factiii.id,
      spaceId: factiii.spaceId,
      title: factiii.name,
      description: "This post has been tagged with a NSFW or Politics factiii",
    },
    select: {
      id: true,
      title: true,
    },
  });

  return await prisma.report.create({
    data: {
      type: ReportType.FACTIII,
      ruleId: rule.id,
      userId: userId,
      comment: rule.title,
      reportedPostId: postId,
    },
  });
};
