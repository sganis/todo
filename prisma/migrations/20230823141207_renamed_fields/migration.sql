/*
  Warnings:

  - You are about to drop the column `bookingId` on the `booking_guests` table. All the data in the column will be lost.
  - You are about to drop the column `guestId` on the `booking_guests` table. All the data in the column will be lost.
  - You are about to drop the column `maxAdults` on the `rooms` table. All the data in the column will be lost.
  - Added the required column `booking_id` to the `booking_guests` table without a default value. This is not possible if the table is not empty.
  - Added the required column `guest_id` to the `booking_guests` table without a default value. This is not possible if the table is not empty.
  - Added the required column `max_adults` to the `rooms` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "booking_guests" DROP CONSTRAINT "booking_guests_bookingId_fkey";

-- DropForeignKey
ALTER TABLE "booking_guests" DROP CONSTRAINT "booking_guests_guestId_fkey";

-- AlterTable
ALTER TABLE "booking_guests" DROP COLUMN "bookingId",
DROP COLUMN "guestId",
ADD COLUMN     "booking_id" INTEGER NOT NULL,
ADD COLUMN     "guest_id" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "rooms" DROP COLUMN "maxAdults",
ADD COLUMN     "max_adults" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "booking_guests" ADD CONSTRAINT "booking_guests_guest_id_fkey" FOREIGN KEY ("guest_id") REFERENCES "guests"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "booking_guests" ADD CONSTRAINT "booking_guests_booking_id_fkey" FOREIGN KEY ("booking_id") REFERENCES "bookings"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
