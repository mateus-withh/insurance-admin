import { IsNotEmpty, IsString, IsEmail } from 'class-validator';

export class CreateClienteDto {
  nome: string;
  email: string;
  cpf: string;
  telefone: string;
  cep: string;
  endereco: string;
  cidade: string;
  estado: string;
  userId: string;
}
