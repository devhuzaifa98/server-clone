import { Request, Response } from "express";
import AppError from "../utilities/AppError";
import prisma from "../clients/prisma";
import { getS3ObjectURL } from "../clients/s3";
import { returnPostObjectDto } from "./posts.controller";

/**
 * @returns all the rules of the s/factiii space
 */
export const getRulesList = async (req: Request, res: Response) => {
  const { postId } = req.query;

  const rules: any[] = [];

  const defaultRules = await prisma.rule.findMany({
    where: {
      space: {
        slug: "factiii",
      },
    },
    select: {
      id: true,
      title: true,
    },
  });
  rules.push(...defaultRules);

  if (!postId == undefined) {
    const check = await prisma.post.findFirst({
      where: {
        uuid: postId as any,
      },
      select: {
        space: {
          select: {
            slug: true,
          },
        },
        id: true,
      },
    });

    if (check && check.space && check.space.slug !== "factiii") {
      const newRules = await prisma.rule.findMany({
        where: {
          space: {
            slug: check.space.slug,
          },
        },
        select: {
          id: true,
          title: true,
        },
      });
      rules.push(...newRules);
    }
  }

  return res.send(rules.sort((a, b) => a.id - b.id));
};

/**
 * @authRequired
 *
 * @body ruleId: The ID of the rule that the target violates
 * @body comment: [OPTIONAL] Any additional comments given about the report
 * @body type: ["POST", "USER", "SPACE"]: Enum indicating the type of target
 * @body targetId: ID of the target (`type`) that is being reported
 *
 * @returns an object with property `reported` indicating the new report was saved
 */
export const newModerationReport = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { ruleId, comment, type, targetId } = req.body;

  if (type === "POST") {
    const reportedPost = await prisma.post.findFirstOrThrow({
      where: {
        uuid: targetId,
      },
      select: {
        id: true,
        spaceId: true,
      },
    });
    await prisma.report.create({
      data: {
        type,
        ruleId,
        comment,
        userId,
        reportedPostId: reportedPost.id,
        reportedSpaceId: reportedPost.spaceId
      },
    });
  } else if (type === "USER") {
    const reportedUser = await prisma.user.findFirstOrThrow({
      where: {
        username: targetId,
      },
      select: {
        id: true,
      },
    });
    await prisma.report.create({
      data: {
        type,
        ruleId,
        comment,
        userId,
        reportedUserId: reportedUser.id,
      },
    });
  } else if (type === "SPACE") {
    const reportedSpace = await prisma.space.findFirstOrThrow({
      where: {
        slug: targetId,
      },
      select: {
        id: true,
      },
    });

    await prisma.report.create({
      data: {
        type,
        ruleId,
        comment,
        userId,
        reportedSpaceId: reportedSpace.id,
      },
    });
  } else {
    throw new AppError("Invalid `type` provided.");
  }

  return res.send({
    reported: true,
  });
};

/**
 * @authRequired
 *
 * @returns the list of all the spaces the user moderates
 */
export const getModeratorPermissionsList = async (
  req: Request,
  res: Response,
) => {
  const userId: number = req.body.auth?.userId ?? 0;

  const listRaw = await prisma.spaceMember.findMany({
    where: {
      userId,
      roles: {
        hasSome: ["MODERATOR", "OWNER"],
      },
    },
    select: {
      space: {
        select: {
          slug: true,
        },
      },
    },
  });

  return res.send({
    spaces: listRaw.map((com) => com.space.slug),
  });
};

/**
 * @authRequired
 *
 * @returns all the pending moderation reports for a space or the platform
 */
