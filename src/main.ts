import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { Logger } from '@nestjs/common';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
   //habilitar CORS
    app.enableCors();
  await app.listen(`${process.env.CURSO_SERVER_PORT}`);
  Logger.debug(`Desplegando exitosamnte en el puerto ${process.env.CURSO_SERVER_PORT} desde un Pipeline CI/CD, en AWS con el servicio EC2  `)
}
bootstrap();
