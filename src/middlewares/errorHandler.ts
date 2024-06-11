import { Request, NextFunction, Response } from "express";

const errorHandler = (
  err: any,
  req: Request,
  res: Response,
  next: NextFunction,
) => {
  console.error(err);
  return res
    .status(500)
    .send({
      error: true,
      message: err.message ?? "An unexpected error occured with the server.",
    })
    .end();
};

export default errorHandler;
