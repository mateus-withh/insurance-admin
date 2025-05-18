-- CreateEnum
CREATE TYPE "Role" AS ENUM ('ADMIN', 'CORRETOR');

-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "role" "Role" NOT NULL DEFAULT 'CORRETOR',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Client" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "cpfCnpj" TEXT NOT NULL,
    "cep" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "email" TEXT NOT NULL,

    CONSTRAINT "Client_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Seguradora" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "cnpj" TEXT NOT NULL,
    "contact" TEXT NOT NULL,
    "website" TEXT NOT NULL,

    CONSTRAINT "Seguradora_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Apolice" (
    "id" SERIAL NOT NULL,
    "clientId" INTEGER NOT NULL,
    "seguradoraId" INTEGER NOT NULL,
    "tipo" TEXT NOT NULL,
    "numeroApolice" TEXT NOT NULL,
    "valor" DOUBLE PRECISION NOT NULL,
    "dataInicio" TIMESTAMP(3) NOT NULL,
    "dataFim" TIMESTAMP(3) NOT NULL,
    "status" TEXT NOT NULL,

    CONSTRAINT "Apolice_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- AddForeignKey
ALTER TABLE "Apolice" ADD CONSTRAINT "Apolice_clientId_fkey" FOREIGN KEY ("clientId") REFERENCES "Client"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Apolice" ADD CONSTRAINT "Apolice_seguradoraId_fkey" FOREIGN KEY ("seguradoraId") REFERENCES "Seguradora"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

INSERT INTO "User" (id, name, email, password) VALUES ('123e4567-e89b-12d3-a456-426614174000', 'Teste', 'teste@exemplo.com', 'senha123');