-- CreateTable
CREATE TABLE "CoinRewardItem" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "description" TEXT NOT NULL,
    "expiresAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "CoinRewardItem_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserCoinReward" (
    "id" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    "rewardId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "UserCoinReward_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "UserCoinReward" ADD CONSTRAINT "UserCoinReward_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserCoinReward" ADD CONSTRAINT "UserCoinReward_rewardId_fkey" FOREIGN KEY ("rewardId") REFERENCES "CoinRewardItem"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
