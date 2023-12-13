/*
  Warnings:

  - You are about to drop the column `numberOfInstallments` on the `Installments` table. All the data in the column will be lost.
  - You are about to drop the column `startDate` on the `Installments` table. All the data in the column will be lost.
  - Added the required column `date` to the `Installments` table without a default value. This is not possible if the table is not empty.
  - Added the required column `installmentNumber` to the `Installments` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Installments" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "installmentNumber" INTEGER NOT NULL,
    "date" TEXT NOT NULL,
    "installmentValue" REAL NOT NULL,
    "eventId" TEXT NOT NULL,
    CONSTRAINT "Installments_eventId_fkey" FOREIGN KEY ("eventId") REFERENCES "Event" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Installments" ("eventId", "id", "installmentValue") SELECT "eventId", "id", "installmentValue" FROM "Installments";
DROP TABLE "Installments";
ALTER TABLE "new_Installments" RENAME TO "Installments";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
