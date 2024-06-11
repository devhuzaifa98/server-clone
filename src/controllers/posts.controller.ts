import { FactiiiRequirement, Space, SpaceTime, User } from "@prisma/client";
import { Request, Response } from "express";
import { sendNotifications } from "../clients/expo";
import prisma from "../clients/prisma";
import { getS3ObjectURL } from "../clients/s3";
import { getIoInstance } from "../clients/socket";
import { generatePostRank } from "../helpers";
import contentFilter from "../helpers/contentFilter/contentFilter";
import {
  getMutedUserIds,
  getSpaceRuleIds,
  getUnauthorizedFactiiiIds,
  getUnauthorizedSpaceIds,
  getUnauthorizedUserIds,
} from "../helpers/moderation";
import { processFactiiis } from "../helpers/processFactiiis";
import { createPushNotificationItems } from "../utilities";
import AppError from "../utilities/AppError";
import awardCoinsReward from "../utilities/awardCoinsReward";
import emitNotificationCount from "../utilities/emitNotificationCount";
import generateOpenAiImageToPost from "../utilities/generateOpenAiImageToPost";
import generateOpenAiReplyToPost from "../utilities/generateOpenAiReplyToPost";

enum VoteType {
  UPVOTE = "UPVOTE",
  DOWNVOTE = "DOWNVOTE",
}

interface PostDto {
  id: string;
  createdAt: Date;
  parentPostId?: string;
  content: string;
  uploads: UploadDto[] | null;
  user: UserDto;
  replies_count: number;
  voteCount: number;
  voted: null | "UPVOTE" | "DOWNVOTE";
  saved: boolean;
  edited: boolean;
  awards: AwardDto[];
  factiiis: FactiiiDto[];
  approvedFactiiis: ApprovedFactiiiDto[];
  dataFactiiis: DataFactiiiDto[];
  openaiReply?: PostDto | null; // Recursive type reference for nested posts
  repost?: PostDto | null; // Recursive type reference for reposts
  space?: string | null;
  //Types added after response
  pinned?: boolean;
  replies?: PostDto[];
}

type UserDto = Pick<User, "id" | "username" | "name" | "robohash" | "tag"> & {
  avatar: string | null; // Manually adjust avatar to be a string
};

type AwardDto = {
  coinId: number;
  _count: {
    coinId: number;
  };
};

type FactiiiDto = {
  name?: string | undefined;
  factiiiId: number;
  _count: {
    factiiiId: number;
  };
};

type DataFactiiiDto = {
  data: string | null;
  factiiiId: number;
  spaceTimes: SpaceTime[];
  uploads: UploadDto[] | null;
  factiii: {
    space: Space | null;
    name: string | null;
    requirements: FactiiiRequirement[];
  };
};

type UploadDto = {
  id: string;
  url: string | null;
  type: string;
  name?: string | null;
  size?: number | null;
  isFactiii: boolean;
};

type ApprovedFactiiiDto = {
  factiiiId: number;
  _count: {
    factiiiId: number;
  };
};

export const returnPostObjectDto = async (
  postId: number,
  userId: number,
  unauthorizedUserIds: number[],
  unauthorizedFactiiiIds: number[],
  spaceRuleIds: number[],
  isWithdrawnQuery?: boolean,
): Promise<PostDto | null> => {
  const post = await prisma.post.findFirst({
    where: {
      id: postId,
    },
    select: {
      id: true,
      uuid: true,
      content: true,
      status: true,
      userId: true,
      repostId: true,
      voteCount: true,
      createdAt: true,
      parentPostId: true,
      anonymous: true,
      parentPost: {
        select: {
          uuid: true,
        },
      },
      reports: {
        where: {
          status: "CONTENT_REMOVED",
          ruleId: {
            in: spaceRuleIds,
          },
        },
      },
      user: {
        select: {
          id: true,
          tag: true,
          name: true,
          username: true,
          avatar: {
            select: {
              key: true,
            },
          },
          robohash: true,
        },
      },
      uploads: {
        select: {
          id: true,
          key: true,
          type: true,
          name: true,
          size: true,
        },
      },
      space: {
        select: {
          slug: true,
          id: true,
        },
      },
      editHistory: {
        select: {
          id: true,
        },
      },
    },
  });
  if (!post) return Promise.reject(`No post found with the ID: ${postId}`);
  const [
    replies_count,
    userVote,
    userSavedPost,
    userSpaceFilter,
    awards,
    postFactiiis,
    approvedFactiiis,
    dataFactiiis,
    checkOpenAiReply,
  ] = await Promise.all([
    //replies_count
    prisma.post.count({
      where: {
        parentPostId: post.id,
        userId: {
          notIn: unauthorizedUserIds,
        },
      },
    }),
    //userVote
    userId
      ? prisma.vote.findFirst({
          where: {
            postId: post.id,
            userId,
          },
          select: {
            type: true,
          },
        })
      : null,
    //userSavedPost
    userId
      ? prisma.savedPost.findFirst({
          where: {
            postId: post.id,
            userId,
          },
        })
      : null,
    //userSpaceFilter
    userId
      ? prisma.user.findFirst({
          where: {
            id: userId,
          },
          select: {
            filters: true,
          },
        })
      : null,
    //awards
    prisma.postAward.groupBy({
      by: ["coinId"],
      where: {
        postId: post.id,
        post: {
          user: {
            preferences: {
              awardsVisibilityPrivate: false,
            },
          },
        },
      },
      _count: {
        coinId: true,
      },
    }),
    //postFactiiis
    prisma.postFactiii.groupBy({
      where: {
        //moderation
        factiiiId: {
          notIn: unauthorizedFactiiiIds,
        },
        userId: {
          notIn: unauthorizedUserIds,
        },
        //query
        postId: post.id,
        AND: [
          {
            data: {
              equals: null,
            },
          },
          {
            spaceTimes: {
              none: {},
            },
          },
          {
            uploads: {
              none: {},
            },
          },
        ],
      },
      by: ["factiiiId"],
      _count: {
        factiiiId: true,
      },
    }),
    //approvedFactiiis
    prisma.postFactiii.groupBy({
      where: {
        //moderation
        factiiiId: {
          notIn: unauthorizedFactiiiIds,
        },
        userId: {
          notIn: unauthorizedUserIds,
        },
        //query
        postId: post.id,
        status: "APPROVED",
        AND: [
          {
            data: {
              equals: null,
            },
          },
          {
            spaceTimes: {
              none: {},
            },
          },
          {
            uploads: {
              none: {},
            },
          },
        ],
      },
      by: ["factiiiId"],
      _count: {
        factiiiId: true,
      },
    }),
    //dataFactiiis
    prisma.postFactiii.findMany({
      where: {
        //moderation
        factiiiId: {
          notIn: unauthorizedFactiiiIds,
        },
        userId: {
          notIn: unauthorizedUserIds,
        },
        //query
        postId: post.id,
        status: "APPROVED",
        OR: [
          {
            data: {
              not: null,
            },
          },
          {
            spaceTimes: {
              some: {},
            },
          },
          {
            uploads: {
              some: {},
            },
          },
        ],
      },
      select: {
        factiiiId: true,
        data: true,
        spaceTimes: true,
        uploads: {
          select: {
            id: true,
            key: true,
            type: true,
            name: true,
            size: true,
          },
        },
        factiii: {
          select: {
            name: true,
            space: true,
            requirements: true,
          },
        },
      },
    }),
    //checkOpenAiReply
    prisma.post.findFirst({
      where: {
        parentPostId: post.id,
        user: {
          username: "openai",
        },
      },
      select: {
        id: true,
      },
    }),
  ]);

  let repost: PostDto | null = null;
  if (post.repostId !== null) {
    repost = await returnPostObjectDto(
      post.repostId,
      userId,
      unauthorizedUserIds,
      unauthorizedFactiiiIds,
      spaceRuleIds,
    );
  }

  const factiiiData = await prisma.postFactiii.findMany({
    where: {
      factiiiId: {
        in: postFactiiis.map((data) => data.factiiiId),
      },
    },
    select: {
      factiiiId: true,
      factiii: {
        select: {
          name: true,
        },
      },
    },
  });

  // Combine the two sets of data based on factiiiId
  const factiiis = postFactiiis.map((data) => {
    const matchingInfo = factiiiData.find(
      (factiii) => factiii.factiiiId === data.factiiiId,
    );
    return { ...data, ...matchingInfo?.factiii };
  });

  let voted: null | "UPVOTE" | "DOWNVOTE" = null;
  if (userVote?.type) {
    voted = userVote.type;
  }

  let saved = userSavedPost ? true : false;

  let openaiPost: PostDto | null = null;
  if (checkOpenAiReply && checkOpenAiReply.id !== null) {
    repost = await returnPostObjectDto(
      checkOpenAiReply.id,
      userId,
      unauthorizedUserIds,
      unauthorizedFactiiiIds,
      spaceRuleIds,
    );
  }

  let edited = post.editHistory && post.editHistory.length > 0;

  return {
    id: post.uuid,
    createdAt: post.createdAt,
    parentPostId: post.parentPost?.uuid,
    content:
      post.reports[0] && !isWithdrawnQuery
        ? "Post Withdrawn due to violation of rule " + post.reports[0].ruleId
        : post.content,
    uploads: post.uploads.map((upload) => ({
      id: upload.id,
      url: getS3ObjectURL(upload.key),
      type: upload.type,
      name: upload.name,
      size: upload.size,
      isFactiii: false,
    })),
    user: {
      id: post.user.id,
      username: post.anonymous ? "Anonymous User" : post.user.username,
      name: post.anonymous ? "Anonymous User" : post.user.name,
      robohash: post.user.robohash,
      tag: post.user.tag,
      avatar: post.anonymous
        ? null
        : post.user?.avatar?.key
          ? getS3ObjectURL(post.user.avatar?.key)
          : `https://robohash.org/${post.user.robohash}?bgset=bg2`,
    },
    replies_count,
    voteCount: post.voteCount,
    voted,
    saved,
    edited,
    awards,
    factiiis,
    approvedFactiiis,
    dataFactiiis: dataFactiiis.map((factiii) => {
      return {
        data: factiii.data,
        factiiiId: factiii.factiiiId,
        spaceTimes: factiii.spaceTimes,
        uploads: factiii.uploads.map(
          (upload) =>
            ({
              id: upload.id,
              url: getS3ObjectURL(upload.key),
              type: upload.type,
              name: upload.name,
              size: upload.size,
              isFactiii: true,
            }) ?? [],
        ),
        factiii: {
          name: factiii.factiii?.name,
          space: factiii.factiii?.space,
          requirements: factiii.factiii?.requirements,
        },
      };
    }),
    openaiReply: openaiPost,
    repost,
    space: post?.space?.slug ?? null,
  };
};

