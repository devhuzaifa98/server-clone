-- AlterTable
ALTER TABLE "Report" ADD COLUMN     "actionTakenById" INTEGER;

-- AddForeignKey
ALTER TABLE "Report" ADD CONSTRAINT "Report_actionTakenById_fkey" FOREIGN KEY ("actionTakenById") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
