import { CronJob } from "cron";
import prisma from "../clients/prisma";
import log from "../helpers/log";
import updatePendingScrapes from "../helpers/updatePendingScrapes";
import createScraper from "./createScraper";

const cronJobMap = new Map<number, CronJob>();

//This runs when the server starts
export const startCronJobs = async () => {
  const bots = await prisma.botSetting.findMany({
    where: {
      enabled: true,
    },
    select: {
      userId: true,
      scrapesPerDay: true,
    },
  });

  if (bots.length > 0) {
    // Update the plannedAt for all pending scrapes for all bots
    for (const bot of bots) {
      try {
        log("info", `Starting scraper for bot ${bot.userId}`);
        const addTime = await updatePendingScrapes(bot);
        createScraper(bot.userId, addTime);
      } catch (error: any) {
        log(
          "error",
          `Error getting scrapes for bot ${bot.userId}: ${error.message}`,
        );
        continue; // Do not break loop if one bot fails
      }
    }
    log("success", "All scrapers scraping :)");
  } else {
    log("info", "Bot scraper off");
  }
};

export const startCronJob = (userId: number, cronJob: CronJob) => {
  cronJobMap.set(userId, cronJob);
  cronJob.start();
};

export const stopCronJob = (userId: number) => {
  const cronJob = cronJobMap.get(userId);
  if (cronJob) {
    cronJob.stop();
    cronJobMap.delete(userId);
    log("info", `Stopped cron job for user ${userId}`);
  } else {
    log("info", `No cron job found for user ${userId}`);
  }
};
