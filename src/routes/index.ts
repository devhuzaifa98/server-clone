import { Express } from "express";
import auth from "./auth.route";
import awards from "./awards.route";
import bots from "./bots.route";
import coins from "./coins.route";
import factiiis from "./factiiis.route";
import invites from "./invites.route";
import messages from "./messages.route";
import notifications from "./notifications.route";
import platform from "./platform.route";
import posts from "./posts.route";
import reports from "./reports.route";
import search from "./search.route";
import sessions from "./sessions.route";
import spaces from "./spaces.route";
import uploads from "./uploads.route";
import users from "./users.route";
import tests from "./tests.route";

export default function initializeApiRoutes(app: Express) {
  app.use("/auth", auth);
  app.use("/awards", awards);
  app.use("/bots", bots);
  app.use("/coins", coins);
  app.use("/factiiis", factiiis);
  app.use("/invites", invites);
  app.use("/messages", messages);
  app.use("/notifications", notifications);
  app.use("/platform", platform);
  app.use("/posts", posts);
  app.use("/reports", reports);
  app.use("/search", search);
  app.use("/sessions", sessions);
  app.use("/spaces", spaces);
  app.use("/uploads", uploads);
  app.use("/users", users);
  app.use("/tests", tests);
}
