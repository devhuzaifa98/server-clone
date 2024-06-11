-- CreateEnum
CREATE TYPE "SpaceMemberRoles" AS ENUM ('OWNER', 'MODERATOR', 'MEMBER');

-- CreateEnum
CREATE TYPE "SpaceType" AS ENUM ('PUBLIC', 'PREMIUM', 'PAID', 'INVITE', 'PRIVATE');

-- CreateEnum
CREATE TYPE "SpaceStatus" AS ENUM ('ACTIVE', 'DELISTED', 'BANNED');

-- AlterTable
ALTER TABLE "Ban" ADD COLUMN     "spaceId" INTEGER;

-- AlterTable
ALTER TABLE "EventVote" ADD COLUMN     "spaceId" INTEGER;

-- AlterTable
ALTER TABLE "Factiii" ADD COLUMN     "spaceId" INTEGER;

-- AlterTable
ALTER TABLE "Post" ADD COLUMN     "spaceId" INTEGER;

-- AlterTable
ALTER TABLE "PostTag" ADD COLUMN     "spaceId" INTEGER;

-- AlterTable
ALTER TABLE "PostTagType" ADD COLUMN     "spaceId" INTEGER;

-- AlterTable
ALTER TABLE "Product" ADD COLUMN     "spaceId" INTEGER;

-- AlterTable
ALTER TABLE "Rule" ADD COLUMN     "spaceId" INTEGER;

-- AlterTable
ALTER TABLE "UserTag" ADD COLUMN     "spaceId" INTEGER;

-- CreateTable
CREATE TABLE "SpaceMember" (
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expires" TIMESTAMP(3),
    "userId" INTEGER NOT NULL,
    "spaceId" INTEGER NOT NULL,
    "productId" TEXT,
    "roles" "CommunityMemberRoles"[] DEFAULT ARRAY['MEMBER']::"CommunityMemberRoles"[],
    "subscriptionId" TEXT,

    CONSTRAINT "SpaceMember_pkey" PRIMARY KEY ("userId","spaceId")
);

-- CreateTable
CREATE TABLE "Space" (
    "id" SERIAL NOT NULL,
    "slug" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "types" "SpaceType"[] DEFAULT ARRAY['PUBLIC']::"SpaceType"[],
    "avatarId" TEXT,
    "bannerId" TEXT,
    "pinnedPostId" TEXT,
    "robohash" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "status" "SpaceStatus" NOT NULL DEFAULT 'ACTIVE',

    CONSTRAINT "Space_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SpaceFilter" (
    "spaceId" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "SpaceFilter_pkey" PRIMARY KEY ("spaceId","userId")
);

-- CreateIndex
CREATE UNIQUE INDEX "Space_slug_key" ON "Space"("slug");

-- AddForeignKey
ALTER TABLE "UserTag" ADD CONSTRAINT "UserTag_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PostTagType" ADD CONSTRAINT "PostTagType_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PostTag" ADD CONSTRAINT "PostTag_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Product" ADD CONSTRAINT "Product_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Post" ADD CONSTRAINT "Post_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Rule" ADD CONSTRAINT "Rule_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Ban" ADD CONSTRAINT "Ban_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EventVote" ADD CONSTRAINT "EventVote_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Factiii" ADD CONSTRAINT "Factiii_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SpaceMember" ADD CONSTRAINT "SpaceMember_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SpaceMember" ADD CONSTRAINT "SpaceMember_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SpaceMember" ADD CONSTRAINT "SpaceMember_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Product"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SpaceMember" ADD CONSTRAINT "SpaceMember_subscriptionId_fkey" FOREIGN KEY ("subscriptionId") REFERENCES "Subscription"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Space" ADD CONSTRAINT "Space_avatarId_fkey" FOREIGN KEY ("avatarId") REFERENCES "Upload"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Space" ADD CONSTRAINT "Space_bannerId_fkey" FOREIGN KEY ("bannerId") REFERENCES "Upload"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Space" ADD CONSTRAINT "Space_pinnedPostId_fkey" FOREIGN KEY ("pinnedPostId") REFERENCES "Post"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SpaceFilter" ADD CONSTRAINT "SpaceFilter_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SpaceFilter" ADD CONSTRAINT "SpaceFilter_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
