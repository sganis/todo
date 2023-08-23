/*
  Warnings:

  - You are about to drop the column `guestId` on the `credit_cards` table. All the data in the column will be lost.
  - Added the required column `guest_id` to the `credit_cards` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "credit_cards" DROP CONSTRAINT "credit_cards_guestId_fkey";

-- AlterTable
ALTER TABLE "credit_cards" DROP COLUMN "guestId",
ADD COLUMN     "guest_id" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "credit_cards" ADD CONSTRAINT "credit_cards_guest_id_fkey" FOREIGN KEY ("guest_id") REFERENCES "guests"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
