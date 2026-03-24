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

  // Use module name directly as storage key
  const moduleKey = module;
  const fullLessonId = `${moduleKey}/${lessonId}`;

  // Initialize from localStorage
  useEffect(() => {
    console.log(`[LessonCompletionButton] Mount: module=${module}, lessonId=${lessonId}, fullLessonId=${fullLessonId}`);

    // Check if localStorage is available
    if (typeof window === 'undefined' || typeof localStorage === 'undefined') {
      console.log(`[LessonCompletionButton] localStorage not available, skipping initialization`);
      setIsMounted(true);
      return;
    }

    try {
      const progress = localStorage.getItem('courseProgress');
      console.log(`[LessonCompletionButton] localStorage.courseProgress:`, progress ? 'FOUND (length=' + progress.length + ')' : 'NOT_FOUND');

      if (progress) {
        const data = JSON.parse(progress);
        const isCompleted = data.completedLessons?.includes(fullLessonId) || false;
        console.log(`[LessonCompletionButton] Completed lessons:`, data.completedLessons, 'Is current completed?', isCompleted);
        setIsCompleted(isCompleted);
      } else {
        console.log(`[LessonCompletionButton] No progress found, initializing as incomplete`);
      }
    } catch (error) {
      console.error('[LessonCompletionButton] Error loading progress:', error);
    }

    setIsMounted(true);
  }, [fullLessonId, module, lessonId]);

  const handleToggleCompletion = () => {
    console.log(`[LessonCompletionButton] Click handler called for: ${fullLessonId}`);

    // Check if localStorage is available
    if (typeof window === 'undefined' || typeof localStorage === 'undefined') {
      console.error(`[LessonCompletionButton] localStorage not available in click handler`);
      return;
    }

    try {
      const progress = localStorage.getItem('courseProgress');
      console.log(`[LessonCompletionButton] Current storage before update:`, progress ? JSON.parse(progress) : 'EMPTY');

      let data = progress
        ? JSON.parse(progress)
        : {
            completedLessons: [],
            totalLessons: 48,
            moduleProgress: {
              'basico-claude-code': { completed: 0, total: 8 },
              bootcamp: { completed: 0, total: 18 },
              mastery: { completed: 0, total: 22 },
            },
            version: 2,
          };

      // Ensure moduleProgress entry exists for this module
      if (!data.moduleProgress[moduleKey]) {
        console.log(`[LessonCompletionButton] Initializing moduleProgress for ${moduleKey}`);
        const totalsByModule = {
          'basico-claude-code': 8,
          'bootcamp': 18,
          'mastery': 22,
        };
        data.moduleProgress[moduleKey] = {
          completed: 0,
          total: totalsByModule[moduleKey] || 8,
        };
      }

      const index = data.completedLessons.indexOf(fullLessonId);

      if (index > -1) {
        // Remove from completed
        console.log(`[LessonCompletionButton] Removing from completed`);
        data.completedLessons.splice(index, 1);
        data.moduleProgress[moduleKey].completed--;
        setIsCompleted(false);
      } else {
        // Add to completed
        console.log(`[LessonCompletionButton] Adding to completed`);
        data.completedLessons.push(fullLessonId);
        data.moduleProgress[moduleKey].completed++;
        setIsCompleted(true);
      }

      console.log(`[LessonCompletionButton] Storage after update:`, data);
      localStorage.setItem('courseProgress', JSON.stringify(data));
      console.log(`[LessonCompletionButton] Dispatching progressUpdate event`);
      window.dispatchEvent(new Event('progressUpdate'));
    } catch (error) {
      console.error('[LessonCompletionButton] Error updating progress:', error);
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
