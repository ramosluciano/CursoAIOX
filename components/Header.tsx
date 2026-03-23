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
            href="/bootcamp"
            className={`font-medium transition-colors ${
              isBootcamp
                ? 'text-aiox-purple border-b-2 border-aiox-purple'
                : 'text-gray-600 hover:text-aiox-purple'
            }`}
          >
            Bootcamp
          </Link>
          <Link
            href="/mastery"
            className={`font-medium transition-colors ${
              isMastery
                ? 'text-aiox-accent border-b-2 border-aiox-accent'
                : 'text-gray-600 hover:text-aiox-accent'
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
            Projects
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

  const updateProgress = () => {
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
