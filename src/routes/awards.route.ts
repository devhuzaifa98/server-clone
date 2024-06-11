import { Router } from "express";
import { wrapper } from "../utilities";
import * as controller from "../controllers/awards.controller";
import { authGuard, required } from "../middlewares";

const router = Router();

router.get("/items", authGuard(), wrapper(controller.getItems));

router.get("/history", authGuard(true), wrapper(controller.history));

router.get("/post/:postId", authGuard(true), wrapper(controller.postAwards));

router.post(
  "/:awardId",
  required(["postId"]),
  authGuard(true),
  wrapper(controller.awardPost),
);

export default router;
