'use client';

import React, { useEffect, useState } from 'react';
import { marked } from 'marked';
import { Code, CheckCircle, ChevronLeft, ChevronRight } from 'lucide-react';
import Link from 'next/link';

interface LessonRendererProps {
  content: string;
  lessonSlug: string;
  module: 'basico-claude-code' | 'bootcamp' | 'mastery';
  lessonIndex: number;
  totalLessons: number;
  nextLesson?: string;
  prevLesson?: string;
}

export function LessonRenderer({
  content,
  lessonSlug,
  module,
  lessonIndex,
  totalLessons,
  nextLesson,
  prevLesson,
}: LessonRendererProps) {
  const [htmlContent, setHtmlContent] = useState('');
  const [isCompleted, setIsCompleted] = useState(false);

  useEffect(() => {
    // Configure marked options
    marked.setOptions({
      breaks: true,
      gfm: true,
    });

    // Process markdown (checkboxes are already converted in the .md files)
    Promise.resolve(marked(content)).then((html) => {
      let processedHtml = html as string;

      // Remove any disabled attributes that might be present
      processedHtml = processedHtml.replace(
        /\s+disabled(?=[\s/>])/g,
        ''
      );

      setHtmlContent(processedHtml);
    });

    // Check if lesson is completed
    const progress = localStorage.getItem('courseProgress');
    if (progress) {
      const progressData = JSON.parse(progress);
      const module_key = module === 'basico-claude-code' ? 'basico' : module;
      const lessonId = `${module_key}/${lessonSlug}`;
      setIsCompleted(progressData.completedLessons?.includes(lessonId) || false);
    }
  }, [content, lessonSlug, module]);

  const handleCompleteLesson = () => {
    const progress = localStorage.getItem('courseProgress');
    const module_key = module === 'basico-claude-code' ? 'basico' : module;
    const lessonId = `${module_key}/${lessonSlug}`;

    let progressData = progress
      ? JSON.parse(progress)
      : {
          completedLessons: [],
          totalLessons: 50,
          moduleProgress: {
            basico: { completed: 0, total: 8 },
            bootcamp: { completed: 0, total: 18 },
            mastery: { completed: 0, total: 22 },
          },
          version: 2,
        };

    const index = progressData.completedLessons.indexOf(lessonId);

    if (index > -1) {
      // Unmark as completed
      progressData.completedLessons.splice(index, 1);
      progressData.moduleProgress[module_key].completed--;
      setIsCompleted(false);
    } else {
      // Mark as completed
      progressData.completedLessons.push(lessonId);
      progressData.moduleProgress[module_key].completed++;
      setIsCompleted(true);
    }

    localStorage.setItem('courseProgress', JSON.stringify(progressData));
    window.dispatchEvent(new Event('progressUpdate'));
  };

  return (
    <article className="max-w-4xl mx-auto">
      {/* Lesson Header */}
      <div className="mb-8 pb-8 border-b border-gray-200 dark:border-slate-700">
        <h1 className="text-4xl font-bold text-aiox-700 dark:text-aiox-purple mb-2">
          {htmlContent ? extractTitle(content) : 'Carregando...'}
        </h1>
        <div className="flex items-center gap-4 text-gray-600 dark:text-gray-400">
          <p>
            Módulo:{' '}
            <span className="font-semibold">
              {module === 'basico-claude-code'
                ? 'Básico Claude Code'
                : module === 'bootcamp'
                  ? 'Professional Bootcamp'
                  : 'Mastery'}
            </span>
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
            href={`/${module}/${prevLesson}`}
            className="flex items-center gap-2 px-6 py-3 bg-gray-100 dark:bg-slate-700 text-gray-700 dark:text-gray-200 rounded-lg font-semibold hover:bg-gray-200 dark:hover:bg-slate-600 transition-colors"
          >
            <ChevronLeft className="w-5 h-5" />
            Aula Anterior
          </Link>
        ) : (
          <div />
        )}

        <div className="flex items-center gap-4">
          <button
            onClick={handleCompleteLesson}
            className={`px-6 py-3 rounded-lg font-semibold transition-all duration-300 flex items-center gap-2 whitespace-nowrap ${
              isCompleted
                ? 'bg-green-500 hover:bg-green-600 text-white'
                : 'bg-gray-100 dark:bg-slate-700 text-gray-700 dark:text-gray-200 hover:bg-gray-200 dark:hover:bg-slate-600'
            }`}
          >
            <CheckCircle className="w-5 h-5" />
            {isCompleted ? 'Concluída ✓' : 'Marcar como Concluída'}
          </button>

          {nextLesson ? (
            <Link
              href={`/${module}/${nextLesson}`}
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

function extractTitle(content: string): string {
  const match = content.match(/^#\s+(.+)$/m);
  return match ? match[1] : 'Aula';
}
