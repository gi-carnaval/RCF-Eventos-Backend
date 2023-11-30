/*
  Warnings:

  - You are about to drop the column `appointmentId` on the `Event` table. All the data in the column will be lost.
  - Added the required column `eventId` to the `Appointment` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Appointment" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "appointmentTitle" TEXT NOT NULL,
    "date" TEXT NOT NULL,
    "locale" TEXT NOT NULL,
    "dayOfWeek" TEXT NOT NULL,
    "time" TEXT NOT NULL,
    "eventId" TEXT NOT NULL,
    CONSTRAINT "Appointment_eventId_fkey" FOREIGN KEY ("eventId") REFERENCES "Event" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Appointment" ("appointmentTitle", "date", "dayOfWeek", "id", "locale", "time") SELECT "appointmentTitle", "date", "dayOfWeek", "id", "locale", "time" FROM "Appointment";
DROP TABLE "Appointment";
ALTER TABLE "new_Appointment" RENAME TO "Appointment";
CREATE TABLE "new_Event" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "hirer" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL,
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
    CONSTRAINT "Event_paymentId_fkey" FOREIGN KEY ("paymentId") REFERENCES "Payment" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Event" ("albumId", "createdAt", "desconto", "eventTypeId", "hirer", "id", "makingOfId", "painelId", "paymentId", "photographicRegisterId", "sessaoPreCasamentoId", "valorTotal") SELECT "albumId", "createdAt", "desconto", "eventTypeId", "hirer", "id", "makingOfId", "painelId", "paymentId", "photographicRegisterId", "sessaoPreCasamentoId", "valorTotal" FROM "Event";
DROP TABLE "Event";
ALTER TABLE "new_Event" RENAME TO "Event";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
