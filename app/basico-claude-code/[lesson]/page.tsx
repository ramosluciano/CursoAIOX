import { LessonPageWrapper } from '@/components/LessonPageWrapper';
import { getCourseModule } from '@/lib/courseModules';
import {
  extractTitle,
  processMarkdownContent,
  getLessonFilePath,
  lessonFileExists,
  getLessonNavigation,
} from '@/lib/lessonServerUtils';

const MODULE_KEY = 'basico-claude-code' as const;
const MODULE = getCourseModule(MODULE_KEY);

interface PageProps {
  params: {
    lesson: string;
  };
}

export async function generateStaticParams() {
  return MODULE.lessons.map((lesson) => ({
    lesson,
  }));
}

export default async function LessonPage({ params }: PageProps) {
  const filePath = getLessonFilePath(MODULE, params.lesson);

  if (!lessonFileExists(MODULE, params.lesson)) {
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

  const fs = await import('fs');
  const rawContent = fs.readFileSync(filePath, 'utf-8');
  const title = extractTitle(rawContent);
  const content = await processMarkdownContent(filePath);

  const { lessonIndex, prevLesson, nextLesson } = getLessonNavigation(
    MODULE.lessons,
    params.lesson
  );

  return (
    <LessonPageWrapper
      moduleKey={MODULE_KEY}
      lessonId={params.lesson}
      title={title}
      lessonIndex={lessonIndex}
      totalLessons={MODULE.lessons.length}
      moduleName={MODULE.name}
      htmlContent={content}
      prevLesson={prevLesson}
      nextLesson={nextLesson}
    />
  );
}
