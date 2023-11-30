/*
  Warnings:

  - You are about to alter the column `valorParcela` on the `Pagamento` table. The data in that column could be lost. The data in that column will be cast from `String` to `Float`.
  - You are about to alter the column `valor` on the `MakingOf` table. The data in that column could be lost. The data in that column will be cast from `String` to `Float`.
  - You are about to alter the column `valor` on the `Painel` table. The data in that column could be lost. The data in that column will be cast from `String` to `Float`.
  - You are about to alter the column `valor` on the `Album` table. The data in that column could be lost. The data in that column will be cast from `String` to `Float`.
  - You are about to alter the column `desconto` on the `Evento` table. The data in that column could be lost. The data in that column will be cast from `String` to `Float`.
  - You are about to alter the column `valorTotal` on the `Evento` table. The data in that column could be lost. The data in that column will be cast from `String` to `Float`.
  - You are about to alter the column `valor` on the `RegistroFotografico` table. The data in that column could be lost. The data in that column will be cast from `String` to `Float`.
  - You are about to alter the column `valor` on the `SessaoPreCasamento` table. The data in that column could be lost. The data in that column will be cast from `String` to `Float`.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Pagamento" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "quantidadeParcelas" TEXT NOT NULL,
    "dataInicio" TEXT NOT NULL,
    "valorParcela" REAL NOT NULL
);
INSERT INTO "new_Pagamento" ("dataInicio", "id", "quantidadeParcelas", "valorParcela") SELECT "dataInicio", "id", "quantidadeParcelas", "valorParcela" FROM "Pagamento";
DROP TABLE "Pagamento";
ALTER TABLE "new_Pagamento" RENAME TO "Pagamento";
CREATE TABLE "new_MakingOf" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "compromisso" TEXT NOT NULL,
    "valor" REAL NOT NULL
);
INSERT INTO "new_MakingOf" ("compromisso", "id", "valor") SELECT "compromisso", "id", "valor" FROM "MakingOf";
DROP TABLE "MakingOf";
ALTER TABLE "new_MakingOf" RENAME TO "MakingOf";
CREATE TABLE "new_Painel" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "tamanho" TEXT NOT NULL,
    "valor" REAL NOT NULL
);
INSERT INTO "new_Painel" ("id", "tamanho", "valor") SELECT "id", "tamanho", "valor" FROM "Painel";
DROP TABLE "Painel";
ALTER TABLE "new_Painel" RENAME TO "Painel";
CREATE TABLE "new_Album" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "tamanho" TEXT NOT NULL,
    "paginas" TEXT NOT NULL,
    "capa" TEXT NOT NULL,
    "valor" REAL NOT NULL
);
INSERT INTO "new_Album" ("capa", "id", "paginas", "tamanho", "valor") SELECT "capa", "id", "paginas", "tamanho", "valor" FROM "Album";
DROP TABLE "Album";
ALTER TABLE "new_Album" RENAME TO "Album";
CREATE TABLE "new_Evento" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "contratante" TEXT NOT NULL,
    "desconto" REAL,
    "valorTotal" REAL NOT NULL,
    "registroFotograficoId" TEXT,
    "albumId" TEXT,
    "sessaoPreCasamentoId" TEXT,
    "makingOfId" TEXT,
    "painelId" TEXT,
    "pagamentoId" TEXT,
    CONSTRAINT "Evento_registroFotograficoId_fkey" FOREIGN KEY ("registroFotograficoId") REFERENCES "RegistroFotografico" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Evento_albumId_fkey" FOREIGN KEY ("albumId") REFERENCES "Album" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Evento_sessaoPreCasamentoId_fkey" FOREIGN KEY ("sessaoPreCasamentoId") REFERENCES "SessaoPreCasamento" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Evento_makingOfId_fkey" FOREIGN KEY ("makingOfId") REFERENCES "MakingOf" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Evento_painelId_fkey" FOREIGN KEY ("painelId") REFERENCES "Painel" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Evento_pagamentoId_fkey" FOREIGN KEY ("pagamentoId") REFERENCES "Pagamento" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Evento" ("albumId", "contratante", "desconto", "id", "makingOfId", "pagamentoId", "painelId", "registroFotograficoId", "sessaoPreCasamentoId", "valorTotal") SELECT "albumId", "contratante", "desconto", "id", "makingOfId", "pagamentoId", "painelId", "registroFotograficoId", "sessaoPreCasamentoId", "valorTotal" FROM "Evento";
DROP TABLE "Evento";
ALTER TABLE "new_Evento" RENAME TO "Evento";
CREATE TABLE "new_RegistroFotografico" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "quantidadeProfissionais" TEXT NOT NULL,
    "mediaFotos" TEXT NOT NULL,
    "valor" REAL NOT NULL
);
INSERT INTO "new_RegistroFotografico" ("id", "mediaFotos", "quantidadeProfissionais", "valor") SELECT "id", "mediaFotos", "quantidadeProfissionais", "valor" FROM "RegistroFotografico";
DROP TABLE "RegistroFotografico";
ALTER TABLE "new_RegistroFotografico" RENAME TO "RegistroFotografico";
CREATE TABLE "new_SessaoPreCasamento" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "compromisso" TEXT NOT NULL,
    "valor" REAL NOT NULL
);
INSERT INTO "new_SessaoPreCasamento" ("compromisso", "id", "valor") SELECT "compromisso", "id", "valor" FROM "SessaoPreCasamento";
DROP TABLE "SessaoPreCasamento";
ALTER TABLE "new_SessaoPreCasamento" RENAME TO "SessaoPreCasamento";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
