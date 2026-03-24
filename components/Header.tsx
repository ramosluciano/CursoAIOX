'use client';

import Link from 'next/link';
import { usePathname } from 'next/navigation';
import { Crown, Moon, Sun } from 'lucide-react';
import React, { useState, useEffect } from 'react';

export function Header() {
  const pathname = usePathname();
  const [mounted, setMounted] = useState(false);
  const [theme, setTheme] = useState<'light' | 'dark'>('light');

  // Only use theme context after mount
  let toggleTheme = () => {
    const newTheme = theme === 'light' ? 'dark' : 'light';
    setTheme(newTheme);
    localStorage.setItem('theme', newTheme);
    document.documentElement.classList.toggle('dark', newTheme === 'dark');
  };

  useEffect(() => {
    const savedTheme = localStorage.getItem('theme') as 'light' | 'dark' | null;
    const systemTheme = window.matchMedia('(prefers-color-scheme: dark)').matches
      ? 'dark'
      : 'light';

    const initialTheme = savedTheme || systemTheme;
    setTheme(initialTheme);
    setMounted(true);
  }, []);

  const isBasico = pathname.startsWith('/basico-claude-code');
  const isBootcamp = pathname.startsWith('/bootcamp');
  const isMastery = pathname.startsWith('/mastery');
  const isProjects = pathname.startsWith('/projects');

  return (
    <header className="border-b border-gray-200 dark:border-slate-700 bg-white dark:bg-slate-800 sticky top-0 z-30 transition-colors">
      <div className="flex items-center justify-between h-16 px-6">
        <Link href="/" className="flex items-center gap-2 hover:opacity-80 transition-opacity">
          <Crown className="w-6 h-6 text-aiox-purple" />
          <span className="font-bold text-lg text-aiox-700">AIOX</span>
        </Link>

        <nav className="flex items-center gap-8">
          <Link
            href="/basico-claude-code"
            className={`font-medium transition-colors ${
              isBasico
                ? 'text-green-700 dark:text-green-400 border-b-2 border-green-700 dark:border-green-400'
                : 'text-gray-600 hover:text-green-700 dark:hover:text-green-400'
            }`}
          >
            Básico
          </Link>
          <Link
            href="/bootcamp"
            className={`font-medium transition-colors ${
              isBootcamp
                ? 'text-blue-700 border-b-2 border-blue-700'
                : 'text-gray-600 hover:text-blue-700'
            }`}
          >
            Bootcamp
          </Link>
          <Link
            href="/mastery"
            className={`font-medium transition-colors ${
              isMastery
                ? 'text-stone-700 border-b-2 border-stone-700'
                : 'text-gray-600 hover:text-stone-700'
            }`}
          >
            Mastery
          </Link>
          <Link
            href="/projects"
            className={`font-medium transition-colors ${
              isProjects
                ? 'text-aiox-purple border-b-2 border-aiox-purple'
                : 'text-gray-600 hover:text-aiox-purple'
            }`}
          >
            Projetos
          </Link>
        </nav>

        <div className="flex items-center gap-4">
          <ProgressIndicator />
          {mounted && (
            <button
              onClick={toggleTheme}
              className="p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-slate-700 transition-colors"
              title={`Switch to ${theme === 'light' ? 'dark' : 'light'} mode`}
            >
              {theme === 'light' ? (
                <Moon className="w-5 h-5 text-gray-600 dark:text-gray-300" />
              ) : (
                <Sun className="w-5 h-5 text-yellow-500" />
              )}
            </button>
          )}
        </div>
      </div>
    </header>
  );
}

function ProgressIndicator() {
  const [progress, setProgress] = useState(0);

  // Migrate old data format to new format
  const migrateOldData = () => {
    const savedProgress = localStorage.getItem('courseProgress');
    if (!savedProgress) return;

    try {
      const data = JSON.parse(savedProgress);
      let needsMigration = false;

      // Check if there are old 'basico/' entries that need migration
      const migratedLessons = (data.completedLessons || []).map((lesson: string) => {
        if (lesson.startsWith('basico/') && !lesson.startsWith('basico-claude-code/')) {
          needsMigration = true;
          return lesson.replace('basico/', 'basico-claude-code/');
        }
        return lesson;
      });

      // If migration needed, update storage
      if (needsMigration) {
        console.log('[ProgressIndicator] Migrating old basico/ entries to basico-claude-code/');

        // Recalculate moduleProgress
        const moduleProgress = {
          'basico-claude-code': { completed: 0, total: 8 },
          'bootcamp': { completed: 0, total: 18 },
          'mastery': { completed: 0, total: 22 },
        };

        migratedLessons.forEach((lesson: string) => {
          const [module] = lesson.split('/');
          if (moduleProgress[module as keyof typeof moduleProgress]) {
            moduleProgress[module as keyof typeof moduleProgress].completed++;
          }
        });

        const migratedData = {
          ...data,
          completedLessons: migratedLessons,
          totalLessons: 48,
          moduleProgress,
          version: 2,
        };

        localStorage.setItem('courseProgress', JSON.stringify(migratedData));
        window.dispatchEvent(new Event('progressUpdate'));
        return migratedData;
      }

      return data;
    } catch (error) {
      console.error('[ProgressIndicator] Error during migration:', error);
      return null;
    }
  };

  const updateProgress = () => {
    // Run migration first (it updates localStorage if needed)
    migrateOldData();

    const savedProgress = localStorage.getItem('courseProgress');
    if (savedProgress) {
      const { completedLessons, totalLessons } = JSON.parse(savedProgress);
      const percent = Math.round((completedLessons.length / totalLessons) * 100);
      setProgress(percent);
    } else {
      setProgress(0);
    }
  };

  useEffect(() => {
    updateProgress();

    // Listen for progress updates
    const handleProgressUpdate = () => {
      updateProgress();
    };

    window.addEventListener('progressUpdate', handleProgressUpdate);
    return () => {
      window.removeEventListener('progressUpdate', handleProgressUpdate);
    };
  }, []);

  return (
    <div className="flex items-center gap-2">
      <span className="text-xs font-semibold text-gray-600 dark:text-gray-400 whitespace-nowrap">
        Progresso total
      </span>
      <div className="w-24 h-2 bg-gray-200 dark:bg-slate-700 rounded-full overflow-hidden">
        <div
          className="h-full bg-gradient-to-r from-aiox-purple to-aiox-accent transition-all duration-300"
          style={{ width: `${progress}%` }}
        />
      </div>
      <span className="text-sm font-semibold text-gray-600 dark:text-gray-300">
        {progress}%
      </span>
    </div>
  );
}
