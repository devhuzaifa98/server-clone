import { Request, Response } from "express";
import prisma from "../clients/prisma";
import bcrypt from "bcrypt";
import { v4 } from "uuid";
import {
  constructAuthObject,
  createPushNotificationItems,
  detectBrowser,
  generateTotpSecret,
} from "../utilities";
import {
  sendOTPLoginEmail,
  sendPasswordResetEmail,
  sendEmailVerificationEmail,
} from "../clients/ses";
import totp from "totp-generator";
import AppError from "../utilities/AppError";
import { sendNotifications } from "../clients/expo";
import generateRandomNumber from "../utilities/generateRandomNumber";
import { endAllSessionsFcn } from "./sessions.controller";
import cleanBase32String from "../helpers/cleanBase32String";
import awardCoinsReward from "../utilities/awardCoinsReward";

export const register = async (req: Request, res: Response) => {
  const { username, email, password, types, referrerUserId, mobile } = req.body;
  const userAgent = req.get("user-agent");
  const usernameValidationRegex = /^[a-zA-Z0-9_]+$/;

  if (!username.match(usernameValidationRegex))
    throw new AppError(
      "Username can only contain alphanumeric characters and underscores",
    );

  const usernameCheck = await prisma.user.findFirst({
    where: {
      username,
    },
  });
  if (usernameCheck)
    throw new AppError(
      "An account already exists with that username. Try a different one.",
    );

  const emailCheck = await prisma.user.findFirst({
    where: {
      email,
    },
    select: {
      types: true,
      id: true,
    },
  });
  if (emailCheck)
    throw new AppError(
      "An account already exists with that email. Try a different one.",
    );

  const salt = await bcrypt.genSalt(10);
  const hashedPassword = await bcrypt.hash(password, salt);

  const factiii = await prisma.space.findUnique({
    where: {
      slug: "factiii",
    },
    select: {
      id: true,
    },
  });
  if (!factiii) {
    throw new AppError("factiii not found");
  }

  const user = await prisma.user.create({
    data: {
      username,
      email,
      password: hashedPassword,
      types,
      referredById: referrerUserId ? Number(referrerUserId) : undefined,
      filters: {
        create: {
          spaceId: factiii.id,
        },
      },
    },
  });

  await prisma.userPreference.create({
    data: {
      userId: user.id,
    },
  });

  let browser = userAgent ? detectBrowser(userAgent) : "Unknown";

  if (mobile) browser = mobile === "android" ? "Android" : "iOS";

  return res.send({
    credentials: await constructAuthObject({
      id: user.id,
      browserName: browser,
    }),
  });
};

export const sendResetTwoFaEmail = async (req: Request, res: Response) => {
  const { username, password } = req.body;

  const user = await prisma.user.findFirst({
    where: {
      username,
      twoFaEnabled: true,
    },
    select: {
      id: true,
      password: true,
      email: true,
    },
  });

  if (!user) throw new AppError("Invalid credentials. Please try again.");

  const isMatch = await bcrypt.compare(password, user.password);

  if (!isMatch) throw new AppError("Incorrect credentials. Please try again.");

  const otp = generateRandomNumber(100000, 999999);
  await prisma.oTPBasedLogin.create({
    data: {
      userId: user.id,
      code: otp,
    },
  });

  await sendOTPLoginEmail(user.email, otp);

  return res.send({
    success: true,
  });
};

