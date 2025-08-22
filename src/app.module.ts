import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { ConfigModule } from '@nestjs/config';
import { HealthController } from './controller/health/health.controller';
import { CategoriasController } from './controller/categorias/categorias.controller';
import { CategoriasService } from './servicios/categorias.service';

@Module({
  imports: [
    ConfigModule.forRoot(),
  ],
  controllers: [AppController, HealthController, CategoriasController],
  providers: [CategoriasService],
})
export class AppModule {}
