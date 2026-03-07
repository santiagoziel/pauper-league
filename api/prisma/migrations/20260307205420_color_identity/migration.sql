/*
  Warnings:

  - Added the required column `colorIdentity` to the `Archetype` table without a default value. This is not possible if the table is not empty.
  - Added the required column `colorIdentity` to the `Card` table without a default value. This is not possible if the table is not empty.
  - Added the required column `colorIdentity` to the `Deck` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Archetype" ADD COLUMN     "colorIdentity" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Card" ADD COLUMN     "colorIdentity" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Deck" ADD COLUMN     "colorIdentity" TEXT NOT NULL;