export const login = async (req: Request, res: Response) => {
  const { username, password, pushCode, code } = req.body;
  const userAgent = req.get("user-agent");

  if (!username)
    throw new AppError("Your username or email address is required to login");

  const user = await prisma.user.findFirst({
    where: {
      OR: [{ email: username }, { username }],
    },
    select: {
      id: true,
      status: true,
      password: true,
      twoFaEnabled: true,
      email: true,
      preferences: true,
      devices: {
        select: {
          pushToken: true,
        },
        orderBy: {
          createdAt: "desc",
        },
      },
    },
  });

  if (!user) {
    await prisma.error.create({
      data: {
        ip: req.ip,
        description: "login failed username " + username,
      },
    });
    throw new AppError("Invalid credentials. Please try again.");
  }

  if (user.status !== "ACTIVE") {
    await prisma.error.create({
      data: {
        ip: req.ip,
        description: "deactivated account attempted login",
        userId: user.id,
      },
    });
    throw new AppError(
      "Your account has been deactivated. Please contact us to activate your account",
    );
  }

  const isMatch = await bcrypt.compare(password, user.password);
  if (!isMatch) {
    await prisma.error.create({
      data: {
        ip: req.ip,
        description: "login failed for incorrect password userId: " + user.id,
        userId: user.id,
      },
    });
    throw new AppError("Incorrect credentials. Please try again.");
  }

  //this is the 2fa verification logic that is called twice
  const verify2FACode = async (userId: number, code: string) => {
    if (!code) {
      //DO NOT CHANGE THIS STRING, IT IS USED IN THE FRONT END
      throw new AppError("2FA is enabled. Please enter the 6 digit code.");
    }
    //check 2fa and OTP email secrets
    const secrets = await prisma.session.findMany({
      where: {
        userId: userId,
        twoFaSecret: {
          not: null,
        },
      },
      select: {
        twoFaSecret: true,
      },
    });
    const matchingSecret = secrets.find(
      (s) => totp(cleanBase32String(s.twoFaSecret ?? "")) === code,
    );
    if (!matchingSecret) {
      const checkOTP = await prisma.oTPBasedLogin.findFirst({
        where: {
          code: Number(code),
          disabled: false,
          createdAt: {
            gte: new Date(Date.now() - 15 * 60 * 1000),
          },
        },
      });
      if (!checkOTP) {
        //DO NOT CHANGE THIS STRING, IT IS USED IN THE FRONT END
        throw new AppError("Invalid OTP match. Please try again");
      } else {
        //code matches, disable code and continue login
        await prisma.oTPBasedLogin.updateMany({
          where: {
            code: Number(code),
          },
          data: {
            disabled: true,
          },
        });
      }
    }
  };

  //2fa is on check all codes
  if (user.twoFaEnabled) {
    if (pushCode) {
      //pushCode sent from mobile. If validated approve login
      const matchingDevice = user.devices.find(
        (device) => totp(cleanBase32String(device.pushToken)) === pushCode,
      );
      if (!matchingDevice) {
        await verify2FACode(user.id, code);
      }
    } else {
      //no pushCode sent, check 2fa code
      await verify2FACode(user.id, code);
    }
  }

  //Notify user of new login
  const pushItems = await createPushNotificationItems(
    user.id,
    "A new device has logged in to your Factiii account.",
    "New Account Login Detected",
  );
  sendNotifications(pushItems);

  //set browser in authToken
  const browser = userAgent ? detectBrowser(userAgent) : "Unknown";

  return res.send({
    credentials: await constructAuthObject({
      id: user.id,
      browserName: browser,
    }),
  });
};

export const refresh = async (req: Request, res: Response) => {
  const {
    token: refreshToken,
    mobile,
  }: { token: string; mobile?: "android" | "ios" } = req.body;
  const userAgent = req.get("user-agent");

  const token = await prisma.session.findFirst({
    where: {
      refreshToken,
    },
  });

  if (!token) {
    await prisma.error.create({
      data: {
        ip: req.ip,
        description: "refresh token not found " + refreshToken,
      },
    });
    throw new AppError("Refresh token not found");
  }

  if (token.revokedAt) {
    await prisma.error.create({
      data: {
        ip: req.ip,
        description: "refresh token revoked " + refreshToken,
        userId: token.userId,
      },
    });
    throw new AppError("Refresh token has been revoked");
  }

  let browser = userAgent ? detectBrowser(userAgent) : "Unknown";

  if (mobile) browser = mobile === "android" ? "Android" : "iOS";

  return res.send({
    credentials: await constructAuthObject({
      id: token.userId,
      browserName: browser,
      refreshToken: token.refreshToken,
    }),
  });
};

