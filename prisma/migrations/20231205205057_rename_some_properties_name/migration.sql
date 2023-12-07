/*
  Warnings:

  - You are about to drop the column `valor` on the `SessaoPreCasamento` table. All the data in the column will be lost.
  - You are about to drop the column `valor` on the `MakingOf` table. All the data in the column will be lost.
  - You are about to drop the column `tamanho` on the `Painel` table. All the data in the column will be lost.
  - You are about to drop the column `valor` on the `Painel` table. All the data in the column will be lost.
  - Added the required column `value` to the `SessaoPreCasamento` table without a default value. This is not possible if the table is not empty.
  - Added the required column `value` to the `MakingOf` table without a default value. This is not possible if the table is not empty.
  - Added the required column `size` to the `Painel` table without a default value. This is not possible if the table is not empty.
  - Added the required column `value` to the `Painel` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_SessaoPreCasamento" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "value" REAL NOT NULL
);
INSERT INTO "new_SessaoPreCasamento" ("id") SELECT "id" FROM "SessaoPreCasamento";
DROP TABLE "SessaoPreCasamento";
ALTER TABLE "new_SessaoPreCasamento" RENAME TO "SessaoPreCasamento";
CREATE TABLE "new_MakingOf" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "value" REAL NOT NULL
);
INSERT INTO "new_MakingOf" ("id") SELECT "id" FROM "MakingOf";
DROP TABLE "MakingOf";
ALTER TABLE "new_MakingOf" RENAME TO "MakingOf";
CREATE TABLE "new_Painel" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "size" TEXT NOT NULL,
    "value" REAL NOT NULL
);
INSERT INTO "new_Painel" ("id") SELECT "id" FROM "Painel";
DROP TABLE "Painel";
ALTER TABLE "new_Painel" RENAME TO "Painel";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