export const getBotSettings = async (req: Request, res: Response) => {
  const models = await prisma.model.findMany({
    where: {
      active: true,
    },
    select: {
      id: true,
      description: true,
      maxTokens: true,
      type: true,
      cost: true,
      perTokens: true,
    },
  });

  return res.send({
    models: models.map((x) => {
      return {
        id: x.id,
        description: x.description,
        maxtokens: x.maxTokens,
        type: x.type,
        cost: Number(x.cost),
        pertokens: x.perTokens,
      };
    }),
  });
};

export const newPost = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const {
    content,
    attachments,
    spaceSlug,
    saveAsDraft,
    refDraftPostId,
    bot,
    botSettings,
    repostId,
    factiii,
    addFactiiis,
    anonymousPost,
  } = req.body;
  const { parentPostId } = req.params;

  //Make sure the post has either content or attachments
  if (!content && !attachments)
    throw new AppError("Posts need either content or attachments.");
  //Make sure the user exists
  const user = await prisma.user.findFirst({
    where: {
      id: userId,
    },
  });
  if (!user) {
    throw new AppError("Invalid User request");
  }
  // Check if the user has posted over the limit in the last minute
  const postsPerMinuteLimit = await prisma.siteSettings.findMany({
    select: {
      postsPerMinute: true,
    },
    orderBy: {
      createdAt: "desc",
    },
    take: 1,
  });
  const postsInLastMinuteCount = await prisma.post.count({
    where: {
      userId,
      createdAt: {
        gt: new Date(Date.now() - 60 * 1000).toISOString(),
      },
    },
  });
  if (postsInLastMinuteCount > postsPerMinuteLimit[0].postsPerMinute) {
    throw new AppError(
      "You have created many posts. Please try again after a few minutes.",
    );
  }

  const premiumExpires = await prisma.spaceMember.findFirst({
    where: {
      userId: userId,
      space: {
        slug: "premium",
      },
    },
    select: {
      premiumAccessExpires: true,
    },
  });

  let spaceId: number | undefined = undefined;
  if (spaceSlug) {
    const checkSpace = await prisma.space.findFirst({
      where: {
        slug: spaceSlug,
      },
      select: {
        id: true,
        types: true,
        rules: true,
      },
    });
    if (!checkSpace) throw new AppError("Invalid space.");

    spaceId = checkSpace.id;

    if (checkSpace.types.includes("PAID")) {
      const spaceMember = await prisma.spaceMember.findFirstOrThrow({
        where: {
          userId,
          spaceId: checkSpace.id,
        },
        select: {
          subscription: {
            select: {
              expires: true,
            },
          },
        },
      });
      if (
        new Date(spaceMember.subscription?.expires as any).getTime() <
        new Date().getTime()
      )
        throw new AppError(
          "You have to have a current subscription to this space to post.",
        );
    } else if (checkSpace.types.includes("PREMIUM")) {
      if (
        premiumExpires?.premiumAccessExpires &&
        new Date(premiumExpires.premiumAccessExpires) < new Date()
      ) {
        throw new AppError(
          "Your premium access has expired. You can get it back by receiving tokens or paying for premium access.",
        );
      }
    }
  }

  //if parentPostId exists then this is a reply
  let parentPost;
  if (parentPostId) {
    parentPost = await prisma.post.findFirst({
      where: {
        uuid: parentPostId,
      },
      select: {
        id: true,
      },
    });
    if (!parentPost) throw new AppError("Invalid request.");
  }

  //if repostId exists then this is a repost
  let repost;
  if (repostId) {
    repost = await prisma.post.findFirst({
      where: {
        uuid: repostId,
      },
      select: {
        id: true,
      },
    });
    if (!repost) throw new AppError("Invalid request.");
  }

  //if refDraftPostId exists then delete the draft
  if (refDraftPostId) {
    await prisma.post.delete({
      where: {
        userId,
        uuid: refDraftPostId,
      },
    });
    if (!refDraftPostId) throw new AppError("Invalid request.");
  }

  //filter bad words and generate uuid for post
  const filteredContent = contentFilter(content);

  // Everything Passed so Post that post and look up admin settings for converting to postOBjDto later
  const [post, unauthorizedUserIds, unauthorizedFactiiiIds, spaceRuleIds] =
    await Promise.all([
      //post
      prisma.post.create({
        data: {
          uuid: filteredContent.id,
          userId,
          content: filteredContent.filteredContent,
          parentPostId: parentPost?.id,
          repostId: repost?.id,
          spaceId: spaceId ?? undefined,
          status: saveAsDraft ? "DRAFT" : "PUBLISHED",
          voteCount: 1,
          trendingRank: generatePostRank(new Date(), 1),
          anonymous: anonymousPost,
          votes: {
            create: {
              userId,
              type: "UPVOTE",
            },
          },
          ...(factiii && {
            factiii: {
              create: {
                topics: {
                  create: factiii.topics
                    .filter((item: any) => !item.id)
                    .map((item: any) => {
                      return {
                        topic: {
                          create: {
                            ...item,
                            userId,
                          },
                        },
                      };
                    }),
                },
                timestamp: new Date(new Date(factiii.timestamp).toUTCString()),
                sources: {
                  create: factiii.sources.filter((item: any) => !item.id),
                  connect: factiii.sources
                    .filter((item: any) => item.id)
                    .map((item: any) => {
                      return { id: item.id };
                    }),
                },
                location: {
                  create: {
                    latitude: factiii.latitude,
                    longitude: factiii.longitude,
                  },
                },
              },
            },
          }),
        },
      }),
      //unauthorizedUserIds
      getUnauthorizedUserIds(userId),
      //unauthorizedFactiiiIds
      getUnauthorizedFactiiiIds(userId),
      //spaceRuleIds
      getSpaceRuleIds(userId),
    ]);

  if (addFactiiis) {
    await processFactiiis(
      userId,
      { id: post.id, userId: post.userId },
      addFactiiis,
      [],
    );
  }

  //Make returnPostObjectDto
  const returnPost = await returnPostObjectDto(
    post.id,
    userId,
    unauthorizedUserIds,
    unauthorizedFactiiiIds,
    spaceRuleIds,
  );

  // Award 5 coins reward if it's their first post
  const postsCount = await prisma.post.count({
    where: {
      userId,
    },
  });

  if (postsCount === 10) {
    await awardCoinsReward(post.userId, "PUBLISH_10TH_POST");
  }

  if (bot) {
    if (botSettings) {
      const model = await prisma.model.findFirst({
        where: {
          id: botSettings.modelId,
        },
        select: {
          id: true,
          query: true,
          maxTokens: true,
          perTokens: true,
          type: true,
          cost: true,
        },
      });
      if (!model) throw new AppError("Incorrect model passed.");
      if (model.type === "OPENAI_IMAGE") {
        generateOpenAiImageToPost(user, post, model, req);
      } else if (model.type === "OPENAI_LANGUAGE") {
        generateOpenAiReplyToPost(
          user,
          post,
          model,
          botSettings,
          req,
          !!(
            premiumExpires &&
            premiumExpires.premiumAccessExpires &&
            premiumExpires.premiumAccessExpires > new Date()
          ),
        );
      }
    } else {
      //Default model which is the 2nd most expensive language model
      const model = await prisma.model.findFirst({
        where: {
          type: "OPENAI_LANGUAGE",
          cost: 2000,
        },
        select: {
          id: true,
          query: true,
          maxTokens: true,
          perTokens: true,
          type: true,
          cost: true,
        },
      });
      generateOpenAiReplyToPost(
        user,
        post,
        model,
        botSettings,
        req,
        !!(
          premiumExpires &&
          premiumExpires.premiumAccessExpires &&
          premiumExpires.premiumAccessExpires > new Date()
        ),
      );
    }
  }

  if (post.content.startsWith("@openai")) {
    const model = await prisma.model.findFirst({
      where: {
        type: "OPENAI_LANGUAGE",
        cost: 2000,
      },
      select: {
        id: true,
        query: true,
        maxTokens: true,
        perTokens: true,
        type: true,
        cost: true,
      },
    });
    generateOpenAiReplyToPost(
      user,
      post,
      model,
      botSettings,
      req,
      !!(
        premiumExpires &&
        premiumExpires.premiumAccessExpires &&
        premiumExpires.premiumAccessExpires > new Date()
      ),
    );
  }

  //if parentPostId exists then this is a reply
  if (parentPostId) {
    //Get parentPost
    const parentPost = await prisma.post.findFirst({
      where: {
        uuid: parentPostId,
      },
      select: {
        id: true,
        userId: true,
        user: {
          select: {
            username: true,
          },
        },
      },
    });
    if (!parentPost) throw new AppError("Invalid request.");

    //Emit repliesCount and newReply sockets to all but the user who posted the reply
    const session = await prisma.session.findFirst({
      where: {
        userId,
        refreshToken: req.body.auth.refresher,
      },
      select: {
        socketId: true,
      },
    });
    if (session?.socketId) {
      const io = getIoInstance();
      const repliesCount = await prisma.post.count({
        where: {
          parentPostId: parentPost.id,
          userId: {
            notIn: unauthorizedUserIds,
          },
        },
      });
      io.to(`post-${parentPostId}`)
        .except(session.socketId)
        .emit("repliesCount", repliesCount, parentPostId);
      io.to(`post-${parentPostId}`)
        .except(session.socketId)
        .emit("newReply", returnPost);
    }
    //Create a notification for the parentPost user if the parentPost user is not the same as the reply user
    if (parentPost.userId !== post?.userId) {
      await prisma.notification.create({
        data: {
          targetUserId: parentPost.userId,
          repostId: post.id,
          referenceUserId: userId,
          type: "REPLIED",
        },
      });
      //Emit notificationCount socket to the parentPost user
      if (session?.socketId) {
        await emitNotificationCount(parentPost.userId, session.socketId);
      }

      if (post) {
        const pushItems = await createPushNotificationItems(
          parentPost.userId,
          content.length > 32 ? `"${content.slice(0, 32)}..."` : `"${content}"`,
          `@${parentPost.user.username} replied to your post.`,
          {
            screen: "Post",
            data: {
              post: returnPost,
            },
          },
        );
        await sendNotifications(pushItems);
      }
    }
  }
  //Attach the uploaded attachments to post
  if (attachments && attachments.length > 0) {
    // Collect valid upload IDs that exist in the database
    const uploadsToConnect = await Promise.all(
      attachments.map(async (x: { id: string }) => {
        const attachmentExists = await prisma.upload.findUnique({
          where: { id: x.id },
          select: { id: true }, // We check if the upload exists and is valid
        });
        return attachmentExists ? { id: x.id } : null;
      }),
    );

    // Filter out null values to ensure all entries are valid for connection
    const validUploadsToConnect = uploadsToConnect.filter(
      (upload) => upload !== null,
    );

    // Update the post to connect the valid uploads
    if (validUploadsToConnect.length > 0) {
      await prisma.post.update({
        where: { id: post.id },
        data: {
          uploads: {
            connect: validUploadsToConnect,
          },
        },
      });
    }
  }

  if (post.content.includes("@")) {
    const usernames = post.content.match(/@[a-zA-Z0-9_]+/gm);

    if (usernames) {
      for (let username of usernames) {
        const checkUser = await prisma.user.findFirst({
          where: {
            username: username.replace("@", ""),
          },
          select: {
            id: true,
          },
        });
        const session = await prisma.session.findFirst({
          where: {
            userId,
            refreshToken: req.body.auth.refresher,
          },
          select: {
            socketId: true,
          },
        });

        if (checkUser && session?.socketId) {
          await prisma.notification.create({
            data: {
              referenceUserId: userId,
              repostId: post.id,
              targetUserId: checkUser.id,
              type: "TAGGED_POST",
            },
          });
          await emitNotificationCount(checkUser.id, session.socketId);

          const theCurrentRefPost = await prisma.post.findFirst({
            where: {
              id: post.id,
            },
            select: {
              id: true,
            },
          });

          if (theCurrentRefPost) {
            const pushItems = await createPushNotificationItems(
              checkUser.id,
              post.content.length > 32
                ? `"${post.content.slice(0, 32)}..."`
                : `"${content}"`,
              `${username} tagged you in a post`,
              {
                screen: "Post",
                data: {
                  post: await returnPostObjectDto(
                    theCurrentRefPost.id,
                    userId,
                    unauthorizedUserIds,
                    unauthorizedFactiiiIds,
                    spaceRuleIds,
                  ),
                },
              },
            );
            await sendNotifications(pushItems);
          }
        }
      }
    }
  }

  return res.send({
    post: returnPost,
  });
};

