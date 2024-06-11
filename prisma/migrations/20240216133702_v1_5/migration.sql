-- AlterEnum
ALTER TYPE "FactiiiRequirement" ADD VALUE 'CAMERA';
ALTER TYPE "FactiiiRequirement" ADD VALUE 'DEVICE_LOCATION';
-- AlterEnum
ALTER TYPE "ReportType" ADD VALUE 'USER';
ALTER TYPE "ReportType" ADD VALUE 'SPACE';

-- DropForeignKeys
ALTER TABLE "Ban" DROP CONSTRAINT "Ban_spaceId_fkey";
ALTER TABLE "Coin" DROP CONSTRAINT "Coin_productId_fkey";
ALTER TABLE "Item" DROP CONSTRAINT "Item_productId_fkey";
ALTER TABLE "Notification" DROP CONSTRAINT "Notification_referencePostId_fkey";
ALTER TABLE "Post" DROP CONSTRAINT "Post_referencePostId_fkey";
ALTER TABLE "PostAward" DROP CONSTRAINT "PostAward_coinId_fkey";
ALTER TABLE "ReadMessage" DROP CONSTRAINT "ReadMessage_conversationId_fkey";
ALTER TABLE "ReadMessage" DROP CONSTRAINT "ReadMessage_messageId_fkey";
ALTER TABLE "ReadMessage" DROP CONSTRAINT "ReadMessage_userId_fkey";
ALTER TABLE "SpaceMember" DROP CONSTRAINT "SpaceMember_productId_fkey";
ALTER TABLE "Subscription" DROP CONSTRAINT "Subscription_productId_fkey";
ALTER TABLE "Upload" DROP CONSTRAINT "Upload_productId_fkey";
ALTER TABLE "_ExpoPushTokenToUser" DROP CONSTRAINT "_ExpoPushTokenToUser_A_fkey";
ALTER TABLE "_ExpoPushTokenToUser" DROP CONSTRAINT "_ExpoPushTokenToUser_B_fkey";

-- DropIndexes
DROP INDEX "Product_id_key";
DROP INDEX "Report_reportedPostId_status_ruleId_idx";

-- AlterTable
-- ALTER TABLE "Product" DROP CONSTRAINT "Product_pkey",
-- DROP COLUMN "saleTitle",
-- ADD COLUMN     "quantity" INTEGER NOT NULL DEFAULT -100,
-- ADD COLUMN     "stripeProductId" TEXT,
-- ADD COLUMN     "title" TEXT NOT NULL,
-- DROP COLUMN "id",
-- ADD COLUMN     "id" SERIAL NOT NULL,
-- ALTER COLUMN "price" SET DEFAULT 0,
-- ADD CONSTRAINT "Product_pkey" PRIMARY KEY ("id");
ALTER TABLE "Product"
    ADD COLUMN "stripeProductId" TEXT,
    ADD COLUMN "quantity" INTEGER NOT NULL DEFAULT -100,
    ALTER COLUMN "price" SET DEFAULT 0;
ALTER TABLE "Product" RENAME COLUMN "saleTitle" TO "title";
-- Copy data from old columns to new columns
UPDATE "Product"
    SET "stripeProductId" = "id";
-- Drop and recreate the primary key and columns
ALTER TABLE "Product"
    DROP CONSTRAINT "Product_pkey",
    DROP COLUMN "id",
    ADD COLUMN "id" SERIAL,
    ADD CONSTRAINT "Product_pkey" PRIMARY KEY ("id");
-- AlterTable
ALTER TABLE "Ban" ADD COLUMN     "expiresAt" TIMESTAMP(3) NOT NULL,
ALTER COLUMN "spaceId" SET NOT NULL;
-- AlterTable
-- ALTER TABLE "Coin" DROP CONSTRAINT "Coin_pkey",
-- DROP COLUMN "productId",
-- ADD COLUMN     "productId" INTEGER NOT NULL,
-- ADD CONSTRAINT "Coin_pkey" PRIMARY KEY ("productId");
-- Step 1: Add a temporary integer column to hold the new product IDs
ALTER TABLE "Coin"
    ADD COLUMN "newProductId" INTEGER;
-- Step 2: Populate the new column with the corresponding integer IDs from the Product table
UPDATE "Coin"
SET "newProductId" = (
    SELECT "id"
    FROM "Product"
    WHERE "Coin"."productId" = "Product"."stripeProductId"
);
-- Step 3: Drop the old productId column and the primary key constraint
ALTER TABLE "Coin"
    DROP COLUMN "productId";
    -- DROP CONSTRAINT "Coin_pkey";
