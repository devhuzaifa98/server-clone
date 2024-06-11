import jwt from "jsonwebtoken";
import { sendNotifications } from "../clients/expo";
import prisma from "../clients/prisma";
import createPushNotificationItems from "./createPushNotificationItems";

interface AuthObjectParams {
  id: number;
  browserName: string;
  refreshToken?: string;
}

const constructAuthObject = async ({
  id,
  browserName,
  refreshToken,
}: AuthObjectParams) => {
  const payload = {
    userId: id,
    refresher: refreshToken,
    browserName: browserName,
  };

  if (!refreshToken) {
    const token = await prisma.session.create({
      data: {
        userId: id,
        browserName: browserName,
      },
    });
    payload.refresher = token.refreshToken;
  }

  if (refreshToken) {
    const token = await prisma.session.update({
      where: {
        refreshToken,
      },
      data: {
        browserName: browserName,
      },
      select: {
        userId: true,
        refreshToken: true,
      },
    });
    if (!token) throw new Error("No refresh token found");
    payload.refresher = token.refreshToken;
  }

  const accessToken = jwt.sign(
    payload,
    process.env.ACCESS_TOKEN_SECRET as string,
    { expiresIn: "30m" },
  );

  return {
    access: accessToken,
    refresh: payload.refresher,
  };
};

export default constructAuthObject;