export const deletePost = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { postId } = req.params;

  const checkPost = await prisma.post.findFirst({
    where: {
      uuid: postId,
      userId,
    },
    select: {
      id: true,
    },
  });

  if (!checkPost) throw new AppError("No such post found. Try again.");

  await prisma.post.deleteMany({
    where: {
      uuid: postId,
      userId,
    },
  });

  return res.send({
    deleted: true,
  });
};

export const getUserPosts = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { username } = req.params;
  const { page = 0, type = "trending" } = req.query;

  if (!username) throw new AppError("Invalid request. Please try again.");

  const [
    unauthorizedUserIds,
    unauthorizedFactiiiIds,
    unauthorizedSpaceIds,
    spaceRuleIds,
  ] = await Promise.all([
    getUnauthorizedUserIds(userId),
    getUnauthorizedFactiiiIds(userId),
    getUnauthorizedSpaceIds(userId),
    getSpaceRuleIds(userId),
  ]);

  const profileUser = await prisma.user.findFirstOrThrow({
    where: {
      //moderation
      id: {
        notIn: unauthorizedUserIds,
      },
      //query
      username,
    },
    select: {
      id: true,
      pinnedPostId: true,
      preferences: {
        select: {
          hidePostsOnProfile: true,
        },
      },
    },
  });

  if (!profileUser) throw new AppError("Invalid request. Please try again.");

  //return empty array if user set to hide posts on profile and the userId is not the same as the profileUser
  if (
    profileUser.preferences?.hidePostsOnProfile &&
    userId !== profileUser.id
  ) {
    return res.send({
      posts: [],
    });
  }

  const pinnedPostId = await prisma.post.findFirst({
    where: {
      id: profileUser.pinnedPostId ?? 0,
    },
    select: {
      id: true,
    },
  });

  const conditionalAnonymous =
    userId == profileUser.id ? {} : { anonymous: false };

  const postIds = await prisma.post.findMany({
    where: {
      //moderation
      OR: [
        {
          spaceId: {
            notIn: unauthorizedSpaceIds,
          },
        },
        {
          spaceId: null,
        },
      ],
      //query
      userId: profileUser.id,
      id: {
        not: pinnedPostId?.id,
      },
      parentPostId: null,
      status:
        userId === profileUser.id
          ? { in: ["PUBLISHED", "PRIVATE"] }
          : "PUBLISHED",
      ...conditionalAnonymous,
    },
    select: {
      id: true,
    },
    ...(type === "new" && {
      orderBy: [{ createdAt: "desc" }, { id: "desc" }],
    }),
    ...(type === "trending" && {
      orderBy: [{ trendingRank: "desc" }, { id: "desc" }],
    }),
    ...(type === "popular" && {
      orderBy: [{ voteCount: "desc" }, { id: "desc" }],
    }),
    skip: 10 * Number(page),
    take: 10 - (pinnedPostId && page === 0 ? 1 : 0), //If there is a pinned post, take 1 less to make 10 total returns
  });

  const posts = await Promise.all(
    postIds.map(
      async (post) =>
        await returnPostObjectDto(
          post.id,
          userId,
          unauthorizedUserIds,
          unauthorizedFactiiiIds,
          spaceRuleIds,
        ),
    ),
  );

  if (Number(page) === 0 && pinnedPostId) {
    const pinnedPost = await returnPostObjectDto(
      pinnedPostId.id,
      userId,
      unauthorizedUserIds,
      unauthorizedFactiiiIds,
      spaceRuleIds,
    );
    if (pinnedPost) {
      posts.unshift({ ...pinnedPost, pinned: true });
    }
  }

  return res.send({
    posts,
  });
};

