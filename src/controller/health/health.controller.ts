import { Controller, Get, HttpCode, HttpStatus } from '@nestjs/common';

@Controller('health')
export class HealthController {
    @Get()
        @HttpCode(HttpStatus.OK)
        index()
        {
            return {"estado":"ok", "mensaje": "todo ok"};
        }
}
