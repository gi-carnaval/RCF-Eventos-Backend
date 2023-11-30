/*
  Warnings:

  - You are about to drop the column `capa` on the `Album` table. All the data in the column will be lost.
  - You are about to drop the column `paginas` on the `Album` table. All the data in the column will be lost.
  - You are about to drop the column `tamanho` on the `Album` table. All the data in the column will be lost.
  - You are about to drop the column `valor` on the `Album` table. All the data in the column will be lost.
  - Added the required column `albumCover` to the `Album` table without a default value. This is not possible if the table is not empty.
  - Added the required column `pages` to the `Album` table without a default value. This is not possible if the table is not empty.
  - Added the required column `size` to the `Album` table without a default value. This is not possible if the table is not empty.
  - Added the required column `value` to the `Album` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Album" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "size" TEXT NOT NULL,
    "pages" TEXT NOT NULL,
    "albumCover" TEXT NOT NULL,
    "value" REAL NOT NULL
);
INSERT INTO "new_Album" ("id") SELECT "id" FROM "Album";
DROP TABLE "Album";
ALTER TABLE "new_Album" RENAME TO "Album";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
