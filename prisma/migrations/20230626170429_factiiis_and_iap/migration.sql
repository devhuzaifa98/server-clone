/*
  Warnings:

  - The values [PRIVATE] on the enum `SpaceType` will be removed. If these variants are still used in the database, this will fail.
  - The primary key for the `Factiii` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `downFactiiiId` on the `Factiii` table. All the data in the column will be lost.
  - You are about to drop the column `eventId` on the `Factiii` table. All the data in the column will be lost.
  - You are about to drop the column `postId` on the `Factiii` table. All the data in the column will be lost.
  - You are about to drop the column `timestamp` on the `Factiii` table. All the data in the column will be lost.
  - You are about to drop the column `upFactiiiId` on the `Factiii` table. All the data in the column will be lost.
  - You are about to drop the column `total` on the `Order` table. All the data in the column will be lost.
  - You are about to drop the column `image` on the `Product` table. All the data in the column will be lost.
  - The primary key for the `Vote` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the `Event` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `EventVote` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Location` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `PostTag` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `PostTagType` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Ref` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Source` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `UserTag` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[spaceId,slug]` on the table `Factiii` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `slug` to the `Factiii` table without a default value. This is not possible if the table is not empty.
  - Added the required column `text` to the `Factiii` table without a default value. This is not possible if the table is not empty.
  - Added the required column `price` to the `Item` table without a default value. This is not possible if the table is not empty.
  - The required column `id` was added to the `Vote` table with a prisma-level default value. This is not possible if the table is not empty. Please add this column as optional, then populate it before making it required.

*/
-- DropTable
DROP TABLE "UserTag";

-- CreateEnum
CREATE TYPE "UserType" AS ENUM ('PUBLIC', 'PREMIUM', 'PAID', 'INVITE');

-- CreateEnum
CREATE TYPE "UserTag" AS ENUM ('HUMAN', 'BOT', 'GOVERNMENT', 'ACADEMIA', 'BUSINESS', 'NEW');

-- CreateEnum
CREATE TYPE "PostFactiiiStatus" AS ENUM ('PENDING', 'APPROVED', 'REJECTED', 'RETIRED');

-- CreateEnum
CREATE TYPE "FactiiiRequirement" AS ENUM ('MEDIA_REQUIRED', 'CONTENT_REQUIRED', 'HUMAN_SOURCE', 'GOVERNMENT_SOURCE', 'ENTERPRISE_SOURCE', 'ANONYMOUS_SOURCE', 'WIKI', 'DATA_REQUIRED', 'LOCATION_REQUIRED', 'TIME_REQUIRED', 'NONE');

-- CreateEnum
CREATE TYPE "FactiiiType" AS ENUM ('PUBLIC', 'PREMIUM', 'PAID', 'INVITE');

-- AlterEnum
ALTER TYPE "NotificationType" ADD VALUE 'SPACE_INVITES';

-- AlterEnum
-- This migration adds more than one value to an enum.
-- With PostgreSQL versions 11 and earlier, this is not possible
-- in a single migration. This can be worked around by creating
-- multiple migrations, each migration adding only one value to
-- the enum.


ALTER TYPE "PaymentType" ADD VALUE 'GOOGLE';
ALTER TYPE "PaymentType" ADD VALUE 'APPLE';

-- AlterEnum
ALTER TYPE "ProductType" ADD VALUE 'DONATION';

-- AlterEnum
BEGIN;
CREATE TYPE "SpaceType_new" AS ENUM ('PUBLIC', 'PREMIUM', 'PAID', 'INVITE');
ALTER TABLE "Space" ALTER COLUMN "types" DROP DEFAULT;
ALTER TABLE "Space" ALTER COLUMN "types" TYPE "SpaceType_new"[] USING ("types"::text::"SpaceType_new"[]);
ALTER TYPE "SpaceType" RENAME TO "SpaceType_old";
ALTER TYPE "SpaceType_new" RENAME TO "SpaceType";
DROP TYPE "SpaceType_old";
ALTER TABLE "Space" ALTER COLUMN "types" SET DEFAULT ARRAY['PUBLIC']::"SpaceType"[];
COMMIT;

-- AlterEnum
-- This migration adds more than one value to an enum.
-- With PostgreSQL versions 11 and earlier, this is not possible
-- in a single migration. This can be worked around by creating
-- multiple migrations, each migration adding only one value to
-- the enum.


ALTER TYPE "UploadStatus" ADD VALUE 'S3_MISSING';
ALTER TYPE "UploadStatus" ADD VALUE 'DB_MISSING';

