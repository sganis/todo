/*
  Warnings:

  - You are about to drop the column `breakfast_price` on the `settings` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "settings" DROP COLUMN "breakfast_price",
ADD COLUMN     "breakfast_price_ars" DECIMAL(65,30),
ADD COLUMN     "breakfast_price_usd" DECIMAL(65,30);
