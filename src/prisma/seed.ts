import { PrismaClient } from '@prisma/client';
import * as bcrypt from 'bcrypt';

const prisma = new PrismaClient();

async function main() {
  const password = await bcrypt.hash('admin123', 10);

  await prisma.user.upsert({
    where: { email: 'admin@admin.com' },
    update: {},
    create: {
      name: 'Admin',
      email: 'admin@admin.com',
      password,
      role: 'ADMIN',
    },
  });

  console.log('✅ Admin criado!');
}

main()
  .catch((e) => console.error(e))
  .finally(() => prisma.$disconnect());
