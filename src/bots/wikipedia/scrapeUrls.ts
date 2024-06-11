import { prisma } from "../../clients/prisma";
import AppError from "../../utilities/AppError";
import scrapeArticle from "./helpers/scrapeArticle";
import { wikipediaScrapes } from "./scraper";

//This function scrapes a list of URLs and validates them
//This also validates the URL and checks if it has been scraped before
export const scrapeUrls = async (userId: number, urls: string[]) => {
  const errors: string[] = [];
  const bot = await prisma.botSetting.findUnique({
    where: {
      userId,
    },
    select: {
      rootUrl: true,
    },
  });
  if (!bot) throw new AppError("Invalid Bot");
  if (!bot.rootUrl)
    throw new AppError(
      "Invalid Bot Root URL. Set it in the bot status on your profile.",
    );
  for (const url of urls) {
    try {
      // Check if the URL is from the bot's root URL
      if (!url.includes(bot.rootUrl))
        throw new AppError("Invalid URL. URL must be from the bot's root URL.");
      // Check if the URL has been scraped before
      // This checks across ALL BOTS
      const URLcited = await prisma.postFactiii.findFirst({
        where: {
          data: url,
          factiii: {
            requirements: {
              //Only include factiiis that have these requirements
              //These are the citations.
              //If they have any of these requirements they have been scraped before
              //This is done on postFactiii because a Factiii can exist that has no posts associated yet
              hasSome: [
                "HUMAN_SOURCE",
                "GOVERNMENT_SOURCE",
                "ENTERPRISE_SOURCE",
                "ANONYMOUS_SOURCE",
              ],
            },
          },
        },
        select: {
          id: true,
        },
      });
      if (URLcited) throw new AppError("URL already scraped");
      // Check if the URL is already in the scraping queue
      // If it is, use it, otherwise create a new scrape
      let scrape = await prisma.scrape.findFirst({
        where: {
          url,
          status: "PENDING",
        },
        select: {
          id: true,
        },
      });
      if (!scrape) {
        scrape = await prisma.scrape.create({
          data: {
            status: "PENDING",
            plannedAt: new Date(),
            url,
            userId,
          },
          select: {
            id: true,
          },
        });
      }
      try {
        // Scrape the article
        const scrapedData = await scrapeArticle(url);
        // Save the scraped data to the database
        await wikipediaScrapes(userId, scrapedData);
        // Update the scrape status to successful and sace the raw scrape
        await prisma.scrape.update({
          where: {
            id: scrape.id,
          },
          data: {
            status: "COMPLETED",
            rawScrape: scrapedData.rawScrape,
          },
        });
      } catch (error) {
        errors.push(`Error scraping URL ${url}`);
        await prisma.scrape.update({
          where: {
            id: scrape.id,
          },
          data: {
            status: "FAILED",
          },
        });
        continue;
      }
    } catch (error: any) {
      continue;
    }
  }
  return errors;
};
