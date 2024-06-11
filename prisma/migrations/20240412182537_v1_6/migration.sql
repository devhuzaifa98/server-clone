-- CreateEnum
CREATE TYPE "EmailVerificationStatus" AS ENUM ('UNVERIFIED', 'PENDING', 'VERIFIED');
CREATE TYPE "BotType" AS ENUM ('OPENAI_LANGUAGE', 'OPENAI_IMAGE', 'OPENAI_EMBEDDING', 'OPENAI_FINE_TUNED', 'WIKIPEDIA_SCRAPER');
CREATE TYPE "ScrapeStatus" AS ENUM ('PENDING', 'COMPLETED', 'FAILED');

-- AlterEnum
ALTER TYPE "FactiiiRequirement" ADD VALUE 'DISAPPEARING_DATA';

--Consider all DELISTED as DELETED
UPDATE "Post" SET status = 'DELETED' WHERE status = 'DELISTED';


-- AlterEnum
-- BEGIN;
CREATE TYPE "PostStatus_new" AS ENUM ('PUBLISHED', 'PRIVATE', 'DELETED', 'DRAFT');
ALTER TABLE "Post" ALTER COLUMN "status" DROP DEFAULT;
ALTER TABLE "Post" ALTER COLUMN "status" TYPE "PostStatus_new" USING ("status"::text::"PostStatus_new");
ALTER TYPE "PostStatus" RENAME TO "PostStatus_old";
ALTER TYPE "PostStatus_new" RENAME TO "PostStatus";
DROP TYPE "PostStatus_old";
ALTER TABLE "Post" ALTER COLUMN "status" SET DEFAULT 'PUBLISHED';
COMMIT;

-- AlterEnum
-- BEGIN;
CREATE TYPE "SpaceStatus_new" AS ENUM ('ACTIVE', 'BANNED');
ALTER TABLE "Space" ALTER COLUMN "status" DROP DEFAULT;
ALTER TABLE "Space" ALTER COLUMN "status" TYPE "SpaceStatus_new" USING ("status"::text::"SpaceStatus_new");
ALTER TYPE "SpaceStatus" RENAME TO "SpaceStatus_old";
ALTER TYPE "SpaceStatus_new" RENAME TO "SpaceStatus";
DROP TYPE "SpaceStatus_old";
ALTER TABLE "Space" ALTER COLUMN "status" SET DEFAULT 'ACTIVE';
COMMIT;

-- AlterEnum
-- BEGIN;
CREATE TYPE "UploadStatus_new" AS ENUM ('PUBLISHED', 'DELETED', 'S3_MISSING', 'DB_MISSING');
ALTER TABLE "Upload" ALTER COLUMN "status" DROP DEFAULT;
ALTER TABLE "Upload" ALTER COLUMN "status" TYPE "UploadStatus_new" USING ("status"::text::"UploadStatus_new");
ALTER TYPE "UploadStatus" RENAME TO "UploadStatus_old";
ALTER TYPE "UploadStatus_new" RENAME TO "UploadStatus";
DROP TYPE "UploadStatus_old";
ALTER TABLE "Upload" ALTER COLUMN "status" SET DEFAULT 'PUBLISHED';
COMMIT;

-- DropForeignKey
ALTER TABLE "Factiii" DROP CONSTRAINT "Factiii_spaceMemberUserId_spaceMemberSpaceId_fkey";
ALTER TABLE "UserCoinReward" DROP CONSTRAINT "UserCoinReward_rewardId_fkey";
DROP INDEX "Factiii_spaceId_slug_key";

-- DropIndex
DROP INDEX "Factiii_userId_slug_key";

-- AlterTable
ALTER TABLE "BotSetting" DROP COLUMN "api",
ADD COLUMN     "enabled" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "rootUrl" TEXT,
ADD COLUMN     "scrapesPerDay" INTEGER NOT NULL DEFAULT 10,
DROP COLUMN "types",
ADD COLUMN     "types" "BotType"[];

-- AlterTable
ALTER TABLE "CoinRewardItem" DROP CONSTRAINT "CoinRewardItem_pkey",
ADD COLUMN     "slug" TEXT NOT NULL,
DROP COLUMN "id",
ADD COLUMN     "id" SERIAL NOT NULL,
ADD CONSTRAINT "CoinRewardItem_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "Factiii" DROP COLUMN "spaceMemberSpaceId",
DROP COLUMN "spaceMemberUserId";

