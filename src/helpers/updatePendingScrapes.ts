import prisma from "../clients/prisma";

const updatePendingScrapes = async (bot: {
  userId: number;
  scrapesPerDay: number;
}) => {
  const scrapes = await prisma.scrape.findMany({
    where: {
      userId: bot.userId,
      status: "PENDING",
    },
    select: {
      id: true,
    },
  });
  const now = new Date();
  const oneDay = 24 * 60 * 60 * 1000;
  const addTime = oneDay / bot.scrapesPerDay;
  let index = 0;
  for (const scrape of scrapes) {
    await prisma.scrape.update({
      where: {
        id: scrape.id,
      },
      data: {
        plannedAt: new Date(now.getTime() + index * addTime),
      },
    });
    index++;
  }
  return addTime;
};

export default updatePendingScrapes;
