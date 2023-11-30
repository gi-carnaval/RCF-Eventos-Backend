/*
  Warnings:

  - You are about to drop the `Evento` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `TipoEvento` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Evento";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "TipoEvento";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "Event" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "hirer" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL,
    "eventTypeId" TEXT,
    "desconto" REAL,
    "valorTotal" REAL,
    "registroFotograficoId" TEXT,
    "albumId" TEXT,
    "sessaoPreCasamentoId" TEXT,
    "makingOfId" TEXT,
    "painelId" TEXT,
    "pagamentoId" TEXT,
    CONSTRAINT "Event_eventTypeId_fkey" FOREIGN KEY ("eventTypeId") REFERENCES "EventType" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Event_registroFotograficoId_fkey" FOREIGN KEY ("registroFotograficoId") REFERENCES "RegistroFotografico" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Event_albumId_fkey" FOREIGN KEY ("albumId") REFERENCES "Album" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Event_sessaoPreCasamentoId_fkey" FOREIGN KEY ("sessaoPreCasamentoId") REFERENCES "SessaoPreCasamento" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Event_makingOfId_fkey" FOREIGN KEY ("makingOfId") REFERENCES "MakingOf" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Event_painelId_fkey" FOREIGN KEY ("painelId") REFERENCES "Painel" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Event_pagamentoId_fkey" FOREIGN KEY ("pagamentoId") REFERENCES "Pagamento" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "EventType" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "type" TEXT NOT NULL
);
