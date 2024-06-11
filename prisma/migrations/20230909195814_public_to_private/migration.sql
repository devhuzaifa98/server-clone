/*
  Warnings:
  - The values [PUBLIC] on the enum `FactiiiType` will be removed. If these variants are still used in the database, this will fail.
  - The values [PUBLIC] on the enum `SpaceType` will be removed. If these variants are still used in the database, this will fail.
  - The values [PUBLIC] on the enum `UserType` will be removed. If these variants are still used in the database, this will fail.
*/
-- Update Factiii with new type PRIVATE
BEGIN;
-- 1. Create the new enum type
CREATE TYPE "FactiiiType_new" AS ENUM ('PRIVATE', 'PREMIUM', 'PAID', 'INVITE');
-- 2. Change the column type to the new enum using a transition phase
ALTER TABLE "Factiii" ADD COLUMN "types_new" "FactiiiType_new"[];
-- 3. Migrate data from the old "types" column to "types_new", replacing 'PUBLIC' with 'PRIVATE'
UPDATE "Factiii"
SET "types_new" = ARRAY_REPLACE("types"::text[], 'PUBLIC', 'PRIVATE')::"FactiiiType_new"[];
-- 4. Flip PRIVATE PUBLIC
-- Remove PRIVATE from types_new where PRIVATE exists in types
UPDATE "Factiii"
SET "types_new" = ARRAY_REMOVE("types_new", 'PRIVATE')
WHERE 'PUBLIC' = ANY("types");
-- Add PRIVATE to types_new where PRIVATE does not exist in types
UPDATE "Factiii"
SET "types_new" = ARRAY_APPEND("types_new", 'PRIVATE')
WHERE NOT 'PUBLIC' = ANY("types");
-- 5. Drop the old "types" column and rename "types_new" to "types"
ALTER TABLE "Factiii" DROP COLUMN "types";
ALTER TABLE "Factiii" RENAME COLUMN "types_new" TO "types";
-- 6. Cleanup: Rename old enum type and set the new one as default
ALTER TYPE "FactiiiType" RENAME TO "FactiiiType_old";
ALTER TYPE "FactiiiType_new" RENAME TO "FactiiiType";
DROP TYPE "FactiiiType_old";
ALTER TABLE "Factiii" ALTER COLUMN "types" SET DEFAULT ARRAY[]::"FactiiiType"[];
COMMIT;

-- Update Space with new type PRIVATE
BEGIN;
-- 1. Create the new enum type
CREATE TYPE "SpaceType_new" AS ENUM ('PRIVATE', 'PREMIUM', 'PAID', 'INVITE');
-- 2. Change the column type to the new enum using a transition phase
ALTER TABLE "Space" ADD COLUMN "types_new" "SpaceType_new"[];
-- 3. Migrate data from the old "types" column to "types_new", replacing 'PUBLIC' with 'PRIVATE'
UPDATE "Space"
SET "types_new" = ARRAY_REPLACE("types"::text[], 'PUBLIC', 'PRIVATE')::"SpaceType_new"[];
-- 4. Flip PRIVATE PUBLIC
-- Remove PRIVATE from types_new where PRIVATE exists in types
UPDATE "Space"
SET "types_new" = ARRAY_REMOVE("types_new", 'PRIVATE')
WHERE 'PUBLIC' = ANY("types");
-- Add PRIVATE to types_new where PRIVATE does not exist in types
UPDATE "Space"
SET "types_new" = ARRAY_APPEND("types_new", 'PRIVATE')
WHERE NOT 'PUBLIC' = ANY("types");
-- 5. Drop the old "types" column and rename "types_new" to "types"
ALTER TABLE "Space" DROP COLUMN "types";
ALTER TABLE "Space" RENAME COLUMN "types_new" TO "types";
-- 6. Cleanup: Rename old enum type and set the new one as default
ALTER TYPE "SpaceType" RENAME TO "SpaceType_old";
ALTER TYPE "SpaceType_new" RENAME TO "SpaceType";
DROP TYPE "SpaceType_old";
ALTER TABLE "Space" ALTER COLUMN "types" SET DEFAULT ARRAY[]::"SpaceType"[];
--7. ReCreateIndex for new index
CREATE INDEX "idx_space_types" ON "Space"("types");
COMMIT;

-- Update User with new type PRIVATE
BEGIN;
-- 1. Create the new enum type
CREATE TYPE "UserType_new" AS ENUM ('PRIVATE', 'PREMIUM', 'PAID', 'INVITE');
-- 2. Change the column type to the new enum using a transition phase
ALTER TABLE "User" ADD COLUMN "types_new" "UserType_new"[];
-- 3. Migrate data from the old "types" column to "types_new", replacing 'PUBLIC' with 'PRIVATE'
UPDATE "User"
SET "types_new" = ARRAY_REPLACE("types"::text[], 'PUBLIC', 'PRIVATE')::"UserType_new"[];
-- 4. Flip PRIVATE PUBLIC
-- Remove PRIVATE from types_new where PRIVATE exists in types
UPDATE "User"
SET "types_new" = ARRAY_REMOVE("types_new", 'PRIVATE')
WHERE 'PUBLIC' = ANY("types");
-- Add PRIVATE to types_new where PRIVATE does not exist in types
UPDATE "User"
SET "types_new" = ARRAY_APPEND("types_new", 'PRIVATE')
WHERE NOT 'PUBLIC' = ANY("types");
-- 5. Drop the old "types" column and rename "types_new" to "types"
ALTER TABLE "User" DROP COLUMN "types";
ALTER TABLE "User" RENAME COLUMN "types_new" TO "types";
-- 6. Cleanup: Rename old enum type and set the new one as default
ALTER TYPE "UserType" RENAME TO "UserType_old";
ALTER TYPE "UserType_new" RENAME TO "UserType";
DROP TYPE "UserType_old";
ALTER TABLE "User" ALTER COLUMN "types" SET DEFAULT ARRAY[]::"UserType"[];
COMMIT;