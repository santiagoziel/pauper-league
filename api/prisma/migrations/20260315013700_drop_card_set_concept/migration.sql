/*
  Warnings:

  - You are about to drop the column `setId` on the `ArchetypeCondition` table. All the data in the column will be lost.
  - You are about to drop the column `tag` on the `Deck` table. All the data in the column will be lost.
  - You are about to drop the column `setId` on the `DeckListRecord` table. All the data in the column will be lost.
  - You are about to drop the `CardSet` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[archetypeId,cardId]` on the table `ArchetypeCondition` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[name]` on the table `Card` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[deckId,cardId,board]` on the table `DeckListRecord` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `cardId` to the `ArchetypeCondition` table without a default value. This is not possible if the table is not empty.
  - Added the required column `amount` to the `DeckListRecord` table without a default value. This is not possible if the table is not empty.
  - Added the required column `cardId` to the `DeckListRecord` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "ClassificationStatus" AS ENUM ('AUTO', 'TIE', 'MANUAL', 'UNCLASSIFIED');

-- CreateEnum
CREATE TYPE "Board" AS ENUM ('MAIN', 'SIDE');

-- CreateEnum
CREATE TYPE "ArchetypeCategory" AS ENUM ('AGGRO', 'CONTROL', 'COMBO', 'AGGRO_COMBO', 'AGGRO_CONTROL', 'COMBO_CONTROL', 'MIDRANGE', 'RAMP', 'UNCLASSIFIED');

-- DropForeignKey
ALTER TABLE "ArchetypeCondition" DROP CONSTRAINT "ArchetypeCondition_setId_fkey";

-- DropForeignKey
ALTER TABLE "CardSet" DROP CONSTRAINT "CardSet_cardId_fkey";

-- DropForeignKey
ALTER TABLE "DeckListRecord" DROP CONSTRAINT "DeckListRecord_setId_fkey";

-- AlterTable
ALTER TABLE "Archetype" ADD COLUMN     "category" "ArchetypeCategory",
ADD COLUMN     "minMatchThreshold" DOUBLE PRECISION NOT NULL DEFAULT 0.6,
ADD COLUMN     "parentId" TEXT;

-- AlterTable
ALTER TABLE "ArchetypeCondition" DROP COLUMN "setId",
ADD COLUMN     "cardId" TEXT NOT NULL,
ADD COLUMN     "minAmount" INTEGER NOT NULL DEFAULT 1;

-- AlterTable
ALTER TABLE "Card" ADD COLUMN     "maxAmount" INTEGER;

-- AlterTable
ALTER TABLE "Deck" DROP COLUMN "tag",
ADD COLUMN     "archetypeId" TEXT,
ADD COLUMN     "classificationStatus" "ClassificationStatus" NOT NULL DEFAULT 'UNCLASSIFIED';

-- AlterTable
ALTER TABLE "DeckListRecord" DROP COLUMN "setId",
ADD COLUMN     "amount" INTEGER NOT NULL,
ADD COLUMN     "board" "Board" NOT NULL DEFAULT 'MAIN',
ADD COLUMN     "cardId" TEXT NOT NULL;

-- DropTable
DROP TABLE "CardSet";

-- CreateTable
CREATE TABLE "DeckClassification" (
    "id" TEXT NOT NULL,
    "deckId" TEXT NOT NULL,
    "archetypeId" TEXT NOT NULL,
    "matchScore" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "DeckClassification_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "DeckClassification_deckId_archetypeId_key" ON "DeckClassification"("deckId", "archetypeId");

-- CreateIndex
CREATE INDEX "Archetype_colorIdentity_idx" ON "Archetype"("colorIdentity");

-- CreateIndex
CREATE UNIQUE INDEX "ArchetypeCondition_archetypeId_cardId_key" ON "ArchetypeCondition"("archetypeId", "cardId");

-- CreateIndex
CREATE UNIQUE INDEX "Card_name_key" ON "Card"("name");

-- CreateIndex
CREATE UNIQUE INDEX "DeckListRecord_deckId_cardId_board_key" ON "DeckListRecord"("deckId", "cardId", "board");

-- AddForeignKey
ALTER TABLE "Deck" ADD CONSTRAINT "Deck_archetypeId_fkey" FOREIGN KEY ("archetypeId") REFERENCES "Archetype"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Game" ADD CONSTRAINT "Game_deck1Id_fkey" FOREIGN KEY ("deck1Id") REFERENCES "Deck"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Game" ADD CONSTRAINT "Game_deck2Id_fkey" FOREIGN KEY ("deck2Id") REFERENCES "Deck"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Archetype" ADD CONSTRAINT "Archetype_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "Archetype"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DeckListRecord" ADD CONSTRAINT "DeckListRecord_cardId_fkey" FOREIGN KEY ("cardId") REFERENCES "Card"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ArchetypeCondition" ADD CONSTRAINT "ArchetypeCondition_cardId_fkey" FOREIGN KEY ("cardId") REFERENCES "Card"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DeckClassification" ADD CONSTRAINT "DeckClassification_deckId_fkey" FOREIGN KEY ("deckId") REFERENCES "Deck"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DeckClassification" ADD CONSTRAINT "DeckClassification_archetypeId_fkey" FOREIGN KEY ("archetypeId") REFERENCES "Archetype"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
