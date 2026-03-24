import { marked } from 'marked';
import { Code, ChevronLeft, ChevronRight } from 'lucide-react';
import Link from 'next/link';
import fs from 'fs';
import path from 'path';
import { LessonCompletionButton } from '@/components/LessonCompletionButton';

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

function extractTitle(content: string): string {
  const match = content.match(/^#\s+(.+)$/m);
  return match ? match[1] : 'Aula';
}

export default async function LessonPage({ params }: PageProps) {
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
  let htmlContent = await marked.parse(content) as string;

  // Remove disabled attributes from checkboxes to make them interactive
  htmlContent = htmlContent.replace(
    /\s*\bdisabled(?:="")?(?=[\s/>])/g,
    ''
  );

  // Remove h1 titles from content to avoid duplication (title is shown in header)
  htmlContent = htmlContent.replace(/<h1[^>]*>.*?<\/h1>\s*/gi, '');

  const title = extractTitle(content);
  const lessonIndex = BOOTCAMP_LESSONS.indexOf(params.lesson);
  const nextLesson =
    lessonIndex < BOOTCAMP_LESSONS.length - 1
      ? BOOTCAMP_LESSONS[lessonIndex + 1]
      : undefined;
  const prevLesson = lessonIndex > 0 ? BOOTCAMP_LESSONS[lessonIndex - 1] : undefined;

  return (
    <article className="max-w-4xl mx-auto">
      <div className="mb-8 pb-8 border-b border-gray-200 dark:border-slate-700">
        <h1 className="text-4xl font-bold text-aiox-700 dark:text-aiox-purple mb-2">
          {title}
        </h1>
        <div className="flex items-center gap-4 text-gray-600 dark:text-gray-400">
          <p>
            Módulo: <span className="font-semibold">Professional Bootcamp</span>
          </p>
          <p>
            Aula:{' '}
            <span className="font-semibold">
              {lessonIndex + 1} / {BOOTCAMP_LESSONS.length}
            </span>
          </p>
        </div>
      </div>

      <div
        className="prose dark:prose-invert max-w-none mb-8"
        dangerouslySetInnerHTML={{ __html: htmlContent }}
      />

      <div className="mt-12 pt-8 border-t border-gray-200 dark:border-slate-700">
        <div className="bg-blue-50 dark:bg-blue-900/20 p-6 rounded-lg border border-blue-200 dark:border-blue-800">
          <div className="flex items-start gap-3">
            <Code className="w-6 h-6 text-blue-600 dark:text-blue-400 flex-shrink-0 mt-1" />
            <div>
              <h3 className="font-bold text-lg text-blue-900 dark:text-blue-100 mb-2">
                Pratique o que você aprendeu
              </h3>
              <p className="text-blue-700 dark:text-blue-300">
                Implemente os conceitos desta aula em seus próprios projetos.
                Consulte a página de projetos para desafios práticos e exemplos
                de código.
              </p>
            </div>
          </div>
        </div>
      </div>

      <div className="mt-12 flex justify-between gap-4">
        {prevLesson ? (
          <Link
            href={`/bootcamp/${prevLesson}`}
            className="flex items-center gap-2 px-6 py-3 bg-gray-100 dark:bg-slate-700 text-gray-700 dark:text-gray-200 rounded-lg font-semibold hover:bg-gray-200 dark:hover:bg-slate-600 transition-colors"
          >
            <ChevronLeft className="w-5 h-5" />
            Aula Anterior
          </Link>
        ) : (
          <div />
        )}

        <div className="flex items-center gap-4">
          <LessonCompletionButton
            lessonId={params.lesson}
            module="bootcamp"
          />

          {nextLesson ? (
            <Link
              href={`/bootcamp/${nextLesson}`}
              className="flex items-center gap-2 px-6 py-3 bg-aiox-purple text-white rounded-lg font-semibold hover:bg-aiox-purple/90 transition-colors"
            >
              Próxima Aula
              <ChevronRight className="w-5 h-5" />
            </Link>
          ) : (
            <div className="px-6 py-3 bg-gray-100 dark:bg-slate-700 text-gray-500 dark:text-gray-400 rounded-lg font-semibold cursor-not-allowed">
              Parabéns! Você completou o módulo!
            </div>
          )}
        </div>
      </div>
    </article>
  );
}
