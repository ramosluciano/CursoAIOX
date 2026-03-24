import { useState, useEffect } from 'react';

/**
 * Hook reutilizável para gerenciar estado de aulas concluídas
 * Sincroniza com localStorage e event listeners em tempo real
 */
export function useLessonCompletion() {
  const [completedLessons, setCompletedLessons] = useState<Set<string>>(new Set());
  const [isMounted, setIsMounted] = useState(false);

  useEffect(() => {
    setIsMounted(true);

    const loadCompleted = () => {
      try {
        const progress = localStorage.getItem('courseProgress');
        if (progress) {
          const progressData = JSON.parse(progress);
          const completed = new Set<string>(progressData.completedLessons || []);
          setCompletedLessons(completed);
        }
      } catch (error) {
        console.error('Error loading course progress:', error);
      }
    };

    // Initial load
    loadCompleted();

    // Listen for progress updates from other components
    const handleProgressUpdate = () => {
      loadCompleted();
    };

    window.addEventListener('progressUpdate', handleProgressUpdate);
    return () => {
      window.removeEventListener('progressUpdate', handleProgressUpdate);
    };
  }, []);

  return { completedLessons, isMounted };
}
