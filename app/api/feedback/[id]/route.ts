import { NextRequest, NextResponse } from 'next/server';
import { prisma } from '@/lib/db';

export async function DELETE(
  _request: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const { id } = params;

    if (!id) {
      return NextResponse.json(
        { error: 'ID do feedback é obrigatório' },
        { status: 400 }
      );
    }

    // Verificar se feedback existe
    const feedback = await prisma.feedback.findUnique({
      where: { id },
    });

    if (!feedback) {
      return NextResponse.json(
        { error: 'Feedback não encontrado' },
        { status: 404 }
      );
    }

    // Deletar feedback
    const deleted = await prisma.feedback.delete({
      where: { id },
    });

    // Atualizar stats (decrementar count)
    try {
      await prisma.feedbackStats.updateMany({
        where: {
          module: feedback.module,
          lesson: feedback.lesson,
          categoryId: feedback.categoryId,
        },
        data: {
          count: { decrement: 1 },
        },
      });

      // Deletar stat se count ficar 0
      await prisma.feedbackStats.deleteMany({
        where: {
          count: { lte: 0 },
        },
      });
    } catch (err) {
      console.warn('Erro ao atualizar stats:', err);
    }

    return NextResponse.json(deleted, { status: 200 });
  } catch (error) {
    console.error('Erro ao deletar feedback:', error);
    return NextResponse.json(
      { error: 'Erro interno do servidor' },
      { status: 500 }
    );
  }
}
