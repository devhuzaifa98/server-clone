import { Router } from "express";
import { wrapper } from "../utilities";
import * as controller from "../controllers/platform.controller";

const router = Router();

router.get(
  "/opengraph/image/post/:postId",
  wrapper(controller.postOpenGraphImage),
);

router.get(
  "/opengraph/image/profile/:username",
  wrapper(controller.profileOpenGraphImage),
);

router.get(
  "/opengraph/image/space/:slug",
  wrapper(controller.spaceOpenGraphImage),
);

router.get(
  "/opengraph/image/factiii/:slug",
  wrapper(controller.factiiiOpenGraphImage),
);

export default router;
