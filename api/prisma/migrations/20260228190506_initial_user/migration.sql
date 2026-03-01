-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "friendlyId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "salt" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_friendlyId_key" ON "User"("friendlyId");