export const updateDetails = async (req: Request, res: Response) => {
  const { username, email } = req.body;
  const userId: number = req.body.auth?.userId ?? 0;

  const checkUser = await prisma.user.findFirst({
    where: {
      id: userId,
    },
    select: {
      id: true,
      username: true,
    },
  });

  if (!checkUser) {
    await prisma.error.create({
      data: {
        ip: req.ip,
        description: "user account update failed with userId " + userId,
      },
    });
    throw new AppError("No such account found.");
  }

  await prisma.user.update({
    where: {
      id: checkUser.id,
    },
    data: {
      email,
      username,
    },
  });

  await prisma.history.create({
    data: {
      userId,
      column: "username",
      value: checkUser.username,
    },
  });

  return res.send({
    updated: true,
  });
};

export const changePassword = async (req: Request, res: Response) => {
  const {
    oldPassword,
    newPassword,
  }: { oldPassword: string; newPassword: string } = req.body;
  const userId: number = req.body.auth?.userId ?? 0;
  const currentRefreshToken: string = req.body.auth.refresher;

  if (oldPassword === newPassword)
    throw new AppError("New password cannot be the same as old password");
  if (newPassword.length < 6)
    throw new AppError("Password must be at least 6 characters long");

  const user = await prisma.user.findFirst({
    where: {
      id: userId,
    },
    select: {
      password: true,
      id: true,
    },
  });

  if (!user) {
    await prisma.error.create({
      data: {
        ip: req.ip,
        description: "change password failed invalid user id " + userId,
      },
    });
    throw new AppError("Invalid login request.");
  }

  const isMatch = await bcrypt.compare(oldPassword, user.password);
  if (!isMatch) {
    await prisma.error.create({
      data: {
        ip: req.ip,
        description: "change password failed invalid user password",
        userId,
      },
    });
    throw new AppError("Invalid login request. Try again.");
  }

  const salt = await bcrypt.genSalt(10);
  const hashedPassword = await bcrypt.hash(newPassword, salt);
  await prisma.user.update({
    where: {
      id: userId,
    },
    data: {
      password: hashedPassword,
    },
  });
  await prisma.session.updateMany({
    where: {
      userId,
      revokedAt: null,
      NOT: {
        refreshToken: currentRefreshToken,
      },
    },
    data: {
      revokedAt: new Date(),
    },
  });
  await prisma.error.create({
    data: {
      ip: req.ip,
      description: "change password success",
      userId,
    },
  });

  return res.send({
    changed: true,
    message:
      "Password changed successfully. You will have to re-login from all devices.",
  });
};

export const sendResetPasswordEmail = async (req: Request, res: Response) => {
  const { email }: { email: string } = req.body;
  let ip = req.ip;

  const result = await prisma.user.findFirst({
    where: {
      email,
      status: "ACTIVE",
    },
    select: {
      id: true,
    },
  });
  if (!result) {
    await prisma.error.create({
      data: {
        ip: req.ip,
        description: "password reset request email invalid " + email,
      },
    });
    throw new AppError("No such account not found.");
  }
  //Deactivate any prior password request attempts
  await prisma.passwordReset.updateMany({
    where: {
      userId: result.id,
    },
    data: {
      invalidatedAt: new Date(),
    },
  });
  const passwordReset = await prisma.passwordReset.create({
    data: {
      userId: result.id,
    },
  });
  await prisma.error.create({
    data: {
      ip,
      description: "password reset requested",
      userId: result.id,
    },
  });
  await sendPasswordResetEmail(email, passwordReset.id as string);

  return res.send({
    message: "Password reset email sent successfully",
  });
};

