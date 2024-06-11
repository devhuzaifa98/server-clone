import prisma from "../clients/prisma";
import { faker } from "@faker-js/faker";
import log from "./log";

const spaces = async (spaceSeeds: number) => {
  let count = 0;
  const spaceRules = [
    {
      title: "No Hate Content",
      description:
        "Content that expresses, incites, or promotes hate based on identity",
    },
    {
      title: "No Violence Content",
      description:
        "Content that promotes or glorifies violence or celebrates the suffering or humiliation of others",
    },
    {
      title: "No Self-Harm Content",
      description:
        "Content that promotes, encourages, or depicts acts of self-harm, such as suicide, cutting, and eating disorders",
    },
    {
      title: "No Sexual Content",
      description:
        "Content meant to arouse sexual excitement, such as the description of sexual activity, or that promotes sexual services (excluding sex education and wellness)",
    },
    {
      title: "No Political Content",
      description:
        "Content attempting to influence the political process or to be used for campaigning purposes",
    },
    {
      title: "No Deceptive Content",
      description:
        "Content that is false or misleading, such as attempting to defraud individuals or spread disinformation",
    },
  ];

  for (let i = 0; i < spaceSeeds; i++) {
    const name = `${faker.location.city()}`;
    const slug = name
      .toLowerCase()
      .replace(" ", "-")
      .replace(/[^A-Za-z0-9-]+/g, "")
      .replace(/-$/, "");
    const checkSpace = await prisma.space.findFirst({
      where: {
        OR: [{ name }, { slug }],
      },
    });
    if (!checkSpace) {
      if (i % 100 === 0) {
        log("info", "Added " + count + " spaces to DB");
      }
      count++;
      const space = await prisma.space.create({
        data: {
          name,
          slug,
          createdAt: faker.date.past(),
          description: faker.lorem.sentences(),
        },
      });
      // TODO fix this to be the owner of the space
      const spaceAvatar = await prisma.upload.create({
        data: {
          userId: 1,
          key: faker.image.avatar(),
          type: "IMAGE",
        },
      });
      // TODO fix this to be the owner of the space
      const spaceBanner = await prisma.upload.create({
        data: {
          userId: 1,
          key: faker.image.urlPicsumPhotos({ width: 1920, height: 1080 }),
          type: "IMAGE",
        },
      });
      await prisma.space.update({
        where: {
          id: space.id,
        },
        data: {
          bannerId: spaceBanner.id,
          avatarId: spaceAvatar.id,
        },
      });
      // TODO allow rules to very
      await prisma.rule.createMany({
        data: faker.helpers.arrayElements(spaceRules).map((x) => {
          return { ...x, spaceId: space.id };
        }),
      });
    }
  }
  log("success", "Added " + count + " spaces to DB");
};

export default spaces;
