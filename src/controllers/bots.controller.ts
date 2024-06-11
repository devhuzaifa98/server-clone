import { Request, Response } from "express";
import { scrapeUrls } from "../bots/wikipedia/scrapeUrls";
import prisma from "../clients/prisma";
import createScraper from "../cron/createScraper";
import { stopCronJob } from "../cron/cronJobManager";
import updatePendingScrapes from "../helpers/updatePendingScrapes";
import AppError from "../utilities/AppError";

export const wikiControl = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { urls } = req.query as { urls: string };

  if (!urls) throw new AppError("Invalid URLs provided");

  const wikiUrls = urls.split(",");

  //this forces bot to be wikipedia
  //this will update later when general scraping comes on
  const bot = await prisma.botSetting.findUnique({
    where: {
      userId,
      user: {
        username: "wikipedia",
      },
    },
  });

  if (!bot) throw new AppError("Invalid Bot");

  const errors = await scrapeUrls(userId, wikiUrls);

  if (errors.length > 0) {
    throw new AppError(errors.join(", "));
  }
  return res.send({});
};

export const toggleBotStatus = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;

  const { status } = req.body as {
    status: boolean;
  };

  //TODO disable this once bots are ready for all users
  const checkUser = await prisma.user.findUnique({
    where: {
      id: userId,
      username: "wikipedia",
    },
    select: {
      id: true,
    },
  });

  if (!checkUser)
    throw new AppError("Only the wikipedia user can toggle bot status");

  const bot = await prisma.botSetting.upsert({
    where: {
      userId: checkUser.id,
    },
    update: {
      enabled: status,
    },
    create: {
      enabled: status,
      userId: checkUser.id,
    },
    select: {
      userId: true,
      scrapesPerDay: true,
      enabled: true,
    },
  });

  if (bot.enabled === true) {
    //Start the scraper cron
    const addTime = await updatePendingScrapes(bot);
    createScraper(checkUser.id, addTime);
  } else {
    //Stop the scraper cron
    stopCronJob(checkUser.id);
  }

  return res.send({
    status: bot.enabled,
  });
};

export const getBotStatus = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;

  const botSettings = await prisma.botSetting.upsert({
    where: {
      userId,
    },
    update: {},
    create: {
      userId,
      enabled: false,
      scrapesPerDay: 100,
      rootUrl: "https://en.wikipedia.org",
    },
    select: {
      enabled: true,
      scrapesPerDay: true,
      rootUrl: true,
    },
  });

  const pendingScrapes = await prisma.scrape.count({
    where: {
      userId,
      status: "PENDING",
    },
  });

  const failedScrapes = await prisma.scrape.count({
    where: {
      userId,
      status: "FAILED",
    },
  });

  return res.send({
    status: botSettings.enabled,
    limit: botSettings.scrapesPerDay,
    pendingScrapes,
    failedScrapes,
    rootUrl: botSettings.rootUrl,
  });
};

export const updateBot = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;

  const { limit, rootUrl } = req.body as {
    limit: string;
    rootUrl: string;
  };

  const checkUser = await prisma.user.findUnique({
    where: {
      id: userId,
      username: "wikipedia",
    },
    select: {
      id: true,
      botSettings: {
        select: {
          scrapesPerDay: true,
        },
      },
    },
  });

  if (!checkUser || !checkUser.botSettings)
    throw new AppError("Only the wikipedia user can set scrape limit");

  await prisma.botSetting.update({
    where: {
      userId: checkUser.id,
    },
    data: {
      scrapesPerDay: Number(limit),
      rootUrl,
    },
    select: {
      scrapesPerDay: true,
    },
  });

  return res.send({
    ok: true,
  });
};
