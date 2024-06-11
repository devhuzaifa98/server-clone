/*
  Warnings:

  - A unique constraint covering the columns `[spaceId,userId,slug,requirements]` on the table `Factiii` will be added. If there are existing duplicate values, this will fail.

*/
-- DropIndex
DROP INDEX "Factiii_spaceId_slug_idx";

-- DropIndex
DROP INDEX "Factiii_spaceId_slug_requirements_key";

-- DropIndex
DROP INDEX "Factiii_userId_slug_idx";

-- DropIndex
DROP INDEX "Factiii_userId_slug_requirements_key";

-- CreateIndex
CREATE UNIQUE INDEX "Factiii_spaceId_userId_slug_requirements_key" ON "Factiii"("spaceId", "userId", "slug", "requirements");
