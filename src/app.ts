import express, { Express, Response } from "express";
import dotenv from "dotenv";
import cors from "cors";
import helmet from "helmet";
import morgan from "morgan";
import { testDatabaseConnection } from "./clients/prisma";
import initializeApiRoutes from "./routes";
import webhooksRoute from "./routes/webhooks.route";
import { startCronJobs } from "./cron/cronJobManager";
import http from "http";
import { initializeSocketConnection } from "./clients/socket";
import * as Sentry from "@sentry/node";
import { ProfilingIntegration } from "@sentry/profiling-node";
import errorHandler from "./middlewares/errorHandler";
import log from "./helpers/log";
// import { v4 as uuid } from 'uuid';

export const app: Express = express();

if (process.env.ENV === "test") {
  dotenv.config({ path: ".env.test" });
} else {
  dotenv.config();
}

const httpServer = http.createServer(app);

//only initialize sentry in production
if (process.env.ENV === "production") {
  if (process.env.SENTRY_DSN === "") {
    log("info", "SENTRY_DSN is not set. Sentry will not be initialized.");
  } else {
    Sentry.init({
      dsn: process.env.SENTRY_DSN,
      integrations: [
        // enable HTTP calls tracing
        new Sentry.Integrations.Http({ tracing: true }),
        // enable Express.js middleware tracing
        new Sentry.Integrations.Express({ app }),
        new ProfilingIntegration(),
      ],
      // Performance Monitoring
      tracesSampleRate: 1.0, //  Capture 100% of the transactions
      // Set sampling rate for profiling - this is relative to tracesSampleRate
      profilesSampleRate: 1.0,
    });
  }
}

// Webhooks are put at the beginning to make sure that
// other middlewares don't mess with communications
// such as in the case of Stripe webhooks
app.use("/webhooks", webhooksRoute);

// The request handler must be the first middleware on the app after webhooks
app.use(Sentry.Handlers.requestHandler());
// TracingHandler creates a trace for every incoming request
app.use(Sentry.Handlers.tracingHandler());

app.use(
  express.json({
    limit: "100mb",
  }),
);
app.use(
  express.urlencoded({
    extended: true,
    limit: "100mb",
  }),
);
app.use(
  cors({
    credentials: true,
    origin: process.env.CLIENT_APP_URL,
    optionsSuccessStatus: 200,
  }),
);
app.use(
  helmet({
    // contentSecurityPolicy: {
    //     directives: {
    //         "connect-src": ['https://checkout.stripe.com'],
    //         "frame-src": ['https://checkout.stripe.com'],
    //         "script-src": ['self', process.env.CLIENT_APP_URL as string, 'https://checkout.stripe.com', 'nonce-' + uuid()],
    //         "img-src": ['https://*.stripe.com'],
    //     },
    // },
  }),
);
morgan.token("date", () => {
  return new Date().toLocaleString();
});
app.use(morgan("[:date] :status :method :url - :response-time ms"));
//Enables IP tracking with req.ip
app.set("trust proxy", true);

initializeApiRoutes(app);
export const io = initializeSocketConnection(httpServer);

// The sentry error handler must be registered before any other error middleware and after all controllers
app.use(Sentry.Handlers.errorHandler());

app.use("*", (_, res: Response) => {
  res.status(403).send({
    error: true,
    message: "The requested resource is forbidden.",
  });
});

//Enables IP tracking with req.ip
app.set("trust proxy", true);

app.use(errorHandler);

if (process.env.ENV !== "test") {
  const PORT: number = parseInt(process.env.PORT as string) || 5001;
  httpServer.listen(PORT, () => {
    log(`Listening at PORT ${PORT}`);
    testDatabaseConnection();
    startCronJobs();
  });
}
