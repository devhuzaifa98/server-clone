/*
  Warnings:

  - The `referencePostId` column on the `Notification` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The primary key for the `Post` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The `id` column on the `Post` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `parentPostId` column on the `Post` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `referencePostId` column on the `Post` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `reportedPostId` column on the `Report` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The primary key for the `SavedPost` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The `pinnedPostId` column on the `Space` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `pinnedPostId` column on the `User` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The primary key for the `Vote` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - A unique constraint covering the columns `[spaceId,slug]` on the table `Factiii` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[userId,slug]` on the table `Factiii` will be added. If there are existing duplicate values, this will fail.
  - Changed the type of `postId` on the `PostAward` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `postId` on the `PostEditHistory` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `postId` on the `PostFactiii` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `postId` on the `PostOpenAILanguageSetting` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `postId` on the `PostUpload` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `postId` on the `SavedPost` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `postId` on the `Vote` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `B` on the `_BanReasonToPost` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - A unique constraint covering the columns `[uuid]` on the table `Post` will be added. If there are existing duplicate values, this will fail.
  - Commands to update the database:
npx prisma generate --schema=./prisma/oldSchema.prisma //puts the old schema in the node_modules folder so cli can run
ts-node db check //checks the db for any issues
ts-node db fix //fixes the db
npx prisma migrate deploy //deploys the new schema
npx prisma generate //regenerates the new schema
*/

-- DropForeignKeys
ALTER TABLE "Notification" DROP CONSTRAINT "Notification_referencePostId_fkey";
ALTER TABLE "Post" DROP CONSTRAINT "Post_parentPostId_fkey";
ALTER TABLE "Post" DROP CONSTRAINT "Post_referencePostId_fkey";
ALTER TABLE "PostAward" DROP CONSTRAINT "PostAward_postId_fkey";
ALTER TABLE "PostEditHistory" DROP CONSTRAINT "PostEditHistory_postId_fkey";
ALTER TABLE "PostFactiii" DROP CONSTRAINT "PostFactiii_postId_fkey";
ALTER TABLE "PostOpenAILanguageSetting" DROP CONSTRAINT "PostOpenAILanguageSetting_postId_fkey";
ALTER TABLE "PostUpload" DROP CONSTRAINT "PostUpload_postId_fkey";
ALTER TABLE "Report" DROP CONSTRAINT "Report_reportedPostId_fkey";
ALTER TABLE "SavedPost" DROP CONSTRAINT "SavedPost_postId_fkey";
ALTER TABLE "Space" DROP CONSTRAINT "Space_pinnedPostId_fkey";
ALTER TABLE "User" DROP CONSTRAINT "User_pinnedPostId_fkey";
ALTER TABLE "Vote" DROP CONSTRAINT "Vote_postId_fkey";
ALTER TABLE "_BanReasonToPost" DROP CONSTRAINT "_BanReasonToPost_B_fkey";

-- DropConstraints
ALTER TABLE "Post" DROP CONSTRAINT "Post_pkey";
ALTER TABLE "SavedPost" DROP CONSTRAINT "SavedPost_pkey";
ALTER TABLE "Vote" DROP CONSTRAINT "Vote_pkey";

-- DropIndex
DROP INDEX "Factiii_spaceId_slug_userId_key";

-- Update Post table to new schema
-- 1. Add a new uuid column with default UUID values
ALTER TABLE "Post" ADD COLUMN "uuid" UUID NOT NULL DEFAULT gen_random_uuid();
-- 2. Copy values from id to uuid
UPDATE "Post" SET "uuid" = "id"::UUID;
-- 3. Drop the old id column
ALTER TABLE "Post" DROP COLUMN "id";
-- 4. Add a new id column of type SERIAL
ALTER TABLE "Post" ADD COLUMN "id" SERIAL;
-- 5. Populate the new id column with sequential integers for existing rows
UPDATE "Post" SET "id" = nextval(pg_get_serial_sequence('"Post"', 'id'));

-- Add the newParentPostId column
ALTER TABLE "Post" ADD COLUMN "newParentPostId" INTEGER;
-- Populate newParentPostId with the corresponding id values based on the parentPostId's uuid
UPDATE "Post" AS child
SET "newParentPostId" = parent."id"
FROM "Post" AS parent
WHERE child."parentPostId"::UUID = parent."uuid";
-- Drop the old parentPostId column
ALTER TABLE "Post" DROP COLUMN "parentPostId";
-- Rename the newParentPostId column to parentPostId
ALTER TABLE "Post" RENAME COLUMN "newParentPostId" TO "parentPostId";

