import { Request, Response, NextFunction } from "express";
import AppError from "./AppError";

const wrapper = (fn: Function) => {
  return (req: Request, res: Response, next: NextFunction) => {
    return fn(req, res, next).catch((error: any) => {
      if (error instanceof AppError) {
        return res
          .status(400)
          .send({
            error: true,
            message: error.message,
          })
          .end();
      }
      next(error);
    });
  };
};

export default wrapper;
