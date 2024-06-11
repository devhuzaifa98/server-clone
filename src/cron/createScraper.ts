import { CronJob } from "cron";
import { scrapeUrls } from "../bots/wikipedia/scrapeUrls";
import prisma from "../clients/prisma";
import { startCronJob, stopCronJob } from "../cron/cronJobManager";
import updatePendingScrapes from "../helpers/updatePendingScrapes";

const createScraper = (userId: number, addTime: number) => {
  //save last urls to know if there are too many URLs
  //also makes it so the same URL is not scraped twice
  let lastUrls: string[] = [];
  const main = async () => {
    // Find all pending scrape URLs for the user
    const urls = await prisma.scrape.findMany({
      where: {
        userId,
        status: "PENDING",
        plannedAt: {
          lte: new Date(),
        },
      },
      select: {
        url: true,
      },
    });
    //Disable bot if there are no URLs tin PENDING to scrape
    const checkPending = await prisma.scrape.findFirst({
      where: {
        userId,
        status: "PENDING",
      },
    });
    if (!checkPending) {
      stopCronJob(userId);
      await prisma.botSetting.update({
        where: {
          userId,
        },
        data: {
          enabled: false,
        },
      });
    }
    const scrapesPerInterval = Math.max(
      1,
      Math.round((times.minutesPerRun * 60 * 1000) / addTime),
    );
    const currentUrls = urls
      .map((url) => url.url)
      .filter((url) => !lastUrls.includes(url));
    //Slow down if there are too many URLs
    if (
      currentUrls.length >
      scrapesPerInterval + Math.max(3, scrapesPerInterval * 0.1)
    ) {
      stopCronJob(userId);
      const botSettings = await prisma.botSetting.findUniqueOrThrow({
        where: {
          userId,
        },
        select: {
          scrapesPerDay: true,
        },
      });
      await prisma.botSetting.update({
        where: {
          userId,
        },
        data: {
          scrapesPerDay: Math.round(botSettings.scrapesPerDay * 0.8),
        },
        select: {
          scrapesPerDay: true,
        },
      });
      await updatePendingScrapes({
        userId,
        scrapesPerDay: botSettings.scrapesPerDay,
      });
      createScraper(userId, addTime);
    }
    // Save the current URLs so we can compare them next time
    lastUrls = currentUrls;
    // Scrapes the URLs
    await scrapeUrls(
      userId,
      currentUrls.map((url) => url),
    );
  };

  // Convert addTime to a cron expression
  const times = calculateCronExpression(addTime);

  // Create the cron job
  const cronJob = new CronJob(
    times.cronExpression,
    main,
    null,
    false,
    "America/Los_Angeles",
  );
  //Start the cron job
  startCronJob(userId, cronJob);
};

const calculateCronExpression = (addTime: number) => {
  // Convert addTime to minutes
  const addTimeMinutes = Math.max(Math.floor(addTime / (60 * 1000)), 1);

  let cronExpression;
  let minutesPerRun = addTimeMinutes;

  if (addTimeMinutes < 60) {
    // For intervals less than 1 hour, use a simple minutes interval
    cronExpression = `*/${addTimeMinutes} * * * *`;
  } else if (addTimeMinutes < 1440) {
    // For intervals between 1 hour and 1 day, calculate hours and minutes
    const hours = Math.floor(addTimeMinutes / 60);
    const minutes = addTimeMinutes % 60;
    cronExpression = `${minutes} */${hours} * * *`;
    minutesPerRun = hours * 60 + minutes;
  } else {
    // For intervals of 1 day or more, calculate days
    const days = Math.floor(addTimeMinutes / 1440);
    cronExpression = `0 0 */${days} * *`;
    minutesPerRun = days * 1440;
  }

  // If minutesPerRun is less than 1, set it to 1 and adjust the cron expression
  if (minutesPerRun < 1) {
    minutesPerRun = 1;
    cronExpression = `* * * * *`;
  }

  return { cronExpression, minutesPerRun };
};

export default createScraper;