-- DropForeignKey
ALTER TABLE "EventVote" DROP CONSTRAINT "EventVote_eventId_fkey";

-- DropForeignKey
ALTER TABLE "EventVote" DROP CONSTRAINT "EventVote_spaceId_fkey";

-- DropForeignKey
ALTER TABLE "Factiii" DROP CONSTRAINT "Factiii_downFactiiiId_fkey";

-- DropForeignKey
ALTER TABLE "Factiii" DROP CONSTRAINT "Factiii_eventId_fkey";

-- DropForeignKey
ALTER TABLE "Factiii" DROP CONSTRAINT "Factiii_postId_fkey";

-- DropForeignKey
ALTER TABLE "Factiii" DROP CONSTRAINT "Factiii_upFactiiiId_fkey";

-- DropForeignKey
ALTER TABLE "Location" DROP CONSTRAINT "Location_factiiiId_fkey";

-- DropForeignKey
ALTER TABLE "PostTag" DROP CONSTRAINT "PostTag_postId_fkey";

-- DropForeignKey
ALTER TABLE "PostTag" DROP CONSTRAINT "PostTag_spaceId_fkey";

-- DropForeignKey
ALTER TABLE "PostTag" DROP CONSTRAINT "PostTag_typeId_fkey";

-- DropForeignKey
ALTER TABLE "PostTag" DROP CONSTRAINT "PostTag_userId_fkey";

-- DropForeignKey
ALTER TABLE "PostTagType" DROP CONSTRAINT "PostTagType_spaceId_fkey";

-- DropForeignKey
ALTER TABLE "PostTagType" DROP CONSTRAINT "PostTagType_uploadId_fkey";

-- DropForeignKey
ALTER TABLE "PostTagType" DROP CONSTRAINT "PostTagType_userId_fkey";

-- DropForeignKey
ALTER TABLE "Ref" DROP CONSTRAINT "Ref_factiiiId_fkey";

-- DropForeignKey
ALTER TABLE "Ref" DROP CONSTRAINT "Ref_sourceId_fkey";

-- DropForeignKey
--ALTER TABLE "UserTag" DROP CONSTRAINT "UserTag_spaceId_fkey";

-- DropForeignKey
--ALTER TABLE "UserTag" DROP CONSTRAINT "UserTag_tagOwnerId_fkey";

-- DropForeignKey
--ALTER TABLE "UserTag" DROP CONSTRAINT "UserTag_userId_fkey";

-- DropIndex
DROP INDEX "Factiii_postId_key";

-- AlterTable
ALTER TABLE "Factiii" DROP CONSTRAINT "Factiii_pkey",
DROP COLUMN "downFactiiiId",
DROP COLUMN "eventId",
DROP COLUMN "postId",
DROP COLUMN "timestamp",
DROP COLUMN "upFactiiiId",
ADD COLUMN     "avatarId" TEXT,
ADD COLUMN     "bannerId" TEXT,
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "description" TEXT,
ADD COLUMN     "id" SERIAL NOT NULL,
ADD COLUMN     "requirements" "FactiiiRequirement"[] DEFAULT ARRAY['NONE']::"FactiiiRequirement"[],
ADD COLUMN     "slug" TEXT NOT NULL,
ADD COLUMN     "text" TEXT NOT NULL,
ADD COLUMN     "types" "FactiiiType"[] DEFAULT ARRAY['PUBLIC']::"FactiiiType"[],
ADD CONSTRAINT "Factiii_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "Item" ADD COLUMN     "price" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "Notification" ADD COLUMN     "referenceSpaceId" INTEGER;

-- AlterTable
ALTER TABLE "Order" DROP COLUMN "total";

-- AlterTable
ALTER TABLE "Product" DROP COLUMN "image";

-- AlterTable
ALTER TABLE "Rule" ADD COLUMN     "edited" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "factiiiId" INTEGER;

-- AlterTable
ALTER TABLE "Space" ADD COLUMN     "paidSpaceMonthlyPrice" INTEGER NOT NULL DEFAULT 99;

-- AlterTable
ALTER TABLE "Upload" ADD COLUMN     "productId" TEXT;

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "tag" "UserTag" NOT NULL DEFAULT 'NEW',
ADD COLUMN     "types" "UserType"[] DEFAULT ARRAY['PUBLIC']::"UserType"[];

