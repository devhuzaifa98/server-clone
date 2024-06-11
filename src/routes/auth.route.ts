import { Router } from "express";
import { required, authGuard } from "../middlewares";
import { wrapper } from "../utilities";
import * as controller from "../controllers/auth.controller";

const router = Router();

router.post(
  "/register",
  required(["username", "email", "password"]),
  wrapper(controller.register),
);

router
  .route("/twoFa-reset")
  .post(
    required(["password", "username"]),
    wrapper(controller.sendResetTwoFaEmail),
  );

router.post("/login", required(["password"]), wrapper(controller.login));

router.post("/update", authGuard(true), wrapper(controller.updateDetails));

router.post("/refresh", required(["token"]), wrapper(controller.refresh));

router.post(
  "/change-password",
  required(["oldPassword", "newPassword"]),
  authGuard(true),
  wrapper(controller.changePassword),
);

router.post(
  "/send-password-reset-email",
  required(["email"]),
  wrapper(controller.sendResetPasswordEmail),
);

router.post(
  "/send-verification-email",
  required(["email"]),
  authGuard(true),
  wrapper(controller.sendVerificationEmail),
);

router.post(
  "/verify-email",
  required(["email"]),
  authGuard(true),
  wrapper(controller.verifyEmail),
);

router
  .route("/password-reset/:token")
  .get(wrapper(controller.checkResetPasswordToken))
  .post(required(["password"]), wrapper(controller.resetPassword));

router.get("/logout", authGuard(), wrapper(controller.logout));

router.post(
  "/2fa/disable",
  required(["password"]),
  authGuard(true),
  wrapper(controller.disable2FA),
);

router.post("/2fa/enable", authGuard(true), wrapper(controller.enable2FA));

//This will add a 2fa if one does not exist and requires a push token from a device so can only be called from a device
router.post(
  "/2fa/secret",
  authGuard(true),
  required(["pushCode"]),
  wrapper(controller.getSecret),
);

export default router;
