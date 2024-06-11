-- AlterEnum
-- BEGIN;
-- CREATE TYPE "ProductType_new" AS ENUM ('COIN', 'MONTHLY_SUBSCRIPTION', 'FOUNDERS_TOKEN', 'DONATION');
-- ALTER TABLE "Product" ALTER COLUMN "type" TYPE "ProductType_new" USING ("type"::text::"ProductType_new");
-- ALTER TYPE "ProductType" RENAME TO "ProductType_old";
-- ALTER TYPE "ProductType_new" RENAME TO "ProductType";
-- DROP TYPE "ProductType_old";
-- COMMIT;
BEGIN;
ALTER TYPE "ProductType" RENAME VALUE 'LIFETIME_PREMIUM' TO 'FOUNDERS_TOKEN';
COMMIT;

-- AlterEnum
ALTER TYPE "SpaceMemberRoles" ADD VALUE 'FORMER_MEMBER';

-- DropForeignKey
ALTER TABLE "Payment" DROP CONSTRAINT "Payment_subscriptionId_fkey";
ALTER TABLE "SpaceMember" DROP CONSTRAINT "SpaceMember_productId_fkey";
ALTER TABLE "SpaceMember" DROP CONSTRAINT "SpaceMember_subscriptionId_fkey";

-- DropIndex
DROP INDEX "Payment_paymentIntent_key";
DROP INDEX "Payment_stripeSessionId_key";
DROP INDEX "Product_spaceId_title_key";
DROP INDEX "Subscription_id_key";
DROP INDEX "Subscription_identifier_key";

-- AlterTable
ALTER TABLE "Item" ALTER COLUMN "discount" DROP DEFAULT;

-- AlterTable
-- ALTER TABLE "Order" ADD COLUMN     "total" INTEGER NOT NULL;
-- AlterTable
ALTER TABLE "Order" ADD COLUMN "total" INTEGER;
UPDATE "Order" SET "total" = 0 WHERE "total" IS NULL;
ALTER TABLE "Order" ALTER COLUMN "total" SET NOT NULL;

--Set all payment intents to TEMP1, TEMP2, TEMP3, etc
DO $$
DECLARE
    counter INTEGER := 1;
    record RECORD;