-- AlterTable
ALTER TABLE "Vote" DROP CONSTRAINT "Vote_pkey",
ADD COLUMN     "id" TEXT NOT NULL,
ALTER COLUMN "postId" DROP NOT NULL,
ADD CONSTRAINT "Vote_pkey" PRIMARY KEY ("id");

-- DropTable
DROP TABLE "Event";

-- DropTable
DROP TABLE "EventVote";

-- DropTable
DROP TABLE "Location";

-- DropTable
DROP TABLE "PostTag";

-- DropTable
DROP TABLE "PostTagType";

-- DropTable
DROP TABLE "Ref";

-- DropTable
DROP TABLE "Source";

-- DropEnum
DROP TYPE "EventType";

-- DropEnum
DROP TYPE "EventVoted";

-- DropEnum
DROP TYPE "FactiiiStatus";

-- DropEnum
DROP TYPE "SourceType";

-- DropEnum
DROP TYPE "UserTagType";

-- CreateTable
CREATE TABLE "SpaceInvite" (
    "spaceId" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL,
    "inviterId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "joined" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "SpaceInvite_pkey" PRIMARY KEY ("spaceId","userId")
);

-- CreateTable
CREATE TABLE "SpaceRuleEditHistory" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "ruleId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "SpaceRuleEditHistory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PostFactiii" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "anonymous" BOOLEAN NOT NULL DEFAULT false,
    "status" "PostFactiiiStatus" NOT NULL DEFAULT 'APPROVED',
    "data" TEXT,
    "postId" TEXT NOT NULL,
    "factiiiId" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "PostFactiii_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SpaceTime" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "timestamp" TIMESTAMP(3),
    "latitude" DOUBLE PRECISION,
    "longitude" DOUBLE PRECISION,
    "display" TEXT,
    "altitude" INTEGER,
    "postFactiiiId" INTEGER NOT NULL,

    CONSTRAINT "SpaceTime_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_ReferencesPostFactiii" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "PostFactiii_postId_factiiiId_userId_key" ON "PostFactiii"("postId", "factiiiId", "userId");

-- CreateIndex
CREATE UNIQUE INDEX "_ReferencesPostFactiii_AB_unique" ON "_ReferencesPostFactiii"("A", "B");

-- CreateIndex
CREATE INDEX "_ReferencesPostFactiii_B_index" ON "_ReferencesPostFactiii"("B");

-- CreateIndex
CREATE UNIQUE INDEX "Factiii_spaceId_slug_key" ON "Factiii"("spaceId", "slug");

-- AddForeignKey
ALTER TABLE "Upload" ADD CONSTRAINT "Upload_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Product"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notification" ADD CONSTRAINT "Notification_referenceSpaceId_fkey" FOREIGN KEY ("referenceSpaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Rule" ADD CONSTRAINT "Rule_factiiiId_fkey" FOREIGN KEY ("factiiiId") REFERENCES "Factiii"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SpaceInvite" ADD CONSTRAINT "SpaceInvite_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SpaceInvite" ADD CONSTRAINT "SpaceInvite_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SpaceInvite" ADD CONSTRAINT "SpaceInvite_inviterId_fkey" FOREIGN KEY ("inviterId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SpaceRuleEditHistory" ADD CONSTRAINT "SpaceRuleEditHistory_ruleId_fkey" FOREIGN KEY ("ruleId") REFERENCES "Rule"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PostFactiii" ADD CONSTRAINT "PostFactiii_postId_fkey" FOREIGN KEY ("postId") REFERENCES "Post"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PostFactiii" ADD CONSTRAINT "PostFactiii_factiiiId_fkey" FOREIGN KEY ("factiiiId") REFERENCES "Factiii"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PostFactiii" ADD CONSTRAINT "PostFactiii_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SpaceTime" ADD CONSTRAINT "SpaceTime_postFactiiiId_fkey" FOREIGN KEY ("postFactiiiId") REFERENCES "PostFactiii"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Factiii" ADD CONSTRAINT "Factiii_avatarId_fkey" FOREIGN KEY ("avatarId") REFERENCES "Upload"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Factiii" ADD CONSTRAINT "Factiii_bannerId_fkey" FOREIGN KEY ("bannerId") REFERENCES "Upload"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ReferencesPostFactiii" ADD CONSTRAINT "_ReferencesPostFactiii_A_fkey" FOREIGN KEY ("A") REFERENCES "PostFactiii"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ReferencesPostFactiii" ADD CONSTRAINT "_ReferencesPostFactiii_B_fkey" FOREIGN KEY ("B") REFERENCES "PostFactiii"("id") ON DELETE CASCADE ON UPDATE CASCADE;