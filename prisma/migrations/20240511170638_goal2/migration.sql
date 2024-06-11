/*
  Warnings:

  - A unique constraint covering the columns `[factiiiId,userId,type]` on the table `FactiiiGoal` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "FactiiiGoal_factiiiId_userId_type_key" ON "FactiiiGoal"("factiiiId", "userId", "type");