export const getModerationReports = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { page = 0 } = req.query;
  const { slug } = req.params;

  // check if the user has the permissions to get reports
  const check = await prisma.spaceMember.count({
    where: {
      roles: {
        hasSome: ["MODERATOR", "OWNER"],
      },
      userId,
    },
  });

  if (check === 0)
    throw new AppError("You do not have the permissions to view this resource");

  // get the list of spaces the user moderates
  let spaceIds;
  if (slug === "all") {
    const modIds = await prisma.spaceMember.findMany({
      where: {
        userId,
        roles: {
          hasSome: ["MODERATOR", "OWNER"],
        },
      },
      select: {
        spaceId: true,
      },
    });
    spaceIds = modIds.map((item) => item.spaceId);
  }

  // get the reports
  const reports = await prisma.report.findMany({
    where: {
      status: "PENDING",
      ...((slug !== "all" && slug !== "discarded") && {
        rule: {
          space: {
            slug,
          }
        }
      }),
      ...(slug === "all" && {
        rule: {
          spaceId: {
            in: spaceIds,
          }
        }
      }),
      ...(slug === "discarded" && {
        status: "DISCARDED",
        actionTakenById: userId,
      }),
    },
    select: {
      id: true,
      reportedPost: {
        select: {
          id: true,
          content: true,
          user: {
            select: {
              avatar: true,
              name: true,
              username: true,
              robohash: true,
            },
          },
        },
      },
      reportedUser: {
        select: {
          id: true,
          avatar: true,
          robohash: true,
          name: true,
          username: true,
          bio: true,
          followedBy: true,
          following: true,
          posts: true,
        },
      },
      reportedSpace: {
        select: {
          id: true,
          avatar: true,
          robohash: true,
          name: true,
          slug: true,
          description: true,
          members: true,
          posts: true,
        },
      },
      reportedUpload: {
        select: {
          id: true,
          key: true,
        },
      },
      user: {
        select: {
          name: true,
          username: true,
          avatar: true,
          robohash: true,
        },
      },
      type: true,
      createdAt: true,
      comment: true,
      status: true,
    },
    orderBy: {
      createdAt: "asc",
    },
    take: 10,
    skip: 10 * Number(page),
  });

  return res.send({
    reports: await Promise.all(
      reports.map(async (report) => {
        if (report.type === "AVATAR" && report.reportedUpload) {
          return {
            type: report.type,
            id: report.id,
            comment: report.comment,
            date: report.createdAt,
            reporter: {
              name: report.user.name,
              username: report.user.username,
              avatar: report.user.avatar?.key
                ? getS3ObjectURL(report.user.avatar.key)
                : `https://robohash.org/${report.user.robohash}?bgset=bg2`,
            },
            data: {
              avatar: getS3ObjectURL(report.reportedUpload.key),
            },
          };
        } else if (report.type === "BANNER" && report.reportedUpload) {
          return {
            type: report.type,
            id: report.id,
            comment: report.comment,
            date: report.createdAt,
            reporter: {
              name: report.user.name,
              username: report.user.username,
              avatar: report.user.avatar?.key
                ? getS3ObjectURL(report.user.avatar.key)
                : `https://robohash.org/${report.user.robohash}?bgset=bg2`,
            },
            data: {
              avatar: getS3ObjectURL(report.reportedUpload.key),
            },
          };
        } else if (report.type === "BIO" && report.reportedPost) {
          //TODO
        } else if (
          (report.type === "POST" ||
            report.type === "FACTIII" ||
            report.type === "USER" ||
            report.type === "SPACE") &&
          (report.reportedPost || report.reportedUser || report.reportedSpace)
        ) {
          let previousReportsCount;
          if (report.type === "POST" && report.reportedPost) {
            previousReportsCount = await prisma.report.count({
              where: {
                reportedPostId: report.reportedPost.id,
              },
            });
          } else if (report.type === "USER" && report.reportedUser) {
            previousReportsCount = await prisma.report.count({
              where: {
                reportedUserId: report.reportedUser.id,
              },
            });
          } else if (report.type === "SPACE" && report.reportedSpace) {
            previousReportsCount = await prisma.report.count({
              where: {
                reportedSpaceId: report.reportedSpace.id,
              },
            });
          }
          return {
            type: report.type,
            id: report.id,
            comment: report.comment,
            date: report.createdAt,
            reporter: {
              name: report.user.name,
              username: report.user.username,
              avatar: report.user.avatar?.key
                ? getS3ObjectURL(report.user.avatar.key)
                : `https://robohash.org/${report.user.robohash}?bgset=bg2`,
            },
            data: report.reportedPost
              ? {
                  id: report.reportedPost.id,
                  name: report.reportedPost.user.name,
                  username: report.reportedPost.user.username,
                  avatar: report.reportedPost.user.avatar?.key
                    ? getS3ObjectURL(report.reportedPost.user.avatar?.key)
                    : `https://robohash.org/${report.reportedPost.user.robohash}?bgset=bg2`,
                  content: report.reportedPost.content,
                  previousReportsCount,
                  post: await returnPostObjectDto(
                    report.reportedPost.id,
                    userId,
                    [],
                    [],
                    [],
                  ),
                }
              : report.type === "SPACE" && report.reportedSpace
                ? {
                    name: report.reportedSpace.name,
                    slug: report.reportedSpace.slug,
                    description: report.reportedSpace.description,
                    membersCount: report.reportedSpace.members.length,
                    postCount: report.reportedSpace.posts.length,
                    avatar: report.reportedSpace.avatar?.key
                      ? getS3ObjectURL(report.reportedSpace.avatar.key)
                      : `https://robohash.org/${report.reportedSpace.robohash}?bgset=bg2`,
                    previousReportsCount,
                  }
                : {
                    id: report.reportedUser?.id,
                    name: report.reportedUser?.name,
                    username: report.reportedUser?.username,
                    bio: report.reportedUser?.bio,
                    followersCount: report.reportedUser?.followedBy.length,
                    followingCount: report.reportedUser?.following.length,
                    postCount: report.reportedUser?.posts.length,
                    avatar: report.reportedUser?.avatar?.key
                      ? getS3ObjectURL(report.reportedUser.avatar.key)
                      : `https://robohash.org/${report.reportedUser?.robohash}?bgset=bg2`,
                    previousReportsCount,
                  },
            status: report.status,
          };
        } else {
          throw new AppError("An error occured while structuring the data.");
        }
      }),
    ),
    currentPage: page,
  });
};

