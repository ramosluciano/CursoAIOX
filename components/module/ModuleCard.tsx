'use client';

import Link from 'next/link';
import { useEffect, useState } from 'react';

interface ModuleProgress {
  completed: number;
  total: number;
}

interface ModuleCardProps {
  module: 'basico' | 'bootcamp' | 'mastery';
  title: string;
  description: string;
  lessonCount: number;
  icon: React.ReactNode;
  href: string;
  gradient: string;
  textColor: string;
  badgeColor: string;
}

const LESSON_COUNTS = {
  basico: 8,
  bootcamp: 18,
  mastery: 22,
};

export function ModuleCard({
  module,
  title,
  description,
  lessonCount,
  icon,
  href,
  gradient,
  textColor,
  badgeColor,
}: ModuleCardProps) {
  const [progress, setProgress] = useState<(ModuleProgress & { percentage: number }) | null>(null);
  const [isMounted, setIsMounted] = useState(false);

  useEffect(() => {
    // Only run after mount to avoid hydration mismatch
    setIsMounted(true);

    const loadProgress = () => {
      try {
        const stored = localStorage.getItem('courseProgress');
        if (stored) {
          const data = JSON.parse(stored);
          const moduleProgress = data.moduleProgress?.[module] || {
            completed: 0,
            total: LESSON_COUNTS[module],
          };
          const percentage = moduleProgress.total > 0
            ? Math.round((moduleProgress.completed / moduleProgress.total) * 100)
            : 0;
          setProgress({ ...moduleProgress, percentage });
        } else {
          setProgress({
            completed: 0,
            total: LESSON_COUNTS[module],
            percentage: 0,
          });
        }
      } catch (error) {
        console.error('Error loading progress:', error);
        setProgress({
          completed: 0,
          total: LESSON_COUNTS[module],
          percentage: 0,
        });
      }
    };

    loadProgress();

    const handleProgressUpdate = () => {
      loadProgress();
    };

    window.addEventListener('progressUpdate', handleProgressUpdate);
    return () => window.removeEventListener('progressUpdate', handleProgressUpdate);
  }, [module]);

  // Render progress only after mount to avoid hydration issues
  const displayProgress = isMounted ? (progress?.percentage || 0) : 0;
  const displayCompleted = isMounted ? (progress?.completed || 0) : 0;
  const displayTotal = isMounted ? (progress?.total || LESSON_COUNTS[module]) : LESSON_COUNTS[module];

  return (
    <Link
      href={href}
      className={`group p-8 bg-gradient-to-br ${gradient} rounded-lg border-2 ${badgeColor} hover:border-opacity-80 transition-all hover:shadow-lg`}
    >
      <div className="flex items-center gap-3 mb-4">
        <div className={`w-8 h-8 ${textColor}`}>{icon}</div>
        <h2 className={`text-2xl font-bold ${textColor}`}>{title}</h2>
      </div>

      <p className="text-gray-600 mb-4">{description}</p>

      <ul className="text-sm text-gray-600 space-y-2 mb-6 text-left">
        <li>✓ {lessonCount} aulas</li>
        <li>✓ Projetos práticos</li>
        <li>✓ Aprendizado progressivo</li>
      </ul>

      {/* Progress Ring */}
      <div className="mb-4 flex items-center gap-4">
        <div className="flex items-center justify-center relative w-16 h-16">
          <svg className="absolute w-16 h-16 transform -rotate-90" viewBox="0 0 100 100">
            {/* Background circle */}
            <circle
              cx="50"
              cy="50"
              r="45"
              fill="none"
              stroke="currentColor"
              strokeWidth="8"
              className="text-gray-200"
            />
            {/* Progress circle */}
            <circle
              cx="50"
              cy="50"
              r="45"
              fill="none"
              stroke="currentColor"
              strokeWidth="8"
              strokeDasharray={`${Math.PI * 90}`}
              strokeDashoffset={`${Math.PI * 90 * (1 - displayProgress / 100)}`}
              className={`transition-all duration-500 ${textColor}`}
            />
          </svg>
          <div className="text-center">
            <div className={`text-2xl font-bold ${textColor}`}>
              {displayProgress}%
            </div>
          </div>
        </div>

        <div className="flex-1">
          <p className="text-sm text-gray-600">
            <span className="font-semibold">{displayCompleted}</span> de{' '}
            <span className="font-semibold">{displayTotal}</span> aulas
          </p>
          <p className="text-xs text-gray-500 mt-1">
            {displayTotal > 0
              ? `${displayTotal - displayCompleted} restantes`
              : 'Comece agora!'}
          </p>
        </div>
      </div>

      <span className={`${textColor} font-semibold group-hover:translate-x-1 inline-block transition-transform`}>
        {displayProgress === 100 ? 'Revisitar Módulo' : 'Continuar Aprendendo'} →
      </span>
    </Link>
  );
}
