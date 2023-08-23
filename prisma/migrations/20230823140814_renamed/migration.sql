/*
  Warnings:

  - You are about to drop the `Booking` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `BookingGuest` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `CreditCard` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Guest` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Room` table. If the table is not empty, all the data it contains will be lost.

*/
-- CreateEnum
CREATE TYPE "source" AS ENUM ('WALKIN', 'BOOKING', 'EXPEDIA', 'AIRBNB', 'ENGINE', 'AGENT');

-- CreateEnum
CREATE TYPE "booking_status" AS ENUM ('CREATED', 'OK');

-- CreateEnum
CREATE TYPE "reason" AS ENUM ('TOURISM', 'WORK');

-- DropForeignKey
ALTER TABLE "Booking" DROP CONSTRAINT "Booking_roomId_fkey";

-- DropForeignKey
ALTER TABLE "BookingGuest" DROP CONSTRAINT "BookingGuest_bookingId_fkey";

-- DropForeignKey
ALTER TABLE "BookingGuest" DROP CONSTRAINT "BookingGuest_guestId_fkey";

-- DropForeignKey
ALTER TABLE "CreditCard" DROP CONSTRAINT "CreditCard_guestId_fkey";

-- DropTable
DROP TABLE "Booking";

-- DropTable
DROP TABLE "BookingGuest";

-- DropTable
DROP TABLE "CreditCard";

-- DropTable
DROP TABLE "Guest";

-- DropTable
DROP TABLE "Room";

-- DropEnum
DROP TYPE "BookingStatus";

-- DropEnum
DROP TYPE "Reason";

-- DropEnum
DROP TYPE "Source";

-- CreateTable
CREATE TABLE "guests" (
    "id" SERIAL NOT NULL,
    "firstname" TEXT NOT NULL,
    "lastname" TEXT,
    "email" TEXT,
    "tel" TEXT,
    "city" TEXT,
    "country" TEXT,
    "dob" TIMESTAMP(3),
    "doctype" TEXT,
    "docnr" TEXT,
    "status" TEXT,
    "remarks" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "guests_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "credit_cards" (
    "id" SERIAL NOT NULL,
    "type" TEXT NOT NULL,
    "number" TEXT NOT NULL,
    "expiration" TEXT NOT NULL,
    "cvv" TEXT NOT NULL,
    "guestId" INTEGER NOT NULL,

    CONSTRAINT "credit_cards_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "rooms" (
    "id" SERIAL NOT NULL,
    "number" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "maxAdults" INTEGER NOT NULL,

    CONSTRAINT "rooms_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "bookings" (
    "id" SERIAL NOT NULL,
    "roomId" INTEGER NOT NULL,
    "arrival" TIMESTAMP(3) NOT NULL,
    "departure" TIMESTAMP(3) NOT NULL,
    "status" "booking_status" NOT NULL DEFAULT 'CREATED',
    "breakfast" BOOLEAN NOT NULL DEFAULT true,
    "source" "source" NOT NULL DEFAULT 'WALKIN',
    "reason" "reason" NOT NULL DEFAULT 'TOURISM',
    "adults" INTEGER NOT NULL,
    "children" INTEGER NOT NULL DEFAULT 0,
    "babies" INTEGER NOT NULL DEFAULT 0,
    "price_list" TEXT,
    "price_total" DECIMAL(65,30) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "bookings_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "booking_guests" (
    "id" SERIAL NOT NULL,
    "guestId" INTEGER NOT NULL,
    "bookingId" INTEGER NOT NULL,
    "main" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "booking_guests_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "guests_email_key" ON "guests"("email");

-- AddForeignKey
ALTER TABLE "credit_cards" ADD CONSTRAINT "credit_cards_guestId_fkey" FOREIGN KEY ("guestId") REFERENCES "guests"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bookings" ADD CONSTRAINT "bookings_roomId_fkey" FOREIGN KEY ("roomId") REFERENCES "rooms"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "booking_guests" ADD CONSTRAINT "booking_guests_guestId_fkey" FOREIGN KEY ("guestId") REFERENCES "guests"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "booking_guests" ADD CONSTRAINT "booking_guests_bookingId_fkey" FOREIGN KEY ("bookingId") REFERENCES "bookings"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
