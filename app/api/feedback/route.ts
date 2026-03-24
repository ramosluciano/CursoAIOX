import { NextRequest, NextResponse } from 'next/server';
import { prisma } from '@/lib/db';

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const { module, lesson, categoryId, text } = body;

    if (!module || !lesson || !categoryId || !text) {
      return NextResponse.json(
        { error: 'Campo obrigatório faltando' },
        { status: 400 }
      );
    }

    if (text.length < 10) {
      return NextResponse.json(
        { error: 'Feedback deve ter ao menos 10 caracteres' },
        { status: 400 }
      );
    }

    const category = await prisma.feedbackCategory.findUnique({
      where: { id: categoryId },
    });

    if (!category) {
      return NextResponse.json(
        { error: 'Categoria não encontrada' },
        { status: 404 }
      );
    }

    const feedback = await prisma.feedback.create({
      data: {
        module,
        lesson,
        categoryId,
        text,
        ipAddress: request.ip || 'unknown',
      },
      include: {
        category: true,
      },
    });

    // Atualizar stats
    try {
      await prisma.feedbackStats.upsert({
        where: {
          module_lesson_categoryId: {
            module,
            lesson,
            categoryId,
          },
        },
        update: { count: { increment: 1 } },
        create: { module, lesson, categoryId, count: 1 },
      });
    } catch (err) {
      console.warn('Erro ao atualizar stats:', err);
    }

    return NextResponse.json(feedback, { status: 201 });
  } catch (error) {
    console.error('Erro ao criar feedback:', error);
    return NextResponse.json(
      { error: 'Erro interno do servidor' },
      { status: 500 }
    );
  }
}

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url);
    const module = searchParams.get('module');
    const lesson = searchParams.get('lesson');
    const categoryId = searchParams.get('categoryId');
    const limit = parseInt(searchParams.get('limit') || '50', 10);
    const offset = parseInt(searchParams.get('offset') || '0', 10);

    const where: any = {};
    if (module) where.module = module;
    if (lesson) where.lesson = lesson;
    if (categoryId) where.categoryId = categoryId;

    const [feedbacks, total] = await Promise.all([
      prisma.feedback.findMany({
        where,
        include: { category: true },
        orderBy: { createdAt: 'desc' },
        take: limit,
        skip: offset,
      }),
      prisma.feedback.count({ where }),
    ]);

    return NextResponse.json({
      data: feedbacks,
      pagination: {
        total,
        limit,
        offset,
        pages: Math.ceil(total / limit),
      },
    });
  } catch (error) {
    console.error('Erro ao listar feedbacks:', error);
    return NextResponse.json(
      { error: 'Erro interno do servidor' },
      { status: 500 }
    );
  }
}
