import { renderHook, act } from '@testing-library/react';
import { useProgress, ProgressData } from '../../hooks/useProgress';

describe('useProgress - Multi-Module Progress System', () => {
  beforeEach(() => {
    localStorage.clear();
    jest.clearAllMocks();
  });

  describe('Initialization', () => {
    it('should initialize with default progress on first mount', () => {
      const { result } = renderHook(() => useProgress());

      expect(result.current.progressData).toBeNull();
      expect(result.current.mounted).toBe(false);

      // Wait for mount
      act(() => {
        jest.runAllTimers();
      });
    });

    it('should load existing progress from localStorage', () => {
      const existingData: ProgressData = {
        completedLessons: ['bootcamp/aula-01', 'bootcamp/aula-02'],
        totalLessons: 50,
        moduleProgress: {
          basico: { completed: 0, total: 10 },
          bootcamp: { completed: 2, total: 18 },
          mastery: { completed: 0, total: 22 },
        },
        version: 2,
      };

      localStorage.setItem('courseProgress', JSON.stringify(existingData));

      const { result } = renderHook(() => useProgress());
      act(() => {
        jest.runAllTimers();
      });

      expect(result.current.loadProgress()).toEqual(existingData);
    });

    it('should create default progress on empty storage', () => {
      const { result } = renderHook(() => useProgress());

      const defaultData = result.current.loadProgress();
      expect(defaultData.completedLessons).toEqual([]);
      expect(defaultData.totalLessons).toBe(50);
      expect(defaultData.version).toBe(2);
      expect(defaultData.moduleProgress).toEqual({
        basico: { completed: 0, total: 10 },
        bootcamp: { completed: 0, total: 18 },
        mastery: { completed: 0, total: 22 },
      });
    });
  });

  describe('getModuleProgress()', () => {
    it('should return progress for Básico module', () => {
      localStorage.setItem(
        'courseProgress',
        JSON.stringify({
          completedLessons: ['basico/aula-01', 'basico/aula-02'],
          totalLessons: 50,
          moduleProgress: {
            basico: { completed: 2, total: 10 },
            bootcamp: { completed: 0, total: 18 },
            mastery: { completed: 0, total: 22 },
          },
          version: 2,
        })
      );

      const { result } = renderHook(() => useProgress());
      act(() => {
        jest.runAllTimers();
      });

      const progress = result.current.getModuleProgress('basico');
      expect(progress.completed).toBe(2);
      expect(progress.total).toBe(10);
    });

    it('should return progress for Bootcamp module', () => {
      localStorage.setItem(
        'courseProgress',
        JSON.stringify({
          completedLessons: ['bootcamp/aula-01', 'bootcamp/aula-02', 'bootcamp/aula-03'],
          totalLessons: 50,
          moduleProgress: {
            basico: { completed: 0, total: 10 },
            bootcamp: { completed: 3, total: 18 },
            mastery: { completed: 0, total: 22 },
          },
          version: 2,
        })
      );

      const { result } = renderHook(() => useProgress());
      act(() => {
        jest.runAllTimers();
      });

      const progress = result.current.getModuleProgress('bootcamp');
      expect(progress.completed).toBe(3);
      expect(progress.total).toBe(18);
    });

    it('should return progress for Mastery module', () => {
      localStorage.setItem(
        'courseProgress',
        JSON.stringify({
          completedLessons: ['mastery/aula-01', 'mastery/aula-02'],
          totalLessons: 50,
          moduleProgress: {
            basico: { completed: 0, total: 10 },
            bootcamp: { completed: 0, total: 18 },
            mastery: { completed: 2, total: 22 },
          },
          version: 2,
        })
      );

      const { result } = renderHook(() => useProgress());
      act(() => {
        jest.runAllTimers();
      });

      const progress = result.current.getModuleProgress('mastery');
      expect(progress.completed).toBe(2);
      expect(progress.total).toBe(22);
    });

    it('should return 0 completed for new module', () => {
      const { result } = renderHook(() => useProgress());

      const progress = result.current.getModuleProgress('bootcamp');
      expect(progress.completed).toBe(0);
      expect(progress.total).toBe(18);
    });
  });

  describe('getGlobalProgress()', () => {
    it('should return 0% for empty progress', () => {
      const { result } = renderHook(() => useProgress());

      const progress = result.current.getGlobalProgress();
      expect(progress.completedLessons).toBe(0);
      expect(progress.totalLessons).toBe(50);
      expect(progress.percentage).toBe(0);
    });

    it('should calculate 25% progress (12.5/50 lessons)', () => {
      localStorage.setItem(
        'courseProgress',
        JSON.stringify({
          completedLessons: Array.from({ length: 12 }, (_, i) => `bootcamp/aula-${i + 1}`),
          totalLessons: 50,
          moduleProgress: {
            basico: { completed: 0, total: 10 },
            bootcamp: { completed: 12, total: 18 },
            mastery: { completed: 0, total: 22 },
          },
          version: 2,
        })
      );

      const { result } = renderHook(() => useProgress());
      act(() => {
        jest.runAllTimers();
      });

      const progress = result.current.getGlobalProgress();
      expect(progress.completedLessons).toBe(12);
      expect(progress.percentage).toBe(24); // Math.round(12/50 * 100) = 24
    });

    it('should calculate 50% progress across modules', () => {
      localStorage.setItem(
        'courseProgress',
        JSON.stringify({
          completedLessons: [
            ...Array.from({ length: 5 }, (_, i) => `basico/aula-${i + 1}`),
            ...Array.from({ length: 9 }, (_, i) => `bootcamp/aula-${i + 1}`),
            ...Array.from({ length: 11 }, (_, i) => `mastery/aula-${i + 1}`),
          ],
          totalLessons: 50,
          moduleProgress: {
            basico: { completed: 5, total: 10 },
            bootcamp: { completed: 9, total: 18 },
            mastery: { completed: 11, total: 22 },
          },
          version: 2,
        })
      );

      const { result } = renderHook(() => useProgress());
      act(() => {
        jest.runAllTimers();
      });

      const progress = result.current.getGlobalProgress();
      expect(progress.completedLessons).toBe(25);
      expect(progress.percentage).toBe(50);
    });

    it('should calculate 100% progress (all lessons completed)', () => {
      const allLessons = [
        ...Array.from({ length: 10 }, (_, i) => `basico/aula-${i + 1}`),
        ...Array.from({ length: 18 }, (_, i) => `bootcamp/aula-${i + 1}`),
        ...Array.from({ length: 22 }, (_, i) => `mastery/aula-${i + 1}`),
      ];

      localStorage.setItem(
        'courseProgress',
        JSON.stringify({
          completedLessons: allLessons,
          totalLessons: 50,
          moduleProgress: {
            basico: { completed: 10, total: 10 },
            bootcamp: { completed: 18, total: 18 },
            mastery: { completed: 22, total: 22 },
          },
          version: 2,
        })
      );

      const { result } = renderHook(() => useProgress());
      act(() => {
        jest.runAllTimers();
      });

      const progress = result.current.getGlobalProgress();
      expect(progress.completedLessons).toBe(50);
      expect(progress.percentage).toBe(100);
    });

    it('should round percentage correctly', () => {
      localStorage.setItem(
        'courseProgress',
        JSON.stringify({
          completedLessons: Array.from({ length: 17 }, (_, i) => `bootcamp/aula-${i + 1}`),
          totalLessons: 50,
          moduleProgress: {
            basico: { completed: 0, total: 10 },
            bootcamp: { completed: 17, total: 18 },
            mastery: { completed: 0, total: 22 },
          },
          version: 2,
        })
      );

      const { result } = renderHook(() => useProgress());
      act(() => {
        jest.runAllTimers();
      });

      const progress = result.current.getGlobalProgress();
      expect(progress.percentage).toBe(34); // Math.round(17/50 * 100) = 34
    });
  });

  describe('toggleLessonComplete()', () => {
    it('should mark lesson as complete', () => {
      const { result } = renderHook(() => useProgress());

      act(() => {
        result.current.toggleLessonComplete('bootcamp/aula-01', 'bootcamp');
      });

      expect(result.current.isLessonComplete('bootcamp/aula-01')).toBe(true);
    });

    it('should unmark lesson as complete', () => {
      localStorage.setItem(
        'courseProgress',
        JSON.stringify({
          completedLessons: ['bootcamp/aula-01'],
          totalLessons: 50,
          moduleProgress: {
            basico: { completed: 0, total: 10 },
            bootcamp: { completed: 1, total: 18 },
            mastery: { completed: 0, total: 22 },
          },
          version: 2,
        })
      );

      const { result } = renderHook(() => useProgress());
      act(() => {
        jest.runAllTimers();
      });

      act(() => {
        result.current.toggleLessonComplete('bootcamp/aula-01', 'bootcamp');
      });

      expect(result.current.isLessonComplete('bootcamp/aula-01')).toBe(false);
    });

    it('should allow toggling multiple lessons', () => {
      const { result } = renderHook(() => useProgress());

      act(() => {
        result.current.toggleLessonComplete('basico/aula-01', 'basico');
        result.current.toggleLessonComplete('bootcamp/aula-01', 'bootcamp');
        result.current.toggleLessonComplete('mastery/aula-01', 'mastery');
      });

      expect(result.current.isLessonComplete('basico/aula-01')).toBe(true);
      expect(result.current.isLessonComplete('bootcamp/aula-01')).toBe(true);
      expect(result.current.isLessonComplete('mastery/aula-01')).toBe(true);

      const progress = result.current.getGlobalProgress();
      expect(progress.completedLessons).toBe(3);
    });

    it('should not duplicate completed lessons', () => {
      const { result } = renderHook(() => useProgress());

      act(() => {
        result.current.toggleLessonComplete('bootcamp/aula-01', 'bootcamp');
        result.current.toggleLessonComplete('bootcamp/aula-01', 'bootcamp');
        result.current.toggleLessonComplete('bootcamp/aula-01', 'bootcamp');
      });

      expect(result.current.isLessonComplete('bootcamp/aula-01')).toBe(true);
      const data = result.current.loadProgress();
      expect(data.completedLessons.filter(id => id === 'bootcamp/aula-01').length).toBe(1);
    });

    it('should persist to localStorage', () => {
      const { result } = renderHook(() => useProgress());

      act(() => {
        result.current.toggleLessonComplete('bootcamp/aula-01', 'bootcamp');
      });

      const stored = localStorage.getItem('courseProgress');
      expect(stored).toBeTruthy();
      const data = JSON.parse(stored!);
      expect(data.completedLessons).toContain('bootcamp/aula-01');
    });

    it('should update module progress on toggle', () => {
      const { result } = renderHook(() => useProgress());

      act(() => {
        result.current.toggleLessonComplete('bootcamp/aula-01', 'bootcamp');
        result.current.toggleLessonComplete('bootcamp/aula-02', 'bootcamp');
      });

      const progress = result.current.getModuleProgress('bootcamp');
      expect(progress.completed).toBe(2);
    });
  });

  describe('resetProgress()', () => {
    it('should clear all progress', () => {
      localStorage.setItem(
        'courseProgress',
        JSON.stringify({
          completedLessons: [
            'basico/aula-01',
            'bootcamp/aula-01',
            'mastery/aula-01',
          ],
          totalLessons: 50,
          moduleProgress: {
            basico: { completed: 1, total: 10 },
            bootcamp: { completed: 1, total: 18 },
            mastery: { completed: 1, total: 22 },
          },
          version: 2,
        })
      );

      const { result } = renderHook(() => useProgress());
      act(() => {
        jest.runAllTimers();
      });

      act(() => {
        result.current.resetProgress();
      });

      expect(result.current.getGlobalProgress().completedLessons).toBe(0);
      expect(localStorage.getItem('courseProgress')).toBeNull();
    });

    it('should allow restarting after reset', () => {
      const { result } = renderHook(() => useProgress());

      act(() => {
        result.current.toggleLessonComplete('bootcamp/aula-01', 'bootcamp');
      });

      expect(result.current.isLessonComplete('bootcamp/aula-01')).toBe(true);

      act(() => {
        result.current.resetProgress();
      });

      expect(result.current.isLessonComplete('bootcamp/aula-01')).toBe(false);

      act(() => {
        result.current.toggleLessonComplete('basico/aula-01', 'basico');
      });

      expect(result.current.isLessonComplete('basico/aula-01')).toBe(true);
    });
  });

  describe('Data Migration (V1 → V2)', () => {
    it('should migrate V1 format with bootcamp lessons', () => {
      const v1Data = {
        completedLessons: [
          'bootcamp/aula-01',
          'bootcamp/aula-02',
          'bootcamp/aula-03',
        ],
        totalLessons: 40,
        version: 1,
      };

      localStorage.setItem('courseProgress', JSON.stringify(v1Data));

      const { result } = renderHook(() => useProgress());
      act(() => {
        jest.runAllTimers();
      });

      const migrated = result.current.loadProgress();
      expect(migrated.version).toBe(2);
      expect(migrated.totalLessons).toBe(50); // New total
      expect(migrated.completedLessons).toEqual(v1Data.completedLessons);
      expect(migrated.moduleProgress.bootcamp.completed).toBe(3);
      expect(migrated.moduleProgress.basico.completed).toBe(0);
      expect(migrated.moduleProgress.mastery.completed).toBe(0);
    });

    it('should migrate V1 format with mixed bootcamp and mastery lessons', () => {
      const v1Data = {
        completedLessons: [
          'bootcamp/aula-01',
          'mastery/aula-01',
          'mastery/aula-02',
        ],
        totalLessons: 40,
        version: 1,
      };

      localStorage.setItem('courseProgress', JSON.stringify(v1Data));

      const { result } = renderHook(() => useProgress());
      act(() => {
        jest.runAllTimers();
      });

      const migrated = result.current.loadProgress();
      expect(migrated.moduleProgress.bootcamp.completed).toBe(1);
      expect(migrated.moduleProgress.mastery.completed).toBe(2);
    });

    it('should preserve all lessons during migration', () => {
      const v1Data = {
        completedLessons: Array.from({ length: 18 }, (_, i) => `bootcamp/aula-${i + 1}`),
        totalLessons: 40,
        version: 1,
      };

      localStorage.setItem('courseProgress', JSON.stringify(v1Data));

      const { result } = renderHook(() => useProgress());
      act(() => {
        jest.runAllTimers();
      });

      const migrated = result.current.loadProgress();
      expect(migrated.completedLessons).toEqual(v1Data.completedLessons);
      expect(migrated.completedLessons.length).toBe(18);
    });
  });

  describe('localStorage Persistence', () => {
    it('should persist progress after toggle', () => {
      const { result } = renderHook(() => useProgress());

      act(() => {
        result.current.toggleLessonComplete('bootcamp/aula-01', 'bootcamp');
      });

      const stored = localStorage.getItem('courseProgress');
      expect(stored).toBeTruthy();

      const parsed = JSON.parse(stored!);
      expect(parsed.completedLessons).toContain('bootcamp/aula-01');
    });

    it('should persist module progress structure', () => {
      const { result } = renderHook(() => useProgress());

      act(() => {
        result.current.toggleLessonComplete('basico/aula-01', 'basico');
      });

      const stored = JSON.parse(localStorage.getItem('courseProgress')!);
      expect(stored.moduleProgress.basico.completed).toBe(1);
      expect(stored.moduleProgress.basico.total).toBe(10);
    });

    it('should handle corrupted localStorage gracefully', () => {
      localStorage.setItem('courseProgress', 'invalid json {[}');

      const { result } = renderHook(() => useProgress());
      act(() => {
        jest.runAllTimers();
      });

      const progress = result.current.getGlobalProgress();
      expect(progress.completedLessons).toBe(0);
      expect(progress.totalLessons).toBe(50);
    });

    it('should emit progressUpdate event on save', () => {
      const dispatchEventSpy = jest.spyOn(window, 'dispatchEvent');

      const { result } = renderHook(() => useProgress());

      act(() => {
        result.current.toggleLessonComplete('bootcamp/aula-01', 'bootcamp');
      });

      expect(dispatchEventSpy).toHaveBeenCalledWith(expect.objectContaining({
        type: 'progressUpdate',
      }));

      dispatchEventSpy.mockRestore();
    });
  });

  describe('Edge Cases', () => {
    it('should handle 0 completed lessons (0/48)', () => {
      const { result } = renderHook(() => useProgress());

      const progress = result.current.getGlobalProgress();
      expect(progress.completedLessons).toBe(0);
      expect(progress.percentage).toBe(0);
    });

    it('should handle all lessons completed (48/48)', () => {
      const allLessons = [
        ...Array.from({ length: 10 }, (_, i) => `basico/aula-${i + 1}`),
        ...Array.from({ length: 18 }, (_, i) => `bootcamp/aula-${i + 1}`),
        ...Array.from({ length: 22 }, (_, i) => `mastery/aula-${i + 1}`),
      ];

      localStorage.setItem(
        'courseProgress',
        JSON.stringify({
          completedLessons: allLessons,
          totalLessons: 50,
          moduleProgress: {
            basico: { completed: 10, total: 10 },
            bootcamp: { completed: 18, total: 18 },
            mastery: { completed: 22, total: 22 },
          },
          version: 2,
        })
      );

      const { result } = renderHook(() => useProgress());
      act(() => {
        jest.runAllTimers();
      });

      const progress = result.current.getGlobalProgress();
      expect(progress.completedLessons).toBe(50);
      expect(progress.percentage).toBe(100);
    });

    it('should handle partial progress', () => {
      localStorage.setItem(
        'courseProgress',
        JSON.stringify({
          completedLessons: [
            'basico/aula-01',
            'bootcamp/aula-01',
            'bootcamp/aula-02',
          ],
          totalLessons: 50,
          moduleProgress: {
            basico: { completed: 1, total: 10 },
            bootcamp: { completed: 2, total: 18 },
            mastery: { completed: 0, total: 22 },
          },
          version: 2,
        })
      );

      const { result } = renderHook(() => useProgress());
      act(() => {
        jest.runAllTimers();
      });

      expect(result.current.getModuleProgress('basico').completed).toBe(1);
      expect(result.current.getModuleProgress('bootcamp').completed).toBe(2);
      expect(result.current.getModuleProgress('mastery').completed).toBe(0);
    });

    it('should handle lesson ID formatting edge cases', () => {
      const { result } = renderHook(() => useProgress());

      act(() => {
        result.current.toggleLessonComplete('bootcamp/aula-01', 'bootcamp');
        result.current.toggleLessonComplete('bootcamp/aula-10', 'bootcamp');
        result.current.toggleLessonComplete('bootcamp/aula-18', 'bootcamp');
      });

      expect(result.current.isLessonComplete('bootcamp/aula-01')).toBe(true);
      expect(result.current.isLessonComplete('bootcamp/aula-10')).toBe(true);
      expect(result.current.isLessonComplete('bootcamp/aula-18')).toBe(true);
    });
  });
});
