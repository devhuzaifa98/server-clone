import { Expo } from "expo-server-sdk";

export type PushNotificationItem = {
  title: string;
  to: string;
  sound: undefined | "default";
  body: string;
  data?: {
    screen: string;
    data?: any;
  };
};

const expo = new Expo();

export const sendNotifications = async (items: PushNotificationItem[]) => {
  try {
    const validItems: PushNotificationItem[] = [];
    for (let item of items) {
      if (Expo.isExpoPushToken(item.to)) validItems.push(item);
    }
    const chunks = expo.chunkPushNotifications(validItems);
    const tickets = [];

    for (let chunk of chunks) {
      try {
        let ticketChunk = await expo.sendPushNotificationsAsync(chunk);
        tickets.push(...ticketChunk);
      } catch (error: any) {
        throw new Error("Expo Push Error: " + error);
      }
    }

    return tickets;
  } catch (error) {
    throw new Error(error as any);
  }
};
