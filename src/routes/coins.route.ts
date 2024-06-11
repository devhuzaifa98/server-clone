import { Router } from "express";
import { wrapper } from "../utilities";
import { authGuard, required } from "../middlewares";
import * as controller from "../controllers/coins.controllers";

const router = Router();

router.get("/", authGuard(), wrapper(controller.listCoins));

router.get(
  "/purchaseable",
  authGuard(),
  wrapper(controller.getPurchasableCoins),
);

router.get("/premium", authGuard(), wrapper(controller.listPremium));

router.get("/purchases", authGuard(true), wrapper(controller.listPurchases));

router.get("/donations", authGuard(true), wrapper(controller.listDonations));

//This verifies the user can buy the product for stripe/google/apple
router.post(
  "/check/:productId",
  authGuard(true),
  wrapper(controller.checkPurchase),
);

//This credits the user with the product for google/apple
router.post(
  "/credit/:productId",
  authGuard(true),
  wrapper(controller.creditPurchase),
);

router.get("/rewards", authGuard(true), wrapper(controller.coinRewards));

router.post(
  "/donate",
  required(["email", "amount"]),
  authGuard(),
  wrapper(controller.createDonation),
);

router.post(
  "/cancel/:subscriptionId",
  authGuard(true),
  wrapper(controller.cancelSubscription),
);

export default router;
