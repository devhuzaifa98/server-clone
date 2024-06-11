-- DropForeignKey
ALTER TABLE "Rule" DROP CONSTRAINT "Rule_spaceId_fkey";

-- AlterTable
ALTER TABLE "Rule" ALTER COLUMN "spaceId" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "Rule" ADD CONSTRAINT "Rule_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE SET NULL ON UPDATE CASCADE;
