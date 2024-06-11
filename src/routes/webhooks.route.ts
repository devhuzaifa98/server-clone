import { Router, raw } from "express";
import { wrapper } from "../utilities";
import * as controller from "../controllers/webhooks.controller";

const router = Router();

router.post(
  "/stripe",
  raw({ type: "application/json" }),
  wrapper(controller.stripeHook),
);

export default router;
