'use client';

import Link from 'next/link';
import { ChevronLeft, ChevronRight, Code } from 'lucide-react';
import { LessonCompletionButton } from './LessonCompletionButton';
import { ModuleKey } from '@/lib/courseModules';

interface LessonPageWrapperProps {
  moduleKey: ModuleKey;
  lessonId: string;
  title: string;
  lessonIndex: number;
  totalLessons: number;
  moduleName: string;
  htmlContent: string;
  prevLesson?: string;
  nextLesson?: string;
}

export function LessonPageWrapper({
  moduleKey,
  lessonId,
  title,
  lessonIndex,
  totalLessons,
  moduleName,
  htmlContent,
  prevLesson,
  nextLesson,
}: LessonPageWrapperProps) {
  return (
    <article className="max-w-4xl mx-auto">
      {/* Lesson Header */}
      <div className="mb-8 pb-8 border-b border-gray-200 dark:border-slate-700">
        <h1 className="text-4xl font-bold text-aiox-700 dark:text-aiox-purple mb-2">
          {title}
        </h1>
        <div className="flex items-center gap-4 text-gray-600 dark:text-gray-400">
          <p>
            Módulo: <span className="font-semibold">{moduleName}</span>
          </p>
          <p>
            Aula:{' '}
            <span className="font-semibold">
              {lessonIndex + 1} / {totalLessons}
            </span>
          </p>
        </div>
      </div>

      {/* Lesson Content */}
      <div
        className="prose dark:prose-invert max-w-none mb-8"
        dangerouslySetInnerHTML={{ __html: htmlContent }}
      />

      {/* Lesson Footer */}
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

      {/* Navigation */}
      <div className="mt-12 flex justify-between gap-4">
        {prevLesson ? (
          <Link
            href={`/${moduleKey}/${prevLesson}`}
            className="flex items-center gap-2 px-6 py-3 bg-gray-100 dark:bg-slate-700 text-gray-700 dark:text-gray-200 rounded-lg font-semibold hover:bg-gray-200 dark:hover:bg-slate-600 transition-colors"
          >
            <ChevronLeft className="w-5 h-5" />
            Aula Anterior
          </Link>
        ) : (
          <div />
        )}

        <div className="flex items-center gap-4">
          <LessonCompletionButton lessonId={lessonId} module={moduleKey} />

          {nextLesson ? (
            <Link
              href={`/${moduleKey}/${nextLesson}`}
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
