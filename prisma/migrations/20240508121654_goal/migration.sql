-- CreateEnum
CREATE TYPE "FactiiiGoalType" AS ENUM ('DAILY', 'WEEKLY', 'MONTHLY', 'YEARLY');

-- CreateTable
CREATE TABLE "FactiiiGoal" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "data" TEXT NOT NULL,
    "type" "FactiiiGoalType" NOT NULL,
    "factiiiId" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "FactiiiGoal_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "FactiiiGoal" ADD CONSTRAINT "FactiiiGoal_factiiiId_fkey" FOREIGN KEY ("factiiiId") REFERENCES "Factiii"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FactiiiGoal" ADD CONSTRAINT "FactiiiGoal_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
