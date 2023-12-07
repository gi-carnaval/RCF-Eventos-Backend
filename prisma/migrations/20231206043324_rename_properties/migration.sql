/*
  Warnings:

  - You are about to drop the `Painel` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `SessaoPreCasamento` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the column `painelId` on the `Event` table. All the data in the column will be lost.
  - You are about to drop the column `sessaoPreCasamentoId` on the `Event` table. All the data in the column will be lost.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Painel";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "SessaoPreCasamento";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "PhotoShoot" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "value" REAL NOT NULL
);

-- CreateTable
CREATE TABLE "PhotoPanel" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "size" TEXT NOT NULL,
    "value" REAL NOT NULL
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Event" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "hirer" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL,
    "eventTypeId" TEXT,
    "desconto" REAL,
    "valorTotal" REAL,
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
INSERT INTO "new_Event" ("albumId", "createdAt", "desconto", "eventTypeId", "hirer", "id", "makingOfId", "paymentId", "photographicRegisterId", "valorTotal") SELECT "albumId", "createdAt", "desconto", "eventTypeId", "hirer", "id", "makingOfId", "paymentId", "photographicRegisterId", "valorTotal" FROM "Event";
DROP TABLE "Event";
ALTER TABLE "new_Event" RENAME TO "Event";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
