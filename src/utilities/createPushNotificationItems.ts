import { PushNotificationItem } from "../clients/expo";
import prisma from "../clients/prisma";
import AppError from "./AppError";

const createPushNotificationItems = async (
  userId: number,
  message: string,
  title: string = "Factiii",
  actions?: { screen: string; data?: any },
) => {
  const items: PushNotificationItem[] = [];

  const userTokens = await prisma.user.findUnique({
    where: {
      id: userId,
    },
    select: {
      devices: true,
    },
  });

  if (!userTokens)
    throw new AppError("User not found. Please check the request again.");

  for (const token of userTokens.devices) {
    items.push({
      title,
      to: token.pushToken,
      sound: "default",
      body: message,
      data: actions,
    });
  }

  return items;
};

export default createPushNotificationItems;
