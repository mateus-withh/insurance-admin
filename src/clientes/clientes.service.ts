import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateClienteDto } from './dto/create-cliente.dto';
import { UpdateClienteDto } from './dto/update-cliente.dto';

@Injectable()
export class ClientesService {
  constructor(private readonly prisma: PrismaService) {}

  async findAll() {
    return this.prisma.cliente.findMany();
  }

  async findOne(id: string) {
    const cliente = await this.prisma.cliente.findUnique({
      where: { id },
    });
    if (!cliente) {
      throw new NotFoundException(`Cliente with id ${id} not found`);
    }
    return cliente;
  }

  async create(data: CreateClienteDto) {
    const { userId, ...rest } = data;
    return this.prisma.cliente.create({
      data: {
        ...rest,
        user: {
          connect: { id: userId },
        },
      },
    });
  }

  async update(id: string, data: UpdateClienteDto) {
    const clienteExists = await this.prisma.cliente.findUnique({ where: { id } });
    if (!clienteExists) {
      throw new NotFoundException(`Cliente with id ${id} not found`);
    }
    return this.prisma.cliente.update({
      where: { id },
      data,
    });
  }

  async remove(id: string) {
    const clienteExists = await this.prisma.cliente.findUnique({ where: { id } });
    if (!clienteExists) {
      throw new NotFoundException(`Cliente with id ${id} not found`);
    }
    return this.prisma.cliente.delete({
      where: { id },
    });
  }
}
