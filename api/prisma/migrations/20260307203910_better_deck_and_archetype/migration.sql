/*
  Warnings:

  - You are about to drop the column `archetypeId` on the `CardSet` table. All the data in the column will be lost.
  - You are about to drop the column `deckId` on the `CardSet` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "CardSet" DROP CONSTRAINT "CardSet_archetypeId_fkey";

-- DropForeignKey
ALTER TABLE "CardSet" DROP CONSTRAINT "CardSet_deckId_fkey";

-- AlterTable
ALTER TABLE "CardSet" DROP COLUMN "archetypeId",
DROP COLUMN "deckId";

-- CreateTable
CREATE TABLE "DeckListRecord" (
    "id" TEXT NOT NULL,
    "deckId" TEXT NOT NULL,
    "setId" TEXT NOT NULL,

    CONSTRAINT "DeckListRecord_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ArchetypeCondition" (
    "id" TEXT NOT NULL,
    "archetypeId" TEXT NOT NULL,
    "setId" TEXT NOT NULL,

    CONSTRAINT "ArchetypeCondition_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "DeckListRecord" ADD CONSTRAINT "DeckListRecord_deckId_fkey" FOREIGN KEY ("deckId") REFERENCES "Deck"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DeckListRecord" ADD CONSTRAINT "DeckListRecord_setId_fkey" FOREIGN KEY ("setId") REFERENCES "CardSet"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ArchetypeCondition" ADD CONSTRAINT "ArchetypeCondition_archetypeId_fkey" FOREIGN KEY ("archetypeId") REFERENCES "Archetype"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ArchetypeCondition" ADD CONSTRAINT "ArchetypeCondition_setId_fkey" FOREIGN KEY ("setId") REFERENCES "CardSet"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
