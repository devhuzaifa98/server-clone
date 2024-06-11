import prisma from "../clients/prisma";
import { faker } from "@faker-js/faker";
import stringToSlug from "./stringToSlug";
import randomNumber from "./randomNumber";
import log from "./log";

const factiiis = async (quantity: number) => {
  const wikipedia = await prisma.space.findFirstOrThrow({
    where: {
      slug: "wikipedia",
    },
    select: {
      id: true,
    },
  });
  const jonUser = await prisma.user.findFirstOrThrow({
    where: {
      username: "jon",
    },
    select: {
      id: true,
    },
  });
  let count = 0;
  const factiiiIds: number[] = [];
  for (let i = 0; i < quantity; i++) {
    if (i % 100 === 0) {
      log("Added " + count + " Wikipedia Factiiis to DB");
    }
    const name = faker.internet.userName();
    const slug = stringToSlug(name);
    const factiii = await prisma.factiii.findFirst({
      where: {
        slug,
        spaceId: wikipedia.id,
        userId: jonUser.id,
      },
    });
    if (!factiii) {
      count++;
      const wiki = await prisma.factiii.create({
        data: {
          name,
          slug,
          requirements: ["NO_POST_DUPLICATES"],
          description: faker.lorem.sentence(),
          rules: {
            create: [
              {
                title: faker.lorem.sentence(),
                description: faker.lorem.sentence(),
              },
            ],
          },
          createdAt: faker.date.past(),
          userId: jonUser.id,
          spaceId: wikipedia.id,
        },
        select: {
          id: true,
        },
      });
      const tagFactiiis = faker.helpers.arrayElements(
        factiiiIds,
        randomNumber(0, 15),
      );
      for (const factiiiId of tagFactiiis) {
        await prisma.post.create({
          data: {
            content: faker.lorem.sentence(),
            userId: jonUser.id,
            createdAt: faker.date.past(),
            factiiis: {
              create: [
                { factiiiId, userId: jonUser.id },
                { factiiiId: wiki.id, userId: jonUser.id },
              ],
            },
          },
        });
      }
      factiiiIds.push(wiki.id);
    }
  }
  log("Added " + count + " Wikipedia Factiiis to DB");
};

export default factiiis;
