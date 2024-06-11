import { Router } from "express";
import { required, authGuard } from "../middlewares";
import { wrapper } from "../utilities";
import * as controller from "../controllers/reports.controller";

const router = Router();

// returns all the rules of the s/factiii space
router.get("/rules", controller.getRulesList);

// records/saves a new moderation report
router.post(
  "/",
  required(["ruleId", "type", "targetId"]),
  authGuard(true),
  controller.newModerationReport,
);

// returns the list of all the spaces the user moderates
router.get(
  "/list",
  authGuard(true),
  wrapper(controller.getModeratorPermissionsList),
);

// returns the list of all the pending moderation reports
router.get("/:slug", authGuard(true), wrapper(controller.getModerationReports));

// discards a moderation report
router.delete("/:id", authGuard(true), controller.discardModerationReport);

// delists/bans the report target
router.put("/:id", authGuard(true), controller.moderationReportAction);

// records/saves a new feedback
router.post(
  "/feedback",
  required(["message", "feedbackType"]),
  authGuard(),
  controller.newFeedback,
);

export default router;
