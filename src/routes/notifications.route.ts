import { Router } from "express";
import { required, authGuard } from "../middlewares";
import { wrapper } from "../utilities";
import * as controller from "../controllers/notifications.controller";

const router = Router();

// router.post('/', authGuard(true), required(['type', 'to']), wrapper(controller.newNotif));

router.get("/", authGuard(true), wrapper(controller.getNotifications));

router.post("/mark-read", authGuard(true), wrapper(controller.markAllAsRead));

export default router;
