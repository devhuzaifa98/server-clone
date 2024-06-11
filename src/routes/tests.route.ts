import { Router } from "express";
import { authGuard } from "../middlewares";
import { wrapper } from "../utilities";
import * as controller from "../controllers/tests.controller";

const router = Router();

router.get("/sentry", authGuard(true), wrapper(controller.sentry));

export default router;
