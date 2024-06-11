/*
  Warnings:

  - You are about to drop the column `expoPushTokens` on the `User` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "User" DROP COLUMN "expoPushTokens";

-- CreateTable
CREATE TABLE "ExpoPushToken" (
    "id" SERIAL NOT NULL,
    "token" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ExpoPushToken_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_ExpoPushTokenToUser" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "ExpoPushToken_token_key" ON "ExpoPushToken"("token");

-- CreateIndex
CREATE UNIQUE INDEX "_ExpoPushTokenToUser_AB_unique" ON "_ExpoPushTokenToUser"("A", "B");

-- CreateIndex
CREATE INDEX "_ExpoPushTokenToUser_B_index" ON "_ExpoPushTokenToUser"("B");

-- AddForeignKey
ALTER TABLE "_ExpoPushTokenToUser" ADD CONSTRAINT "_ExpoPushTokenToUser_A_fkey" FOREIGN KEY ("A") REFERENCES "ExpoPushToken"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ExpoPushTokenToUser" ADD CONSTRAINT "_ExpoPushTokenToUser_B_fkey" FOREIGN KEY ("B") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
