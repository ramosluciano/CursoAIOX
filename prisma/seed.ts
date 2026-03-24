import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

const FEEDBACK_CATEGORIES = [
  {
    name: 'Erro de Procedimento',
    slug: 'erro-procedimento',
    description: 'Passo ou comando está incorreto no procedimento descrito',
    color: 'red',
    icon: 'AlertCircle',
  },
  {
    name: 'Melhoria de Texto',
    slug: 'melhoria-texto',
    description: 'Texto pode ser melhorado para clareza ou compreensão',
    color: 'yellow',
    icon: 'Edit',
  },
  {
    name: 'Erro de Digitação / Semântica',
    slug: 'erro-digitacao',
    description: 'Typo, erro gramatical ou uso incorreto de termos',
    color: 'blue',
    icon: 'Spellcheck',
  },
  {
    name: 'Falta de Conteúdo',
    slug: 'falta-conteudo',
    description: 'Tópico importante não foi abordado nesta aula',
    color: 'purple',
    icon: 'PackageX',
  },
  {
    name: 'Comando Incorreto',
    slug: 'comando-incorreto',
    description: 'Comando CLI/terminal está errado ou desatualizado',
    color: 'red',
    icon: 'Terminal',
  },
  {
    name: 'Confusão na Navegação',
    slug: 'confusao-navegacao',
    description: 'Caminho ou localização do recurso é confuso',
    color: 'orange',
    icon: 'Map',
  },
  {
    name: 'Exercício Desalinhado',
    slug: 'exercicio-desalinhado',
    description: 'Exercício não combina com o conteúdo teórico',
    color: 'pink',
    icon: 'Zap',
  },
  {
    name: 'Checkpoint Inefetivo',
    slug: 'checkpoint-inefetivo',
    description: 'Checkpoint não valida corretamente o aprendizado',
    color: 'amber',
    icon: 'Flag',
  },
  {
    name: 'Link Quebrado',
    slug: 'link-quebrado',
    description: 'URL ou referência está quebrada ou inacessível',
    color: 'slate',
    icon: 'LinkX',
  },
  {
    name: 'Exemplo Não Funciona',
    slug: 'exemplo-nao-funciona',
    description: 'Código ou exemplo prático não funciona como descrito',
    color: 'red',
    icon: 'Bug',
  },
];

async function main() {
  console.log('🌱 Iniciando seed de categorias...');

  for (const category of FEEDBACK_CATEGORIES) {
    const exists = await prisma.feedbackCategory.findUnique({
      where: { slug: category.slug },
    });

    if (!exists) {
      await prisma.feedbackCategory.create({
        data: category,
      });
      console.log(`✅ Criada categoria: ${category.name}`);
    } else {
      console.log(`⏭️  Categoria já existe: ${category.name}`);
    }
  }

  console.log('✨ Seed concluído!');
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
