/*
  Warnings:

  - You are about to drop the `Compromissos` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Pagamento` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `RegistroFotografico` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the column `pagamentoId` on the `Event` table. All the data in the column will be lost.
  - You are about to drop the column `registroFotograficoId` on the `Event` table. All the data in the column will be lost.
  - You are about to drop the column `compromisso` on the `SessaoPreCasamento` table. All the data in the column will be lost.
  - You are about to drop the column `compromisso` on the `MakingOf` table. All the data in the column will be lost.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Compromissos";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Pagamento";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "RegistroFotografico";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "PhotographicRegister" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "professionalQuantity" TEXT NOT NULL,
    "photoAverage" TEXT NOT NULL,
    "value" REAL NOT NULL
);

-- CreateTable
CREATE TABLE "Payment" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "numberOfInstallments" TEXT NOT NULL,
    "startDate" TEXT NOT NULL,
    "installmentValue" REAL NOT NULL
);

-- CreateTable
CREATE TABLE "Appointment" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "appointmentTitle" TEXT NOT NULL,
    "date" TEXT NOT NULL,
    "locale" TEXT NOT NULL,
    "dayOfWeek" TEXT NOT NULL,
    "time" TEXT NOT NULL
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Event" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "hirer" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL,
    "appointmentId" TEXT,
    "eventTypeId" TEXT,
    "desconto" REAL,
    "valorTotal" REAL,
    "photographicRegisterId" TEXT,
    "albumId" TEXT,
    "sessaoPreCasamentoId" TEXT,
    "makingOfId" TEXT,
    "painelId" TEXT,
    "paymentId" TEXT,
    CONSTRAINT "Event_eventTypeId_fkey" FOREIGN KEY ("eventTypeId") REFERENCES "EventType" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Event_photographicRegisterId_fkey" FOREIGN KEY ("photographicRegisterId") REFERENCES "PhotographicRegister" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Event_albumId_fkey" FOREIGN KEY ("albumId") REFERENCES "Album" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Event_sessaoPreCasamentoId_fkey" FOREIGN KEY ("sessaoPreCasamentoId") REFERENCES "SessaoPreCasamento" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Event_makingOfId_fkey" FOREIGN KEY ("makingOfId") REFERENCES "MakingOf" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Event_painelId_fkey" FOREIGN KEY ("painelId") REFERENCES "Painel" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Event_paymentId_fkey" FOREIGN KEY ("paymentId") REFERENCES "Payment" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Event_appointmentId_fkey" FOREIGN KEY ("appointmentId") REFERENCES "Appointment" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Event" ("albumId", "createdAt", "desconto", "eventTypeId", "hirer", "id", "makingOfId", "painelId", "sessaoPreCasamentoId", "valorTotal") SELECT "albumId", "createdAt", "desconto", "eventTypeId", "hirer", "id", "makingOfId", "painelId", "sessaoPreCasamentoId", "valorTotal" FROM "Event";
DROP TABLE "Event";
ALTER TABLE "new_Event" RENAME TO "Event";
CREATE TABLE "new_SessaoPreCasamento" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "valor" REAL NOT NULL
);
INSERT INTO "new_SessaoPreCasamento" ("id", "valor") SELECT "id", "valor" FROM "SessaoPreCasamento";
DROP TABLE "SessaoPreCasamento";
ALTER TABLE "new_SessaoPreCasamento" RENAME TO "SessaoPreCasamento";
CREATE TABLE "new_MakingOf" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "valor" REAL NOT NULL
);
INSERT INTO "new_MakingOf" ("id", "valor") SELECT "id", "valor" FROM "MakingOf";
DROP TABLE "MakingOf";
ALTER TABLE "new_MakingOf" RENAME TO "MakingOf";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
