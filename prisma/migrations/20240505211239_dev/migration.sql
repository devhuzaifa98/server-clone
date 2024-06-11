/*
  Warnings:

  - The primary key for the `FactiiiPreferences` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `userId` on the `FactiiiPreferences` table. All the data in the column will be lost.
  - You are about to drop the `PostUpload` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `orderNumber` to the `FactiiiPreferences` table without a default value. This is not possible if the table is not empty.
  - Made the column `userPreferenceUserId` on table `FactiiiPreferences` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE "FactiiiPreferences" DROP CONSTRAINT "FactiiiPreferences_userId_fkey";

-- DropForeignKey
ALTER TABLE "FactiiiPreferences" DROP CONSTRAINT "FactiiiPreferences_userPreferenceUserId_fkey";

-- DropForeignKey
ALTER TABLE "PostUpload" DROP CONSTRAINT "PostUpload_postId_fkey";

-- DropForeignKey
ALTER TABLE "PostUpload" DROP CONSTRAINT "PostUpload_uploadId_fkey";

-- AlterTable
ALTER TABLE "FactiiiPreferences" DROP CONSTRAINT "FactiiiPreferences_pkey",
DROP COLUMN "userId",
ADD COLUMN     "orderNumber" INTEGER NOT NULL,
ALTER COLUMN "userPreferenceUserId" SET NOT NULL,
ADD CONSTRAINT "FactiiiPreferences_pkey" PRIMARY KEY ("factiiiId", "userPreferenceUserId");

-- DropTable
DROP TABLE "PostUpload";

-- CreateTable
CREATE TABLE "_postUploads" (
    "A" INTEGER NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_factiiiUploads" (
    "A" INTEGER NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_postUploads_AB_unique" ON "_postUploads"("A", "B");

-- CreateIndex
CREATE INDEX "_postUploads_B_index" ON "_postUploads"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_factiiiUploads_AB_unique" ON "_factiiiUploads"("A", "B");

-- CreateIndex
CREATE INDEX "_factiiiUploads_B_index" ON "_factiiiUploads"("B");

-- AddForeignKey
ALTER TABLE "FactiiiPreferences" ADD CONSTRAINT "FactiiiPreferences_userPreferenceUserId_fkey" FOREIGN KEY ("userPreferenceUserId") REFERENCES "UserPreference"("userId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_postUploads" ADD CONSTRAINT "_postUploads_A_fkey" FOREIGN KEY ("A") REFERENCES "Post"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_postUploads" ADD CONSTRAINT "_postUploads_B_fkey" FOREIGN KEY ("B") REFERENCES "Upload"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_factiiiUploads" ADD CONSTRAINT "_factiiiUploads_A_fkey" FOREIGN KEY ("A") REFERENCES "PostFactiii"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_factiiiUploads" ADD CONSTRAINT "_factiiiUploads_B_fkey" FOREIGN KEY ("B") REFERENCES "Upload"("id") ON DELETE CASCADE ON UPDATE CASCADE;
