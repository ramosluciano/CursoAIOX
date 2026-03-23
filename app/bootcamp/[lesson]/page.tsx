import { LessonRenderer } from '@/components/LessonRenderer';
import fs from 'fs';
import path from 'path';

const BOOTCAMP_LESSONS = [
  'aula-01-setup-anatomia',
  'aula-02-conceitos-fluxo',
  'aula-03-analyst-pm',
  'aula-04-architect-stories',
  'aula-05-devops-infra',
  'aula-06-dev-backend',
  'aula-07-dev-qa-frontend',
  'aula-08-devops-cicd-deploy',
  'aula-09-auction-analyst',
  'aula-10-pm-architect-spec',
  'aula-11-dev-scrapers',
  'aula-12-dev-normalization-api',
  'aula-13-devops-deploy-retro',
  'aula-14-squad-architecture',
  'aula-15-voice-content',
  'aula-16-backend-persistence',
  'aula-17-analytics-patterns',
  'aula-18-automation-brownfield-retro',
];

interface PageProps {
  params: {
    lesson: string;
  };
}

export async function generateStaticParams() {
  return BOOTCAMP_LESSONS.map((lesson) => ({
    lesson,
  }));
}

export default function LessonPage({ params }: PageProps) {
  const filePath = path.join(process.cwd(), 'Bootcamp', `${params.lesson}.md`);

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
  const lessonIndex = BOOTCAMP_LESSONS.indexOf(params.lesson);
  const nextLesson =
    lessonIndex < BOOTCAMP_LESSONS.length - 1
      ? BOOTCAMP_LESSONS[lessonIndex + 1]
      : undefined;
  const prevLesson = lessonIndex > 0 ? BOOTCAMP_LESSONS[lessonIndex - 1] : undefined;

  return (
    <LessonRenderer
      content={content}
      lessonSlug={params.lesson}
      module="bootcamp"
      lessonIndex={lessonIndex}
      totalLessons={BOOTCAMP_LESSONS.length}
      nextLesson={nextLesson}
      prevLesson={prevLesson}
    />
  );
}
