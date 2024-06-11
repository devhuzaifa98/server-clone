/*
  Warnings:

  - You are about to drop the column `expires` on the `Ban` table. All the data in the column will be lost.

*/
-- AlterEnum
-- This migration adds more than one value to an enum.
-- With PostgreSQL versions 11 and earlier, this is not possible
-- in a single migration. This can be worked around by creating
-- multiple migrations, each migration adding only one value to
-- the enum.


ALTER TYPE "FactiiiRequirement" ADD VALUE 'NO_POST_DUPLICATES';
ALTER TYPE "FactiiiRequirement" ADD VALUE 'BUDGET';

-- AlterEnum
ALTER TYPE "ModelType" ADD VALUE 'WIKIPEDIA_SCRAPER';

-- AlterTable
ALTER TABLE "Ban" DROP COLUMN "expires";

-- AlterTable
ALTER TABLE "Factiii" ADD COLUMN     "data" TEXT;

-- AlterTable
ALTER TABLE "User" ALTER COLUMN "name" SET DEFAULT 'Factiii User';

-- AlterEnum
ALTER TYPE "UserTag" ADD VALUE 'WAITLIST';
