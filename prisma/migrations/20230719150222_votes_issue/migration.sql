/*
  Warnings:

  - The primary key for the `Vote` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `Vote` table. All the data in the column will be lost.
  - Made the column `postId` on table `Vote` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "Vote" DROP CONSTRAINT "Vote_pkey",
DROP COLUMN "id",
ALTER COLUMN "postId" SET NOT NULL,
ADD CONSTRAINT "Vote_pkey" PRIMARY KEY ("postId", "userId");
