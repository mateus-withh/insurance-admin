/*
  Warnings:

  - The primary key for the `Apolice` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `clientId` on the `Apolice` table. All the data in the column will be lost.
  - You are about to drop the column `dataFim` on the `Apolice` table. All the data in the column will be lost.
  - You are about to drop the column `dataInicio` on the `Apolice` table. All the data in the column will be lost.
  - You are about to drop the column `numeroApolice` on the `Apolice` table. All the data in the column will be lost.
  - You are about to drop the column `tipo` on the `Apolice` table. All the data in the column will be lost.
  - You are about to drop the column `valor` on the `Apolice` table. All the data in the column will be lost.
  - The primary key for the `Seguradora` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `contact` on the `Seguradora` table. All the data in the column will be lost.
  - You are about to drop the column `name` on the `Seguradora` table. All the data in the column will be lost.
  - You are about to drop the column `website` on the `Seguradora` table. All the data in the column will be lost.
  - The primary key for the `User` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the `Client` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[numero]` on the table `Apolice` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[nome]` on the table `Seguradora` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[cnpj]` on the table `Seguradora` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `clienteId` to the `Apolice` table without a default value. This is not possible if the table is not empty.
  - Added the required column `numero` to the `Apolice` table without a default value. This is not possible if the table is not empty.
  - Added the required column `premio` to the `Apolice` table without a default value. This is not possible if the table is not empty.
  - Added the required column `validadeFim` to the `Apolice` table without a default value. This is not possible if the table is not empty.
  - Added the required column `validadeInicio` to the `Apolice` table without a default value. This is not possible if the table is not empty.
  - Changed the type of `status` on the `Apolice` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Added the required column `nome` to the `Seguradora` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "ApoliceStatus" AS ENUM ('ATIVA', 'VENCIDA', 'CANCELADA');

-- DropForeignKey
ALTER TABLE "Apolice" DROP CONSTRAINT "Apolice_clientId_fkey";

-- DropForeignKey
ALTER TABLE "Apolice" DROP CONSTRAINT "Apolice_seguradoraId_fkey";

-- AlterTable
ALTER TABLE "Apolice" DROP CONSTRAINT "Apolice_pkey",
DROP COLUMN "clientId",
DROP COLUMN "dataFim",
DROP COLUMN "dataInicio",
DROP COLUMN "numeroApolice",
DROP COLUMN "tipo",
DROP COLUMN "valor",
ADD COLUMN     "clienteId" TEXT NOT NULL,
ADD COLUMN     "numero" TEXT NOT NULL,
ADD COLUMN     "premio" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "validadeFim" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "validadeInicio" TIMESTAMP(3) NOT NULL,
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "seguradoraId" SET DATA TYPE TEXT,
DROP COLUMN "status",
ADD COLUMN     "status" "ApoliceStatus" NOT NULL,
ADD CONSTRAINT "Apolice_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "Apolice_id_seq";

-- AlterTable
ALTER TABLE "Seguradora" DROP CONSTRAINT "Seguradora_pkey",
DROP COLUMN "contact",
DROP COLUMN "name",
DROP COLUMN "website",
ADD COLUMN     "nome" TEXT NOT NULL,
ADD COLUMN     "site" TEXT,
ADD COLUMN     "telefone" TEXT,
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD CONSTRAINT "Seguradora_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "Seguradora_id_seq";

-- AlterTable
ALTER TABLE "User" DROP CONSTRAINT "User_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "updatedAt" DROP DEFAULT,
ADD CONSTRAINT "User_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "User_id_seq";

-- DropTable
DROP TABLE "Client";

-- CreateTable
CREATE TABLE "Cliente" (
    "id" TEXT NOT NULL,
    "nome" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "telefone" TEXT NOT NULL,
    "cpf" TEXT NOT NULL,
    "cep" TEXT NOT NULL,
    "endereco" TEXT NOT NULL,
    "cidade" TEXT NOT NULL,
    "estado" TEXT NOT NULL,
    "userId" TEXT NOT NULL,

    CONSTRAINT "Cliente_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Cliente_email_key" ON "Cliente"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Cliente_cpf_key" ON "Cliente"("cpf");

-- CreateIndex
CREATE UNIQUE INDEX "Apolice_numero_key" ON "Apolice"("numero");

-- CreateIndex
CREATE UNIQUE INDEX "Seguradora_nome_key" ON "Seguradora"("nome");

-- CreateIndex
CREATE UNIQUE INDEX "Seguradora_cnpj_key" ON "Seguradora"("cnpj");

-- AddForeignKey
ALTER TABLE "Cliente" ADD CONSTRAINT "Cliente_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Apolice" ADD CONSTRAINT "Apolice_clienteId_fkey" FOREIGN KEY ("clienteId") REFERENCES "Cliente"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Apolice" ADD CONSTRAINT "Apolice_seguradoraId_fkey" FOREIGN KEY ("seguradoraId") REFERENCES "Seguradora"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
