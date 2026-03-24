import { useState, useCallback, useEffect } from 'react';

export interface ProgressData {
  completedLessons: string[];
  totalLessons: number;
  moduleProgress: {
    [module: string]: {
      completed: number;
      total: number;
    };
  };
  version: number; // For migrations
}

const STORAGE_KEY = 'courseProgress';
const CURRENT_VERSION = 2;

const MODULES = {
  basico: { total: 10, label: 'Básico Claude Code' },
  bootcamp: { total: 18, label: 'Professional Bootcamp' },
  mastery: { total: 22, label: 'Mastery' },
};

export function useProgress() {
  const [progressData, setProgressData] = useState<ProgressData | null>(null);
  const [mounted, setMounted] = useState(false);

  // Initialize progress on mount
  useEffect(() => {
    const data = loadProgress();
    setProgressData(data);
    setMounted(true);
  }, []);

  const loadProgress = useCallback((): ProgressData => {
    const stored = localStorage.getItem(STORAGE_KEY);
    if (!stored) {
      return createDefaultProgress();
    }

    try {
      let data = JSON.parse(stored) as ProgressData;
      // Migrate if needed
      if (data.version !== CURRENT_VERSION) {
        data = migrateProgress(data);
      }
      return data;
    } catch {
      console.warn('Failed to parse progress data, resetting');
      return createDefaultProgress();
    }
  }, []);

  const saveProgress = useCallback((data: ProgressData) => {
    try {
      localStorage.setItem(STORAGE_KEY, JSON.stringify(data));
      setProgressData(data);
      // Emit event for header updates
      window.dispatchEvent(new Event('progressUpdate'));
    } catch (error) {
      console.error('Failed to save progress:', error);
    }
  }, []);

  const toggleLessonComplete = useCallback((lessonId: string, module: string) => {
    const data = progressData || loadProgress();
    const newData = { ...data };

    if (newData.completedLessons.includes(lessonId)) {
      // Mark as incomplete
      newData.completedLessons = newData.completedLessons.filter(id => id !== lessonId);
    } else {
      // Mark as complete
      newData.completedLessons.push(lessonId);
    }

    // Update module progress
    updateModuleProgress(newData, module);
    saveProgress(newData);
  }, [progressData, loadProgress, saveProgress]);

  const getModuleProgress = useCallback((module: keyof typeof MODULES) => {
    const data = progressData || loadProgress();
    return {
      completed: data.completedLessons.filter(id => id.startsWith(`${module}/`)).length,
      total: MODULES[module]?.total || 0,
    };
  }, [progressData, loadProgress]);

  const getGlobalProgress = useCallback(() => {
    const data = progressData || loadProgress();
    return {
      completedLessons: data.completedLessons.length,
      totalLessons: data.totalLessons,
      percentage: Math.round((data.completedLessons.length / data.totalLessons) * 100),
    };
  }, [progressData, loadProgress]);

  const isLessonComplete = useCallback((lessonId: string) => {
    const data = progressData || loadProgress();
    return data.completedLessons.includes(lessonId);
  }, [progressData, loadProgress]);

  const resetProgress = useCallback(() => {
    localStorage.removeItem(STORAGE_KEY);
    const newData = createDefaultProgress();
    setProgressData(newData);
    window.dispatchEvent(new Event('progressUpdate'));
  }, []);

  return {
    progressData,
    mounted,
    toggleLessonComplete,
    getModuleProgress,
    getGlobalProgress,
    isLessonComplete,
    resetProgress,
    loadProgress,
    saveProgress,
  };
}

// Helper functions
function createDefaultProgress(): ProgressData {
  return {
    completedLessons: [],
    totalLessons: 50, // 10 + 18 + 22
    moduleProgress: {
      basico: { completed: 0, total: MODULES.basico.total },
      bootcamp: { completed: 0, total: MODULES.bootcamp.total },
      mastery: { completed: 0, total: MODULES.mastery.total },
    },
    version: CURRENT_VERSION,
  };
}

function updateModuleProgress(data: ProgressData, module: string) {
  const completed = data.completedLessons.filter(id => id.startsWith(`${module}/`)).length;
  const total = MODULES[module as keyof typeof MODULES]?.total || 0;
  if (data.moduleProgress[module]) {
    data.moduleProgress[module] = { completed, total };
  }
}

// V1 to V2 migration: Single module (bootcamp/mastery) -> Multi-module (basico, bootcamp, mastery)
function migrateProgress(data: any): ProgressData {
  if (data.version === 1) {
    // V1 format: { completedLessons: ['bootcamp/lesson1', ...], totalLessons: 40 }
    return {
      completedLessons: data.completedLessons || [],
      totalLessons: 50, // New total with basico
      moduleProgress: {
        basico: { completed: 0, total: MODULES.basico.total },
        bootcamp: {
          completed: (data.completedLessons || []).filter((id: string) => id.startsWith('bootcamp/')).length,
          total: MODULES.bootcamp.total,
        },
        mastery: {
          completed: (data.completedLessons || []).filter((id: string) => id.startsWith('mastery/')).length,
          total: MODULES.mastery.total,
        },
      },
      version: CURRENT_VERSION,
    };
  }
  // If already at current version, return as-is
  return {
    ...data,
    version: CURRENT_VERSION,
  };
}