export const sendVerificationEmail = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { email }: { email: string } = req.body;

  const result = await prisma.user.findUnique({
    where: {
      id: userId,
      email,
      status: "ACTIVE",
    },
    select: {
      id: true,
      email: true,
    },
  });
  if (!result) {
    await prisma.error.create({
      data: {
        ip: req.ip,
        description: "verification request email invalid " + email,
      },
    });
    throw new AppError("No such account not found.");
  }

  const otp = v4();

  await prisma.user.update({
    where: {
      id: userId,
      email,
    },
    data: {
      emailVerificationStatus: "PENDING",
      otpForEmailVerification: otp,
    },
  });

  await sendEmailVerificationEmail(email, otp);

  return res.send({
    message: "Email sent successfully",
  });
};

export const verifyEmail = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { email, otp }: { email: string; otp: string } = req.body;

  const user = await prisma.user.findFirst({
    where: {
      id: userId,
      email,
      status: "ACTIVE",
    },
    select: {
      id: true,
      emailVerificationStatus: true,
      otpForEmailVerification: true,
    },
  });

  if (!user) throw new AppError("Invalid Email Address.");
  if (otp === user.otpForEmailVerification) {
    await prisma.user.update({
      where: {
        id: userId,
        email,
      },
      data: {
        emailVerificationStatus: "VERIFIED",
        otpForEmailVerification: null,
      },
    });
  } else throw new AppError("Invalid OTP");

  if (user.emailVerificationStatus === "VERIFIED") {
    await awardCoinsReward(user.id, "VERIFY_EMAIL_ADDRESS");
  }

  return res.send({
    ok: true,
  });
};

export const checkResetPasswordToken = async (req: Request, res: Response) => {
  const { token: id } = req.params;

  const result = await prisma.passwordReset.findFirst({
    where: {
      id,
      invalidatedAt: null,
    },
    select: {
      id: true,
      createdAt: true,
      userId: true,
    },
  });
  if (!result) {
    await prisma.error.create({
      data: {
        ip: req.ip,
        description: "invalid password reset token",
      },
    });
    throw new AppError("Invalid password reset token.");
  }

  if (result.createdAt.getTime() + 3600000 < Date.now()) {
    await prisma.error.create({
      data: {
        ip: req.ip,
        description: "password reset token expired",
      },
    });
    await prisma.passwordReset.update({
      where: {
        id,
      },
      data: {
        invalidatedAt: new Date(),
      },
    });
    throw new AppError("Password reset token expired.");
  }

  await prisma.error.create({
    data: {
      ip: req.ip,
      description: "password reset approved",
      userId: result.userId,
    },
  });

  return res.send({
    ok: true,
    token: result.id,
    id: result.userId,
  });
};

export const resetPassword = async (req: Request, res: Response) => {
  // Get the new password from the request
  const { password }: { password: string } = req.body;

  // Get the token from the request
  const { token } = req.params;
  const id = token;

  // Check if the token exists and is not expired
  const result = await prisma.passwordReset.findFirst({
    where: {
      id,
      invalidatedAt: null,
    },
    select: {
      id: true,
      createdAt: true,
      userId: true,
    },
  });
  if (!result) {
    throw new AppError("Invalid password reset token.");
  }

  if (result.createdAt.getTime() + 3600000 < Date.now()) {
    await prisma.passwordReset.update({
      where: {
        id,
      },
      data: {
        invalidatedAt: new Date(),
      },
    });
    throw new AppError("Password reset token expired.");
  }

  // Hash the password (bcrypt)
  const salt = await bcrypt.genSalt(10);
  const hashedPassword = await bcrypt.hash(password, salt);

  // Update the user's password
  await prisma.user.update({
    where: {
      id: result.userId,
    },
    data: {
      password: hashedPassword,
    },
  });

  // Invalidate the token
  await prisma.passwordReset.update({
    where: {
      id,
    },
    data: {
      invalidatedAt: new Date(),
    },
  });

  return res.send({
    message: "Password updated successfully.",
  });
};

