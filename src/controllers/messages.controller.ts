import { Response, Request } from "express";
import AppError from "../utilities/AppError";
import { getS3ObjectURL } from "../clients/s3";
import prisma from "../clients/prisma";
import { createPushNotificationItems } from "../utilities";
import { sendNotifications } from "../clients/expo";
import { getIoInstance } from "../clients/socket";

export const startConversation = async (req: Request, res: Response) => {
  const { username } = req.params;
  const userId: number = req.body.auth?.userId ?? 0;

  const checkUser = await prisma.user.findFirst({
    where: {
      username,
    },
    select: {
      id: true,
    },
  });

  if (!checkUser)
    throw new AppError("No user found with that username. Please try again.");

  if (checkUser.id === userId)
    throw new AppError("You cannot start a conversation with yourself.");

  const checkBlock = await prisma.user.count({
    where: {
      username,
      blockedUsers: {
        some: {
          id: userId,
        },
      },
    },
  });

  if (checkBlock) throw new AppError(`Starting conversation failed.`);

  const conversations = await prisma.conversation.findMany({
    where: {
      participants: {
        every: {
          userId: {
            in: [userId, checkUser.id],
          },
        },
      },
    },
    select: {
      id: true,
      participants: {
        select: {
          userId: true,
        },
      },
    },
  });

  const exclusiveConversations = conversations.filter((conversation) => {
    const participantIds = conversation.participants.map((p) => p.userId);
    return (
      participantIds.length === 2 &&
      participantIds.includes(userId) &&
      participantIds.includes(checkUser.id)
    );
  });

  if (exclusiveConversations.length === 1) {
    return res.send({
      id: exclusiveConversations[0].id,
    });
  }

  const newConversation = await prisma.conversation.create({
    data: {
      participants: {
        createMany: {
          data: [{ userId }, { userId: checkUser.id }],
        },
      },
    },
  });

  return res.send({
    id: newConversation.id,
  });
};

export const getConversations = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { page = 0 } = req.query;

  const conversations = await prisma.conversation.findMany({
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
      participants: {
        select: {
          user: {
            select: {
              avatar: true,
              id: true,
              name: true,
              username: true,
              lastActive: true,
            },
          },
        },
      },
      lastMessage: {
        select: {
          id: true,
          content: true,
          createdAt: true,
          sender: {
            select: {
              id: true,
              name: true,
              username: true,
              avatar: true,
            },
          },
        },
      },
      reads: {
        where: {
          userId: {
            equals: userId,
          },
        },
        select: {
          lastReadMessageId: true,
        },
      },
    },
    orderBy: {
      lastMessage: {
        createdAt: "desc",
      },
    },
    skip: 10 * Number(page),
    take: 10,
  });

  const dto = await Promise.all(
    conversations.map(async (cov) => {
      return {
        id: cov.id,
        read: cov.reads[0]?.lastReadMessageId === cov.lastMessage?.id,
        lastMessage: cov.lastMessage
          ? {
              id: cov.lastMessage.id,
              content: cov.lastMessage.content,
              createdAt: cov.lastMessage.createdAt,
              sender: {
                id: cov.lastMessage.sender.id,
                name: cov.lastMessage.sender.name,
                username: cov.lastMessage.sender.username,
                avatar: getS3ObjectURL(cov.lastMessage?.sender.avatar?.key),
              },
            }
          : null,
        participants: cov.participants.map((x) => {
          return {
            id: x.user.id,
            name: x.user.name,
            username: x.user.username,
            avatar: getS3ObjectURL(x.user.avatar?.key),
            lastActive: x.user.lastActive,
          };
        }),
      };
    }),
  );

  return res.send({
    conversations: dto.filter((item) => !!item),
  });
};

