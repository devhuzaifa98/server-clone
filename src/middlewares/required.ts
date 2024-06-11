import { Request, Response, NextFunction } from "express";

const required = (fields: string[]) => {
  return (req: Request, res: Response, next: NextFunction) => {
    const missingFields = fields.filter(
      (field) => !req.body[field.replace("[]", "")],
    );

    if (missingFields.length > 0) {
      return res.status(400).send({
        error: true,
        message: `Please provide all required fields: ${missingFields.join(", ")}`,
      });
    }

    if (
      fields.includes("password") &&
      req.body.password &&
      req.body.password.length < 6
    ) {
      return res.status(400).send({
        error: true,
        message: "Password must be at least 6 characters long",
      });
    }

    if (fields.includes("email") && req.body.email) {
      const re = /\S+@\S+\.\S+/;

      if (!re.test(req.body.email)) {
        return res.status(400).send({
          error: true,
          message: "Please provide a valid email address",
        });
      }
    }

    next();
  };
};

export default required;
