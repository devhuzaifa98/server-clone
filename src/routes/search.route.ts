import { Router } from "express";
import * as controller from "../controllers/search.controller";
import { authGuard } from "../middlewares";
import { wrapper } from "../utilities";

const router = Router();

router.get("/users", authGuard(), wrapper(controller.searchUsers));

router.get("/posts", authGuard(), wrapper(controller.searchPosts));

router.get("/spaces", authGuard(), wrapper(controller.searchSpaces));

router.get("/factiiis", authGuard(), wrapper(controller.searchFactiiis));

router.get("/goals", authGuard(), wrapper(controller.searchGoals));

router.get("/scrapes", authGuard(), wrapper(controller.searchScrapes));

export default router;