-- Add the newReferencePostId column
ALTER TABLE "Post" ADD COLUMN "newReferencePostId" INTEGER;
-- Populate newReferencePostId with the corresponding id values based on the referencePostId's uuid
UPDATE "Post" AS child
SET "newReferencePostId" = parent."id"
FROM "Post" AS parent
WHERE child."referencePostId"::UUID = parent."uuid";
-- Drop the old referencePostId column
ALTER TABLE "Post" DROP COLUMN "referencePostId";
-- Rename the newReferencePostId column to referencePostId
ALTER TABLE "Post" RENAME COLUMN "newReferencePostId" TO "referencePostId";

-- AlterTable template for the Notification table
-- 1. Add the newReferencePostId column to Notification table
ALTER TABLE "Notification" ADD COLUMN "newReferencePostId" INTEGER;
-- 2. Populate newReferencePostId with the corresponding id values from the Post table based on the referencePostId's uuid
UPDATE "Notification" AS n
SET "newReferencePostId" = p."id"
FROM "Post" AS p
WHERE n."referencePostId"::UUID = p."uuid";
-- 3. Drop the old referencePostId column from Notification table
ALTER TABLE "Notification" DROP COLUMN "referencePostId";
-- 4. Rename the newReferencePostId column to referencePostId in Notification table
ALTER TABLE "Notification" RENAME COLUMN "newReferencePostId" TO "referencePostId";

-- For the PostAward table
ALTER TABLE "PostAward" ADD COLUMN "newPostId" INTEGER;
UPDATE "PostAward" pa
SET "newPostId" = p."id"
FROM "Post" p
WHERE pa."postId"::UUID = p."uuid";
ALTER TABLE "PostAward" DROP COLUMN "postId";
ALTER TABLE "PostAward" RENAME COLUMN "newPostId" TO "postId";

-- For the PostEditHistory table
ALTER TABLE "PostEditHistory" ADD COLUMN "newPostId" INTEGER;
UPDATE "PostEditHistory" peh
SET "newPostId" = p."id"
FROM "Post" p
WHERE peh."postId"::UUID = p."uuid";
ALTER TABLE "PostEditHistory" DROP COLUMN "postId";
ALTER TABLE "PostEditHistory" RENAME COLUMN "newPostId" TO "postId";

-- For the PostFactiii table
ALTER TABLE "PostFactiii" ADD COLUMN "newPostId" INTEGER;
UPDATE "PostFactiii" pf
SET "newPostId" = p."id"
FROM "Post" p
WHERE pf."postId"::UUID = p."uuid";
ALTER TABLE "PostFactiii" DROP COLUMN "postId";
ALTER TABLE "PostFactiii" RENAME COLUMN "newPostId" TO "postId";

-- For the PostOpenAILanguageSetting table
ALTER TABLE "PostOpenAILanguageSetting" ADD COLUMN "newPostId" INTEGER;
UPDATE "PostOpenAILanguageSetting" pols
SET "newPostId" = p."id"
FROM "Post" p
WHERE pols."postId"::UUID = p."uuid";
ALTER TABLE "PostOpenAILanguageSetting" DROP COLUMN "postId";
ALTER TABLE "PostOpenAILanguageSetting" RENAME COLUMN "newPostId" TO "postId";

-- For the PostUpload table
ALTER TABLE "PostUpload" ADD COLUMN "newPostId" INTEGER;
UPDATE "PostUpload" pu
SET "newPostId" = p."id"
FROM "Post" p
WHERE pu."postId"::UUID = p."uuid";
ALTER TABLE "PostUpload" DROP COLUMN "postId";
ALTER TABLE "PostUpload" RENAME COLUMN "newPostId" TO "postId";

-- For the Report table
ALTER TABLE "Report" ADD COLUMN "newReportedPostId" INTEGER;
UPDATE "Report" r
SET "newReportedPostId" = p."id"
FROM "Post" p
WHERE r."reportedPostId"::UUID = p."uuid";
ALTER TABLE "Report" DROP COLUMN "reportedPostId";
ALTER TABLE "Report" RENAME COLUMN "newReportedPostId" TO "reportedPostId";

