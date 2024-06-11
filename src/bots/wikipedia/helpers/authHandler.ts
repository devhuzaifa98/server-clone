import axios from "axios";
import { stdin, stdout } from "node:process";
import * as readline from "node:readline/promises";
import log from "../../../helpers/log";

/**
 *
 * @returns the auth token if the operation was successful
 */
const authHandler = async () => {
  let authToken = "";
  log("info", "Authentication is required to proceed");

  while (authToken === "") {
    const rl = readline.createInterface({ input: stdin, output: stdout });
    try {
      const password = await rl.question(
        "Please enter the password for @wikipedia user: ",
        {
          hideEchoBack: true,
        } as any,
      );

      const { data } = await axios.post(
        process.env.SERVER_URL + "/auth/login",
        {
          username: "wikipedia",
          password,
        },
      );

      if (data && data.credentials && data.credentials.access) {
        authToken = data.credentials.access;
        log("success", "Authentication was successful!");
      }
    } catch (error: any) {
      log("error", error);
      log(
        "error",
        error.response?.data?.message ??
          "An error occured while authenticating. Please try again later.",
      );
      rl.close();
    }
    rl.close();
  }

  return authToken;
};

export default authHandler;
