import { Router } from "express";
import { wrapper } from "../utilities";
import { authGuard, required } from "../middlewares";
import * as controller from "../controllers/spaces.controller";

const router = Router();

router.get("/rules/revisions/:ruleId", wrapper(controller.ruleEditHistory));

router.get("/my", authGuard(true), wrapper(controller.mySpaces));

router.get("/suggested", authGuard(), wrapper(controller.suggestedSpaces));

router.get("/filter", authGuard(true), wrapper(controller.listFilteredSpaces));

router
  .route("/:slug/space")
  .get(authGuard(), wrapper(controller.getSpace))
  .put(authGuard(true), wrapper(controller.updateSpace));

router
  .route("/:slug/options")
  .get(authGuard(true), wrapper(controller.getSpaceOptions))
  .put(authGuard(true), wrapper(controller.updateSpaceOptions));

router
  .route("/:slug/rules")
  .post(authGuard(true), wrapper(controller.updateRule))
  .put(authGuard(true), wrapper(controller.updateRule));

router.get("/:slug/members", authGuard(), wrapper(controller.membersList));

// router.get(
//   "/:slug/membership/subscribe",
//   authGuard(true),
//   wrapper(controller.joinPaidSpace)
// );

router.get(
  "/:slug/membership/cancel",
  authGuard(true),
  wrapper(controller.cancelSpaceSubscription),
);

router.post("/:slug/pin/:postId", authGuard(true), wrapper(controller.pinPost));

router.post("/:slug/unpin", authGuard(true), wrapper(controller.unpinPost));

router.post(
  "/",
  required(["name"]),
  authGuard(true),
  wrapper(controller.createSpace),
);

router
  .route("/:slug/moderators")
  .post(
    required(["username"]),
    authGuard(true),
    wrapper(controller.addModerator),
  )
  .get(authGuard(), authGuard(), wrapper(controller.moderatorsList));

//Gets a list of factiiis for a space
router
  .route("/:slug/factiiis")
  .get(authGuard(), wrapper(controller.factiiisList));

router.delete(
  "/:slug/moderators/:username",
  authGuard(true),
  wrapper(controller.removeModerator),
);

router
  .route("/:slug/user-ban")
  .post(required(["username"]), authGuard(true), wrapper(controller.banUser))
  .get(authGuard(), authGuard(), wrapper(controller.bannedUsersList));

router.delete(
  "/:slug/user-ban/:username",
  authGuard(true),
  wrapper(controller.unbanUser),
);

router.post("/:slug/join", authGuard(true), wrapper(controller.joinSpace));

router.post("/:slug/leave", authGuard(true), wrapper(controller.leaveSpace));

router
  .route("/:slug/filter")
  .post(authGuard(true), wrapper(controller.addFilter))
  .delete(authGuard(true), wrapper(controller.removeFilter));

router.get("/:slug/history", authGuard(), wrapper(controller.getSpaceHistory));

router.post(
  "/:slug/invite",
  authGuard(true),
  required(["targetUsername"]),
  wrapper(controller.inviteUserToSpace),
);

router
  .route("/:slug/transfer-ownership")
  .post(authGuard(true), wrapper(controller.transferOwnership));

router
  .route("/:spaceSlug/:factiiiSlug/factiii")
  .delete(authGuard(true), wrapper(controller.deleteFactiii))
  .get(authGuard(), wrapper(controller.getFactiii));

export default router;