-- For the SavedPost table
ALTER TABLE "SavedPost" ADD COLUMN "newPostId" INTEGER;
UPDATE "SavedPost" sp
SET "newPostId" = p."id"
FROM "Post" p
WHERE sp."postId"::UUID = p."uuid";
ALTER TABLE "SavedPost" DROP COLUMN "postId";
ALTER TABLE "SavedPost" RENAME COLUMN "newPostId" TO "postId";

-- For the Space table
ALTER TABLE "Space" ADD COLUMN "newPinnedPostId" INTEGER;
UPDATE "Space" s
SET "newPinnedPostId" = p."id"
FROM "Post" p
WHERE s."pinnedPostId"::UUID = p."uuid";
ALTER TABLE "Space" DROP COLUMN "pinnedPostId";
ALTER TABLE "Space" RENAME COLUMN "newPinnedPostId" TO "pinnedPostId";

-- For the User table
ALTER TABLE "User" ADD COLUMN "newPinnedPostId" INTEGER;
UPDATE "User" u
SET "newPinnedPostId" = p."id"
FROM "Post" p
WHERE u."pinnedPostId"::UUID = p."uuid";
ALTER TABLE "User" DROP COLUMN "pinnedPostId";
ALTER TABLE "User" RENAME COLUMN "newPinnedPostId" TO "pinnedPostId";

-- For the Vote table
ALTER TABLE "Vote" ADD COLUMN "newPostId" INTEGER;
UPDATE "Vote" v
SET "newPostId" = p."id"
FROM "Post" p
WHERE v."postId"::UUID = p."uuid";
ALTER TABLE "Vote" DROP COLUMN "postId";
ALTER TABLE "Vote" RENAME COLUMN "newPostId" TO "postId";

-- For the _BanReasonToPost table
ALTER TABLE "_BanReasonToPost" ADD COLUMN "newB" INTEGER;
UPDATE "_BanReasonToPost" brtp
SET "newB" = p."id"
FROM "Post" p
WHERE brtp."B"::UUID = p."uuid";
ALTER TABLE "_BanReasonToPost" DROP COLUMN "B";
ALTER TABLE "_BanReasonToPost" RENAME COLUMN "newB" TO "B";

-- AddConstraints
ALTER TABLE "Post" ADD CONSTRAINT "Post_pkey" PRIMARY KEY ("id");
ALTER TABLE "SavedPost" ADD CONSTRAINT "SavedPost_pkey" PRIMARY KEY ("userId", "postId");
ALTER TABLE "Vote" ADD CONSTRAINT "Vote_pkey" PRIMARY KEY ("postId", "userId");
CREATE UNIQUE INDEX "Post_uuid_key" ON "Post"("uuid");

-- AddForeignKeys
ALTER TABLE "User" ADD CONSTRAINT "User_pinnedPostId_fkey" FOREIGN KEY ("pinnedPostId") REFERENCES "Post"("id") ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE "PostOpenAILanguageSetting" ADD CONSTRAINT "PostOpenAILanguageSetting_postId_fkey" FOREIGN KEY ("postId") REFERENCES "Post"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE "Notification" ADD CONSTRAINT "Notification_referencePostId_fkey" FOREIGN KEY ("referencePostId") REFERENCES "Post"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "Post" ADD CONSTRAINT "Post_parentPostId_fkey" FOREIGN KEY ("parentPostId") REFERENCES "Post"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "Post" ADD CONSTRAINT "Post_referencePostId_fkey" FOREIGN KEY ("referencePostId") REFERENCES "Post"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "PostUpload" ADD CONSTRAINT "PostUpload_postId_fkey" FOREIGN KEY ("postId") REFERENCES "Post"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "Vote" ADD CONSTRAINT "Vote_postId_fkey" FOREIGN KEY ("postId") REFERENCES "Post"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "SavedPost" ADD CONSTRAINT "SavedPost_postId_fkey" FOREIGN KEY ("postId") REFERENCES "Post"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "PostAward" ADD CONSTRAINT "PostAward_postId_fkey" FOREIGN KEY ("postId") REFERENCES "Post"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE "Report" ADD CONSTRAINT "Report_reportedPostId_fkey" FOREIGN KEY ("reportedPostId") REFERENCES "Post"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "PostEditHistory" ADD CONSTRAINT "PostEditHistory_postId_fkey" FOREIGN KEY ("postId") REFERENCES "Post"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "Space" ADD CONSTRAINT "Space_pinnedPostId_fkey" FOREIGN KEY ("pinnedPostId") REFERENCES "Post"("id") ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE "PostFactiii" ADD CONSTRAINT "PostFactiii_postId_fkey" FOREIGN KEY ("postId") REFERENCES "Post"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "_BanReasonToPost" ADD CONSTRAINT "_BanReasonToPost_B_fkey" FOREIGN KEY ("B") REFERENCES "Post"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- Add ReportType
ALTER TYPE "ReportType" ADD VALUE 'FACTIII';

