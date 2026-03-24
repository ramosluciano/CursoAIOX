'use client';

import { useState } from 'react';
import { MessageSquare } from 'lucide-react';
import { FeedbackModal } from './FeedbackModal';

interface LessonFeedbackButtonProps {
  module: 'basico-claude-code' | 'bootcamp' | 'mastery';
  lesson: string;
}

export function LessonFeedbackButton({ module, lesson }: LessonFeedbackButtonProps) {
  const [isOpen, setIsOpen] = useState(false);

  // Convert module names to display format
  const moduleDisplay: Record<string, string> = {
    'basico-claude-code': 'Básico Claude Code',
    'bootcamp': 'Professional Bootcamp',
    'mastery': 'Mastery'
  };

  return (
    <>
      {/* Floating button */}
      <button
        onClick={() => setIsOpen(true)}
        className="fixed bottom-8 right-8 z-40 flex items-center justify-center w-14 h-14 bg-aiox-purple text-white rounded-full shadow-lg hover:bg-aiox-purple/90 transition-all hover:scale-110 active:scale-95"
        title="Enviar feedback desta aula"
        aria-label="Enviar feedback"
      >
        <MessageSquare className="w-6 h-6" />
      </button>

      {/* Feedback Modal */}
      <FeedbackModal
        module={moduleDisplay[module]}
        lesson={lesson}
        isOpen={isOpen}
        onClose={() => setIsOpen(false)}
      />
    </>
  );
}
