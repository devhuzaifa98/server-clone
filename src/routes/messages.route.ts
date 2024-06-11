import { Router } from "express";
import { required, authGuard } from "../middlewares";
import { wrapper } from "../utilities";
import * as controller from "../controllers/messages.controller";

const router = Router();

router.post(
  "/start-conversation/:username",
  authGuard(true),
  wrapper(controller.startConversation),
);

router.get(
  "/conversations",
  authGuard(true),
  wrapper(controller.getConversations),
);

router.post(
  "/send/:conversation",
  required(["message"]),
  authGuard(true),
  wrapper(controller.sendMessage),
);

router.get(
  "/get/:conversationId",
  authGuard(true),
  wrapper(controller.getMessages),
);

router.post(
  "/update-read-receipt/:conversationId",
  authGuard(true),
  wrapper(controller.updateReadReceipt),
);

router.get(
  "/fetch-last-read-message/:conversationId",
  authGuard(true),
  wrapper(controller.fetchLastReadMessage),
);

export default router;
