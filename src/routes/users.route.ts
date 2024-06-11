import { Router } from "express";
import { authGuard, required } from "../middlewares";
import { wrapper } from "../utilities";
import * as controller from "../controllers/users.controller";

const router = Router();

router.put("/setSocket", authGuard(), wrapper(controller.setSocketId));

router.get(
  "/details/:username",
  authGuard(),
  wrapper(controller.publicDetails),
);

router
  .route("/details")
  .get(authGuard(true), wrapper(controller.details))
  .put(authGuard(true), wrapper(controller.updateUser));

router.get(
  "/followers/:username",
  authGuard(),
  wrapper(controller.followersList),
);

router.get(
  "/following/:username",
  authGuard(),
  wrapper(controller.followingList),
);

router.post("/mute/:username", authGuard(true), wrapper(controller.muteUser));

router.post("/unmute/:username", authGuard(true), wrapper(controller.unmuteUser));

router.post(
  "/deactivate",
  required(["password"]),
  authGuard(true),
  wrapper(controller.deactivate),
);

router.post(
  "/preferences",
  required(["payload"]),
  authGuard(true),
  wrapper(controller.updatePreferences),
);

router.post("/follow/:username", authGuard(true), wrapper(controller.follow));

router.post(
  "/unfollow/:username",
  authGuard(true),
  wrapper(controller.unfollow),
);

router.post("/pin/:postId", authGuard(true), wrapper(controller.pinPost));

router.post("/unpin", authGuard(true), wrapper(controller.unpinPost));

router.post(
  "/register-push-token",
  required(["token"]),
  authGuard(),
  wrapper(controller.registerPushToken),
);

router.post(
  "/deregister-push-token",
  required(["token"]),
  authGuard(),
  wrapper(controller.deregisterPushToken),
);

router
  .route("/block/:username")
  .post(authGuard(true), wrapper(controller.block))
  .delete(authGuard(true), wrapper(controller.unblock));

router.get(
  "/history/:username",
  authGuard(),
  wrapper(controller.getProfileHistory),
);

router.get("/muted-users", authGuard(true), wrapper(controller.mutedUsers));

router.get(
  "/blocked-users",
  authGuard(true),
  wrapper(controller.blockedUsersList),
);

router.post("/waitlist", required(["email"]), controller.waitList);

router.post("/ping", authGuard(true), wrapper(controller.pingHandler));

router.post(
  "/pinned-factiiis/visibility",
  authGuard(true),
  wrapper(controller.togglePinnedFactiiisVisibility),
);

router
  .route("/:username/:factiiiSlug/factiii")
  .post(authGuard(true), wrapper(controller.addFactiii))
  .delete(authGuard(true), wrapper(controller.deleteFactiii))
  .get(authGuard(), wrapper(controller.getUserFactiii));

export default router;