export const logout = async (req: Request, res: Response) => {
  const token = req.body.auth.refresher;

  if (!token) {
    // if no token is provided, then we can assume the user is already logged out
    return res.send({
      success: false,
    });
  } else {
    // if a token is provided, then we can revoke the token for future logins
    const session = await prisma.session.findFirst({
      where: {
        refreshToken: token,
      },
      select: {
        id: true,
      },
    });
    if (!session)
      return res.send({
        //return 200 even if session is missing so front end still logs out
        success: false,
      });
    //revoke session and delete 2fa secret
    await prisma.session.update({
      where: {
        refreshToken: token,
      },
      data: {
        revokedAt: new Date(),
        twoFaSecret: null,
      },
    });
  }

  return res.send({
    success: true,
  });
};

export const enable2FA = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const refreshToken: string = req.body.auth?.refresher ?? "";

  const user = await prisma.user.findFirst({
    where: {
      id: userId,
    },
    select: {
      twoFaEnabled: true,
    },
  });

  if (user?.twoFaEnabled === true) throw new AppError("2Fa already enabled.");

  const checkSession = await prisma.session.findFirst({
    where: {
      userId,
      refreshToken,
    },
    select: {
      deviceId: true,
    },
  });

  if (!checkSession?.deviceId)
    throw new AppError("You must be logged in on mobile to enable 2FA.");

  endAllSessionsFcn(userId, refreshToken, true, true);

  const secret = generateTotpSecret();

  //update user twoFaEnabled to true
  await prisma.user.update({
    where: {
      id: userId,
    },
    data: {
      twoFaEnabled: true,
    },
  });

  //create a new 2fa secret for the user
  await prisma.session.update({
    where: {
      refreshToken,
    },
    data: {
      twoFaSecret: secret,
    },
  });

  return res.send({
    secret,
  });
};

export const disable2FA = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const refreshToken: string = req.body.auth?.refresher ?? "";
  const { password } = req.body;

  const user = await prisma.user.findFirst({
    where: {
      id: userId,
    },
    select: {
      password: true,
      status: true,
    },
  });

  if (!user) throw new AppError("No account found.");

  if (user.status !== "ACTIVE")
    throw new AppError(
      "Your account has been deactivated. Please contact us to activate your account",
    );
  //TODO: check against current 2fa
  const isMatch = await bcrypt.compare(password, user.password);
  if (!isMatch)
    throw new AppError(
      "The password you entered is incorrect. Please try again.",
    );

  await prisma.user.update({
    where: {
      id: userId,
    },
    data: {
      twoFaEnabled: false,
    },
  });

  await prisma.session.update({
    where: {
      refreshToken,
    },
    data: {
      twoFaSecret: null,
    },
  });

  return res.send({
    disabled: true,
  });
};

//This will add a 2fa if one does not exist and requires a push token from a device so can only be called from a device
export const getSecret = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const refreshToken: string = req.body.auth?.refresher ?? "";
  const { pushCode } = req.body; //pushToken converted to 6 digit code

  const user = await prisma.user.findFirst({
    where: {
      id: userId,
    },
    select: {
      twoFaEnabled: true,
    },
  });

  if (!user?.twoFaEnabled) throw new AppError("2FA not enabled.");

  const sessions = await prisma.session.findMany({
    where: {
      userId,
      refreshToken,
    },
    select: {
      twoFaSecret: true,
      device: {
        select: {
          pushToken: true,
        },
      },
    },
  });

  if (sessions.length !== 1 || !sessions[0].device)
    throw new AppError("Invalid request");

  if (
    pushCode &&
    sessions[0].twoFaSecret &&
    totp(cleanBase32String(sessions[0].device.pushToken)) === pushCode
  ) {
    //old 2fa exists return null
    return res.send({
      secret: null,
    });
  } else if (
    totp(cleanBase32String(sessions[0].device.pushToken)) === pushCode &&
    !sessions[0].twoFaSecret
  ) {
    //pushCode matches pushToken and no 2fa exists, create new 2fa
    const secret = generateTotpSecret();
    await prisma.session.update({
      where: {
        refreshToken,
      },
      data: {
        twoFaSecret: secret,
      },
    });
    return res.send({
      secret,
    });
  }

  throw new AppError("Invalid request");
};
