import { Global, Module } from '@nestjs/common';
import { PrismaService } from './prisma.service';

@Global()  // opcional, para que o PrismaService fique disponível globalmente
@Module({
  providers: [PrismaService],
  exports: [PrismaService],
})
export class PrismaModule {}