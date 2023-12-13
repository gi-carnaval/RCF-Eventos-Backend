/*
  Warnings:

  - You are about to drop the `Payment` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Payment";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "Installments" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "numberOfInstallments" INTEGER NOT NULL,
    "startDate" TEXT NOT NULL,
    "installmentValue" REAL NOT NULL,
    "eventId" TEXT NOT NULL,
    CONSTRAINT "Installments_eventId_fkey" FOREIGN KEY ("eventId") REFERENCES "Event" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Event" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "hirer" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL,
    "discount" REAL,
    "totalValue" REAL,
    "eventTypeId" TEXT,
    "photographicRegisterId" TEXT,
    "albumId" TEXT,
    "photoShootId" TEXT,
    "makingOfId" TEXT,
    "photoPanelId" TEXT,
    "paymentId" TEXT,
    CONSTRAINT "Event_eventTypeId_fkey" FOREIGN KEY ("eventTypeId") REFERENCES "EventType" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Event_photographicRegisterId_fkey" FOREIGN KEY ("photographicRegisterId") REFERENCES "PhotographicRegister" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Event_albumId_fkey" FOREIGN KEY ("albumId") REFERENCES "Album" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Event_photoShootId_fkey" FOREIGN KEY ("photoShootId") REFERENCES "PhotoShoot" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Event_makingOfId_fkey" FOREIGN KEY ("makingOfId") REFERENCES "MakingOf" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Event_photoPanelId_fkey" FOREIGN KEY ("photoPanelId") REFERENCES "PhotoPanel" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Event" ("albumId", "createdAt", "discount", "eventTypeId", "hirer", "id", "makingOfId", "paymentId", "photoPanelId", "photoShootId", "photographicRegisterId", "totalValue") SELECT "albumId", "createdAt", "discount", "eventTypeId", "hirer", "id", "makingOfId", "paymentId", "photoPanelId", "photoShootId", "photographicRegisterId", "totalValue" FROM "Event";
DROP TABLE "Event";
ALTER TABLE "new_Event" RENAME TO "Event";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
