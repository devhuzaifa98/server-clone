import { Router } from "express";
import * as controller from "../controllers/factiiis.controller";
import { authGuard } from "../middlewares";
import { wrapper } from "../utilities";

const router = Router();

router.get("/initialItems", authGuard(), wrapper(controller.getInitialItems));

router.get("/items", authGuard(), wrapper(controller.getFactiiiItems));

router.get("/goals", authGuard(true), wrapper(controller.getGoals));

router
  .route("/preferences")
  .get(authGuard(true), wrapper(controller.getFactiiiPreferences))
  .put(authGuard(true), wrapper(controller.putFactiiiPreferences));

router.get("/fetch/:type/:slug", authGuard(), wrapper(controller.getFactiiis));

router.get("/posts", authGuard(), wrapper(controller.getFactiiiPosts));

router.post("/:factiiiId/pin", authGuard(true), wrapper(controller.pinFactiii));

router.get(
  "/myFactiiiTags/:postId",
  authGuard(true),
  wrapper(controller.myFactiiiTags),
);

router.get(
  `/:factiiiQuery/query`,
  authGuard(),
  wrapper(controller.getFactiiiQuery),
);

router.get(
  `/:spaceSlug/all`,
  authGuard(true),
  wrapper(controller.getAllFactiiis),
);

router.post("/tag/:postId", authGuard(true), wrapper(controller.tagPost));

router.post("/updateGoals", authGuard(true), wrapper(controller.updateGoals));

router.route("/add").post(authGuard(true), wrapper(controller.addFactiii));

router
  .route("/:factiiiId/retire")
  .delete(authGuard(true), wrapper(controller.deleteFactiii));

router
  .route("/:factiiiId/reactivate")
  .post(authGuard(true), wrapper(controller.reactivateFactiii));

export default router;