export const sendMessage = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { conversation } = req.params;
  const { message } = req.body;

  const checkConversation = await prisma.conversation.findFirst({
    where: {
      id: conversation,
      participants: {
        some: {
          userId: {
            equals: userId,
          },
        },
      },
    },
    select: {
      participants: {
        select: {
          userId: true,
        },
      },
      id: true,
    },
  });

  if (!checkConversation)
    throw new AppError(
      "You do not have the permissions to send a message in this conversation.",
    );

  const currentUser = await prisma.user.findFirst({
    where: {
      id: userId,
    },
    select: {
      id: true,
      name: true,
      username: true,
      avatar: true,
    },
  });

  if (!currentUser) throw new AppError("User not found.");

  const newMessage = await prisma.message.create({
    data: {
      content: message,
      senderId: userId,
      conversationId: checkConversation.id,
    },
  });

  await prisma.conversation.updateMany({
    where: {
      id: checkConversation.id,
    },
    data: {
      lastMessageId: newMessage.id,
    },
  });

  for (const participant of checkConversation.participants.filter(
    (user) => user.userId !== userId,
  )) {
    const pushItem = await createPushNotificationItems(
      participant.userId,
      message.length > 32 ? `"${message.slice(0, 32)}..."` : `"${message}"`,
      currentUser?.name
        ? `${currentUser?.name} sent a message`
        : `@${currentUser.username} sent a message`,
      {
        screen: "MessageChat",
        data: {
          convId: checkConversation.id,
          name: currentUser?.name,
          avatar: getS3ObjectURL(currentUser?.avatar?.key),
          username: currentUser?.username,
        },
      },
    );
    await sendNotifications(pushItem);
  }

  const sender = {
    id: currentUser.id,
    name: currentUser.name,
    username: currentUser.username,
    avatar: getS3ObjectURL(currentUser.avatar?.key),
  };

  const io = getIoInstance();
  io.to("conversation-" + checkConversation.id).emit(
    "newMessage",
    sender,
    checkConversation.id,
    message,
    newMessage.id,
    newMessage.createdAt,
  );

  return res.send({
    id: newMessage.id,
    createdAt: newMessage.createdAt,
  });
};

export const getMessages = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { page = 0 } = req.query;
  const { conversationId } = req.params;

  const checkConversation = await prisma.conversation.findFirst({
    where: {
      id: conversationId,
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
      createdAt: true,
      participants: {
        select: {
          user: {
            select: {
              id: true,
              name: true,
              username: true,
              avatar: true,
              lastActive: true,
            },
          },
        },
      },
      lastMessage: {
        select: {
          id: true,
          senderId: true,
          content: true,
          createdAt: true,
          sender: {
            select: {
              id: true,
              name: true,
              username: true,
              avatar: true,
            },
          },
        },
      },
      reads: {
        where: {
          userId: {
            equals: userId,
          },
        },
        select: {
          lastReadMessageId: true,
        },
      },
    },
  });

  if (!checkConversation)
    throw new AppError(
      "You do not have the permissions to send a message in this conversation.",
    );

  const messages = await prisma.message.findMany({
    where: {
      conversationId: checkConversation.id,
    },
    orderBy: {
      createdAt: "desc",
    },
    select: {
      id: true,
      content: true,
      senderId: true,
      conversationId: true,
      createdAt: true,
      sender: {
        select: {
          id: true,
          name: true,
          username: true,
          avatar: true,
        },
      },
    },
    skip: 20 * Number(page),
    take: 20,
  });

  //if page is 0, return conversation details
  let conversation = null;
  if (Number(page) === 0) {
    conversation = {
      id: checkConversation.id,
      read:
        checkConversation.reads[0]?.lastReadMessageId ===
        checkConversation.lastMessage?.id,
      lastMessage: checkConversation.lastMessage
        ? {
            id: checkConversation.lastMessage.id,
            content: checkConversation.lastMessage.content,
            createdAt: checkConversation.lastMessage.createdAt,
            sender: {
              id: checkConversation.lastMessage.sender.id,
              name: checkConversation.lastMessage.sender.name,
              username: checkConversation.lastMessage.sender.username,
              avatar: getS3ObjectURL(
                checkConversation.lastMessage?.sender.avatar?.key,
              ),
            },
          }
        : null,
      participants: checkConversation.participants.map((x) => {
        return {
          id: x.user.id,
          name: x.user.name,
          username: x.user.username,
          avatar: getS3ObjectURL(x.user.avatar?.key),
          lastActive: x.user.lastActive,
        };
      }),
    };
  }

  return res.send({
    messages: messages.map((x) => {
      return {
        id: x.id,
        content: x.content,
        sender: {
          id: x.sender.id,
          name: x.sender.name,
          username: x.sender.username,
          avatar: getS3ObjectURL(x.sender.avatar?.key),
        },
        conversationId: x.conversationId,
        createdAt: x.createdAt,
      };
    }),
    ...(conversation ? { conversation } : {}), // Conditionally include 'conversation' this stops sending after page 0
  });
};

export const updateReadReceipt = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { conversationId } = req.params;
  const { lastReadMessageId } = req.body;

  await prisma.readConversation.upsert({
    where: {
      userId_conversationId: {
        userId,
        conversationId,
      },
    },
    create: {
      userId,
      conversationId,
      lastReadMessageId,
    },
    update: {
      lastReadMessageId,
    },
  });

  return res.send({
    success: true,
  });
};

export const fetchLastReadMessage = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { conversationId } = req.params;

  const checkConversation = await prisma.readConversation.findFirst({
    where: {
      userId,
      conversationId,
    },
    select: {
      lastReadMessageId: true,
    },
  });

  return res.send({
    lastReadMessageId: checkConversation?.lastReadMessageId ?? null,
  });
};
