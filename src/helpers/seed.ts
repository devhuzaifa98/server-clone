import { PrismaClient } from "@prisma/client";
import { generatePostRank } from ".";
import log from "./log";
import stringToSlug from "./stringToSlug";

const prisma = new PrismaClient();

let postIds: number[] = [];
const ENV = process.env.ENV;

async function main() {
  const jonUser = await prisma.user.findFirst({
    where: {
      username: "jon",
    },
    select: {
      id: true,
    },
  });

  if (jonUser) {
    log("already seeded");
  } else {
    if (ENV == "development") {
      const today = new Date();
      log("seededing defaults");
      log("seeding Coin items and site settings");
      await prisma.siteSettings.create({
        data: {
          coinTronRatio: 3000,
          coinTransferRatio: 5,
          requestRateLimit: 50,
          maxSpacesPerUser: 10,
          postsPerMinute: 30,
          openAiLimitPerHourPerUser: 30,
          openAiLimitPremiumUser: 100,
        },
      });

      const nataliiaUser = await prisma.user.create({
        data: {
          email: "nasnyder10@gmail.com",
          password:
            "$2b$10$Q4oF8y8x/2RivokaVcxllO6KGv8313NQaW98JC5wTTkC4ebpjzxbG",
          username: "nataliia",
          name: "Nataliia Snyder",
          bio: "Factiii's #1 user.",
          preferences: {
            create: {},
          },
        },
      });
      const jonUser = await prisma.user.create({
        data: {
          email: "jsnyder@factiii.com",
          password:
            "$2b$10$Q4oF8y8x/2RivokaVcxllO6KGv8313NQaW98JC5wTTkC4ebpjzxbG",
          username: "jon",
          name: "Jonathan Snyder",
          bio: "Active duty Air Force. Full time parent. Part time programmer and science fanatic.",
          coinsBalance: 1000000,
          tronsBalance: 3000000000,
          preferences: {
            create: {},
          },
        },
      });
      const parikUser = await prisma.user.create({
        data: {
          email: "parik36@icloud.com",
          password:
            "$2b$10$Q4oF8y8x/2RivokaVcxllO6KGv8313NQaW98JC5wTTkC4ebpjzxbG",
          username: "parik",
          name: "Parik",
          bio: "Factiii's #1 developer.",
          preferences: {
            create: {},
          },
        },
      });
      const factiii = await prisma.space.create({
        data: {
          slug: "factiii",
          name: "factiii",
          description:
            "Welcome to factiii. This is a place to discuss anything you like with an emphasis on factiii and how we can improve. Hope you all enjoy it here!",
          members: {
            create: [
              { userId: jonUser.id, roles: ["OWNER"] },
              { userId: parikUser.id, roles: ["OWNER"] },
              { userId: nataliiaUser.id, roles: ["MODERATOR"] },
            ],
          },
          filters: {
            create: [
              { userId: jonUser.id },
              { userId: parikUser.id },
              { userId: nataliiaUser.id },
            ],
          },
          rules: {
            create: [
              {
                title: "No Hate",
                description:
                  "We do not tolerate content that expresses, incites, or promotes hate based on identity.",
              },
              {
                title: "No Illegal Content",
                description:
                  "We do not allow content that violates any laws, trademarks, or copyrights.",
              },
              {
                title: "Respect Others",
                description:
                  "Please keep your content respectful. We may not agree on everything, but as fellow humans, we should strive to respect each other.",
              },
              {
                title: "No Deceptive Content",
                description:
                  "We do not allow content that is intentionally misleading or spreading false information. Parody is allowed, but impersonation is not.",
              },
              {
                title: "No Harassment or Trolling",
                description:
                  "We do not tolerate content that is harassing or trolling.",
              },
              {
                title: "No Name Trolling",
                description:
                  "We reserve the right to transfer account Space and User names to new owners. This will be done in a transparent and open manner.",
              },
              {
                title: "No Violence",
                description:
                  "We do not allow content that encourages violence against others.",
              },
              {
                title: "No Self-Harm",
                description:
                  "We do not allow content that promotes, encourages, or depicts acts of self-harm.",
              },
              {
                title: "Political Content Discouraged",
                description:
                  "While political content is allowed, it is not encouraged. The default site filter deboosts political content. Please keep political discussion in s/politics.",
              },
            ],
          },
        },
      });
      log("seeding tags");
      const tagFunny = await prisma.upload.create({
        data: { userId: jonUser.id, key: "static/tagFunny.jpg", type: "IMAGE" },
      });
      const tagInformative = await prisma.upload.create({
        data: {
          userId: jonUser.id,
          key: "static/tagInformative.jpg",
          type: "IMAGE",
        },
      });
      const tagTroll = await prisma.upload.create({
        data: { userId: jonUser.id, key: "static/tagTroll.jpg", type: "IMAGE" },
      });
      const tagPolitics = await prisma.upload.create({
        data: {
          userId: jonUser.id,
          key: "static/tagPolitics.jpg",
          type: "IMAGE",
        },
      });
      const tagMisleading = await prisma.upload.create({
        data: {
          userId: jonUser.id,
          key: "static/tagMisleading.jpg",
          type: "IMAGE",
        },
      });
      const tagNSFW = await prisma.upload.create({
        data: { userId: jonUser.id, key: "static/tagNSFW.jpg", type: "IMAGE" },
      });
      await prisma.factiii.createMany({
        data: [
          {
            name: "Funny",
            slug: "funny",
            spaceId: factiii.id,
            userId: jonUser.id,
            avatarId: tagFunny.id,
          },
          {
            name: "Informative",
            slug: "informative",
            spaceId: factiii.id,
            userId: jonUser.id,
            avatarId: tagInformative.id,
          },
          {
            name: "Troll",
            slug: "troll",
            spaceId: factiii.id,
            userId: jonUser.id,
            avatarId: tagTroll.id,
          },
          {
            name: "Politics",
            slug: "politics",
            spaceId: factiii.id,
            userId: jonUser.id,
            avatarId: tagPolitics.id,
          },
          {
            name: "Misleading",
            slug: "misleading",
            spaceId: factiii.id,
            userId: jonUser.id,
            avatarId: tagMisleading.id,
          },
          {
            name: "NSFW",
            slug: "nsfw",
            spaceId: factiii.id,
            userId: jonUser.id,
            avatarId: tagNSFW.id,
          },
          {
            requirements: ["MEDIA_REQUIRED"],
            name: "For Sale",
            slug: "for_sale",
            spaceId: factiii.id,
            userId: jonUser.id,
            description:
              "All posts tagged with this must contain at least 1 picture of items to be sold as well as have the location of the items for sale.",
          },
          {
            requirements: ["MEDIA_REQUIRED", "DATA_REQUIRED"],
            name: "Count Calories",
            slug: "count_calories",
            spaceId: factiii.id,
            userId: jonUser.id,
            description:
              "All posts tagged with this must contain at least 1 picture of the item being summed. The factiii must contain a summation of the components of the calories found in the food in the picture.",
          },
          {
            requirements: ["MEDIA_REQUIRED"],
            name: "Work Out",
            slug: "work_out",
            spaceId: factiii.id,
            userId: jonUser.id,
            description:
              "All posts tagged with this must contain at least 1 picture or video of a workout.",
          },
          {
            requirements: ["MEDIA_REQUIRED", "DATA_REQUIRED"],
            name: "Run",
            slug: "run",
            spaceId: factiii.id,
            userId: jonUser.id,
            description:
              "All posts tagged with this must contain proof of a run to include distance.",
          },
          {
            requirements: ["LOCATION_REQUIRED", "TIME_REQUIRED"],
            name: "Space Time",
            slug: "space_time",
            spaceId: factiii.id,
            userId: jonUser.id,
          },
          {
            requirements: ["LOCATION_REQUIRED"],
            name: "Location",
            slug: "location",
            spaceId: factiii.id,
            userId: jonUser.id,
          },
          {
            requirements: ["TIME_REQUIRED"],
            name: "Date Time",
            slug: "date_time",
            spaceId: factiii.id,
            userId: jonUser.id,
          },
          {
            requirements: ["DATA_REQUIRED"],
            name: "Data",
            slug: "data",
            userId: jonUser.id,
          },
          {
            requirements: ["CONTENT_REQUIRED"],
            name: "Content",
            slug: "content",
            userId: jonUser.id,
          },
          {
            requirements: ["WIKI"],
            name: "Wiki",
            slug: "wiki",
            userId: jonUser.id,
          },
          {
            requirements: ["NO_POST_DUPLICATES"],
            name: "No Duplicates",
            slug: stringToSlug("No Duplicates"),
            userId: jonUser.id,
          },
          {
            requirements: ["BUDGET"],
            name: "Budget",
            slug: stringToSlug("Budget"),
            userId: jonUser.id,
            spaceId: factiii.id,
          },
        ],
      });
      const wikiUser = await prisma.user.create({
        data: {
          email: "parikshith8040@gmail.com",
          password:
            "$2b$10$9BonSswdP4/T0YZvbiqHhekYSR66NuFy65nPnlW6XGqNVDNdxGdeS",
          username: "wikipedia",
          name: "Wikipedia",
          bio: "Unofficial Wikipedia account",
          tag: "BOT",
          preferences: {
            create: {},
          },
        },
      });

      await prisma.botSetting.create({
        data: {
          userId: wikiUser.id,
          types: ["WIKIPEDIA_SCRAPER"],
          scrapesPerDay: 1000,
          enabled: false,
          rootUrl: "https://en.wikipedia.org",
        },
      });

      const wikipediaSpace = await prisma.space.create({
        data: {
          slug: "wikipedia",
          name: "Wikipedia",
          description: "Welcome to the unofficial Wikipedia Page!",
          members: {
            create: [
              { userId: jonUser.id, roles: ["OWNER"] },
              { userId: wikiUser.id, roles: ["OWNER"] },
            ],
          },
        },
        select: {
          id: true,
        },
      });
      const wiki1 = await prisma.factiii.create({
        data: {
          name: "History",
          slug: "history",
          requirements: ["NO_POST_DUPLICATES"],
          description: "This is where you can view all the history factiiis.",
          avatarId: wikiUser.avatarId,
          userId: jonUser.id,
          spaceId: wikipediaSpace.id,
        },
      });
      await prisma.post.create({
        data: {
          userId: jonUser.id,
          content: "This is a post about history.",
          factiiis: {
            create: {
              factiiiId: wiki1.id,
              userId: jonUser.id,
              data: "https://en.wikipedia.org/wiki/History",
            },
          },
        },
      });
      const nsfw = await prisma.factiii.findFirstOrThrow({
        where: {
          name: "NSFW",
        },
        select: {
          id: true,
        },
      });
      await prisma.factiii.update({
        where: {
          id: nsfw.id,
        },
        data: {
          rules: {
            create: [{ title: "nsfw", description: "nsfw rule" }],
          },
        },
      });
      const politics = await prisma.factiii.findFirstOrThrow({
        where: {
          name: "Politics",
        },
        select: {
          id: true,
        },
      });
      await prisma.factiii.update({
        where: {
          id: politics.id,
        },
        data: {
          rules: {
            create: [{ title: "Politics", description: "Politics rule" }],
          },
        },
      });
      log("seeding costs and models");
      await prisma.model.create({
        data: {
          cost: 20000,
          perTokens: 1000,
          active: true,
          description: "OpenAI's best AI.",
          type: "OPENAI_LANGUAGE",
          maxTokens: 4000,
          query: "davinci",
        },
      });
      await prisma.model.create({
        data: {
          cost: 2000,
          perTokens: 1000,
          active: true,
          description: "OpenAI's 2nd best AI.",
          type: "OPENAI_LANGUAGE",
          maxTokens: 1000,
          query: "curie",
        },
      });
      await prisma.model.create({
        data: {
          cost: 500,
          perTokens: 1000,
          active: true,
          description: "OpenAI's 2nd cheapest AI.",
          type: "OPENAI_LANGUAGE",
          maxTokens: 1000,
          query: "babbage",
        },
      });
      await prisma.model.create({
        data: {
          cost: 400,
          perTokens: 1000,
          active: true,
          description: "OpenAI's cheapest AI.",
          type: "OPENAI_LANGUAGE",
          maxTokens: 1000,
          query: "ada",
        },
      });
      await prisma.model.create({
        data: {
          cost: 20000,
          perTokens: 1000,
          active: true,
          description: "OpenAI's best image.",
          type: "OPENAI_IMAGE",
          query: "1024x1024",
          maxTokens: 1000,
        },
      });
      await prisma.model.create({
        data: {
          cost: 18000,
          perTokens: 1000,
          active: true,
          description: "OpenAI's medium size image.",
          type: "OPENAI_IMAGE",
          query: "512x512",
          maxTokens: 1000,
        },
      });
      await prisma.model.create({
        data: {
          cost: 16000,
          perTokens: 1000,
          active: true,
          description: "OpenAI's cheapest image.",
          type: "OPENAI_IMAGE",
          query: "256x256",
          maxTokens: 1000,
        },
      });
      await prisma.model.createMany({
        data: [
          {
            description: "OpenAI EMBEDDING_ADA",
            cost: 400,
            perTokens: 1000,
            active: true,
            type: "OPENAI_EMBEDDING",
          },
          {
            description: "OpenAI FINE_TUNED_DAVINCI",
            cost: 30000,
            perTokens: 1000,
            active: true,
            type: "OPENAI_FINE_TUNED",
          },
          {
            description: "OpenAI FINE_TUNED_CURIE",
            cost: 3000,
            perTokens: 1000,
            active: true,
            type: "OPENAI_FINE_TUNED",
          },
          {
            description: "OpenAI FINE_TUNED_BABBAGE",
            cost: 600,
            perTokens: 1000,
            active: true,
            type: "OPENAI_FINE_TUNED",
          },
          {
            description: "OpenAI FINE_TUNED_ADA",
            cost: 400,
            perTokens: 1000,
            active: true,
            type: "OPENAI_FINE_TUNED",
          },
        ],
      });
      log("seeding default users and spaces");
      const jonAvatar = await prisma.upload.create({
        data: {
          userId: jonUser.id,
          key: "static/jonAvatar.jpg",
          type: "IMAGE",
        },
      });
      const jonBanner = await prisma.upload.create({
        data: {
          userId: jonUser.id,
          key: "static/jonBanner.jpg",
          type: "IMAGE",
        },
      });
      await prisma.user.update({
        where: {
          id: jonUser.id,
        },
        data: {
          bannerId: jonBanner.id,
          avatarId: jonAvatar.id,
        },
      });

      const parikAvatar = await prisma.upload.create({
        data: {
          userId: parikUser.id,
          key: "static/parikAvatar.jpg",
          type: "IMAGE",
        },
      });
      const parikBanner = await prisma.upload.create({
        data: {
          userId: parikUser.id,
          key: "static/parikBanner.jpg",
          type: "IMAGE",
        },
      });
      await prisma.user.update({
        where: {
          id: parikUser.id,
        },
        data: {
          bannerId: parikBanner.id,
          avatarId: parikAvatar.id,
        },
      });
      const nataliiaAvatar = await prisma.upload.create({
        data: {
          userId: nataliiaUser.id,
          key: "static/nataliiaAvatar.jpg",
          type: "IMAGE",
        },
      });
      const nataliiaBanner = await prisma.upload.create({
        data: {
          userId: nataliiaUser.id,
          key: "static/nataliiaBanner.jpg",
          type: "IMAGE",
        },
      });
      await prisma.user.update({
        where: {
          id: nataliiaUser.id,
        },
        data: {
          bannerId: nataliiaBanner.id,
          avatarId: nataliiaAvatar.id,
        },
      });
      //This is a private space for premium members
      const factiiiPremium = await prisma.space.create({
        data: {
          slug: "premium",
          name: "premium",
          description:
            "Welcome to premium! A place for premium members to hang out and share requests. This is only open to those with active premium subscriptions.",
          types: ["PREMIUM"],
          members: {
            create: [
              {
                premiumAccessExpires: new Date(
                  today.setFullYear(today.getFullYear() + 20),
                ),
                userId: jonUser.id,
                roles: ["OWNER"],
              },
              {
                premiumAccessExpires: new Date(
                  today.setFullYear(today.getFullYear() + 20),
                ),
                userId: parikUser.id,
                roles: ["OWNER"],
              },
            ],
          },
        },
      });

      const factiiiPremiumAvatar = await prisma.upload.create({
        data: {
          userId: jonUser.id,
          key: "static/premiumAvatar.jpg",
          type: "IMAGE",
        },
      });
      const factiiiPremiumBanner = await prisma.upload.create({
        data: {
          userId: jonUser.id,
          key: "static/premiumBanner.jpg",
          type: "IMAGE",
        },
      });
      await prisma.space.update({
        where: {
          id: factiiiPremium.id,
        },
        data: {
          bannerId: factiiiPremiumBanner.id,
          avatarId: factiiiPremiumAvatar.id,
        },
      });

      const factiiiAvatar = await prisma.upload.create({
        data: {
          userId: jonUser.id,
          key: "static/factiiiAvatar.jpg",
          type: "IMAGE",
        },
      });
      const factiiiBanner = await prisma.upload.create({
        data: {
          userId: jonUser.id,
          key: "static/factiiiBanner.jpg",
          type: "IMAGE",
        },
      });
      await prisma.space.update({
        where: {
          id: factiii.id,
        },
        data: {
          bannerId: factiiiBanner.id,
          avatarId: factiiiAvatar.id,
        },
      });
      //Hard coded to be the About page for factiii
      const about = await prisma.space.create({
        data: {
          slug: "about",
          name: "about",
          description:
            "Welcome to our about page. Here you can see our blog as well as learn about our Mission. Feel free to engage with us in s/factiii.",
          members: {
            create: [
              { userId: jonUser.id, roles: ["OWNER"] },
              { userId: parikUser.id, roles: ["OWNER"] },
              { userId: nataliiaUser.id, roles: ["MODERATOR"] },
            ],
          },
        },
      });
      const aboutAvatar = await prisma.upload.create({
        data: {
          userId: jonUser.id,
          key: "static/aboutAvatar.jpg",
          type: "IMAGE",
        },
      });
      const aboutBanner = await prisma.upload.create({
        data: {
          userId: jonUser.id,
          key: "static/aboutBanner.jpg",
          type: "IMAGE",
        },
      });
      await prisma.space.update({
        where: {
          id: about.id,
        },
        data: {
          bannerId: aboutBanner.id,
          avatarId: aboutAvatar.id,
        },
      });
      const janiceUser = await prisma.user.create({
        data: {
          email: "janice123@yahoot.com",
          password:
            "$2b$10$Q4oF8y8x/2RivokaVcxllO6KGv8313NQaW98JC5wTTkC4ebpjzxbG",
          username: "janice78",
          name: "Janice Bogan PhD",
          bio: "I am a test user!",
          preferences: {
            create: {},
          },
        },
      });
      const premiumProduct = await prisma.product.create({
        data: {
          stripeProductId: "price_1OoCdyDS6lFTllE6SuUiO0mX",
          playStoreProductId: "factiii_premium",
          appStoreProductId: "premium_monthly",
          type: "MONTHLY_SUBSCRIPTION",
          description:
            "Enhance your Factiii experience with our Premium Subscription! Get 1 month of premium access plus 200 coins at 20% off. Elevate your interactions and enjoy exclusive features with this special offer.",
          title: "Premium Subscription",
          price: 800,
          images: {
            create: [
              {
                userId: jonUser.id,
                key: "static/premium-icon.svg",
                type: "IMAGE",
              },
            ],
          },
          active: true,
          spaceId: factiiiPremium.id,
          coin: {
            create: {
              premiumDays: 0,
              quantity: 200,
            },
          },
        },
      });
      const testSub = await prisma.product.create({
        data: {
          stripeProductId: "price_1OoUZjDS6lFTllE6Wgap2TQ5",
          type: "MONTHLY_SUBSCRIPTION",
          description: "This is to test subscriptions",
          title: "Test Subscription",
          price: 700,
          images: {
            create: [
              {
                userId: jonUser.id,
                key: "static/premium-icon.svg",
                type: "IMAGE",
              },
            ],
          },
          active: true,
          spaceId: factiiiPremium.id,
          coin: {
            create: {
              premiumDays: 0,
              quantity: 200,
            },
          },
        },
      });
      //This is a private space for founders
      const founders = await prisma.space.create({
        data: {
          slug: "founders",
          name: "founders",
          description:
            "Welcome to founders! A place for founding members to hang out and share requests. This is only open to those who buy founders tokens",
          types: ["PREMIUM", "PRIVATE"],
          members: {
            create: [
              {
                userId: jonUser.id,
                roles: ["OWNER"],
              },
              {
                userId: parikUser.id,
                roles: ["OWNER"],
              },
            ],
          },
        },
      });
      const foundersAvatar = await prisma.upload.create({
        data: {
          userId: jonUser.id,
          key: "static/foundersAvatar.jpg",
          type: "IMAGE",
        },
      });
      const foundersBanner = await prisma.upload.create({
        data: {
          userId: jonUser.id,
          key: "static/foundersBanner.jpg",
          type: "IMAGE",
        },
      });
      await prisma.space.update({
        where: {
          id: founders.id,
        },
        data: {
          bannerId: foundersBanner.id,
          avatarId: foundersAvatar.id,
        },
      });
      const testFoundersToken = await prisma.product.create({
        data: {
          stripeProductId: "price_1OoUfbDS6lFTllE6zFC1Jkwv",
          type: "FOUNDERS_TOKEN",
          description: `Test my logic 5x!.`,
          title: "Test Founders Token",
          price: 9500,
          inventory: 5,
          images: {
            create: [
              {
                userId: jonUser.id,
                key: "static/premium-icon.svg",
                type: "IMAGE",
              },
            ],
          },
          active: true,
          spaceId: founders.id,
          coin: {
            create: {
              premiumDays: 20 * 365,
              quantity: 2000,
            },
          },
        },
      });
      const foundersToken = await prisma.product.create({
        data: {
          appStoreProductId: "founders_token",
          stripeProductId: "price_1OoD5uDS6lFTllE6vVit7IZs",
          playStoreProductId: "founders_token",
          type: "FOUNDERS_TOKEN",
          description: `Experience 20years of Factiii Premium! Only 10,000 tokens available, each with 20,000 bonus coins, 20% off future tokens, and exclusive Founders-only space access. Once sold, they're gone forever—secure yours now!`,
          title: "Founders Token",
          price: 20000,
          inventory: 10000,
          images: {
            create: [
              {
                userId: jonUser.id,
                key: "static/premium-icon.svg",
                type: "IMAGE",
              },
            ],
          },
          active: true,
          spaceId: founders.id,
          coin: {
            create: {
              premiumDays: 20 * 365,
              quantity: 20000,
            },
          },
        },
      });
      //make orders for founders tokens for jon/parik
      await prisma.order.create({
        data: {
          userId: jonUser.id,
          items: {
            create: [
              {
                productId: foundersToken.id,
                price: 10000,
                discount: 10000,
              },
            ],
          },
          total: 10000,
          payments: {
            create: [
              {
                paymentIntent: "FAKE1",
                amount: 10000,
                userId: jonUser.id,
                type: "STRIPE",
                completed: new Date(),
              },
            ],
          },
        },
      });
      await prisma.order.create({
        data: {
          userId: parikUser.id,
          items: {
            create: [
              {
                productId: foundersToken.id,
                price: 10000,
                discount: 10000,
              },
            ],
          },
          total: 10000,
          payments: {
            create: [
              {
                paymentIntent: "FAKE2",
                amount: 10000,
                userId: parikUser.id,
                type: "STRIPE",
                completed: new Date(),
              },
            ],
          },
        },
      });
      const c10 = await prisma.product.create({
        data: {
          type: "COIN",
          description: "10 Coins = 1 Bronze token",
          title: "Bronze",
          price: 10,
          images: {
            create: [
              { userId: jonUser.id, key: "static/bronze.gif", type: "IMAGE" },
            ],
          },
          active: true,
          spaceId: factiii.id,
          coin: {
            create: {
              premiumDays: 1,
              quantity: 10,
            },
          },
        },
      });
      const c200 = await prisma.product.create({
        data: {
          stripeProductId: "price_1OoDCnDS6lFTllE6vacfhHZQ",
          appStoreProductId: "silver_package_01",
          playStoreProductId: "silver_package_test",
          type: "COIN",
          description:
            "Unlock the Silver Package and receive 200 coins along with 7 days of premium access to enhance your Factiii experience.",
          title: "Silver",
          price: 200,
          images: {
            create: [
              { userId: jonUser.id, key: "static/silver.gif", type: "IMAGE" },
            ],
          },
          active: true,
          spaceId: factiii.id,
          coin: {
            create: {
              premiumDays: 7,
              quantity: 200,
            },
          },
        },
      });
      const c1000 = await prisma.product.create({
        data: {
          appStoreProductId: "Gold_Package",
          playStoreProductId: "gold_package",
          stripeProductId: "price_1MartCDS6lFTllE6fFgyZvxI",
          type: "COIN",
          description:
            "Experience the Gold Package, offering 1,000 coins and 31 days of premium access at a 5% discount for an extended and rewarding Factiii journey.",
          title: "Gold",
          price: 1000,
          discount: 5,
          images: {
            create: [
              { userId: jonUser.id, key: "static/gold.gif", type: "IMAGE" },
            ],
          },
          active: true,
          spaceId: factiii.id,
          coin: {
            create: {
              premiumDays: 31,
              quantity: 1000,
            },
          },
        },
      });
      const c5000 = await prisma.product.create({
        data: {
          stripeProductId: "price_1OoDJbDS6lFTllE6kTEG7Iss",
          appStoreProductId: "20230728_Platinum",
          playStoreProductId: "platinum_package",
          active: true,
          type: "COIN",
          description:
            "Upgrade to the Platinum Package and receive 5,000 coins along with 183 days of premium access, all at a 10% discount for an unparalleled Factiii experience.",
          title: "Platinum",
          price: 5000,
          discount: 10,
          images: {
            create: [
              { userId: jonUser.id, key: "static/platinum.gif", type: "IMAGE" },
            ],
          },
          spaceId: factiii.id,
          coin: {
            create: {
              premiumDays: 183,
              quantity: 5000,
            },
          },
        },
      });
      const c25000 = await prisma.product.create({
        data: {
          stripeProductId: "price_1OoDLbDS6lFTllE6LUcQxCtg",
          appStoreProductId: "20230523_Diamond",
          playStoreProductId: "diamond_package",
          type: "COIN",
          description:
            "Experience the ultimate Factiii luxury with the Diamond Package, offering 25,000 coins and 2 years of premium access at a 15% discount.",
          title: "Diamond",
          price: 25000,
          discount: 15,
          images: {
            create: [
              { userId: jonUser.id, key: "static/diamond.gif", type: "IMAGE" },
            ],
          },
          active: true,
          spaceId: factiii.id,
          coin: {
            create: {
              premiumDays: 730,
              quantity: 25000,
            },
          },
        },
      });

      //reserved spaces
      await prisma.space.createMany({
        data: [
          {
            slug: "science",
            name: "science",
            description: "A place to talk about everything science!",
          },
          {
            slug: "history",
            name: "history",
            description: "A place to discuss History!",
          },
          {
            slug: "pics",
            name: "pics",
            description: "A place to post fun pictures!",
          },
          {
            slug: "videos",
            name: "videos",
            description: "A place to post fun videos!",
          },
          {
            slug: "news",
            name: "news",
            description: "A place to post world leading News!",
          },
          {
            slug: "announcements",
            name: "announcements",
            description: "A place factiii uses to share announcements.",
          },
        ],
      });

      const wikipedia = await prisma.space.findUniqueOrThrow({
        where: {
          slug: "wikipedia",
        },
        select: {
          id: true,
        },
      });
      const openaiBot = await prisma.user.create({
        data: {
          email: "openaiBot@factiii.com",
          password: "AHDJHSJCGHJSFCGSHJFCGH*&#$*&_#HSGFH",
          username: "openai",
          name: "OpenAI",
          bio: "Get answers to every single question you have, powered by GPT-3. This space is not managed or endorsed by OpenAI.",
          tag: "BOT",
          preferences: {
            create: {},
          },
          botSettings: {
            create: {
              types: ["OPENAI_LANGUAGE", "OPENAI_IMAGE"],
            },
          },
        },
      });

      const openaiSpace = await prisma.space.create({
        data: {
          slug: "openai",
          name: "OpenAI",
          description:
            "Get answers to every single question you have, powered by GPT-3. Not the official OpenAI account.",
          members: {
            create: [
              { userId: openaiBot.id, roles: ["OWNER"] },
              { userId: jonUser.id, roles: ["MODERATOR"] },
              { userId: parikUser.id, roles: ["MODERATOR"] },
            ],
          },
          rules: {
            create: [
              {
                title: "No Hate",
                description:
                  "Content that expresses, incites, or promotes hate based on identity",
              },
              {
                title: "No Harassment",
                description:
                  "Content that intends to harass, threaten, or bully an individual",
              },
              {
                title: "No Violence",
                description:
                  "Content that promotes or glorifies violence or celebrates the suffering or humiliation of others",
              },
              {
                title: "No Self-harm",
                description:
                  "Content that promotes, encourages, or depicts acts of self-harm, such as suicide, cutting, and eating disorders",
              },
              {
                title: "No Sexual Material",
                description:
                  "Content meant to arouse sexual excitement, such as the description of sexual activity, or that promotes sexual services (excluding sex education and wellness)",
              },
              {
                title: "No Political Manipulation",
                description:
                  "Content attempting to influence the political process or to be used for campaigning purposes",
              },
              { title: "No Spam", description: "Unsolicited bulk content" },
              {
                title: "No Deception",
                description:
                  "Content that is false or misleading, such as attempting to defraud individuals or spread disinformation",
              },
              {
                title: "No Malware",
                description:
                  "Content that attempts to generate ransomware, keyloggers, viruses, or other software intended to impose some level of harm",
              },
              {
                title: "Illegal or harmful industries",
                description:
                  "Includes gambling, payday lending, illegal substances, pseudo-pharmaceuticals, multi-level marketing, weapons development, warfare, cybercrime, adult industries, spam, and non-consensual surveillance.",
              },
              {
                title: "Misuse of personal data",
                description:
                  "Includes classifying people based on protected characteristics, mining sensitive information without appropriate consent, products that claim to accurately predict behavior based on dubious evidence.",
              },
              {
                title: "Promoting dishonesty",
                description:
                  "Includes testimonial generation, product or service review generation, educational dishonesty, contract cheating, astroturfing.",
              },
              {
                title: "Deceiving or manipulating users",
                description:
                  "Includes automated phone calls that sound human, a romantic chatbot that emotionally manipulates end-users, automated systems (including conversational AI and chatbots) that don’t disclose that they are an AI system, or products that simulate another person without their explicit consent.",
              },
              {
                title: "Trying to influence politics",
                description:
                  "Includes generating political fundraising emails, or classifying people in order to deliver targeted political messages.",
              },
            ],
          },
        },
      });

      const openAIAvatar = await prisma.upload.create({
        data: {
          userId: openaiBot.id,
          key: "static/openai-logo.jpg",
          type: "IMAGE",
        },
      });
      const openAIBanner = await prisma.upload.create({
        data: {
          userId: openaiBot.id,
          key: "static/openai-banner.png",
          type: "IMAGE",
        },
      });
      await prisma.user.update({
        where: {
          id: openaiBot.id,
        },
        data: {
          bannerId: openAIBanner.id,
          avatarId: openAIAvatar.id,
        },
      });
      await prisma.space.update({
        where: {
          id: openaiSpace.id,
        },
        data: {
          bannerId: openAIBanner.id,
          avatarId: openAIAvatar.id,
        },
      });

      const trollFactiii = await prisma.factiii.findFirstOrThrow({
        where: {
          name: "Troll",
        },
        select: {
          id: true,
        },
      });
      const followAllUser = await prisma.user.create({
        data: {
          email: "follow@all.com",
          password:
            "$2b$10$Q4oF8y8x/2RivokaVcxllO6KGv8313NQaW98JC5wTTkC4ebpjzxbG",
          username: "FollowAll",
          name: "I follow everyone",
          bio: "I am a test user that follows everyone",
          preferences: {
            create: {},
          },
        },
      });
      const followedByAllUser = await prisma.user.create({
        data: {
          email: "followed@all.com",
          password:
            "$2b$10$Q4oF8y8x/2RivokaVcxllO6KGv8313NQaW98JC5wTTkC4ebpjzxbG",
          username: "FollowedByAll",
          name: "I am followed by everyone",
          bio: "I am a test that is follwed by everyone",
          preferences: {
            create: {},
          },
        },
      });
      const bannedUser = await prisma.user.create({
        data: {
          email: "banned@yahoot.com",
          password:
            "$2b$10$Q4oF8y8x/2RivokaVcxllO6KGv8313NQaW98JC5wTTkC4ebpjzxbG",
          username: "banned",
          name: "I am banned from everywhere",
          bio: "I am a test user! I have 1 post in every space and I am banned from every space",
          preferences: {
            create: {},
          },
        },
      });
      const mutedUser = await prisma.user.create({
        data: {
          email: "muted@yahoot.com",
          password:
            "$2b$10$Q4oF8y8x/2RivokaVcxllO6KGv8313NQaW98JC5wTTkC4ebpjzxbG",
          username: "muted",
          name: "I am muted by everyone",
          bio: "I am a test user! I have 1 post in every space and I am muted by every one",
          preferences: {
            create: {},
          },
        },
      });
      const blockedUser = await prisma.user.create({
        data: {
          email: "blocked@yahoot.com",
          password:
            "$2b$10$Q4oF8y8x/2RivokaVcxllO6KGv8313NQaW98JC5wTTkC4ebpjzxbG",
          username: "blocked",
          name: "I am blocked by everyone",
          bio: "I am a test user! I have 1 post in every space and I am blocked by every one",
          preferences: {
            create: {},
          },
        },
      });
      const blockAllUser = await prisma.user.create({
        data: {
          email: "blockAll@yahoot.com",
          password:
            "$2b$10$Q4oF8y8x/2RivokaVcxllO6KGv8313NQaW98JC5wTTkC4ebpjzxbG",
          username: "blockAll",
          name: "I blocked everyone",
          bio: "I am a test user! I have 1 post in every space and I blocked every one",
          preferences: {
            create: {},
          },
        },
      });
      const NSFW = await prisma.factiii.findFirstOrThrow({
        where: {
          name: "NSFW",
          spaceId: factiii.id,
        },
      });
      log("env dev detected seeding factiiis/topics/locations");
      const scienceTopic = await prisma.factiii.create({
        data: {
          slug: "science",
          name: "Science",
          userId: janiceUser.id,
          spaceId: factiii.id,
          requirements: ["NO_POST_DUPLICATES"],
        },
        select: {
          id: true,
        },
      });
      const fordTopic = await prisma.factiii.create({
        data: {
          name: "Ford",
          slug: "ford",
          userId: janiceUser.id,
          requirements: ["NO_POST_DUPLICATES"],
        },
        select: {
          id: true,
        },
      });
      const multiFord = await prisma.factiii.createMany({
        data: [
          { name: "Ford 2", slug: "ford2", userId: janiceUser.id },
          { name: "Ford 3", slug: "ford3", userId: janiceUser.id },
          { name: "Ford 4", slug: "ford4", userId: janiceUser.id },
          { name: "Ford 5", slug: "ford5", userId: janiceUser.id },
          { name: "Ford 6", slug: "ford6", userId: janiceUser.id },
          { name: "Ford 7", slug: "ford7", userId: janiceUser.id },
          { name: "Ford 8", slug: "ford8", userId: janiceUser.id },
          { name: "Ford 9", slug: "ford9", userId: janiceUser.id },
          { name: "Ford 10", slug: "ford10", userId: janiceUser.id },
          { name: "Ford 11", slug: "ford11", userId: janiceUser.id },
          { name: "Ford 12", slug: "ford12", userId: janiceUser.id },
        ],
      });
      const technologyTopic = await prisma.factiii.create({
        data: {
          name: "Technology",
          slug: "technology",
          userId: 3,
          requirements: ["NO_POST_DUPLICATES"],
        },
        select: {
          id: true,
        },
      });
      const lonelyTopic = await prisma.factiii.create({
        data: {
          name: "Lonely Topic",
          slug: "lonely_topic",
          userId: 3,
        },
        select: {
          id: true,
        },
      });
      const humanSource = await prisma.factiii.create({
        data: {
          requirements: ["HUMAN_SOURCE"],
          name: "Jonathan Snyder",
          slug: stringToSlug("Jonathan Snyder"),
          userId: jonUser.id,
          description: "I'm a human. https://factiii.com/about",
        },
        select: {
          id: true,
        },
      });
      const governmentSource = await prisma.factiii.create({
        data: {
          requirements: ["GOVERNMENT_SOURCE"],
          name: "EPA",
          slug: "epa",
          description:
            "The Environmental Protection Agency is an independent executive agency of the United States federal government tasked with environmental protection matters. https://www.epa.gov/",
          userId: jonUser.id,
        },
        select: {
          id: true,
        },
      });
      await prisma.factiii.create({
        data: {
          requirements: ["ENTERPRISE_SOURCE"],
          name: "Wikipedia",
          slug: "wikipedia",
          description:
            "This is the unofficial Wikipedia factiii. https://en.wikipedia.org/wiki/Main_Page",
          spaceId: wikipedia.id,
          userId: jonUser.id,
        },
        select: {
          id: true,
        },
      });
      const anonymousSource = await prisma.factiii.create({
        data: {
          requirements: ["ANONYMOUS_SOURCE"],
          name: "Mr Anonymous",
          slug: "mr-anonymous",
          userId: jonUser.id,
        },
        select: {
          id: true,
        },
      });
      //This one has a specific UUID for testing later
      await prisma.post.create({
        data: {
          uuid: "b87effd7-e13b-4c06-8765-3d377c9e115d",
          userId: jonUser.id,
          content: `Post with factiiis science and politics`,
          factiiis: {
            createMany: {
              data: [
                { factiiiId: scienceTopic.id, userId: jonUser.id },
                { factiiiId: politics.id, userId: jonUser.id },
              ],
            },
          },
        },
      });
      await prisma.post.create({
        data: {
          userId: jonUser.id,
          content: "Post with factiiis science and history",
          factiiis: {
            createMany: {
              data: [
                { factiiiId: scienceTopic.id, userId: jonUser.id },
                { factiiiId: wiki1.id, userId: jonUser.id },
              ],
            },
          },
        },
      });
      await prisma.post.create({
        data: {
          userId: jonUser.id,
          content: "Post with factiiis science and ford",
          factiiis: {
            createMany: {
              data: [
                { factiiiId: scienceTopic.id, userId: jonUser.id },
                { factiiiId: fordTopic.id, userId: jonUser.id },
              ],
            },
          },
        },
      });
      await prisma.post.create({
        data: {
          userId: jonUser.id,
          content: "Post with factiiis science and technology",
          factiiis: {
            createMany: {
              data: [
                { factiiiId: scienceTopic.id, userId: jonUser.id },
                { factiiiId: technologyTopic.id, userId: jonUser.id },
              ],
            },
          },
        },
      });
      await prisma.post.create({
        data: {
          userId: jonUser.id,
          content: "Post with factiii lonely",
          factiiis: {
            createMany: {
              data: [{ factiiiId: lonelyTopic.id, userId: jonUser.id }],
            },
          },
        },
      });

      log("seeding the coin reward items");
      await prisma.coinRewardItem.createMany({
        data: [
          {
            slug: "PUBLISH_10TH_POST",
            title: "Publish your 10th post",
            quantity: 5,
            description:
              "You will be rewarded 5 coins when you create your 10th post on Factiii. To claim this, you just have to create 10 posts (including replies). This is only rewarded once.",
          },
          {
            slug: "GET_100_UPVOTES",
            title: "Get 100 upvotes on a post",
            quantity: 100,
            description:
              "You will be rewarded 100 coins when one of the post you created on Factiii recieves 100 upvotes. To claim this, once your post must have a total vote count of 100 (upvotes - downvotes). This is only rewarded once.",
          },
          {
            slug: "VERIFY_EMAIL_ADDRESS",
            title: "Verify your email address",
            quantity: 5,
            description:
              "You will be rewarded 5 coins when you verify your email address. To claim this, you must verify your registered email via an OTP. This is only rewarded once.",
          },
          // {
          // 	id: "VERIFY_PHONE_NUMBER",
          // 	title: "Verify your phone number",
          // 	quantity: 10,
          // 	description: "You will be rewarded 10 coins when you verify your phone number. To claim this, you must add your phone number to Factiii and verify it via an OTP. This is only rewarded once.",
          // }
        ],
      });

      log("inject test users");
      const privateUser = await prisma.user.create({
        data: {
          email: "private@yahoot.com",
          password:
            "$2b$10$Q4oF8y8x/2RivokaVcxllO6KGv8313NQaW98JC5wTTkC4ebpjzxbG",
          username: "private",
          name: "Private User",
          bio: "I am a test Private user!",
          types: ["PRIVATE"],
          preferences: {
            create: {},
          },
        },
      });
      const privateUserFollowsJonParik = await prisma.user.create({
        data: {
          email: "privateUserFollowsJonParik@yahoot.com",
          password:
            "$2b$10$Q4oF8y8x/2RivokaVcxllO6KGv8313NQaW98JC5wTTkC4ebpjzxbG",
          username: "privateUserFollowsJonParik",
          name: "Private User follows Jon and Parik",
          bio: "I am a test Private user that follows Jon and Parik!",
          types: ["PRIVATE"],
          following: {
            create: [
              {
                followingId: jonUser.id,
              },
              {
                followingId: parikUser.id,
              },
            ],
          },
          preferences: {
            create: {},
          },
        },
      });
      const privateUserFollowedByJonParik = await prisma.user.create({
        data: {
          email: "privateUserFollowedByJonParik@yahoot.com",
          password:
            "$2b$10$Q4oF8y8x/2RivokaVcxllO6KGv8313NQaW98JC5wTTkC4ebpjzxbG",
          username: "privateUserFollowedByJonParik",
          name: "Private User followed by Jon and Parik",
          bio: "I am a test Private user that is followed by Jon and Parik!",
          types: ["PRIVATE"],
          followedBy: {
            create: [
              {
                followerId: jonUser.id,
              },
              {
                followerId: parikUser.id,
              },
            ],
          },
          preferences: {
            create: {},
          },
        },
      });
      await prisma.spaceFilter.createMany({
        data: [{ spaceId: factiii.id, userId: janiceUser.id }],
      });
      const janicePostwithdrawn = await prisma.post.create({
        data: {
          userId: janiceUser.id,
          content: "removed post if you see this then it was not removed",
          reports: {
            create: {
              userId: jonUser.id,
              status: "CONTENT_REMOVED",
              comment: "this post is garbage",
              ruleId: 1,
              type: "POST",
            },
          },
        },
      });
      const paidSpace = await prisma.space.create({
        data: {
          slug: "paid",
          name: "paid",
          description:
            "This is a test private paid space. Janice is not invited so we can do tests to see if she can see it.",
          types: ["PRIVATE", "PAID"],
          members: {
            create: [
              { userId: jonUser.id, roles: ["OWNER"] },
              { userId: parikUser.id, roles: ["OWNER"] },
            ],
          },
          posts: {
            create: [
              {
                content: "private paid space post in s/paid",
                userId: jonUser.id,
              },
            ],
          },
        },
      });
      const paidAvatar = await prisma.upload.create({
        data: {
          userId: janiceUser.id,
          key: "static/paidAvatar.svg",
          type: "IMAGE",
        },
      });
      const paidBanner = await prisma.upload.create({
        data: {
          userId: janiceUser.id,
          key: "static/paidBanner.svg",
          type: "IMAGE",
        },
      });
      await prisma.space.update({
        where: {
          id: paidSpace.id,
        },
        data: {
          bannerId: paidBanner.id,
          avatarId: paidAvatar.id,
        },
      });
      const privateTestSpace = await prisma.space.create({
        data: {
          types: ["PRIVATE"],
          slug: "private-test",
          name: "Private Test",
          description:
            "This is a test private space. If you see me then something is broken. Janice loves this secret place.",
          members: {
            create: [{ userId: janiceUser.id, roles: ["MEMBER"] }],
          },
          posts: {
            create: [
              {
                content:
                  "Private post in s/private if you see me then something is broken.",
                userId: janiceUser.id,
              },
            ],
          },
        },
      });
      const privateFactiiiSpace = await prisma.space.create({
        data: {
          types: ["PRIVATE"],
          slug: stringToSlug("Private Factiii"),
          name: "Private Factiii",
          description:
            "This is a test private space. Janice is the owner and it holds private factiiis.",
          members: {
            create: [{ userId: janiceUser.id, roles: ["OWNER"] }],
          },
          factiiis: {
            create: [
              {
                types: ["PRIVATE"],
                slug: stringToSlug("Private Factiii"),
                name: "Private Factiii",
                description:
                  "Private factiii in s/private_Factiii if you see me then something is broken.",
                userId: janiceUser.id,
              },
              {
                slug: stringToSlug("Public Factiii"),
                name: "Public Factiii",
                description:
                  "Public factiii in a private space s/private_Factiii.",
                userId: janiceUser.id,
              },
            ],
          },
        },
        select: {
          id: true,
        },
      });
      const privateFactiii = await prisma.factiii.findUniqueOrThrow({
        where: {
          spaceId_userId_slug_requirements: {
            spaceId: privateFactiiiSpace.id,
            userId: janiceUser.id,
            slug: stringToSlug("Private Factiii"),
            requirements: ["NONE"],
          },
        },
        select: {
          id: true,
        },
      });
      const publicFactiii = await prisma.factiii.findUniqueOrThrow({
        where: {
          spaceId_userId_slug_requirements: {
            spaceId: privateFactiiiSpace.id,
            userId: janiceUser.id,
            slug: stringToSlug("Public Factiii"),
            requirements: ["NONE"],
          },
        },
        select: {
          id: true,
        },
      });
      await prisma.post.create({
        data: {
          userId: janiceUser.id,
          content:
            "Private post in s/private_Factiii with a private and public factiii attached. If you see me then something is broken.",
          spaceId: privateFactiiiSpace.id,
          factiiis: {
            create: [
              { factiiiId: privateFactiii.id, userId: janiceUser.id },
              { factiiiId: publicFactiii.id, userId: janiceUser.id },
            ],
          },
        },
      });
      const publicPost = await prisma.post.create({
        data: {
          userId: janiceUser.id,
          content:
            "Public post in s/factiii with a private and public factiii attached.",
          spaceId: factiii.id,
          factiiis: {
            create: [
              { factiiiId: privateFactiii.id, userId: janiceUser.id },
              { factiiiId: publicFactiii.id, userId: janiceUser.id },
            ],
          },
        },
      });
      await prisma.postFactiii.create({
        data: {
          postId: publicPost.id,
          factiiiId: anonymousSource.id,
          userId: janiceUser.id,
        },
      });
      const upload1 = await prisma.upload.create({
        data: { userId: janiceUser.id, key: "static/test1.jpg", type: "IMAGE" },
      });
      const upload2 = await prisma.upload.create({
        data: { userId: janiceUser.id, key: "static/test2.jpg", type: "IMAGE" },
      });
      const upload3 = await prisma.upload.create({
        data: { userId: janiceUser.id, key: "static/test3.jpg", type: "IMAGE" },
      });
      const upload4 = await prisma.upload.create({
        data: { userId: janiceUser.id, key: "static/test4.gif", type: "IMAGE" },
      });
      const upload5 = await prisma.upload.create({
        data: { userId: janiceUser.id, key: "static/test5.gif", type: "IMAGE" },
      });
      const upload6 = await prisma.upload.create({
        data: { userId: janiceUser.id, key: "static/test6.jpg", type: "IMAGE" },
      });
      const upload7 = await prisma.upload.create({
        data: { userId: janiceUser.id, key: "static/test7.mp4", type: "VIDEO" },
      });
      const upload8 = await prisma.upload.create({
        data: { userId: janiceUser.id, key: "static/test8.jpg", type: "IMAGE" },
      });
      const janicePost1 = await prisma.post.create({
        data: {
          userId: janiceUser.id,
          content: "Hi All! Post with 6 images and 15 awards!",
          uploads: {
            connect: [
              { id: upload1.id },
              { id: upload2.id },
              { id: upload3.id },
              { id: upload4.id },
              { id: upload5.id },
              { id: upload6.id },
            ],
          },
          awards: {
            create: [
              { userId: janiceUser.id, coinId: c10.id },
              { userId: janiceUser.id, coinId: c10.id },
              { userId: janiceUser.id, coinId: c10.id },
              { userId: janiceUser.id, coinId: c10.id },
              { userId: janiceUser.id, coinId: c10.id },
              { userId: janiceUser.id, coinId: c200.id },
              { userId: janiceUser.id, coinId: c200.id },
              { userId: janiceUser.id, coinId: c200.id },
              { userId: janiceUser.id, coinId: c200.id },
              { userId: janiceUser.id, coinId: c1000.id },
              { userId: janiceUser.id, coinId: c1000.id },
              { userId: janiceUser.id, coinId: c1000.id },
              { userId: janiceUser.id, coinId: c5000.id },
              { userId: janiceUser.id, coinId: c5000.id },
              { userId: janiceUser.id, coinId: c25000.id },
            ],
          },
        },
      });
      const janicePost2 = await prisma.post.create({
        data: {
          userId: janiceUser.id,
          content: "Post with 1920x1080 image.",
          uploads: {
            connect: [{ id: upload1.id }],
          },
        },
      });
      const janicePost3 = await prisma.post.create({
        data: {
          userId: janiceUser.id,
          content: "Post with very wide short image.",
          uploads: {
            connect: [{ id: upload2.id }],
          },
        },
      });
      const janicePost4 = await prisma.post.create({
        data: {
          userId: janiceUser.id,
          content: "Post with very tall thin image.",
          uploads: {
            connect: [{ id: upload3.id }],
          },
        },
      });
      const janicePostVideo = await prisma.post.create({
        data: {
          userId: janiceUser.id,
          content:
            "This is a fun video.\n\nVideo by KoolShooters: https://www.pexels.com/video/a-young-an-squeezing-an-orange-6975806",
          uploads: {
            connect: [{ id: upload7.id }],
          },
        },
      });
      const janicePostNsfw = await prisma.post.create({
        data: {
          uuid: "b87effd7-e13b-4c06-8765-2d377d9e115a",
          userId: janiceUser.id,
          content: "Very <c id=b>fucking</c> NSFW post by @janice78 .",
          factiiis: {
            create: {
              factiiiId: NSFW.id,
              userId: janiceUser.id,
            },
          },
          uploads: {
            connect: [{ id: upload8.id }],
          },
        },
      });
      const janiceAvatar = await prisma.upload.create({
        data: {
          userId: janiceUser.id,
          key: "static/janiceAvatar.jpg",
          type: "IMAGE",
        },
      });
      const janiceBanner = await prisma.upload.create({
        data: {
          userId: janiceUser.id,
          key: "static/janiceBanner.jpg",
          type: "IMAGE",
        },
      });
      await prisma.user.update({
        where: {
          id: janiceUser.id,
        },
        data: {
          bannerId: janiceBanner.id,
          avatarId: janiceAvatar.id,
        },
      });
      //TODO report random Avatars, Banners, and Bios
      log("calculating trendingRank and voteCounts");
      for (let postId of postIds) {
        const Upvotes = await prisma.vote.count({
          where: {
            postId: postId,
            type: "UPVOTE",
          },
        });
        const Downvotes = await prisma.vote.count({
          where: {
            postId: postId,
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
            voteCount: voteCount,
            trendingRank: generatePostRank(post.createdAt, voteCount),
          },
        });
      }

      await prisma.space.findFirst({
        where: {
          name: "Factiii",
        },
        select: {
          id: true,
        },
      });
      log("seeding the donation product");
      await prisma.product.create({
        data: {
          stripeProductId: "donation",
          appStoreProductId: "20200729_factiii_donation",
          playStoreProductId: "factiii_donation",
          type: "DONATION",
          title: "Donation to Factiii",
          description:
            "This is a donation to Factiii. Thank you for your support!",
          price: 0,
          active: true,
          spaceId: factiii.id,
        },
      });
      log("Seeding pagination test data");
      const pastDate = new Date(Date.now() - 1000 * 60 * 60 * 24 * 365 * 10); //10 years ago
      for (let i = 0; i < 55; i++) {
        // make paginated posts in wikipedia
        const date = new Date(
          Date.now() - 1000 * 60 * 60 * 24 * 365 * 10 + 1000 * i,
        ); //10 years ago plus 1 second for each post
        await prisma.post.create({
          data: {
            userId: wikiUser.id,
            content: "Post " + i.toString(),
            spaceId: wikipediaSpace.id,
            trendingRank: generatePostRank(date, 1),
            createdAt: date,
          },
        });
      }
      log(
        "banning user banned from all spaces and muting user muted by all users",
      );
      const spaces = await prisma.space.findMany({
        select: {
          id: true,
          name: true,
        },
      });
      const users = await prisma.user.findMany({
        select: {
          id: true,
          username: true,
        },
      });
      const posts = await prisma.post.findMany({
        select: {
          id: true,
        },
      });
      const follows = await prisma.follows.findMany({});
      for (const user of users) {
        //follow all user follows all users but himself
        if (user.id !== followAllUser.id) {
          await prisma.follows.create({
            data: {
              followerId: followAllUser.id,
              followingId: user.id,
            },
          });
        }
        //followed by all user is followed by all users but himself
        if (user.id !== followedByAllUser.id && user.id !== followAllUser.id) {
          await prisma.follows.create({
            data: {
              followerId: user.id,
              followingId: followedByAllUser.id,
            },
          });
        }
        //muted user is muted by all users but himself
        if (user.id !== mutedUser.id) {
          await prisma.userMute.create({
            data: {
              muterId: user.id,
              mutedUserId: mutedUser.id,
            },
          });
        }
        //blocked user is blocked by all users but himself
        if (user.id !== blockedUser.id) {
          await prisma.user.update({
            where: {
              id: user.id,
            },
            data: {
              blockedUsers: {
                connect: {
                  id: blockedUser.id,
                },
              },
            },
          });
        }
        //blockAll user blocks all users but himself
        if (user.id !== blockAllUser.id) {
          await prisma.user.update({
            where: {
              id: blockAllUser.id,
            },
            data: {
              blockedUsers: {
                connect: {
                  id: user.id,
                },
              },
            },
          });
        }
      }
      for (const space of spaces) {
        //ban banned user from all spaces
        await prisma.ban.create({
          data: {
            userId: bannedUser.id,
            spaceId: space.id,
            expiresAt: new Date(Date.now() + 1000 * 60 * 60 * 24 * 365 * 1), //1 year
          },
        });
        const date = new Date(Date.now() - 1000 * 60 * 60 * 24 * 365 * 11); //11 years ago
        //make a post for banned user in all spaces
        await prisma.post.create({
          data: {
            userId: bannedUser.id,
            content: "banned post in space: " + space.name,
            spaceId: space.id,
            createdAt: date,
            trendingRank: generatePostRank(date, 1),
          },
        });
        //muted user post in all spaces
        await prisma.post.create({
          data: {
            userId: mutedUser.id,
            content: "muted post in space: " + space.name,
            spaceId: space.id,
            createdAt: date,
            trendingRank: generatePostRank(date, 1),
          },
        });
        //blockedAll user post in all spaces
        await prisma.post.create({
          data: {
            userId: blockAllUser.id,
            content: "I blocked you post in space: " + space.name,
            spaceId: space.id,
            createdAt: date,
            trendingRank: generatePostRank(date, 1),
          },
        });
      }
      //banned user and muted user reply to all posts, yeah these people are super annoying
      for (const post of posts) {
        const date = new Date(Date.now() - 1000 * 60 * 60 * 24 * 365 * 12); //12 years ago
        await prisma.post.create({
          data: {
            userId: bannedUser.id,
            content: "banned reply to post",
            parentPostId: post.id,
            createdAt: date,
            trendingRank: generatePostRank(date, 1),
          },
        });
        await prisma.post.create({
          data: {
            userId: mutedUser.id,
            content: "muted reply to post",
            parentPostId: post.id,
            createdAt: date,
            trendingRank: generatePostRank(date, 1),
          },
        });
        await prisma.post.create({
          data: {
            userId: blockAllUser.id,
            content: "I blocked you and replied to your post",
            parentPostId: post.id,
            createdAt: date,
            trendingRank: generatePostRank(date, 1),
          },
        });
      }
    }
  }
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
