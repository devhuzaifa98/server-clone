import { Post, User, Model } from "@prisma/client"; //TODO get type Model to work properly
import { openai } from "../clients/openai";
import prisma from "../clients/prisma";
import AppError from "./AppError";
import { socket } from "../clients/socket";
import { returnPostObjectDto } from "../controllers/posts.controller";
import log from "../helpers/log";

const openaiError = async (post: Post, bot: any, req: any) => {
  await prisma.error.create({
    data: {
      ip: req.ip,
      userId: post.userId,
      description: "OpenAiReply creation failed",
    },
  });
  //Create post when OpenAI throws an error.
  return await prisma.post.create({
    data: {
      parentPostId: post.id,
      userId: bot.id,
      content:
        "OpenAI has experienced an error. Admin have been reported and you have not been charged.",
    },
  });
};

const generateAiReplyToPost = async (
  user: User, //user to be charged
  post: Post, //user post to reply to
  model: any, //model to be used
  botSettings: any,
  req: any,
  isPremiumUser: boolean,
) => {
  //TODO let user choose bot
  try {
    const bot = await prisma.user.findFirst({
      where: {
        username: "openai",
      },
      select: {
        id: true,
      },
    });
    if (!bot) {
      throw new AppError("Invalid Bot");
    }

    let language_setting;
    if (botSettings) {
      //Allows for user selected language_settings
      language_setting = {
        chosenMaxTokens: botSettings.chosenMaxTokens,
        temperature: (100 - botSettings.temperature) / 100, //users are shown accuracy and 100 accuracy = 0 temperature = most accurate reply
        n: 1,
      };
    } else {
      //Default language_settings temp of 0 gives most accurate results
      language_setting = {
        chosenMaxTokens: model.maxTokens,
        temperature: 0,
        n: 1,
      };
    }

    //Do checks first
    const requestRateLimit = await prisma.siteSettings.findFirst({
      where: {
        id: 1,
      },
      select: {
        requestRateLimit: true,
        openAiLimitPerHourPerUser: true,
        openAiLimitPremiumUser: true,
      },
      take: 1,
    });

    if (!requestRateLimit)
      throw new AppError(
        "An error occured while retreiving information. Try again.",
      );

    if (
      Number(model.cost) / requestRateLimit.requestRateLimit >
      user.tronsBalance
    ) {
      await prisma.error.create({
        data: {
          ip: req.ip,
          userId: user.id,
          description:
            "RAN OUT OF TRONS FRONT END FAILED model.cost/50:" +
            Number(model.cost) / 50 +
            ", user.tronsBalance: " +
            user.tronsBalance,
        },
      });

      await prisma.post.create({
        data: {
          parentPostId: post.id,
          userId: bot.id,
          content:
            "Sorry, I am unable to process that request since you are running low on your Trons balance. To continue, buy more tokens or receieve them as awards.",
        },
      });

      throw new AppError(
        "You have ran out of trons. You can earn more by receiving or buying tokens.",
      );
    }

    if (isPremiumUser && requestRateLimit.openAiLimitPremiumUser !== 0) {
      const openAiRepliesCount = await prisma.post.count({
        where: {
          user: {
            username: "openai",
          },
          parentPost: {
            userId: user.id,
          },
          createdAt: {
            gt: new Date(new Date().getTime() - 3600000).toISOString(),
          },
        },
      });

      if (openAiRepliesCount >= requestRateLimit.openAiLimitPremiumUser) {
        await prisma.post.create({
          data: {
            parentPostId: post.id,
            userId: bot.id,
            content:
              "You've already made too many requests in the past hour, please try again later.",
          },
        });

        throw new AppError(
          "You've already made too many requests in the past hour, please try again later.",
        );
      }
    }

    if (!isPremiumUser && requestRateLimit.openAiLimitPerHourPerUser !== 0) {
      const openAiRepliesCount = await prisma.post.count({
        where: {
          user: {
            username: "openai",
          },
          parentPost: {
            userId: user.id,
          },
          createdAt: {
            gt: new Date(new Date().getTime() - 3600000).toISOString(),
          },
        },
      });

      if (openAiRepliesCount >= requestRateLimit.openAiLimitPerHourPerUser) {
        await prisma.post.create({
          data: {
            parentPostId: post.id,
            userId: bot.id,
            content:
              "You've already made too many requests in the past hour, please try again later.",
          },
        });

        throw new AppError(
          "You've already made too many requests in the past hour, please try again later.",
        );
      }
    }

    const count = await prisma.post.count({
      where: {
        userId: bot.id,
        createdAt: {
          gt: new Date(new Date().getTime() - 300000).toISOString(),
        },
        parentPost: {
          userId: user.id,
        },
      },
    });
    if (count > 50) {
      await prisma.error.create({
        data: {
          ip: req.ip,
          userId: user.id,
          description: "Too many OpenAiReply Requests",
        },
      });
      throw new AppError(
        "You have made a lot of requests recently. Please take a break.",
      );
    }
    //Everything passed so make request to OpenAI
    let completion;
    try {
      completion = await openai.completions.create({
        model: model.query,
        prompt: post.content.replace("@openai", ""),
        temperature: language_setting.temperature,
        max_tokens: language_setting.chosenMaxTokens,
        n: language_setting.n,
        user: post.userId.toString(), //allows openAI to report abuse by specific users
      });
    } catch (error: any) {
      if (error.response) {
        openaiError;
      } else {
        openaiError;
      }
    }
    const replyContent = completion?.choices[0].text;

    if (!replyContent || !completion?.usage?.total_tokens) {
      throw new AppError("OpeanAI request failed. Please try again.");
    }
    //TODO test this is correct
    const usd = Math.ceil(
      (completion.usage.total_tokens / model.perTokens) * Number(model.cost),
    );
    await prisma.user.update({
      where: {
        id: user.id,
      },
      data: {
        tronsBalance: {
          decrement: usd,
        },
        costs: {
          create: {
            usd: usd,
            tokens: completion.usage.total_tokens,
            modelId: model.id,
          },
        },
      },
    });
    const botPost = await prisma.post.create({
      data: {
        parentPostId: post.id,
        userId: bot.id,
        content: replyContent
          .trim()
          .replace("\n", "<br/>")
          .trim()
          .replace("\n", "<br/>"),
      },
      select: {
        id: true,
      },
    });
    if (language_setting) {
      await prisma.postOpenAILanguageSetting.create({
        data: {
          postId: botPost.id,
          modelId: model.id,
          n: language_setting.n,
          chosenMaxTokens: language_setting.chosenMaxTokens,
          temperature: language_setting.temperature * 100,
        },
      });
    }

    const replyObjDto = await returnPostObjectDto(botPost.id, 0, [], [], []);

    socket.to(`post-${post.uuid}`).emit("openAiReply", post.id, replyObjDto);

    return botPost;
  } catch (error) {
    log("error", error as string);
  }
};

export default generateAiReplyToPost;
