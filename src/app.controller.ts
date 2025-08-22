import { Controller, Get } from '@nestjs/common';

@Controller()
export class AppController {

  @Get()
  getHello() {
    return {"estado": "ok", "mensaje":"Aplicación Nestjs 11 desde gitactions desplegada en EC2 de AWS mediante Pipeline con CI/CD"};
  }
}