-- Step 4: Rename the new column to productId and add the primary key constraint
ALTER TABLE "Coin" RENAME COLUMN "newProductId" TO "productId";
ALTER TABLE "Coin"
    ADD CONSTRAINT "Coin_pkey" PRIMARY KEY ("productId");
-- AlterTable
-- ALTER TABLE "Item" DROP COLUMN "productId",
-- ADD COLUMN     "productId" INTEGER NOT NULL;
-- Step 1: Add a temporary integer column to hold the new product IDs
ALTER TABLE "Item"
    ADD COLUMN "newProductId" INTEGER;
-- Step 2: Populate the new column with the corresponding integer IDs from the Product table
UPDATE "Item"
SET "newProductId" = (
    SELECT "id"
    FROM "Product"
    WHERE "Item"."productId" = "Product"."stripeProductId"
);
-- Step 3: Drop the old productId column
ALTER TABLE "Item"
    DROP COLUMN "productId";
-- Step 4: Rename the new column to productId
ALTER TABLE "Item"
    RENAME COLUMN "newProductId" TO "productId";
ALTER TABLE "Item" ALTER COLUMN "productId" SET NOT NULL;
-- AlterTable
-- ALTER TABLE "Notification" DROP COLUMN "referencePostId",
-- ADD COLUMN     "repostId" INTEGER;
ALTER TABLE "Notification"
    RENAME COLUMN "referencePostId" TO "repostId";
-- AlterTable
-- ALTER TABLE "Payment" DROP CONSTRAINT "Payment_pkey",
-- ADD COLUMN     "amount" INTEGER NOT NULL,
-- ADD COLUMN     "stripeSessionId" TEXT,
-- DROP COLUMN "id",
-- ADD COLUMN     "id" SERIAL NOT NULL,
-- ADD CONSTRAINT "Payment_pkey" PRIMARY KEY ("id");
ALTER TABLE "Payment"
    ADD COLUMN "stripeSessionId" TEXT,
    ADD COLUMN "amount" INTEGER,
    ADD COLUMN "tempId" SERIAL;
UPDATE "Payment"
    SET "stripeSessionId" = "id",
        "amount" = 0; -- Cannot be null as it did not exist before
ALTER TABLE "Payment" ALTER COLUMN "amount" SET NOT NULL;
ALTER TABLE "Payment"
    DROP CONSTRAINT IF EXISTS "Payment_pkey",
    DROP COLUMN "id";
ALTER TABLE "Payment" RENAME COLUMN "tempId" TO "id";
ALTER TABLE "Payment"
    ADD CONSTRAINT "Payment_pkey" PRIMARY KEY ("id");
-- AlterTable
ALTER TABLE "Post"
    RENAME COLUMN "referencePostId" TO "repostId";
