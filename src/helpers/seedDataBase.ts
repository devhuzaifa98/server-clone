import prisma from "../clients/prisma";
import { faker } from "@faker-js/faker";
import { generatePostRank, stringToSlug } from "./";
import randomNumber from "./randomNumber";
import log from "./log";

const seedDatabase = async () => {
  const userSeeds = 10;
  // posts/space posts = userSeeds*10, replies = userSeeds*30
  const spaceSeeds = 10;
  const userIds: number[] = [];
  const postIds: number[] = [];
  let replyIds: number[] = [];
  const spaceIds: number[] = [];

  const factiii = await prisma.space.findFirstOrThrow({
    where: {
      slug: "factiii",
    },
    select: {
      id: true,
    },
  });
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

  for (let i = 0; i < userSeeds; i++) {
    const username = faker.internet.userName();
    const email = faker.internet.email();
    const user = await prisma.user.findFirst({
      where: {
        OR: [{ username }, { email }],
      },
    });
    if (!user) {
      const user = await prisma.user.create({
        data: {
          username,
          name: faker.person.fullName(),
          password: faker.internet.password(),
          email,
          bio: faker.lorem.paragraph(),
          filters: {
            create: {
              spaceId: factiii.id,
            },
          },
        },
      });
      await prisma.userPreference.create({
        data: {
          userId: user.id,
        },
      });
      const avatar = await prisma.upload.create({
        data: {
          userId: user.id,
          key: faker.image.avatar(),
          type: "IMAGE",
        },
      });
      const banner = await prisma.upload.create({
        data: {
          userId: user.id,
          key: faker.image.urlPicsumPhotos({ width: 1920, height: 1080 }),
          type: "IMAGE",
        },
      });
      await prisma.user.update({
        where: {
          id: user.id,
        },
        data: {
          bannerId: banner.id,
          avatarId: avatar.id,
        },
      });
      userIds.push(user.id);
    }
  }

  log("seeding random spaces");
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
      spaceIds.push(space.id);
    }
  }

  log("seeding posts");
  for (let i = 0; i < userSeeds * 10; i++) {
    const post = await prisma.post.create({
      data: {
        content: faker.lorem.paragraph(),
        userId: faker.helpers.arrayElement(userIds),
        createdAt: faker.date.past(),
      },
    });
    postIds.push(post.id);
  }
  log("seeding space posts");
  for (let i = 0; i < userSeeds * 10; i++) {
    const post = await prisma.post.create({
      data: {
        content: faker.lorem.paragraph(),
        userId: faker.helpers.arrayElement(userIds),
        createdAt: faker.date.past(),
        spaceId: faker.helpers.arrayElement(spaceIds),
      },
    });
    postIds.push(post.id);
  }
  replyIds = postIds;
  log("seeding replies");
  for (let i = 0; i < userSeeds * 100; i++) {
    const reply = await prisma.post.create({
      data: {
        content: faker.lorem.sentences(),
        userId: faker.helpers.arrayElement(userIds),
        createdAt: faker.date.past(),
        parentPostId: faker.helpers.arrayElement(replyIds),
      },
    });
    replyIds.push(reply.id);
  }
  log("seeding user follows");
  for (const userId of userIds) {
    // Since userId is an integere this will make lower ineteger ids follow less
    const rand = randomNumber(1, userId);
    const followers = faker.helpers.arrayElements(userIds, rand);
    for (const followingId of followers) {
      if (userId !== followingId) {
        await prisma.follows.create({
          data: {
            followerId: userId,
            followingId,
          },
        });
      }
    }
  }
  log("seeding space owners");
  for (const spaceId of spaceIds) {
    await prisma.spaceMember.create({
      data: {
        userId: faker.helpers.arrayElement(userIds),
        spaceId,
        roles: ["OWNER"],
        createdAt: faker.date.past(),
      },
    });
  }
  log("seeding space members");
  for (const userId of userIds) {
    // Since userId is an integer this will make lower ineteger ids follow less
    const rand = randomNumber(1, userId);
    const spaces = faker.helpers.arrayElements(spaceIds, rand);
    for (const spaceId of spaces) {
      const spaceMember = await prisma.spaceMember.findFirst({
        where: {
          userId,
          spaceId,
        },
      });
      if (!spaceMember) {
        await prisma.spaceMember.create({
          data: {
            userId,
            spaceId,
            roles: ["MEMBER"],
            createdAt: faker.date.past(),
          },
        });
      }
    }
  }
  log("seeding votes");
  for (const userId of userIds) {
    const rand = randomNumber(1, userId);
    const posts = faker.helpers.arrayElements(postIds, rand);
    for (const postId of posts) {
      await prisma.vote.create({
        data: {
          userId,
          postId,
          type: faker.helpers.arrayElement([
            "UPVOTE",
            "DOWNVOTE",
            "UPVOTE",
            "UPVOTE",
            "UPVOTE",
          ]),
        },
      });
    }
  }

  log("reporting random posts");
  spaceIds.push(1, 2, 3, 4);
  const rules = await prisma.rule.findMany({
    select: {
      id: true,
    },
  });
  const ruleIds = rules.map((item) => item.id);
  for (let i = 0; i < userSeeds * 100; i++) {
    await prisma.report.create({
      data: {
        createdAt: faker.date.past(),
        userId: faker.helpers.arrayElement(userIds),
        status: faker.helpers.arrayElement([
          "PENDING",
          "DISCARDED",
          "CONTENT_REMOVED",
        ]),
        reportedPostId: faker.helpers.arrayElement(postIds),
        type: "POST",
        ruleId: faker.helpers.arrayElement(ruleIds), // TODO make random rule array
      },
    });
  }
  log("calculating trendingRank and voteCounts");
  for (const postId of postIds) {
    const Upvotes = await prisma.vote.count({
      where: {
        postId,
        type: "UPVOTE",
      },
    });
    const Downvotes = await prisma.vote.count({
      where: {
        postId,
        type: "DOWNVOTE",
      },
    });
    const voteCount = Upvotes - Downvotes;
    const post = await prisma.post.findFirstOrThrow({
      where: {
        id: postId,
      },
    });
    await prisma.post.update({
      where: {
        id: postId,
      },
      data: {
        voteCount,
        trendingRank: generatePostRank(post.createdAt, voteCount),
      },
    });
  }
};

export default seedDatabase;
