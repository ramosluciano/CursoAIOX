'use client';

import { useEffect, useState } from 'react';

export interface ModuleProgress {
  completed: number;
  total: number;
}

export interface ProgressData {
  completedLessons: string[];
  totalLessons: number;
  moduleProgress: {
    'basico-claude-code': ModuleProgress;
    'bootcamp': ModuleProgress;
    'mastery': ModuleProgress;
  };
  version: 2;
}

export interface GlobalProgress {
  completedLessons: number;
  totalLessons: number;
  percentage: number;
}

const STORAGE_KEY = 'courseProgress';
const LESSON_COUNTS = {
  'basico-claude-code': 8,
  'bootcamp': 18,
  'mastery': 22,
};

/**
 * Hook for managing course progress across 3 modules
 */
export function useProgress() {
  const [progressData, setProgressData] = useState<ProgressData | null>(null);
  const [mounted, setMounted] = useState(false);

  // Initialize from localStorage
  useEffect(() => {
    const stored = localStorage.getItem(STORAGE_KEY);

    if (stored) {
      try {
        const parsed = JSON.parse(stored);

        // Handle V1 to V2 migration
        if (parsed.version === 1 || !parsed.version) {
          const migrated = migrateV1ToV2(parsed);
          setProgressData(migrated);
          localStorage.setItem(STORAGE_KEY, JSON.stringify(migrated));
        } else {
          setProgressData(parsed);
        }
      } catch (error) {
        console.error('Error loading progress:', error);
        setProgressData(getDefaultProgress());
      }
    } else {
      setProgressData(getDefaultProgress());
    }

    setMounted(true);
  }, []);

  const getDefaultProgress = (): ProgressData => ({
    completedLessons: [],
    totalLessons: 48,
    moduleProgress: {
      'basico-claude-code': { completed: 0, total: LESSON_COUNTS['basico-claude-code'] },
      'bootcamp': { completed: 0, total: LESSON_COUNTS['bootcamp'] },
      'mastery': { completed: 0, total: LESSON_COUNTS['mastery'] },
    },
    version: 2,
  });

  const migrateV1ToV2 = (v1Data: any): ProgressData => {
    const moduleProgress: ProgressData['moduleProgress'] = {
      'basico-claude-code': { completed: 0, total: LESSON_COUNTS['basico-claude-code'] },
      'bootcamp': { completed: 0, total: LESSON_COUNTS['bootcamp'] },
      'mastery': { completed: 0, total: LESSON_COUNTS['mastery'] },
    };

    // Migrate completed lessons and count per module
    const migratedLessons: string[] = [];
    v1Data.completedLessons?.forEach((lessonId: string) => {
      const [module, ...rest] = lessonId.split('/');
      const lessonName = rest.join('/');

      // Migrate old 'basico/' to new 'basico-claude-code/'
      if (module === 'basico') {
        const newLessonId = `basico-claude-code/${lessonName}`;
        migratedLessons.push(newLessonId);
        moduleProgress['basico-claude-code'].completed++;
      } else if (module === 'bootcamp') {
        migratedLessons.push(lessonId);
        moduleProgress['bootcamp'].completed++;
      } else if (module === 'mastery') {
        migratedLessons.push(lessonId);
        moduleProgress['mastery'].completed++;
      }
    });

    return {
      completedLessons: migratedLessons,
      totalLessons: 48,
      moduleProgress,
      version: 2,
    };
  };

  const saveProgress = (newData: ProgressData) => {
    setProgressData(newData);
    localStorage.setItem(STORAGE_KEY, JSON.stringify(newData));
    window.dispatchEvent(new Event('progressUpdate'));
  };

  const loadProgress = (): ProgressData => {
    return progressData || getDefaultProgress();
  };

  const toggleLessonComplete = (lessonId: string, module: keyof typeof LESSON_COUNTS) => {
    if (!progressData) return;

    const newData = { ...progressData };
    const index = newData.completedLessons.indexOf(lessonId);

    if (index > -1) {
      // Remove from completed
      newData.completedLessons.splice(index, 1);
      newData.moduleProgress[module].completed--;
    } else {
      // Add to completed
      newData.completedLessons.push(lessonId);
      newData.moduleProgress[module].completed++;
    }

    saveProgress(newData);
  };

  const isLessonComplete = (lessonId: string): boolean => {
    if (!progressData) return false;
    return progressData.completedLessons.includes(lessonId);
  };

  const getModuleProgress = (module: keyof typeof LESSON_COUNTS): ModuleProgress => {
    if (!progressData) {
      return {
        completed: 0,
        total: LESSON_COUNTS[module],
      };
    }
    return progressData.moduleProgress[module];
  };

  const getGlobalProgress = (): GlobalProgress => {
    if (!progressData) {
      return {
        completedLessons: 0,
        totalLessons: 50,
        percentage: 0,
      };
    }

    const completedLessons = progressData.completedLessons.length;
    const totalLessons = progressData.totalLessons;
    const percentage = totalLessons > 0 ? Math.round((completedLessons / totalLessons) * 100) : 0;

    return {
      completedLessons,
      totalLessons,
      percentage,
    };
  };

  const resetProgress = () => {
    localStorage.removeItem(STORAGE_KEY);
    setProgressData(getDefaultProgress());
    window.dispatchEvent(new Event('progressUpdate'));
  };

  return {
    // State
    progressData,
    mounted,

    // Methods
    loadProgress,
    toggleLessonComplete,
    isLessonComplete,
    getModuleProgress,
    getGlobalProgress,
    resetProgress,
  };
}
