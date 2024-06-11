/*
  Warnings:

  - You are about to drop the column `text` on the `Factiii` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[spaceId,slug,userId]` on the table `Factiii` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[identifier]` on the table `Subscription` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `name` to the `Factiii` table without a default value. This is not possible if the table is not empty.
  - The required column `identifier` was added to the `Subscription` table with a prisma-level default value. This is not possible if the table is not empty. Please add this column as optional, then populate it before making it required.

*/
-- CreateEnum
CREATE TYPE "FactiiiStatus" AS ENUM ('PENDING', 'APPROVED', 'REJECTED', 'RETIRED');

-- DropIndex
DROP INDEX "Factiii_spaceId_slug_key";

-- AlterTable
ALTER TABLE "Factiii"
ADD COLUMN     "status" "FactiiiStatus" NOT NULL DEFAULT 'APPROVED';

ALTER TABLE "Factiii"
RENAME COLUMN text TO name;

-- AlterTable
ALTER TABLE "Subscription" ADD COLUMN     "identifier" TEXT NOT NULL,
ALTER COLUMN "nextPayment" DROP NOT NULL;

-- CreateTable
CREATE TABLE "FactiiiPreferences" (
    "factiiiId" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL,
    "userPreferenceUserId" INTEGER,

    CONSTRAINT "FactiiiPreferences_pkey" PRIMARY KEY ("factiiiId","userId")
);

-- CreateIndex
CREATE UNIQUE INDEX "Factiii_spaceId_slug_userId_key" ON "Factiii"("spaceId", "slug", "userId");

-- CreateIndex
CREATE UNIQUE INDEX "Subscription_identifier_key" ON "Subscription"("identifier");

-- AddForeignKey
ALTER TABLE "FactiiiPreferences" ADD CONSTRAINT "FactiiiPreferences_factiiiId_fkey" FOREIGN KEY ("factiiiId") REFERENCES "Factiii"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FactiiiPreferences" ADD CONSTRAINT "FactiiiPreferences_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FactiiiPreferences" ADD CONSTRAINT "FactiiiPreferences_userPreferenceUserId_fkey" FOREIGN KEY ("userPreferenceUserId") REFERENCES "UserPreference"("userId") ON DELETE SET NULL ON UPDATE CASCADE;
