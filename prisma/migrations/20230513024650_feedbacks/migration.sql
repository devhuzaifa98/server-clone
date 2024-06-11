-- CreateEnum
CREATE TYPE "FeedbackType" AS ENUM ('SUGGESTION', 'BUG_REPORT');

-- AlterTable
ALTER TABLE "Product" ADD COLUMN     "originalDisplayPrice" INTEGER;

-- AlterTable
ALTER TABLE "SiteSettings" ALTER COLUMN "openAiLimitPerHourPerUser" DROP DEFAULT,
ALTER COLUMN "openAiLimitPremiumUser" DROP DEFAULT;

-- CreateTable
CREATE TABLE "Feedback" (
    "id" TEXT NOT NULL,
    "message" TEXT,
    "userId" INTEGER NOT NULL,
    "mediaId" TEXT,
    "type" "FeedbackType" NOT NULL DEFAULT 'SUGGESTION',
    "includeDiagnosticsData" BOOLEAN NOT NULL DEFAULT true,
    "discarded" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Feedback_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Feedback" ADD CONSTRAINT "Feedback_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Feedback" ADD CONSTRAINT "Feedback_mediaId_fkey" FOREIGN KEY ("mediaId") REFERENCES "Upload"("id") ON DELETE CASCADE ON UPDATE CASCADE;
