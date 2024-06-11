const dotenv = require("dotenv");

if (process.env.ENV === "test") {
  dotenv.config({ path: ".env.test" });
} else {
  dotenv.config();
}
