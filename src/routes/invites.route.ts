import { Router } from "express";
import { wrapper } from "../utilities";
import * as controller from "../controllers/invites.controller";
import { authGuard, required } from "../middlewares";

const router = Router();

router.get("/", authGuard(true), wrapper(controller.getInvites));

export default router;
