import { Router } from "express";
import { authGuard } from "../middlewares";
import { wrapper } from "../utilities";
import * as controller from "../controllers/sessions.controller";

const router = Router();

router.get("/", authGuard(true), wrapper(controller.getSessions));

router.delete("/", authGuard(true), wrapper(controller.endAllSessions));

router.delete("/:id", authGuard(true), wrapper(controller.deleteSession));

export default router;
