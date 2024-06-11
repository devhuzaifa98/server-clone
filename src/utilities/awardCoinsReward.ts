import prisma from "../clients/prisma";

/**
 *
 * @param userId the ID of the user to whom to reward
 * @param rewardId the ID of the CoinReward which is being given
 * @param quantity the quantity of coins to give
 * @returns true if successful
 */
const awardCoinsReward = async (userId: number, reward: string) => {
  const checkReward = await prisma.coinRewardItem.findFirst({
    where: {
      slug: reward,
    },
    select: {
      id: true,
      quantity: true,
    },
  });

  if (!checkReward) return Promise.reject("The reward ID provided was invalid");

  const checkHistory = await prisma.userCoinReward.count({
    where: {
      rewardId: checkReward.id,
      userId,
    },
  });

  if (checkHistory === 0) {
    await prisma.user.update({
      where: {
        id: userId,
      },
      data: {
        coinsBalance: {
          increment: checkReward.quantity,
        },
      },
    });
    await prisma.userCoinReward.create({
      data: {
        rewardId: checkReward.id,
        userId,
      },
    });
  }

  return true;
};

export default awardCoinsReward;
