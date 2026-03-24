'use client';

import { CheckCircle } from 'lucide-react';
import { useState, useEffect } from 'react';

interface LessonCompletionButtonProps {
  lessonId: string;
  module: 'basico-claude-code' | 'bootcamp' | 'mastery';
}

export function LessonCompletionButton({
  lessonId,
  module,
}: LessonCompletionButtonProps) {
  const [isCompleted, setIsCompleted] = useState(false);
  const [isMounted, setIsMounted] = useState(false);

  // Map module names to storage keys
  const getStorageKey = (mod: string) => {
    if (mod === 'basico-claude-code') return 'basico';
    return mod;
  };

  const moduleKey = getStorageKey(module);
  const fullLessonId = `${moduleKey}/${lessonId}`;

  // Initialize from localStorage
  useEffect(() => {
    setIsMounted(true);

    try {
      const progress = localStorage.getItem('courseProgress');
      if (progress) {
        const data = JSON.parse(progress);
        setIsCompleted(data.completedLessons?.includes(fullLessonId) || false);
      }
    } catch (error) {
      console.error('Error loading progress:', error);
    }
  }, [fullLessonId]);

  const handleToggleCompletion = () => {
    try {
      const progress = localStorage.getItem('courseProgress');
      let data = progress
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

      const index = data.completedLessons.indexOf(fullLessonId);

      if (index > -1) {
        // Remove from completed
        data.completedLessons.splice(index, 1);
        data.moduleProgress[moduleKey].completed--;
        setIsCompleted(false);
      } else {
        // Add to completed
        data.completedLessons.push(fullLessonId);
        data.moduleProgress[moduleKey].completed++;
        setIsCompleted(true);
      }

      localStorage.setItem('courseProgress', JSON.stringify(data));
      window.dispatchEvent(new Event('progressUpdate'));
    } catch (error) {
      console.error('Error updating progress:', error);
    }
  };

  if (!isMounted) {
    return (
      <button
        disabled
        className="px-6 py-3 rounded-lg font-semibold transition-all duration-300 flex items-center gap-2 whitespace-nowrap bg-gray-100 dark:bg-slate-700 text-gray-700 dark:text-gray-200"
      >
        <CheckCircle className="w-5 h-5" />
        Marcar como Concluída
      </button>
    );
  }

  return (
    <button
      onClick={handleToggleCompletion}
      className={`px-6 py-3 rounded-lg font-semibold transition-all duration-300 flex items-center gap-2 whitespace-nowrap ${
        isCompleted
          ? 'bg-green-500 hover:bg-green-600 text-white'
          : 'bg-gray-100 dark:bg-slate-700 text-gray-700 dark:text-gray-200 hover:bg-gray-200 dark:hover:bg-slate-600'
      }`}
    >
      <CheckCircle className="w-5 h-5" />
      {isCompleted ? 'Concluída ✓' : 'Marcar como Concluída'}
    </button>
  );
}