-- -- AlterTable
-- ALTER TABLE "Model" DROP COLUMN "type",
-- ADD COLUMN     "type" "BotType" NOT NULL;
ALTER TABLE "Model" ADD COLUMN "temp_type" "BotType";
UPDATE "Model"
SET "temp_type" = CASE
    WHEN "type" = 'OPENAI_LANGUAGE' THEN 'OPENAI_LANGUAGE'::"BotType"
    WHEN "type" = 'OPENAI_IMAGE' THEN 'OPENAI_IMAGE'::"BotType"
    WHEN "type" = 'OPENAI_EMBEDDING' THEN 'OPENAI_EMBEDDING'::"BotType"
    WHEN "type" = 'OPENAI_FINE_TUNED' THEN 'OPENAI_FINE_TUNED'::"BotType"
    ELSE NULL -- Handle unmapped or unexpected values appropriately
END;
ALTER TABLE "Model" DROP COLUMN "type";
ALTER TABLE "Model" RENAME COLUMN "temp_type" TO "type";
ALTER TABLE "Model" ALTER COLUMN "type" SET NOT NULL;
DROP TYPE "ModelType";


-- AlterTable
ALTER TABLE "SpaceMember" DROP CONSTRAINT "SpaceMember_pkey",
ADD COLUMN     "id" SERIAL NOT NULL,
ADD CONSTRAINT "SpaceMember_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "emailVerificationStatus" "EmailVerificationStatus" NOT NULL DEFAULT 'UNVERIFIED',
ADD COLUMN     "otpForEmailVerification" TEXT;

-- AlterTable
ALTER TABLE "UserCoinReward" DROP CONSTRAINT "UserCoinReward_pkey",
DROP COLUMN "id",
ADD COLUMN     "id" SERIAL NOT NULL,
DROP COLUMN "rewardId",
ADD COLUMN     "rewardId" INTEGER NOT NULL,
ADD CONSTRAINT "UserCoinReward_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "UserPreference" ADD COLUMN     "privatePinnedFactiiis" BOOLEAN NOT NULL DEFAULT true;

-- -- DropEnum
-- DROP TYPE "ModelType";

-- CreateTable
CREATE TABLE "Scrape" (
    "id" SERIAL NOT NULL,
    "plannedAt" TIMESTAMP(3) NOT NULL,
    "url" TEXT NOT NULL,
    "status" "ScrapeStatus" NOT NULL DEFAULT 'PENDING',
    "userId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Scrape_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_pinnedSpaceMemberFactiiis" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_pinnedSpaceMemberFactiiis_AB_unique" ON "_pinnedSpaceMemberFactiiis"("A", "B");
CREATE INDEX "_pinnedSpaceMemberFactiiis_B_index" ON "_pinnedSpaceMemberFactiiis"("B");
CREATE UNIQUE INDEX "CoinRewardItem_slug_key" ON "CoinRewardItem"("slug");
CREATE UNIQUE INDEX "Factiii_spaceId_slug_requirements_key" ON "Factiii"("spaceId", "slug", "requirements");
CREATE UNIQUE INDEX "Factiii_userId_slug_requirements_key" ON "Factiii"("userId", "slug", "requirements");
CREATE UNIQUE INDEX "SpaceMember_userId_spaceId_key" ON "SpaceMember"("userId", "spaceId");
CREATE UNIQUE INDEX "Rule_factiiiId_spaceId_key" ON "Rule"("factiiiId", "spaceId");
CREATE UNIQUE INDEX "Rule_title_spaceId_key" ON "Rule"("title", "spaceId");

-- AddForeignKey
ALTER TABLE "UserCoinReward" ADD CONSTRAINT "UserCoinReward_rewardId_fkey" FOREIGN KEY ("rewardId") REFERENCES "CoinRewardItem"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE "Scrape" ADD CONSTRAINT "Scrape_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "_pinnedSpaceMemberFactiiis" ADD CONSTRAINT "_pinnedSpaceMemberFactiiis_A_fkey" FOREIGN KEY ("A") REFERENCES "Factiii"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "_pinnedSpaceMemberFactiiis" ADD CONSTRAINT "_pinnedSpaceMemberFactiiis_B_fkey" FOREIGN KEY ("B") REFERENCES "SpaceMember"("id") ON DELETE CASCADE ON UPDATE CASCADE;
