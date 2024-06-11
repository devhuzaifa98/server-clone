-- AlterTable
ALTER TABLE "UserPreference" ADD COLUMN     "allowPoliticalContent" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "hidePostsOnProfile" BOOLEAN NOT NULL DEFAULT false;
