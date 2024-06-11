-- AlterEnum
ALTER TYPE "UploadType" ADD VALUE 'DOCUMENT';

-- AlterTable
ALTER TABLE "Upload" ADD COLUMN     "name" TEXT,
ADD COLUMN     "size" INTEGER;
