-- AlterTable
ALTER TABLE "SiteSettings" ADD COLUMN     "openAiLimitPerHourPerUser" INTEGER NOT NULL DEFAULT 50,
ADD COLUMN     "openAiLimitPremiumUser" INTEGER NOT NULL DEFAULT 0;
