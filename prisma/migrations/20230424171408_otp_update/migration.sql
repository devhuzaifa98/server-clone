/*
  Warnings:

  - You are about to drop the column `expiredAt` on the `OTPBasedLogin` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "OTPBasedLogin" DROP COLUMN "expiredAt",
ADD COLUMN     "disabled" BOOLEAN NOT NULL DEFAULT false;