BEGIN
    FOR record IN SELECT id FROM "Payment" WHERE "paymentIntent" IS NULL ORDER BY id
    LOOP
        EXECUTE 'UPDATE "Payment" SET "paymentIntent" = ''TEMP' || counter || ''' WHERE id = ' || record.id;
        counter := counter + 1;
    END LOOP;
END $$;
-- AlterTable
ALTER TABLE "Payment" DROP COLUMN "stripeSessionId",
DROP COLUMN "subscriptionId",
ADD COLUMN     "paymentMethod" TEXT,
ALTER COLUMN "paymentIntent" SET NOT NULL;

-- AlterTable
-- ALTER TABLE "Product" DROP COLUMN "originalDisplayPrice",
-- DROP COLUMN "quantity",
-- ADD COLUMN     "description" TEXT NOT NULL,
-- ADD COLUMN     "discount" INTEGER NOT NULL DEFAULT 0,
-- ADD COLUMN     "inventory" INTEGER NOT NULL DEFAULT -100,
-- ALTER COLUMN "price" DROP DEFAULT,
-- ALTER COLUMN "spaceId" SET NOT NULL;
ALTER TABLE "Product" RENAME COLUMN "quantity" TO "inventory";
ALTER TABLE "Product" DROP COLUMN "originalDisplayPrice";
ALTER TABLE "Product" ADD COLUMN "description" TEXT;
ALTER TABLE "Product" ADD COLUMN "discount" INTEGER NOT NULL DEFAULT 0;
ALTER TABLE "Product" ALTER COLUMN "inventory" TYPE INTEGER;
ALTER TABLE "Product" ALTER COLUMN "inventory" SET NOT NULL;
ALTER TABLE "Product" ALTER COLUMN "inventory" SET DEFAULT -100;
ALTER TABLE "Product" ALTER COLUMN "price" DROP DEFAULT;
UPDATE "Product" SET "spaceId" = 1 WHERE "spaceId" IS NULL;
ALTER TABLE "Product" ALTER COLUMN "spaceId" SET NOT NULL;

-- Update the title in the Product table based on the awardTitle in the Coin table
UPDATE "Product"
SET "title" = (
    SELECT "awardTitle"
    FROM "Coin"
    WHERE "Coin"."productId" = "Product"."id"
);
-- AlterTable
ALTER TABLE "Coin" DROP COLUMN "awardTitle";

-- AlterTable
ALTER TABLE "Factiii" ADD COLUMN     "spaceMemberSpaceId" INTEGER,
ADD COLUMN     "spaceMemberUserId" INTEGER;

-- AlterTable
ALTER TABLE "Space" DROP COLUMN "price";

-- AlterTable
-- ALTER TABLE "SpaceMember" DROP COLUMN "expires",
-- DROP COLUMN "productId",
-- ADD COLUMN     "premiumAccessExpires" TIMESTAMP(3),
-- DROP COLUMN "subscriptionId",
-- ADD COLUMN     "subscriptionId" INTEGER;
ALTER TABLE "SpaceMember" RENAME COLUMN "expires" TO "premiumAccessExpires";
ALTER TABLE "SpaceMember"
    DROP COLUMN "productId",
    DROP COLUMN "subscriptionId",
    ADD COLUMN "subscriptionId" INTEGER;

-- AlterTable
ALTER TABLE "Subscription" DROP CONSTRAINT "Subscription_pkey",
DROP COLUMN "active",
DROP COLUMN "identifier",
ADD COLUMN     "expires" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "subscriptionId" TEXT NOT NULL,
ADD COLUMN     "type" "PaymentType" NOT NULL,
DROP COLUMN "id",
ADD COLUMN     "id" SERIAL NOT NULL,
ADD CONSTRAINT "Subscription_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "lastActive" TIMESTAMP(3),
ADD COLUMN     "stripeCustomerId" TEXT;

-- CreateTable
CREATE TABLE "_pinnedUserFactiiis" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "_pinnedSpaceFactiiis" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- Remove duplicate appStoreProductId values
-- Deletes duplicated appStoreProductId values
UPDATE "Product" SET "appStoreProductId" = NULL
WHERE "appStoreProductId" IN (
    SELECT "appStoreProductId"
    FROM "Product"
    GROUP BY "appStoreProductId"
    HAVING COUNT(*) > 1
);

-- Remove duplicate playStoreProductId values
-- Deletes duplicated playStoreProductId values
UPDATE "Product" SET "playStoreProductId" = NULL
WHERE "playStoreProductId" IN (
    SELECT "playStoreProductId"
    FROM "Product"
    GROUP BY "playStoreProductId"
    HAVING COUNT(*) > 1
);

-- Remove duplicate stripeProductId values
-- Deletes duplicated stripeProductId values
UPDATE "Product" SET "stripeProductId" = NULL
WHERE "stripeProductId" IN (
    SELECT "stripeProductId"
    FROM "Product"
    GROUP BY "stripeProductId"
    HAVING COUNT(*) > 1
);

-- CreateIndex
CREATE UNIQUE INDEX "Payment_paymentIntent_type_key" ON "Payment"("paymentIntent", "type");
CREATE UNIQUE INDEX "Product_appStoreProductId_key" ON "Product"("appStoreProductId");
CREATE UNIQUE INDEX "Product_playStoreProductId_key" ON "Product"("playStoreProductId");
CREATE UNIQUE INDEX "Product_stripeProductId_key" ON "Product"("stripeProductId");
CREATE UNIQUE INDEX "SpaceMember_subscriptionId_key" ON "SpaceMember"("subscriptionId");
CREATE UNIQUE INDEX "Subscription_subscriptionId_type_key" ON "Subscription"("subscriptionId", "type");
CREATE UNIQUE INDEX "User_stripeCustomerId_key" ON "User"("stripeCustomerId");

CREATE UNIQUE INDEX "_pinnedUserFactiiis_AB_unique" ON "_pinnedUserFactiiis"("A", "B");
CREATE INDEX "_pinnedUserFactiiis_B_index" ON "_pinnedUserFactiiis"("B");
CREATE UNIQUE INDEX "_pinnedSpaceFactiiis_AB_unique" ON "_pinnedSpaceFactiiis"("A", "B");
CREATE INDEX "_pinnedSpaceFactiiis_B_index" ON "_pinnedSpaceFactiiis"("B");
ALTER TABLE "Factiii" ADD CONSTRAINT "Factiii_spaceMemberUserId_spaceMemberSpaceId_fkey" FOREIGN KEY ("spaceMemberUserId", "spaceMemberSpaceId") REFERENCES "SpaceMember"("userId", "spaceId") ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE "_pinnedUserFactiiis" ADD CONSTRAINT "_pinnedUserFactiiis_A_fkey" FOREIGN KEY ("A") REFERENCES "Factiii"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "_pinnedUserFactiiis" ADD CONSTRAINT "_pinnedUserFactiiis_B_fkey" FOREIGN KEY ("B") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "_pinnedSpaceFactiiis" ADD CONSTRAINT "_pinnedSpaceFactiiis_A_fkey" FOREIGN KEY ("A") REFERENCES "Factiii"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "_pinnedSpaceFactiiis" ADD CONSTRAINT "_pinnedSpaceFactiiis_B_fkey" FOREIGN KEY ("B") REFERENCES "Space"("id") ON DELETE CASCADE ON UPDATE CASCADE;



-- AddForeignKey
ALTER TABLE "SpaceMember" ADD CONSTRAINT "SpaceMember_subscriptionId_fkey" FOREIGN KEY ("subscriptionId") REFERENCES "Subscription"("id") ON DELETE SET NULL ON UPDATE CASCADE;