export const getSpacePosts = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { slug } = req.params;
  const { page = 0, type = "trending", filterBots } = req.query;

  if (!slug) throw new AppError("Invalid request. Please try again.");

  const [
    unauthorizedSpaceIds,
    unauthorizedUserIds,
    unauthorizedFactiiiIds,
    spaceRuleIds,
    mutedUserIds,
  ] = await Promise.all([
    getUnauthorizedSpaceIds(userId),
    getUnauthorizedUserIds(userId),
    getUnauthorizedFactiiiIds(userId),
    getSpaceRuleIds(userId),
    getMutedUserIds(userId),
  ]);

  const space = await prisma.space.findFirst({
    where: {
      //moderation
      id: {
        notIn: unauthorizedSpaceIds,
      },
      //query
      slug,
    },
    select: {
      id: true,
      pinnedPostId: true,
      types: true,
    },
  });

  if (!space) throw new AppError("Invalid request. Please try again.");

  if (space.types.includes("PRIVATE")) {
    if (userId) {
      const checkIfUserMember = await prisma.spaceMember.findFirst({
        where: {
          spaceId: space?.id,
          userId: userId,
        },
      });

      if (!checkIfUserMember)
        throw new AppError(
          "This is a private community and you need to be a member to view it's posts.",
        );
    } else {
      throw new AppError(
        "This is a private community and you need to be logged in to view this.",
      );
    }
  }

  const pinnedPostId = await prisma.post.findFirst({
    where: {
      id: space.pinnedPostId ?? 0,
    },
    select: {
      id: true,
    },
  });

  const postIds = await prisma.post.findMany({
    where: {
      ...{
        //moderation
        AND: [
          {
            userId: {
              notIn: unauthorizedUserIds,
            },
          },
          {
            userId: {
              notIn: mutedUserIds,
            },
          },
        ],
        //query
        spaceId: space.id,
        status: "PUBLISHED",
        parentPostId: null,
        id: {
          not: pinnedPostId?.id,
        },
      },
      ...(filterBots === "true"
        ? {
            user: {
              botSettings: null,
            },
          }
        : {}),
    },
    ...(type === "new" && {
      orderBy: [{ createdAt: "desc" }, { id: "desc" }],
    }),
    ...(type === "trending" && {
      orderBy: [{ trendingRank: "desc" }, { id: "desc" }],
    }),
    ...(type === "popular" && {
      orderBy: [{ voteCount: "desc" }, { id: "desc" }],
    }),
    select: {
      id: true,
      user: {
        select: {
          name: true,
          username: true,
          avatar: true,
          robohash: true,
          preferences: {
            select: {
              awardsVisibilityPrivate: true,
            },
          },
        },
      },
      uploads: {
        select: {
          id: true,
        },
      },
      space: {
        select: {
          slug: true,
          id: true,
        },
      },
      editHistory: {
        select: {
          id: true,
        },
      },
    },
    skip: 10 * Number(page),
    take: 10 - (pinnedPostId && page === 0 ? 1 : 0), //If there is a pinned post, take 1 less to make 10 total returns
  });

  const posts = await Promise.all(
    postIds.map(
      async (post) =>
        await returnPostObjectDto(
          post.id,
          userId,
          unauthorizedUserIds,
          unauthorizedFactiiiIds,
          spaceRuleIds,
        ),
    ),
  );

  if (Number(page) === 0 && pinnedPostId) {
    const pinnedPost = await returnPostObjectDto(
      pinnedPostId.id,
      userId,
      unauthorizedUserIds,
      unauthorizedFactiiiIds,
      spaceRuleIds,
    );
    if (pinnedPost) {
      posts.unshift({ ...pinnedPost, pinned: true });
    }
  }

  return res.send({
    posts,
  });
};

