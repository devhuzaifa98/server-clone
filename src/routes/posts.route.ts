import { Router } from "express";
import { required, authGuard } from "../middlewares";
import { wrapper } from "../utilities";
import * as controller from "../controllers/posts.controller";

const router = Router();

router.get("/botsettings", authGuard(true), wrapper(controller.getBotSettings));

router.get("/feed", authGuard(true), wrapper(controller.getFeedPosts));

router.get("/trending", authGuard(), wrapper(controller.getExplorePagePosts));

router.get("/saved", authGuard(true), wrapper(controller.getSavedPosts));

router.get("/withdrawn/:username", authGuard(true), wrapper(controller.getWithdrawnPosts))

router.get("/users/openai", authGuard(), wrapper(controller.openAiUserPosts));

router.get("/users/:username", authGuard(), wrapper(controller.getUserPosts));

router.get("/spaces/openai", authGuard(), wrapper(controller.openAISpacePosts));

router.get("/spaces/:slug", authGuard(), wrapper(controller.getSpacePosts));

router.get(
  "/singlePost/:postId",
  authGuard(),
  wrapper(controller.getSinglePost),
);

router.get("/replies/:postId", authGuard(), wrapper(controller.getReplies));

router.get("/revisions/:postId", wrapper(controller.postEditHistory));

router.get("/drafts", authGuard(true), wrapper(controller.getDrafts));

router.get(
  "/:slug/:factiii_slug/factiiis",
  authGuard(),
  wrapper(controller.getFactiiis),
);

router
  .route("/:postId")
  .get(authGuard(), wrapper(controller.getPost))
  .put(authGuard(true), required(["content"]), wrapper(controller.editPost));

router.post("/saved/:postId", authGuard(true), wrapper(controller.savePost));

// When parentPostId is provided it is a reply
router.post("/", authGuard(true), wrapper(controller.newPost));
router.post("/:parentPostId", authGuard(true), wrapper(controller.newPost));

router.put(
  "/vote/:postId",
  authGuard(true),
  required(["type"]),
  wrapper(controller.votePost),
);

router.delete("/:postId", authGuard(true), wrapper(controller.deletePost));

export default router;
