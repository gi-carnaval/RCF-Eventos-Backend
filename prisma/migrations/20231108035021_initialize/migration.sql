-- CreateTable
CREATE TABLE "Evento" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "contratante" TEXT NOT NULL,
    "createdAt" TEXT,
    "desconto" TEXT,
    "valorTotal" TEXT NOT NULL,
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

-- CreateTable
CREATE TABLE "RegistroFotografico" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "quantidadeProfissionais" TEXT NOT NULL,
    "mediaFotos" TEXT NOT NULL,
    "valor" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Album" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "tamanho" TEXT NOT NULL,
    "paginas" TEXT NOT NULL,
    "capa" TEXT NOT NULL,
    "valor" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "SessaoPreCasamento" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "compromisso" TEXT NOT NULL,
    "valor" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "MakingOf" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "compromisso" TEXT NOT NULL,
    "valor" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Painel" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "tamanho" TEXT NOT NULL,
    "valor" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Pagamento" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "quantidadeParcelas" TEXT NOT NULL,
    "dataInicio" TEXT NOT NULL,
    "valorParcela" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Compromissos" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "data" TEXT NOT NULL,
    "local" TEXT NOT NULL,
    "diaDaSemana" TEXT NOT NULL,
    "horario" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "TipoEvento" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "tipo" TEXT NOT NULL
);
