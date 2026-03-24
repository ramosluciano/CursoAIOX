'use client';

import { useEffect, useState } from 'react';

interface ProgressBarProps {
  completed: number;
  total: number;
  mode?: 'module' | 'global';
  showPercentage?: boolean;
}

export function ProgressBar({
  completed,
  total,
  mode = 'module',
  showPercentage = true,
}: ProgressBarProps) {
  const [percentage, setPercentage] = useState(0);

  useEffect(() => {
    const newPercentage = total > 0 ? Math.round((completed / total) * 100) : 0;
    setPercentage(newPercentage);
  }, [completed, total]);

  // Color gradient: red -> yellow -> green
  const getColorClass = () => {
    if (percentage < 33) {
      return 'bg-gradient-to-r from-red-500 to-orange-500';
    } else if (percentage < 66) {
      return 'bg-gradient-to-r from-yellow-500 to-orange-500';
    } else {
      return 'bg-gradient-to-r from-yellow-500 to-green-500';
    }
  };

  return (
    <div className="w-full">
      <div className="flex items-center justify-between mb-2">
        <span className="text-sm font-medium text-gray-700 dark:text-gray-300">
          {mode === 'global' ? 'Progresso Geral' : 'Progresso do Módulo'}
        </span>
        {showPercentage && (
          <span className="text-sm font-semibold text-gray-900 dark:text-white">
            {completed}/{total} ({percentage}%)
          </span>
        )}
      </div>
      <div className="h-3 bg-gray-200 dark:bg-slate-700 rounded-full overflow-hidden">
        <div
          className={`h-full ${getColorClass()} transition-all duration-500`}
          style={{ width: `${percentage}%` }}
        />
      </div>
    </div>
  );
}
