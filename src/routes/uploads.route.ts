import { Router } from "express";
import { authGuard, required } from "../middlewares";
import * as controller from "../controllers/uploads.controller";
import { wrapper } from "../utilities";

const router = Router();

router.post(
  "/",
  authGuard(true),
  required(["source"]),
  wrapper(controller.upload),
);

router.get("/all", authGuard(true), wrapper(controller.getUserUploads));

export default router;