ALTER TABLE "Post"
ADD COLUMN     "anonymous" BOOLEAN NOT NULL DEFAULT false;
-- AlterTable No Post has been awarded in Production yet :(
ALTER TABLE "PostAward" DROP COLUMN "coinId",
ADD COLUMN     "coinId" INTEGER NOT NULL;
-- AlterTable
ALTER TABLE "Report" ADD COLUMN     "reportedSpaceId" INTEGER,
ADD COLUMN     "reportedUserId" INTEGER;
-- AlterTable
ALTER TABLE "Session" ADD COLUMN     "deviceId" INTEGER,
ADD COLUMN     "socketId" TEXT,
ADD COLUMN     "twoFaSecret" TEXT;
-- AlterTable
-- ALTER TABLE "Space" DROP COLUMN "paidSpaceMonthlyPrice",
-- ADD COLUMN     "price" INTEGER NOT NULL DEFAULT 99;
ALTER TABLE "Space" RENAME COLUMN "paidSpaceMonthlyPrice" TO "price";
-- AlterTable
-- ALTER TABLE "SpaceMember" DROP COLUMN "productId",
-- ADD COLUMN     "productId" INTEGER;
ALTER TABLE "SpaceMember" ADD COLUMN "newProductId" INTEGER;
UPDATE "SpaceMember"
SET "newProductId" = (
    SELECT "id"
    FROM "Product"
    WHERE "Product"."stripeProductId" = "SpaceMember"."productId"
);
ALTER TABLE "SpaceMember" DROP COLUMN "productId";
ALTER TABLE "SpaceMember" RENAME COLUMN "newProductId" TO "productId";
-- AlterTable
-- ALTER TABLE "Subscription" DROP COLUMN "productId",
-- ADD COLUMN     "productId" INTEGER NOT NULL;
ALTER TABLE "Subscription" ADD COLUMN "newProductId" INTEGER;
UPDATE "Subscription"
SET "newProductId" = (
    SELECT "id"
    FROM "Product"
    WHERE "Product"."stripeProductId" = "Subscription"."productId"
);
ALTER TABLE "Subscription" DROP COLUMN "productId";
ALTER TABLE "Subscription" RENAME COLUMN "newProductId" TO "productId";
ALTER TABLE "Subscription" ALTER COLUMN "productId" SET NOT NULL;
-- AlterTable
-- ALTER TABLE "Upload" DROP COLUMN "productId",
-- ADD COLUMN     "productId" INTEGER;
ALTER TABLE "Upload" ADD COLUMN "newProductId" INTEGER;
UPDATE "Upload"
SET "newProductId" = (
    SELECT "id"
    FROM "Product"
    WHERE "Product"."stripeProductId" = "Upload"."productId"
);
ALTER TABLE "Upload" DROP COLUMN "productId";
ALTER TABLE "Upload" RENAME COLUMN "newProductId" TO "productId";
-- AlterTable
ALTER TABLE "User" DROP COLUMN "twoFaSecret",
ADD COLUMN     "twoFaEnabled" BOOLEAN NOT NULL DEFAULT false;

-- DropTables
DROP TABLE "ExpoPushToken";
DROP TABLE "ReadMessage";
DROP TABLE "_ExpoPushTokenToUser";

-- CreateTables
CREATE TABLE "Device" (
    "id" SERIAL NOT NULL,
    "pushToken" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Device_pkey" PRIMARY KEY ("id")
);
CREATE TABLE "ReadConversation" (
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "userId" INTEGER NOT NULL,
    "conversationId" TEXT NOT NULL,
    "lastReadMessageId" INTEGER,

    CONSTRAINT "ReadConversation_pkey" PRIMARY KEY ("userId","conversationId")
);
CREATE TABLE "_devices" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndexes
CREATE UNIQUE INDEX "Device_pushToken_key" ON "Device"("pushToken");
CREATE UNIQUE INDEX "_devices_AB_unique" ON "_devices"("A", "B");
CREATE INDEX "_devices_B_index" ON "_devices"("B");
CREATE UNIQUE INDEX "Payment_stripeSessionId_key" ON "Payment"("stripeSessionId");
CREATE INDEX "PostAward_postId_coinId_idx" ON "PostAward"("postId", "coinId");
CREATE UNIQUE INDEX "Product_spaceId_title_key" ON "Product"("spaceId", "title");
CREATE INDEX "Report_reportedPostId_reportedUserId_reportedSpaceId_status_idx" ON "Report"("reportedPostId", "reportedUserId", "reportedSpaceId", "status", "ruleId");
CREATE UNIQUE INDEX "Session_socketId_key" ON "Session"("socketId");
CREATE UNIQUE INDEX "Session_twoFaSecret_key" ON "Session"("twoFaSecret");

-- AddForeignKeys
ALTER TABLE "Session" ADD CONSTRAINT "Session_deviceId_fkey" FOREIGN KEY ("deviceId") REFERENCES "Device"("id") ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE "Upload" ADD CONSTRAINT "Upload_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Product"("id") ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE "Item" ADD CONSTRAINT "Item_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Product"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "Coin" ADD CONSTRAINT "Coin_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Product"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "Subscription" ADD CONSTRAINT "Subscription_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Product"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "Notification" ADD CONSTRAINT "Notification_repostId_fkey" FOREIGN KEY ("repostId") REFERENCES "Post"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "Post" ADD CONSTRAINT "Post_repostId_fkey" FOREIGN KEY ("repostId") REFERENCES "Post"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "PostAward" ADD CONSTRAINT "PostAward_coinId_fkey" FOREIGN KEY ("coinId") REFERENCES "Coin"("productId") ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE "Ban" ADD CONSTRAINT "Ban_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES "Space"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE "Report" ADD CONSTRAINT "Report_reportedUserId_fkey" FOREIGN KEY ("reportedUserId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "Report" ADD CONSTRAINT "Report_reportedSpaceId_fkey" FOREIGN KEY ("reportedSpaceId") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "ReadConversation" ADD CONSTRAINT "ReadConversation_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "ReadConversation" ADD CONSTRAINT "ReadConversation_conversationId_fkey" FOREIGN KEY ("conversationId") REFERENCES "Conversation"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "ReadConversation" ADD CONSTRAINT "ReadConversation_lastReadMessageId_fkey" FOREIGN KEY ("lastReadMessageId") REFERENCES "Message"("id") ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE "SpaceMember" ADD CONSTRAINT "SpaceMember_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Product"("id") ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE "_devices" ADD CONSTRAINT "_devices_A_fkey" FOREIGN KEY ("A") REFERENCES "Device"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "_devices" ADD CONSTRAINT "_devices_B_fkey" FOREIGN KEY ("B") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
