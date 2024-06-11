-- CreateTable
CREATE TABLE "OTPBasedLogin" (
    "id" SERIAL NOT NULL,
    "code" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiredAt" TIMESTAMP(3),

    CONSTRAINT "OTPBasedLogin_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "OTPBasedLogin" ADD CONSTRAINT "OTPBasedLogin_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
