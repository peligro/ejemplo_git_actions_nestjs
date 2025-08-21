-- CreateTable
CREATE TABLE "categoria" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "slug" TEXT NOT NULL,

    CONSTRAINT "categoria_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "receta" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "tiempo" TEXT NOT NULL,
    "descripcion" TEXT NOT NULL,
    "fecha" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "foto" TEXT NOT NULL,
    "categoria_id" INTEGER NOT NULL,
    "usuario_id" INTEGER NOT NULL DEFAULT 1,

    CONSTRAINT "receta_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "contacto" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "correo" TEXT NOT NULL,
    "telefono" TEXT NOT NULL,
    "mensaje" TEXT NOT NULL,
    "fecha" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "contacto_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "estado" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,

    CONSTRAINT "estado_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "usuario" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "correo" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "token" TEXT NOT NULL,
    "estado_id" INTEGER NOT NULL DEFAULT 2,

    CONSTRAINT "usuario_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "categoria_slug_key" ON "categoria"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "receta_slug_key" ON "receta"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "usuario_correo_key" ON "usuario"("correo");

-- AddForeignKey
ALTER TABLE "receta" ADD CONSTRAINT "receta_categoria_id_fkey" FOREIGN KEY ("categoria_id") REFERENCES "categoria"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "receta" ADD CONSTRAINT "receta_usuario_id_fkey" FOREIGN KEY ("usuario_id") REFERENCES "usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "usuario" ADD CONSTRAINT "usuario_estado_id_fkey" FOREIGN KEY ("estado_id") REFERENCES "estado"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
