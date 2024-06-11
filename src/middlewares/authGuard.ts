import { Request, Response, NextFunction } from "express";
import jwt from "jsonwebtoken";
import prisma from "../clients/prisma";

const authGuard = (authRequired: boolean = false) => {
  return async (req: Request, res: Response, next: NextFunction) => {
    const authHeader = req.headers["authorization"];
    const accessToken = authHeader?.split(" ")[1];

    try {
      jwt.verify(
        accessToken as string,
        process.env.ACCESS_TOKEN_SECRET as string,
        async (err, result: any) => {
          if (err) {
            if (err.name === "TokenExpiredError")
              return res.status(401).json({
                error: true,
                message: "Authentication token has expired",
              });
            req.body.auth = {
              userId: undefined,
            };
          } else {
            const { userId, refresher: refreshToken } = result;

            if (!userId || !refreshToken)
              return res.status(403).json({
                error: true,
                message: "Authentication token data incomplete",
              });
            const isAuthenticationURL = ["/register", "/login"].includes(
              req.url,
            );

            if (refreshToken) {
              const token = await prisma.session.findFirst({
                where: {
                  refreshToken,
                  revokedAt: null,
                },
                select: {
                  userId: true,
                  refreshToken: true,
                  browserName: true,
                },
              });

              if (!token) {
                return res.status(401).json({
                  error: true,
                  message: "Invalid authentication token provided",
                });
              }

              if (isAuthenticationURL && token) {
                return res.status(409).json({
                  error: true,
                  message: "Already signed in",
                });
              }
            }

            if (authRequired) {
              //Send 403 if no token is provided and authentication is required
              if (accessToken == null) {
                await prisma.error.create({
                  data: {
                    ip: req.ip,
                    description:
                      "Invalid request: No authentication token provided",
                  },
                });
                return res.status(403).json({
                  error: true,
                  message: "No authentication token provided",
                });
              }
              req.body.auth = result;
            } else {
              //auth not required, send to next page even if no token is provided
              req.body.auth = {
                userId: result.userId,
                refresher: result.refresher,
                browserName: result.browserName,
                iat: result.iat,
                exp: result.exp,
              };
            }
          }
          next();
        },
      );
    } catch (error) {
      res.status(500).json({
        error: true,
        message: "Something went wrong",
      });
    }
  };
};

export default authGuard;