/**
 * @authRequired
 *
 * @returns an object with property `discarded` indicating the report was discarded
 */
export const discardModerationReport = async (req: Request, res: Response) => {
  const { id } = req.params;
  const userId: number = req.body.auth?.userId ?? 0;

  const check = await prisma.spaceMember.count({
    where: {
      roles: {
        hasSome: ["MODERATOR", "OWNER"],
      },
      userId,
    },
  });

  if (check === 0)
    throw new AppError("You do not have the permissions to view this resource");

  await prisma.report.updateMany({
    where: {
      id,
    },
    data: {
      status: "DISCARDED",
      actionTakenById: userId,
    },
  });

  return res.send({
    discarded: true,
  });
};

/**
 * @authRequied
 *
 * @returns an object with property `success` indicating the action was taken for the report
 */
export const moderationReportAction = async (req: Request, res: Response) => {
  const { id } = req.params;
  const userId: number = req.body.auth?.userId ?? 0;

  const check = await prisma.spaceMember.count({
    where: {
      roles: {
        hasSome: ["MODERATOR", "OWNER"],
      },
      userId,
    },
  });

  if (check === 0)
    throw new AppError("You do not have the permissions to view this resource");

  const report = await prisma.report.findFirst({
    where: { id },
    select: {
      id: true,
      type: true,
      reportedPostId: true,
    },
  });

  if (!report) throw new AppError("No report found. Please try again.");

  await prisma.report.update({
    where: {
      id: report.id,
    },
    data: {
      status: "CONTENT_REMOVED",
      actionTakenById: userId,
    },
  });

  return res.send({
    success: true,
  });
};

/**
 * @authRequired
 *
 * @body message: [OPTIONAL] Any additional comments given about the report
 * @body feedbackType: ['SUSUGGESTION', 'BUG_REPORT']: Enum indicating the type of target
 * @body includeDiagnosticData: boolean indicating whether diag. data is collected
 *
 * @returns an object with property `ok` indicating the new report was saved
 */
export const newFeedback = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { mediaId, message, includeDiagnosticsData, feedbackType } = req.body;

  await prisma.feedback.create({
    data: {
      message,
      type: feedbackType,
      // TODO: Create a new Anonymous user and assign these to that account
      user: {
        connect: {
          ...(userId
            ? {
                id: userId,
              }
            : {
                username: "parik",
              }),
        },
      },
      includeDiagnosticsData,
      mediaId,
    },
  });

  return res.send({
    ok: true,
  });
};