export const getFeedPosts = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { page = 0, type = "trending", filterBots } = req.query;

  const [
    following,
    spaceMemberIds,
    unauthorizedUserIds,
    unauthorizedSpaceIds,
    unauthorizedFactiiiIds,
    spaceRuleIds,
    mutedUserIds,
  ] = await Promise.all([
    //following
    prisma.follows.findMany({
      where: {
        followerId: userId,
      },
      select: {
        followingId: true,
      },
    }),
    //spaceMemberIds
    prisma.spaceMember.findMany({
      where: {
        userId: userId,
      },
      select: {
        spaceId: true,
      },
    }),
    //unauthorizedUserIds
    getUnauthorizedUserIds(userId),
    //unauthorizedSpaceIds
    getUnauthorizedSpaceIds(userId),
    //unauthorizedFactiiiIds
    getUnauthorizedFactiiiIds(userId),
    //spaceRuleIds
    getSpaceRuleIds(userId),
    getMutedUserIds(userId),
  ]);

  //prioritize removing unauthorized users from following
  const validUserIds = following
    .map((x) => x.followingId)
    .filter((id) => !unauthorizedUserIds.includes(id));
  const validSpaceIds = spaceMemberIds
    .map((x) => x.spaceId)
    .filter((id) => !unauthorizedSpaceIds.includes(id));

  const postIds = await prisma.post.findMany({
    where: {
      //moderation
      OR: [
        {
          AND: [
            {
              userId: {
                notIn: unauthorizedUserIds, //query and moderation
              },
            },
            {
              spaceId: {
                in: validSpaceIds,
              },
            },
          ],
        },
        {
          userId: userId,
        },
        {
          userId: {
            in: validUserIds, //query and moderation
          },
        },
        {
          AND: [
            {
              userId: {
                in: validUserIds, //query and moderation
              },
            },
            {
              spaceId: null,
            },
          ],
        },
      ],
      //query
      NOT: {
        userId: {
          in: mutedUserIds,
        },
      },
      status: {
        in: ["PUBLISHED"],
      },
      parentPostId: null, //DOn't show replies
      ...(filterBots === "true"
        ? {
            user: {
              botSettings: null,
            },
          }
        : {}),
    },
    ...(type === "new" && {
      orderBy: [{ createdAt: "desc" }, { id: "desc" }],
    }),
    ...(type === "trending" && {
      orderBy: [{ trendingRank: "desc" }, { id: "desc" }],
    }),
    ...(type === "popular" && {
      orderBy: [{ voteCount: "desc" }, { id: "desc" }],
    }),
    select: {
      id: true,
    },
    skip: 10 * Number(page),
    take: 10,
  });

  return res.send({
    posts: await Promise.all(
      postIds.map(
        async (post) =>
          await returnPostObjectDto(
            post.id,
            userId,
            unauthorizedUserIds,
            unauthorizedFactiiiIds,
            spaceRuleIds,
          ),
      ),
    ),
  });
};

export const getExplorePagePosts = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { page = 0, type = "trending", filterBots } = req.query;
  const [
    unauthorizeSpaceIds,
    unauthorizedUserIds,
    unauthorizedFactiiiIds,
    mutedUserIds,
  ] = await Promise.all([
    //unauthorizeSpaceIds
    getUnauthorizedSpaceIds(userId),
    //unauthorizedUserIds
    getUnauthorizedUserIds(userId),
    //unauthorizedFactiiiIds
    getUnauthorizedFactiiiIds(userId),
    getMutedUserIds(userId),
  ]);

  const [postIds, spaceRuleIds] = await Promise.all([
    // //postIds
    prisma.post.findMany({
      where: {
        //moderation
        OR: [
          {
            spaceId: {
              notIn: unauthorizeSpaceIds,
            },
          },
          {
            spaceId: null,
          },
        ],
        userId: {
          notIn: unauthorizedUserIds,
        },
        //query
        NOT: {
          userId: {
            in: mutedUserIds,
          },
        },
        status: "PUBLISHED",
        parentPostId: null,
        ...(filterBots === "true"
          ? {
              user: {
                botSettings: null,
              },
            }
          : {}),
      },
      ...(type === "new" && {
        orderBy: [{ createdAt: "desc" }, { id: "desc" }],
      }),
      ...(type === "trending" && {
        orderBy: [{ trendingRank: "desc" }, { id: "desc" }],
      }),
      ...(type === "popular" && {
        orderBy: [{ voteCount: "desc" }, { id: "desc" }],
      }),
      select: {
        id: true,
      },
      skip: 10 * Number(page),
      take: 10,
    }),
    getSpaceRuleIds(userId),
  ]);

  return res.send({
    posts: await Promise.all(
      postIds.map(
        async (post) =>
          await returnPostObjectDto(
            post.id,
            userId,
            unauthorizedUserIds,
            unauthorizedFactiiiIds,
            spaceRuleIds,
          ),
      ),
    ),
  });
};

