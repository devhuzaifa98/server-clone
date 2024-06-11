import prisma from "../clients/prisma";
import { getIoInstance } from "../clients/socket";

const emitNotificationCount = async (userId: number, socketId: string) => {
  const pendingNotificationsCount = await prisma.notification.count({
    where: {
      targetUserId: userId,
      read: false,
    },
  });
  const sockets = await prisma.session.findMany({
    where: {
      userId,
      revokedAt: null,
    },
    select: {
      socketId: true,
    },
  });
  const io = getIoInstance();
  sockets.forEach((socket) => {
    if (socket.socketId) {
      io.to(socket.socketId).emit(
        "notificationCount",
        pendingNotificationsCount,
      );
    }
  });
};

export default emitNotificationCount;
