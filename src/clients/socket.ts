import { Server as SocketServer, Socket } from "socket.io";
import { Server } from "http";
import prisma from "./prisma";

let socketObject: Socket;
let ioObject: SocketServer | null = null;

const initializeSocketConnection = (httpServer: Server) => {
  const io = new SocketServer(httpServer, {
    cors: {
      origin: [
        process.env.CLIENT_APP_URL,
        process.env.MOBILE_APP_URL,
      ] as string[],
      methods: ["GET", "POST"],
      credentials: true,
    },
  });

  io.on("connection", (socket) => {
    socketObject = socket;
    //remove  socketId if any
    socket.on("disconnect", () => {
      prisma.session.update({
        where: {
          socketId: socket.id,
        },
        data: {
          socketId: null,
        },
      });
    });
    socket.on("joinConversation", (convId: string) => {
      socket.join("conversation-" + convId);
    });
    socket.on("leaveConversation", (convId: string) => {
      socket.leave("conversation-" + convId);
    });
    socket.on("typing", (senderId: number, convId: string) => {
      socket.to("conversation-" + convId).emit("typing", senderId, convId);
    });

    socket.on("joinPostStats", async (postId: string) => {
      socket.join(`post-${postId}`);
    });

    socket.on("leavePostStats", async (postId: number) => {
      socket.leave(`post-${postId}`);
    });

    //socket.to(`notifications-u${userId}`).emit("notificationCount", pendingNotificationsCount);
    // socket.on("subToPostReplies", async (postId: number) => {
    //     socket.join(`post-replies-${postId}`);
    // socket.on("postVote", async (postId: string) => {
    //         socket.to(`post-${postId}`).emit("voteCount", post.voteCount, post.id);
    // socket.on("postReply", async (postId: string, replyId: string) => {

    //     socket.to(`post-${postId}`).emit("repliesCount", repliesCount, postId);
    //     socket.to(`post-${postId}`).emit("newReply", replyDto);
    // });
    // socket.on("subToPurchases", async (userId: number) => {
    //     socket.join(`${userId}-purchases`);
    // });
    // socket.on("subToSession", async (refreshToken: string) => {
    //     socket.join(`session-${refreshToken}`);
    // });
    // socket.on('sessionRemoved', async (refreshToken: string) => {
    //     socket.to(`session-${refreshToken}`).emit("logout");
    // });
  });

  ioObject = io;
  return io;
};

const getIo = () => {
  if (!ioObject) throw new Error("Socket.io has not been initialized.");
  return ioObject;
};

export {
  socketObject as socket,
  getIo as getIoInstance,
  initializeSocketConnection,
};
