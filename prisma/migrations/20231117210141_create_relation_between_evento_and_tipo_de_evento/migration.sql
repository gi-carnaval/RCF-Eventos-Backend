-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Evento" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "contratante" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL,
    "tipoEventoId" TEXT,
    "desconto" REAL,
    "valorTotal" REAL,
    "registroFotograficoId" TEXT,
    "albumId" TEXT,
    "sessaoPreCasamentoId" TEXT,
    "makingOfId" TEXT,
    "painelId" TEXT,
    "pagamentoId" TEXT,
    CONSTRAINT "Evento_tipoEventoId_fkey" FOREIGN KEY ("tipoEventoId") REFERENCES "TipoEvento" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Evento_registroFotograficoId_fkey" FOREIGN KEY ("registroFotograficoId") REFERENCES "RegistroFotografico" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Evento_albumId_fkey" FOREIGN KEY ("albumId") REFERENCES "Album" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Evento_sessaoPreCasamentoId_fkey" FOREIGN KEY ("sessaoPreCasamentoId") REFERENCES "SessaoPreCasamento" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Evento_makingOfId_fkey" FOREIGN KEY ("makingOfId") REFERENCES "MakingOf" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Evento_painelId_fkey" FOREIGN KEY ("painelId") REFERENCES "Painel" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Evento_pagamentoId_fkey" FOREIGN KEY ("pagamentoId") REFERENCES "Pagamento" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Evento" ("albumId", "contratante", "createdAt", "desconto", "id", "makingOfId", "pagamentoId", "painelId", "registroFotograficoId", "sessaoPreCasamentoId", "valorTotal") SELECT "albumId", "contratante", "createdAt", "desconto", "id", "makingOfId", "pagamentoId", "painelId", "registroFotograficoId", "sessaoPreCasamentoId", "valorTotal" FROM "Evento";
DROP TABLE "Evento";
ALTER TABLE "new_Evento" RENAME TO "Evento";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
