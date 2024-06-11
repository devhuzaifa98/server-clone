import { Router } from "express";
import { required, authGuard } from "../middlewares";
import { wrapper } from "../utilities";
import * as controller from "../controllers/bots.controller";

const router = Router();

router.get("/wikiControl", authGuard(true), wrapper(controller.wikiControl));

router.post(
  "/wiki-scrape-bulk-upload",
  authGuard(true),
  required(["scrappedData"]),
  // wrapper(controller.wikipediaBulkUpload),
);

router.get("/status", authGuard(true), wrapper(controller.getBotStatus));
router.put("/status", authGuard(true), wrapper(controller.toggleBotStatus));

router.put(
  "/limit",
  authGuard(true),
  required(["limit", "rootUrl"]),
  wrapper(controller.updateBot),
);

export default router;
