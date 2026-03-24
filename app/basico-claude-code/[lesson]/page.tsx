import { LessonRenderer } from '@/components/LessonRenderer';
import fs from 'fs';
import path from 'path';

const BASICO_LESSONS = [
  'aula-01-o-que-e-claude-code',
  'aula-02-setup-primeira-sessao',
  'aula-03-anatomia-claude-md',
  'aula-04-sistema-permissoes',
  'aula-05-memoria-persistente',
  'aula-06-rules-system-contexto',
  'aula-07-agentes-tasks-orquestracao',
  'aula-08-mcp-integracao-advanced',
];

interface PageProps {
  params: {
    lesson: string;
  };
}

export async function generateStaticParams() {
  return BASICO_LESSONS.map((lesson) => ({
    lesson,
  }));
}

export default function LessonPage({ params }: PageProps) {
  const filePath = path.join(process.cwd(), 'Básico-Claude-Code', `${params.lesson}.md`);

  if (!fs.existsSync(filePath)) {
    return (
      <div className="text-center py-12">
        <h1 className="text-2xl font-bold text-red-600 mb-4">
          Aula não encontrada
        </h1>
        <p className="text-gray-600">
          Desculpe, não conseguimos encontrar a aula solicitada.
        </p>
      </div>
    );
  }

  const content = fs.readFileSync(filePath, 'utf-8');
  const lessonIndex = BASICO_LESSONS.indexOf(params.lesson);
  const nextLesson =
    lessonIndex < BASICO_LESSONS.length - 1
      ? BASICO_LESSONS[lessonIndex + 1]
      : undefined;
  const prevLesson = lessonIndex > 0 ? BASICO_LESSONS[lessonIndex - 1] : undefined;

  return (
    <LessonRenderer
      content={content}
      lessonSlug={params.lesson}
      module="basico-claude-code"
      lessonIndex={lessonIndex}
      totalLessons={BASICO_LESSONS.length}
      nextLesson={nextLesson}
      prevLesson={prevLesson}
    />
  );
}