export const votePost = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { postId } = req.params;
  const { type } = req.body;

  if (!Object.values(VoteType).includes(type))
    throw new AppError("Invalid request. Please try again.");

  const [checkUser, checkPost] = await Promise.all([
    //checkUser
    prisma.user.findFirst({
      where: {
        id: userId,
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
    }),
    //checkPost
    prisma.post.findFirst({
      where: {
        uuid: postId,
      },
      select: {
        id: true,
        userId: true,
        createdAt: true,
      },
    }),
  ]);

  if (!checkUser)
    throw new AppError("Invalid user. Check the request and try again.");
  if (!checkPost) throw new AppError("No post found. Try again.");

  const checkVote = await prisma.vote.findFirst({
    where: {
      postId: checkPost.id,
      userId,
    },
    select: {
      type: true,
    },
  });

  let voted: null | "UPVOTE" | "DOWNVOTE" = null;
  if (!checkVote) {
    //Not voted by user yet so create a new vote
    await prisma.vote.create({
      data: {
        userId,
        postId: checkPost.id,
        type,
      },
    });
    voted = type;
  } else {
    if (checkVote.type === type) {
      //Already voted by user so delete the vote
      await prisma.vote.deleteMany({
        where: {
          postId: checkPost.id,
          userId: userId,
        },
      });
      voted = null;
    } else {
      //Already voted by user but with different type so update the vote with the new type
      await prisma.vote.updateMany({
        where: {
          postId: checkPost.id,
          userId: userId,
        },
        data: {
          type: type === VoteType.UPVOTE ? "UPVOTE" : "DOWNVOTE",
        },
      });
      voted = type;
    }
  }

  //Check if notification before
  const check = await prisma.notification.findFirst({
    where: {
      targetUserId: checkPost.userId,
      repostId: checkPost.id,
      referenceUserId: userId,
    },
  });
  //Send notification/push only if not sent before and post is UPVOTED
  if (!check && voted === "UPVOTE") {
    await prisma.notification.create({
      data: {
        targetUserId: checkPost.userId,
        repostId: checkPost.id,
        referenceUserId: userId,
        type: "UPVOTED",
      },
    });
    //Send push notification
    const pushItems = await createPushNotificationItems(
      checkPost.userId,
      `@${checkUser.username} just upvoted your post.`,
      undefined,
      {
        screen: "Post",
        data: {
          post: await returnPostObjectDto(checkPost.id, userId, [], [], []),
        },
      },
    );
    await sendNotifications(pushItems);
    if (checkUser.sessions.length === 1 && checkUser.sessions[0]?.socketId) {
      await emitNotificationCount(
        checkPost.userId,
        checkUser.sessions[0].socketId,
      );
    }
  } else if (voted === "DOWNVOTE" || voted === null) {
    //Delete notification if user changed to downvoted or null
    await prisma.notification.deleteMany({
      where: {
        targetUserId: checkPost.userId,
        repostId: checkPost.id,
        referenceUserId: userId,
        type: "UPVOTED",
      },
    });
    if (checkUser.sessions.length === 1 && checkUser.sessions[0]?.socketId) {
      await emitNotificationCount(
        checkPost.userId,
        checkUser.sessions[0].socketId,
      );
    }
  }

  const [countUpvotes, countDownvotes] = await Promise.all([
    //countUpvotes
    prisma.vote.count({
      where: {
        postId: checkPost.id,
        type: "UPVOTE",
      },
    }),
    //countDownvotes
    prisma.vote.count({
      where: {
        postId: checkPost.id,
        type: "DOWNVOTE",
      },
    }),
  ]);

  //Don't recalcualte post rank on every post to save resources
  let shouldUpdatePostRank = false;
  const totalVoteCount = countUpvotes - countDownvotes;

  if (totalVoteCount < 10 && totalVoteCount % 1 === 0)
    shouldUpdatePostRank = true;
  else if (totalVoteCount < 50 && totalVoteCount % 5 === 0)
    shouldUpdatePostRank = true;
  else if (totalVoteCount < 100 && totalVoteCount % 10 === 0)
    shouldUpdatePostRank = true;
  else if (totalVoteCount < 1000 && totalVoteCount % 100 === 0)
    shouldUpdatePostRank = true;

  if (shouldUpdatePostRank) {
    await prisma.post.update({
      where: {
        id: checkPost.id,
      },
      data: {
        trendingRank: generatePostRank(checkPost.createdAt, totalVoteCount),
        voteCount: countUpvotes - countDownvotes,
      },
    });
  }

  // Award coins reward if it's their first post with 100 upvotes
  if (totalVoteCount === 100) {
    await awardCoinsReward(checkPost.userId, "GET_100_UPVOTES");
  }

  //Emit repliesCount and newReply sockets to all but the user who posted the reply
  if (checkUser.sessions[0]?.socketId) {
    const io = getIoInstance();
    io.to(`post-${postId}`)
      .except(checkUser.sessions[0].socketId)
      .emit("voteCount", totalVoteCount, postId);
  }

  res.send({
    totalVoteCount,
    voted,
    postId,
  });
};