-- Set NOT NULLs
ALTER TABLE "PostAward" ALTER COLUMN "postId" SET NOT NULL;
ALTER TABLE "PostEditHistory" ALTER COLUMN "postId" SET NOT NULL;
ALTER TABLE "PostFactiii" ALTER COLUMN "postId" SET NOT NULL;
ALTER TABLE "PostOpenAILanguageSetting" ALTER COLUMN "postId" SET NOT NULL;
ALTER TABLE "PostUpload" ALTER COLUMN "postId" SET NOT NULL;
ALTER TABLE "_BanReasonToPost" ALTER COLUMN "B" SET NOT NULL;

-- CreateIndexes
CREATE INDEX "Factiii_spaceId_slug_idx" ON "Factiii"("spaceId", "slug");
CREATE INDEX "Factiii_userId_slug_idx" ON "Factiii"("userId", "slug");
CREATE UNIQUE INDEX "Factiii_spaceId_slug_key" ON "Factiii"("spaceId", "slug");
CREATE UNIQUE INDEX "Factiii_userId_slug_key" ON "Factiii"("userId", "slug");
CREATE INDEX "History_userId_column_idx" ON "History"("userId", "column");
CREATE INDEX "Post_spaceId_status_idx" ON "Post"("spaceId", "status");
CREATE INDEX "Post_parentPostId_idx" ON "Post"("parentPostId");
CREATE INDEX "Post_userId_idx" ON "Post"("userId");
CREATE INDEX "Post_uuid_idx" ON "Post"("uuid");
CREATE INDEX "Post_trendingRank_idx" ON "Post"("trendingRank");
CREATE INDEX "Post_createdAt_idx" ON "Post"("createdAt");
CREATE INDEX "Post_voteCount_idx" ON "Post"("voteCount");
CREATE INDEX "PostAward_postId_userId_idx" ON "PostAward"("postId", "userId");
CREATE INDEX "PostAward_postId_coinId_idx" ON "PostAward"("postId", "coinId");
CREATE INDEX "PostAward_userId_idx" ON "PostAward"("userId");
CREATE INDEX "PostFactiii_factiiiId_userId_status_idx" ON "PostFactiii"("factiiiId", "userId", "status");
CREATE UNIQUE INDEX "PostFactiii_postId_factiiiId_userId_key" ON "PostFactiii"("postId", "factiiiId", "userId");
CREATE INDEX "PostUpload_postId_idx" ON "PostUpload"("postId");
CREATE INDEX "Report_reportedPostId_status_ruleId_idx" ON "Report"("reportedPostId", "status", "ruleId");
CREATE INDEX "idx_space_types" ON "Space"("types");
CREATE INDEX "Space_slug_idx" ON "Space"("slug");
CREATE INDEX "idx_space_member_user_id" ON "SpaceMember"("userId", "spaceId");
CREATE INDEX "SpaceTime_postFactiiiId_idx" ON "SpaceTime"("postFactiiiId");
CREATE INDEX "User_status_idx" ON "User"("status");
CREATE INDEX "User_username_idx" ON "User"("username");
CREATE INDEX "UserMute_mutedUserId_idx" ON "UserMute"("mutedUserId");
CREATE UNIQUE INDEX "_BanReasonToPost_AB_unique" ON "_BanReasonToPost"("A", "B");
CREATE INDEX "_BanReasonToPost_B_index" ON "_BanReasonToPost"("B");