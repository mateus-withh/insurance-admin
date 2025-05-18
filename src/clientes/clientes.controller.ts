import { Controller, Get, Post, Put, Delete, Param, Body } from '@nestjs/common';
import { ClientesService } from './clientes.service';
import { CreateClienteDto } from './dto/create-cliente.dto';
import { UpdateClienteDto } from './dto/update-cliente.dto';

@Controller('clientes')
export class ClientesController {
  constructor(private readonly clientesService: ClientesService) {}

  @Get()
  findAll() {
    return this.clientesService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.clientesService.findOne(id);
  }

  @Post()
  create(@Body() data: CreateClienteDto) {
    return this.clientesService.create(data);
  }

  @Put(':id')
  update(@Param('id') id: string, @Body() data: UpdateClienteDto) {
    return this.clientesService.update(id, data);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.clientesService.remove(id);
  }
}
