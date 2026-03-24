'use client';

import Link from 'next/link';
import { CheckCircle } from 'lucide-react';
import { useLessonCompletion } from '@/hooks/useLessonCompletion';

const LESSONS = [
  { slug: 'aula-01-o-que-e-claude-code', title: '01. O que é Claude Code?', description: 'Introdução ao Claude Code' },
  { slug: 'aula-02-setup-primeira-sessao', title: '02. Setup e Primeira Sessão', description: 'Configurando seu ambiente' },
  { slug: 'aula-03-anatomia-claude-md', title: '03. Anatomia do CLAUDE.md', description: 'Entendendo o CLAUDE.md' },
  { slug: 'aula-04-sistema-permissoes', title: '04. Sistema de Permissões', description: 'Deny e Allow rules' },
  { slug: 'aula-05-memoria-persistente', title: '05. Memória Persistente', description: 'MEMORY.md e context' },
  { slug: 'aula-06-rules-system-contexto', title: '06. Rules System e Contexto', description: 'Sistema de regras' },
  { slug: 'aula-07-agentes-tasks-orquestracao', title: '07. Agentes, Tasks e Orquestração', description: 'Multi-agente' },
  { slug: 'aula-08-mcp-integracao-advanced', title: '08. MCP e Integração Advanced', description: 'MCP servers' },
];

export default function BasicoClaudeCodePage() {
  const { completedLessons, isMounted } = useLessonCompletion();

  return (
    <div className="space-y-8">
      <div className="text-center">
        <h1 className="text-4xl font-bold text-green-700 mb-4">Básico Claude Code</h1>
        <p className="text-lg text-gray-600">8 aulas para dominar Claude Code desde o início</p>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        {LESSONS.map((lesson, index) => {
          const isCompleted = isMounted && completedLessons.has(`basico-claude-code/${lesson.slug}`);

          return (
            <Link
              key={lesson.slug}
              href={`/basico-claude-code/${lesson.slug}`}
              className={`group p-6 rounded-lg border transition-all duration-300 ${
                isCompleted
                  ? 'bg-green-50 border-green-300 hover:border-green-400'
                  : 'bg-white border-gray-200 hover:border-green-500'
              } hover:shadow-lg`}
            >
              <div className="flex items-start gap-4">
                <div className={`flex-shrink-0 w-12 h-12 rounded-lg flex items-center justify-center font-bold transition-colors ${
                  isCompleted
                    ? 'bg-green-200 text-green-700'
                    : 'bg-green-100 text-green-700 group-hover:bg-green-700 group-hover:text-white'
                }`}>
                  {String(index + 1).padStart(2, '0')}
                </div>
                <div className="flex-1">
                  <div className="flex items-start gap-2">
                    <div className="flex-1">
                      <h3 className={`font-bold text-lg transition-colors ${
                        isCompleted
                          ? 'text-green-700 line-through'
                          : 'text-gray-900 group-hover:text-green-700'
                      }`}>
                        {lesson.title}
                      </h3>
                      <p className={`text-sm mt-1 ${
                        isCompleted ? 'text-green-600' : 'text-gray-600'
                      }`}>
                        {lesson.description}
                      </p>
                    </div>
                    {isCompleted && (
                      <CheckCircle className="w-5 h-5 text-green-600 flex-shrink-0 mt-1" />
                    )}
                  </div>
                </div>
                <span className={`font-semibold opacity-0 group-hover:opacity-100 transition-opacity ${
                  isCompleted ? 'text-green-600' : 'text-green-700'
                }`}>
                  →
                </span>
              </div>
            </Link>
          );
        })}
      </div>
    </div>
  );
}