export const getSavedPosts = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { page = 0 } = req.query;

  const [unauthorizedUserIds, unauthorizedFactiiiIds, spaceRuleIds] =
    await Promise.all([
      getUnauthorizedUserIds(userId),
      getUnauthorizedFactiiiIds(userId),
      getSpaceRuleIds(userId),
    ]);

  const postIds = await prisma.savedPost.findMany({
    where: {
      ...{
        userId,
        post: {
          status: "PUBLISHED",
        },
      },
    },
    select: {
      post: {
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

  const posts = await Promise.all(
    postIds.map(async (post) =>
      returnPostObjectDto(
        post.post.id,
        userId,
        unauthorizedUserIds,
        unauthorizedFactiiiIds,
        spaceRuleIds,
      ),
    ),
  );

  return res.send({
    posts,
    currentPage: page,
  });
};

export const getWithdrawnPosts = async (req: Request, res: Response) => {
  const authUserId: number = req.body.auth?.userId ?? 0;
  const { spaceSlug, page } = req.query as { spaceSlug: string; page: string };
  const username: string = req.params.username;

  const { id: userId } = await prisma.user.findFirstOrThrow({
    where: {
      username,
    },
    select: {
      id: true,
    },
  });

  const spaces = await prisma.spaceMember.findMany({
    where: {
      userId: authUserId,
      ...(!["all", "discarded"].includes(spaceSlug) && {
        space: {
          slug: spaceSlug,
        },
      }),
      roles: {
        hasSome: ["MODERATOR", "OWNER"],
      },
    },
    select: {
      spaceId: true,
      space: {
        select: {
          slug: true,
        },
      },
    },
  });

  const [unauthorizedUserIds, unauthorizedFactiiiIds, spaceRuleIds] =
    await Promise.all([
      getUnauthorizedUserIds(userId),
      getUnauthorizedFactiiiIds(userId),
      getSpaceRuleIds(userId),
    ]);

  if (spaces.length === 0)
    throw new AppError("You do not have the permissions to view this resource");

  let count;
  if (Number(page) === 0) {
    count = await prisma.post.count({
      where: {
        userId,
        reports: {
          some: {
            status: "CONTENT_REMOVED",
          },
        },
      },
    });
  }

  const postIds = await prisma.post.findMany({
    where: {
      ...{
        userId,
        reports: {
          some: {
            status: "CONTENT_REMOVED",
          },
        },
        spaceId: {
          in: spaces.map((space) => space.spaceId),
        },
      },
    },
    select: {
      id: true,
    },
    orderBy: {
      createdAt: "desc",
    },
    skip: 10 * Number(page),
    take: 10,
  });

  const posts = await Promise.all(
    postIds.map(async (post) =>
      returnPostObjectDto(
        post.id,
        userId,
        unauthorizedUserIds,
        unauthorizedFactiiiIds,
        spaceRuleIds,
        true,
      ),
    ),
  );

  return res.send({
    posts,
    ...(Number(page) === 0 && {
      count,
    }),
    currentPage: page,
  });
};

export const savePost = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { postId } = req.params;

  const checkPost = await prisma.post.findFirst({
    where: {
      uuid: postId,
    },
  });

  if (!checkPost) throw new AppError("Post not found. Please try again later.");

  const checkSavedPost = await prisma.savedPost.findFirst({
    where: {
      postId: checkPost.id,
      userId,
    },
  });

  if (checkSavedPost) {
    await prisma.savedPost.deleteMany({
      where: {
        postId: checkPost.id,
        userId,
      },
    });
  } else {
    await prisma.savedPost.create({
      data: {
        postId: checkPost.id,
        userId,
      },
    });
  }

  return res.send({
    saved: true,
  });
};

export const getPost = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { postId } = req.params;

  const [
    unauthorizedSpaceIds,
    unauthorizedUserIds,
    unauthorizedFactiiiIds,
    spaceRuleIds,
  ] = await Promise.all([
    getUnauthorizedSpaceIds(userId),
    getUnauthorizedUserIds(userId),
    getUnauthorizedFactiiiIds(userId),
    getSpaceRuleIds(userId),
  ]);

  const post = await prisma.post.findFirst({
    where: {
      uuid: postId,
      OR: [
        {
          spaceId: {
            notIn: unauthorizedSpaceIds,
          },
        },
        {
          spaceId: null,
        },
      ],
    },
    select: {
      id: true,
    },
  });

  if (!post) throw new AppError("POST_NOT_FOUND: No post found with that ID");

  return res.send({
    posts: [
      await returnPostObjectDto(
        post.id,
        userId,
        unauthorizedUserIds,
        unauthorizedFactiiiIds,
        spaceRuleIds,
      ),
    ],
  });
};

export const getSinglePost = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { postId } = req.params;
  const { page } = req.query;

  if (!postId) throw new AppError("Invalid request.");

  const [unauthorizedUserIds, unauthorizedFactiiiIds, spaceRuleIds] =
    await Promise.all([
      //unauthorizedUserIds
      getUnauthorizedUserIds(userId),
      //unauthorizedFactiiiIds
      getUnauthorizedFactiiiIds(userId),
      //spaceRuleIds
      getSpaceRuleIds(userId),
    ]);

  //checkPost
  const postCheck = await prisma.post.findUnique({
    where: {
      uuid: postId,
      userId: {
        notIn: unauthorizedUserIds,
      },
      OR: [
        {
          status: "PUBLISHED",
        },
        {
          userId,
        },
      ],
    },
    select: {
      id: true,
    },
  });

  if (!postCheck) throw new AppError("Invalid request.");

  const replieIds = await prisma.post.findMany({
    where: {
      parentPostId: postCheck.id,
      userId: {
        notIn: unauthorizedUserIds,
      },
    },
    select: {
      id: true,
    },
    orderBy: [{ createdAt: "desc" }, { id: "desc" }],
    skip: 10 * Number(page),
    take: 10,
  });

  //fetch post and replies only if page === 0
  const post = await returnPostObjectDto(
    postCheck.id,
    userId,
    unauthorizedUserIds,
    unauthorizedFactiiiIds,
    spaceRuleIds,
  );
  const replies = await Promise.all(
    replieIds.map(
      async (reply) =>
        await returnPostObjectDto(
          reply.id,
          userId,
          unauthorizedUserIds,
          unauthorizedFactiiiIds,
          spaceRuleIds,
        ),
    ),
  );

  return res.send({
    posts: [
      {
        ...post,
        replies,
      },
    ],
  });
};

export const getReplies = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { postId } = req.params;
  const { page } = req.query;

  if (!postId) throw new AppError("Invalid request.");

  const [unauthorizedUserIds, unauthorizedFactiiiIds, spaceRuleIds] =
    await Promise.all([
      //unauthorizedUserIds
      getUnauthorizedUserIds(userId),
      //unauthorizedFactiiiIds
      getUnauthorizedFactiiiIds(userId),
      //spaceRuleIds
      getSpaceRuleIds(userId),
    ]);

  //checkPost
  const postCheck = await prisma.post.findFirstOrThrow({
    where: {
      uuid: postId,
      userId: {
        notIn: unauthorizedUserIds,
      },
    },
    select: {
      id: true,
    },
  });

  const replieIds = await prisma.post.findMany({
    where: {
      parentPostId: postCheck.id,
      userId: {
        notIn: unauthorizedUserIds,
      },
    },
    select: {
      id: true,
    },
    orderBy: [{ createdAt: "desc" }, { id: "desc" }],
    skip: 10 * Number(page),
    take: 10,
  });

  const replies = await Promise.all(
    replieIds.map(
      async (reply) =>
        await returnPostObjectDto(
          reply.id,
          userId,
          unauthorizedUserIds,
          unauthorizedFactiiiIds,
          spaceRuleIds,
        ),
    ),
  );

  return res.send({
    posts: replies,
  });
};

export const editPost = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { content } = req.body;
  const { postId } = req.params;

  if (content.trim().length === 0)
    throw new AppError("Post content cannot be empty");

  const checkPost = await prisma.post.findFirst({
    where: {
      uuid: postId,
      userId,
    },
    select: {
      id: true,
      content: true,
    },
  });

  if (!checkPost)
    throw new AppError("Post not found or you do not have the permissions");

  await prisma.postEditHistory.create({
    data: {
      content: checkPost.content,
      postId: checkPost.id,
    },
  });

  await prisma.post.update({
    where: {
      id: checkPost.id,
    },
    data: {
      content,
    },
  });

  return res.send({
    edited: true,
  });
};

export const postEditHistory = async (req: Request, res: Response) => {
  const { postId } = req.params;

  const checkPost = await prisma.post.findFirstOrThrow({
    where: {
      uuid: postId,
    },
    select: {
      id: true,
    },
  });

  const revisions = await prisma.postEditHistory.findMany({
    where: {
      postId: checkPost.id,
    },
    include: {
      post: {
        select: {
          user: {
            select: {
              avatar: {
                select: {
                  key: true,
                },
              },
            },
          },
        },
      },
    },
    orderBy: {
      createdAt: "desc",
    },
  });

  return res.send({
    avatar: revisions[0].post.user.avatar,
    edits: revisions.map((x) => {
      return {
        content: x.content,
        date: x.createdAt,
        avatar: x.post.user.avatar,
      };
    }),
  });
};

