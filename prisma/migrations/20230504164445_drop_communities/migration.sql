/*
  Warnings:

  - You are about to drop the column `communityId` on the `Ban` table. All the data in the column will be lost.
  - The primary key for the `EventVote` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `communityId` on the `EventVote` table. All the data in the column will be lost.
  - You are about to drop the column `communityId` on the `Factiii` table. All the data in the column will be lost.
  - You are about to drop the column `communityId` on the `Post` table. All the data in the column will be lost.
  - You are about to drop the column `communityId` on the `PostTag` table. All the data in the column will be lost.
  - You are about to drop the column `communityId` on the `PostTagType` table. All the data in the column will be lost.
  - You are about to drop the column `communityId` on the `Product` table. All the data in the column will be lost.
  - You are about to drop the column `communityId` on the `Rule` table. All the data in the column will be lost.
  - You are about to drop the column `maxCommunitiesPerUser` on the `SiteSettings` table. All the data in the column will be lost.
  - The `roles` column on the `SpaceMember` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - You are about to drop the column `communityMemberCommunityId` on the `Subscription` table. All the data in the column will be lost.
  - You are about to drop the column `communityMemberUserId` on the `Subscription` table. All the data in the column will be lost.
  - You are about to drop the column `communityId` on the `UserTag` table. All the data in the column will be lost.
  - You are about to drop the `Community` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `CommunityFilter` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `CommunityMember` table. If the table is not empty, all the data it contains will be lost.
  - Made the column `spaceId` on table `EventVote` required. This step will fail if there are existing NULL values in that column.
  - Made the column `spaceId` on table `Rule` required. This step will fail if there are existing NULL values in that column.
  - Added the required column `maxSpacesPerUser` to the `SiteSettings` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Ban" DROP CONSTRAINT "Ban_communityId_fkey";

-- DropForeignKey
ALTER TABLE "Community" DROP CONSTRAINT "Community_avatarId_fkey";

-- DropForeignKey
ALTER TABLE "Community" DROP CONSTRAINT "Community_bannerId_fkey";

-- DropForeignKey
ALTER TABLE "Community" DROP CONSTRAINT "Community_pinnedPostId_fkey";

-- DropForeignKey
ALTER TABLE "CommunityFilter" DROP CONSTRAINT "CommunityFilter_communityId_fkey";

-- DropForeignKey
ALTER TABLE "CommunityFilter" DROP CONSTRAINT "CommunityFilter_userId_fkey";

-- DropForeignKey
ALTER TABLE "CommunityMember" DROP CONSTRAINT "CommunityMember_communityId_fkey";

-- DropForeignKey
ALTER TABLE "CommunityMember" DROP CONSTRAINT "CommunityMember_productId_fkey";

-- DropForeignKey
ALTER TABLE "CommunityMember" DROP CONSTRAINT "CommunityMember_userId_fkey";

-- DropForeignKey
ALTER TABLE "EventVote" DROP CONSTRAINT "EventVote_communityId_fkey";

-- DropForeignKey
ALTER TABLE "EventVote" DROP CONSTRAINT "EventVote_spaceId_fkey";

-- DropForeignKey
ALTER TABLE "Factiii" DROP CONSTRAINT "Factiii_communityId_fkey";

-- DropForeignKey
ALTER TABLE "Post" DROP CONSTRAINT "Post_communityId_fkey";

-- DropForeignKey
ALTER TABLE "Post" DROP CONSTRAINT "Post_spaceId_fkey";

-- DropForeignKey
ALTER TABLE "PostTag" DROP CONSTRAINT "PostTag_communityId_fkey";

-- DropForeignKey
ALTER TABLE "PostTagType" DROP CONSTRAINT "PostTagType_communityId_fkey";

-- DropForeignKey
ALTER TABLE "Product" DROP CONSTRAINT "Product_communityId_fkey";

-- DropForeignKey
ALTER TABLE "Rule" DROP CONSTRAINT "Rule_communityId_fkey";

-- DropForeignKey
ALTER TABLE "Rule" DROP CONSTRAINT "Rule_spaceId_fkey";

-- DropForeignKey
ALTER TABLE "Subscription" DROP CONSTRAINT "Subscription_communityMemberUserId_communityMemberCommunit_fkey";

-- DropForeignKey
ALTER TABLE "UserTag" DROP CONSTRAINT "UserTag_communityId_fkey";

-- DropIndex
DROP INDEX "Subscription_communityMemberUserId_communityMemberCommunity_key";

-- AlterTable
ALTER TABLE "Ban" DROP COLUMN "communityId";

-- AlterTable
ALTER TABLE "EventVote" DROP CONSTRAINT "EventVote_pkey",
DROP COLUMN "communityId",
ALTER COLUMN "spaceId" SET NOT NULL,
ADD CONSTRAINT "EventVote_pkey" PRIMARY KEY ("eventId", "spaceId");

-- AlterTable
ALTER TABLE "Factiii" DROP COLUMN "communityId";

-- AlterTable
ALTER TABLE "Post" DROP COLUMN "communityId";

-- AlterTable
ALTER TABLE "PostTag" DROP COLUMN "communityId";

-- AlterTable
ALTER TABLE "PostTagType" DROP COLUMN "communityId";

-- AlterTable
ALTER TABLE "Product" DROP COLUMN "communityId";

-- AlterTable
ALTER TABLE "Rule" DROP COLUMN "communityId",
ALTER COLUMN "spaceId" SET NOT NULL;

-- AlterTable
ALTER TABLE "SiteSettings" DROP COLUMN "maxCommunitiesPerUser",
ADD COLUMN     "maxSpacesPerUser" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "SpaceMember" DROP COLUMN "roles",
ADD COLUMN     "roles" "SpaceMemberRoles"[] DEFAULT ARRAY['MEMBER']::"SpaceMemberRoles"[];

-- AlterTable
ALTER TABLE "Subscription" DROP COLUMN "communityMemberCommunityId",
DROP COLUMN "communityMemberUserId";

-- AlterTable
ALTER TABLE "UserTag" DROP COLUMN "communityId";

-- DropTable
DROP TABLE "Community";

-- DropTable
DROP TABLE "CommunityFilter";

-- DropTable
DROP TABLE "CommunityMember";

-- DropEnum
DROP TYPE "CommunityMemberRoles";

-- DropEnum
DROP TYPE "CommunityStatus";

-- DropEnum
DROP TYPE "CommunityType";

-- AddForeignKey
ALTER TABLE "Post" ADD CONSTRAINT "Post_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Rule" ADD CONSTRAINT "Rule_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EventVote" ADD CONSTRAINT "EventVote_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
