import { FactiiiRequirement } from "@prisma/client";
import prisma from "../../clients/prisma";
import { generatePostRank, stringToSlug } from "../../helpers";
import { ScrappedArticleDataObject } from "./types";

//This functiuon saves scraped data to the database
//ONLY CALL THIS FUNCTION fom scrapeUrls.ts
export const wikipediaScrapes = async (
  userId: number,
  scrapedData: ScrappedArticleDataObject,
) => {
  const wikiSpace = await prisma.space.findFirstOrThrow({
    where: {
      slug: "wikipedia",
    },
    select: {
      id: true,
    },
  });

  const wikiSource = await prisma.factiii.upsert({
    where: {
      spaceId_userId_slug_requirements: {
        spaceId: wikiSpace.id,
        userId,
        slug: "wikipedia",

        requirements: [FactiiiRequirement.ENTERPRISE_SOURCE],
      },
    },
    update: {},
    create: {
      name: "Wikipedia",
      slug: stringToSlug("Wikipedia"),
      userId,
      spaceId: wikiSpace.id,
      requirements: [FactiiiRequirement.ENTERPRISE_SOURCE],
    },
    select: {
      id: true,
    },
  });

  for (const data of scrapedData.sections) {
    try {
      //Make list of all factiiis and then filter out duplicates
      const factiiis = (
        await Promise.all(
          data.factiiis.map(async (factiii) => {
            const slug = stringToSlug(factiii);
            const factiiiCheck = await prisma.factiii.findFirst({
              where: {
                slug,
                spaceId: wikiSpace.id,
                requirements: {
                  hasSome: [
                    FactiiiRequirement.NO_POST_DUPLICATES,
                    FactiiiRequirement.NONE,
                  ],
                },
              },
              select: {
                id: true,
              },
            });
            if (factiiiCheck) {
              return factiiiCheck;
            } else {
              return await prisma.factiii.create({
                data: {
                  name: factiii,
                  slug,
                  userId,
                  spaceId: wikiSpace.id,
                  requirements: [FactiiiRequirement.NO_POST_DUPLICATES],
                },
                select: {
                  id: true,
                },
              });
            }
          }),
        )
      ).filter(
        (factiii, index, self) =>
          factiii && self.findIndex((f) => f.id === factiii.id) === index,
      );

      //Post the Post
      await prisma.post.create({
        data: {
          userId,
          spaceId: wikiSpace.id,
          content: data.content,
          ...(data.imageUrls &&
            data.imageUrls.length > 0 && {
              uploads:
                data.imageUrls && data.imageUrls.length > 0
                  ? {
                      create: data.imageUrls.map((url) => ({
                        userId: userId,
                        key: "https:" + url,
                        type: "IMAGE",
                      })),
                    }
                  : undefined,
            }),
          factiiis: {
            createMany: {
              data: [
                {
                  //Create a factiii for the source
                  userId,
                  factiiiId: wikiSource.id,
                  data: scrapedData.sourceUrl,
                },
                //Attach all the other factiiis
                ...factiiis.map((factiii) => ({
                  userId,
                  factiiiId: factiii.id,
                })),
              ],
            },
          },
          trendingRank: generatePostRank(new Date(), 1),
          voteCount: 1,
          votes: {
            create: {
              userId,
              type: "UPVOTE",
            },
          },
        },
      });
    } catch (error: any) {
      console.error(
        `Error saving scraped data to the database: ${error.message}`,
      );
      continue;
    }
  }

  //Save Scraping errors
  for (const error in scrapedData.errors) {
    await prisma.error.create({
      data: {
        ip: "WikiScraper",
        userId,
        description: error,
      },
    });
  }
  //Plan the next scrapes
  // Get the last planned scrape for the user
  const lastScrape = await prisma.scrape.findFirst({
    where: {
      userId,
      status: "PENDING",
    },
    orderBy: {
      plannedAt: "desc",
    },
    select: {
      id: true,
      plannedAt: true,
    },
  });

  // Check if the user has too many pending scrapes
  const pendingScrapes = await prisma.scrape.count({
    where: {
      userId,
      status: "PENDING",
    },
  });

  // If the user has too many pending scrapes, don't plan more
  if (pendingScrapes > 5000) return;

  const oneDay = 60 * 60 * 24 * 1000; // 24 hours in milliseconds
  const botSettings = await prisma.botSetting.upsert({
    where: {
      userId,
    },
    update: {}, // Do Nothing
    create: {
      userId,
      scrapesPerDay: 100,
      rootUrl: "https://en.wikipedia.org",
    },
    select: {
      scrapesPerDay: true,
      rootUrl: true,
    },
  });

  const addTime = Math.round(oneDay / botSettings.scrapesPerDay);
  let index = 1;

  for (const url of scrapedData.nextUrls) {
    if (url.includes(".jpg")) continue; // Don't plan scrapes for images
    // Check if the source is already in the database
    const checkSource = await prisma.factiii.findFirst({
      where: {
        data: url,
      },
      select: {
        id: true,
      },
    });
    // Check if the source is already planned
    const checkPlannedScrape = await prisma.scrape.findFirst({
      where: {
        url,
      },
      select: {
        id: true,
      },
    });
    // If the source is already in the database or planned, don't plan the scrape
    if (checkSource || checkPlannedScrape) continue;
    let plannedAt;
    if (lastScrape) {
      // start planning scrapes after the last planned scrape
      plannedAt = new Date(lastScrape.plannedAt.getTime() + index * addTime);
    } else {
      // start planning scrapes from now
      plannedAt = new Date(Date.now() + index * addTime);
    }
    if (plannedAt > new Date(Date.now() + oneDay)) continue; // Don't plan scrapes for more than 24 hours
    await prisma.scrape.create({
      data: {
        url,
        userId,
        plannedAt,
      },
    });
    index++;
  }
};
