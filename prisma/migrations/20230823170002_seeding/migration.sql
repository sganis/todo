/*
  Warnings:

  - You are about to drop the column `available` on the `availability` table. All the data in the column will be lost.
  - You are about to drop the column `room_id` on the `availability` table. All the data in the column will be lost.
  - You are about to drop the column `price_list` on the `bookings` table. All the data in the column will be lost.
  - You are about to drop the column `price_total` on the `bookings` table. All the data in the column will be lost.
  - You are about to drop the column `docnr` on the `guests` table. All the data in the column will be lost.
  - You are about to drop the column `doctype` on the `guests` table. All the data in the column will be lost.
  - You are about to drop the column `type` on the `rooms` table. All the data in the column will be lost.
  - Added the required column `num_available` to the `availability` table without a default value. This is not possible if the table is not empty.
  - Added the required column `room_type_id` to the `availability` table without a default value. This is not possible if the table is not empty.
  - Made the column `email` on table `guests` required. This step will fail if there are existing NULL values in that column.
  - Made the column `tel` on table `guests` required. This step will fail if there are existing NULL values in that column.
  - Made the column `country` on table `guests` required. This step will fail if there are existing NULL values in that column.
  - Added the required column `room_type_id` to the `rooms` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "availability" DROP CONSTRAINT "availability_room_id_fkey";

-- DropIndex
DROP INDEX "guests_email_key";

-- AlterTable
ALTER TABLE "availability" DROP COLUMN "available",
DROP COLUMN "room_id",
ADD COLUMN     "num_available" INTEGER NOT NULL,
ADD COLUMN     "room_type_id" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "bookings" DROP COLUMN "price_list",
DROP COLUMN "price_total",
ADD COLUMN     "price_ars" DECIMAL(65,30),
ADD COLUMN     "price_usd" DECIMAL(65,30);

-- AlterTable
ALTER TABLE "guests" DROP COLUMN "docnr",
DROP COLUMN "doctype",
ADD COLUMN     "doc_nr" TEXT,
ADD COLUMN     "doc_type" TEXT,
ALTER COLUMN "email" SET NOT NULL,
ALTER COLUMN "tel" SET NOT NULL,
ALTER COLUMN "country" SET NOT NULL,
ALTER COLUMN "country" SET DEFAULT 'AR';

-- AlterTable
ALTER TABLE "rooms" DROP COLUMN "type",
ADD COLUMN     "room_type_id" INTEGER NOT NULL;

-- CreateTable
CREATE TABLE "room_types" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "num_guests" INTEGER NOT NULL,

    CONSTRAINT "room_types_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "settings" (
    "id" SERIAL NOT NULL,
    "breakfast_price" DECIMAL(65,30),

    CONSTRAINT "settings_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "rooms" ADD CONSTRAINT "rooms_room_type_id_fkey" FOREIGN KEY ("room_type_id") REFERENCES "room_types"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "availability" ADD CONSTRAINT "availability_room_type_id_fkey" FOREIGN KEY ("room_type_id") REFERENCES "room_types"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
