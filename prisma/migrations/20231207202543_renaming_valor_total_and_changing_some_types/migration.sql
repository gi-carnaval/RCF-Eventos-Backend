/*
  Warnings:

  - You are about to drop the column `desconto` on the `Event` table. All the data in the column will be lost.
  - You are about to drop the column `valorTotal` on the `Event` table. All the data in the column will be lost.
  - You are about to alter the column `numberOfInstallments` on the `Payment` table. The data in that column could be lost. The data in that column will be cast from `String` to `Int`.

*/
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
    CONSTRAINT "Event_photoPanelId_fkey" FOREIGN KEY ("photoPanelId") REFERENCES "PhotoPanel" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Event_paymentId_fkey" FOREIGN KEY ("paymentId") REFERENCES "Payment" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Event" ("albumId", "createdAt", "eventTypeId", "hirer", "id", "makingOfId", "paymentId", "photoPanelId", "photoShootId", "photographicRegisterId") SELECT "albumId", "createdAt", "eventTypeId", "hirer", "id", "makingOfId", "paymentId", "photoPanelId", "photoShootId", "photographicRegisterId" FROM "Event";
DROP TABLE "Event";
ALTER TABLE "new_Event" RENAME TO "Event";
CREATE TABLE "new_Payment" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "numberOfInstallments" INTEGER NOT NULL,
    "startDate" TEXT NOT NULL,
    "installmentValue" REAL NOT NULL
);
INSERT INTO "new_Payment" ("id", "installmentValue", "numberOfInstallments", "startDate") SELECT "id", "installmentValue", "numberOfInstallments", "startDate" FROM "Payment";
DROP TABLE "Payment";
ALTER TABLE "new_Payment" RENAME TO "Payment";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
