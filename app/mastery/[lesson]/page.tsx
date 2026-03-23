import { LessonRenderer } from '@/components/LessonRenderer';
import fs from 'fs';
import path from 'path';

const MASTERY_LESSONS = [
  'mastery-aula-01-internals',
  'mastery-aula-02-elicitation-agents',
  'mastery-aula-03-tasks-workflows',
  'mastery-aula-04-worktrees-migration',
  'mastery-aula-05-spec-pipeline',
  'mastery-aula-06-execution-engine',
  'mastery-aula-07-recovery-qa-memory',
  'mastery-aula-08-analyst-domain',
  'mastery-aula-09-prd-architecture',
  'mastery-aula-10-infra-saas',
  'mastery-aula-11-auth-billing',
  'mastery-aula-12-content-engine',
  'mastery-aula-13-quiz-learning-path',
  'mastery-aula-14-tooling-labs',
  'mastery-aula-15-hooks',
  'mastery-aula-16-multi-ide',
  'mastery-aula-17-brownfield-linkedin',
  'mastery-aula-18-squad-zabbix-content',
  'mastery-aula-19-squad-creator-n8n',
  'mastery-aula-20-mcp-testing',
  'mastery-aula-21-composition',
  'mastery-aula-22-marketplace-consolidation',
];

interface PageProps {
  params: {
    lesson: string;
  };
}

export async function generateStaticParams() {
  return MASTERY_LESSONS.map((lesson) => ({
    lesson,
  }));
}

export default function LessonPage({ params }: PageProps) {
  const filePath = path.join(process.cwd(), 'Mastery', `${params.lesson}.md`);

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
  const lessonIndex = MASTERY_LESSONS.indexOf(params.lesson);
  const nextLesson =
    lessonIndex < MASTERY_LESSONS.length - 1
      ? MASTERY_LESSONS[lessonIndex + 1]
      : undefined;
  const prevLesson = lessonIndex > 0 ? MASTERY_LESSONS[lessonIndex - 1] : undefined;

  return (
    <LessonRenderer
      content={content}
      lessonSlug={params.lesson}
      module="mastery"
      lessonIndex={lessonIndex}
      totalLessons={MASTERY_LESSONS.length}
      nextLesson={nextLesson}
      prevLesson={prevLesson}
    />
  );
}