export const getDrafts = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { page = 0 } = req.query;

  const [unauthorizedUserIds, unauthorizedFactiiiIds, spaceRuleIds] =
    await Promise.all([
      getUnauthorizedUserIds(userId),
      getUnauthorizedFactiiiIds(userId),
      getSpaceRuleIds(userId),
    ]);

  const postIds = await prisma.post.findMany({
    where: {
      ...{
        userId,
        status: "DRAFT",
      },
    },
    select: {
      id: true,
    },
    orderBy: {
      createdAt: "desc",
    },
    skip: 10 * Number(page),
    take: 10,
  });

  const posts = await Promise.all(
    postIds.map(
      async (post) =>
        await returnPostObjectDto(
          post.id,
          userId,
          unauthorizedUserIds,
          unauthorizedFactiiiIds,
          spaceRuleIds,
        ),
    ),
  );

  return res.send({
    posts,
    currentPage: page,
  });
};

export const getFactiiis = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { slug, factiii_slug } = req.params;
  const { page = 0, sortBy } = req.query;

  const [
    unauthorizedUserIds,
    unauthorizedSpaceIds,
    unauthorizedFactiiiIds,
    spaceRuleIds,
  ] = await Promise.all([
    getUnauthorizedUserIds(userId),
    getUnauthorizedSpaceIds(userId),
    getUnauthorizedFactiiiIds(userId),
    getSpaceRuleIds(userId),
  ]);

  const factiii = await prisma.factiii.findFirst({
    where: {
      id: {
        notIn: unauthorizedFactiiiIds,
      },
      OR: [
        {
          user: {
            username: slug,
          },
        },
        {
          space: {
            slug: slug,
          },
        },
      ],
      slug: factiii_slug,
    },
    select: {
      id: true,
    },
  });

  if (!factiii) {
    throw new Error("Factiii not found");
  }

  const postIds = await prisma.post.findMany({
    where: {
      ...{
        OR: [
          {
            spaceId: {
              notIn: unauthorizedSpaceIds,
            },
          },
          {
            spaceId: null,
          },
        ],
        factiiis: {
          some: {
            factiiiId: factiii.id,
          },
        },
      },
      status: {
        not: "PRIVATE",
      },
    },
    select: {
      id: true,
      createdAt: true,
    },
    orderBy: [{ trendingRank: "desc" }, { id: "desc" }],
    skip: 10 * Number(page),
    take: 10,
  });

  const posts = await Promise.all(
    postIds.map(
      async (post) =>
        await returnPostObjectDto(
          post.id,
          userId,
          unauthorizedUserIds,
          unauthorizedFactiiiIds,
          spaceRuleIds,
        ),
    ),
  );

  return res.send({
    posts,
    currentPage: page,
  });
};

export const openAiUserPosts = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { page = 0, type = "trending" } = req.query;

  const [
    unauthorizeSpaceIds,
    unauthorizedUserIds,
    unauthorizedFactiiiIds,
    spaceRuleIds,
  ] = await Promise.all([
    getUnauthorizedSpaceIds(userId),
    getUnauthorizedUserIds(userId),
    getUnauthorizedFactiiiIds(userId),
    getSpaceRuleIds(userId),
  ]);

  const openAiUser = await prisma.user.findFirst({
    where: {
      username: "openai",
    },
    select: {
      id: true,
    },
  });

  if (!openAiUser?.id) throw new AppError("Invalid request. Please try again.");

  const posts = await prisma.post.findMany({
    where: {
      ...{
        userId: openAiUser.id,
        status: "PUBLISHED",
        OR: [
          {
            spaceId: {
              notIn: unauthorizeSpaceIds,
            },
          },
          {
            spaceId: null,
          },
        ],
      },
    },
    ...(type === "new" && {
      orderBy: [{ createdAt: "desc" }, { id: "desc" }],
    }),
    ...(type === "trending" && {
      orderBy: [{ trendingRank: "desc" }, { id: "desc" }],
    }),
    ...(type === "popular" && {
      orderBy: [{ voteCount: "desc" }, { id: "desc" }],
    }),
    skip: 10 * Number(page),
    take: 10,
  });

  const parentPostIds: any[] = posts.map((x) => x.parentPostId);

  const postsArray = await prisma.post.findMany({
    where: {
      id: {
        in: parentPostIds ?? [],
      },
    },
    select: {
      id: true,
    },
  });

  return res.send({
    posts: await Promise.all(
      postsArray.map(
        async (post) =>
          await returnPostObjectDto(
            post.id,
            userId,
            unauthorizedUserIds,
            unauthorizedFactiiiIds,
            spaceRuleIds,
          ),
      ),
    ),
    currentPage: page,
  });
};

export const openAISpacePosts = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { page = 0, type = "trending" } = req.query;

  const [
    unauthorizedSpaceIds,
    unauthorizedUserIds,
    openAiSpace,
    unauthorizedFactiiiIds,
    spaceRuleIds,
  ] = await Promise.all([
    //unauthorizedSpaceIds
    getUnauthorizedSpaceIds(userId),
    //bannedUsersListFromSpaceFilter
    getUnauthorizedUserIds(userId),
    //openAiSpace
    prisma.space.findFirst({
      where: {
        slug: "openai",
      },
      select: {
        id: true,
        pinnedPostId: true,
      },
    }),
    //unauthorizedFactiiiIds
    getUnauthorizedFactiiiIds(userId),
    //spaceRuleIds
    getSpaceRuleIds(userId),
  ]);

  if (!openAiSpace?.id)
    throw new AppError("Invalid request. Please try again.");

  const pinnedPostId = await prisma.post.findFirst({
    where: {
      id: openAiSpace.pinnedPostId ?? 0,
    },
    select: {
      id: true,
    },
  });

  const postIds = await prisma.post.findMany({
    where: {
      ...{
        //moderation
        spaceId: {
          notIn: unauthorizedSpaceIds,
        },
        userId: {
          notIn: unauthorizedUserIds,
        },
        //query
        replies: {
          some: {
            user: {
              username: "openai",
            },
          },
        },
        status: "PUBLISHED",
        id: {
          not: pinnedPostId?.id,
        },
      },
    },
    ...(type === "new" && {
      orderBy: [{ createdAt: "desc" }, { id: "desc" }],
    }),
    ...(type === "trending" && {
      orderBy: [{ trendingRank: "desc" }, { id: "desc" }],
    }),
    ...(type === "popular" && {
      orderBy: [{ voteCount: "desc" }, { id: "desc" }],
    }),
    select: {
      id: true,
    },
    skip: 10 * Number(page),
    take: 10 - (pinnedPostId && page === 0 ? 1 : 0), //If there is a pinned post, take 1 less to make 10 total returns
  });

  const posts = await Promise.all(
    postIds.map(
      async (post) =>
        await returnPostObjectDto(
          post.id,
          userId,
          unauthorizedUserIds,
          unauthorizedFactiiiIds,
          spaceRuleIds,
        ),
    ),
  );

  if (Number(page) === 0 && pinnedPostId) {
    const pinnedPost = await returnPostObjectDto(
      pinnedPostId.id,
      userId,
      unauthorizedUserIds,
      unauthorizedFactiiiIds,
      spaceRuleIds,
    );
    if (pinnedPost) {
      posts.unshift({ ...pinnedPost, pinned: true });
    }
  }

  return res.send({
    posts,
  });
};
