'use client';

import Link from 'next/link';
import { CheckCircle } from 'lucide-react';
import { useLessonCompletion } from '@/hooks/useLessonCompletion';

const LESSONS = [
  { slug: 'mastery-aula-01-internals', title: '01. Internals', description: 'AIOX internals' },
  { slug: 'mastery-aula-02-elicitation-agents', title: '02. Elicitation & Agents', description: 'Advanced agents' },
  { slug: 'mastery-aula-03-tasks-workflows', title: '03. Tasks & Workflows', description: 'Workflows' },
  { slug: 'mastery-aula-04-worktrees-migration', title: '04. Worktrees Migration', description: 'Migration' },
  { slug: 'mastery-aula-05-spec-pipeline', title: '05. Spec Pipeline', description: 'Pipeline' },
  { slug: 'mastery-aula-06-execution-engine', title: '06. Execution Engine', description: 'Engine' },
  { slug: 'mastery-aula-07-recovery-qa-memory', title: '07. Recovery QA Memory', description: 'QA' },
  { slug: 'mastery-aula-08-analyst-domain', title: '08. Analyst Domain', description: 'Analysis' },
  { slug: 'mastery-aula-09-prd-architecture', title: '09. PRD Architecture', description: 'Architecture' },
  { slug: 'mastery-aula-10-infra-saas', title: '10. Infra SaaS', description: 'Infrastructure' },
  { slug: 'mastery-aula-11-auth-billing', title: '11. Auth & Billing', description: 'Auth' },
  { slug: 'mastery-aula-12-content-engine', title: '12. Content Engine', description: 'Content' },
  { slug: 'mastery-aula-13-quiz-learning-path', title: '13. Quiz Learning Path', description: 'Learning' },
  { slug: 'mastery-aula-14-tooling-labs', title: '14. Tooling Labs', description: 'Labs' },
  { slug: 'mastery-aula-15-hooks', title: '15. Hooks', description: 'Hooks' },
  { slug: 'mastery-aula-16-multi-ide', title: '16. Multi IDE', description: 'IDE' },
  { slug: 'mastery-aula-17-brownfield-linkedin', title: '17. Brownfield LinkedIn', description: 'Brownfield' },
  { slug: 'mastery-aula-18-squad-zabbix-content', title: '18. Squad Zabbix Content', description: 'Squad' },
  { slug: 'mastery-aula-19-squad-creator-n8n', title: '19. Squad Creator N8N', description: 'Creator' },
  { slug: 'mastery-aula-20-mcp-testing', title: '20. MCP Testing', description: 'MCP' },
  { slug: 'mastery-aula-21-composition', title: '21. Composition', description: 'Composition' },
  { slug: 'mastery-aula-22-marketplace-consolidation', title: '22. Marketplace Consolidation', description: 'Marketplace' },
];

export default function MasteryPage() {
  const { completedLessons, isMounted } = useLessonCompletion();

  return (
    <div className="space-y-8">
      <div className="text-center">
        <h1 className="text-4xl font-bold text-aiox-600 mb-4">Programa Mastery AIOX</h1>
        <p className="text-lg text-gray-600">22 aulas avançadas para desenvolvimento AIOX em nível de especialista</p>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        {LESSONS.map((lesson, index) => {
          const isCompleted = isMounted && completedLessons.has(`mastery/${lesson.slug}`);

          return (
            <Link
              key={lesson.slug}
              href={`/mastery/${lesson.slug}`}
              className={`group p-6 rounded-lg border transition-all duration-300 ${
                isCompleted
                  ? 'bg-purple-50 border-aiox-accent/50 hover:border-aiox-accent'
                  : 'bg-white border-gray-200 hover:border-aiox-accent'
              } hover:shadow-lg`}
            >
              <div className="flex items-start gap-4">
                <div className={`flex-shrink-0 w-12 h-12 rounded-lg flex items-center justify-center font-bold transition-colors ${
                  isCompleted
                    ? 'bg-purple-200 text-aiox-accent'
                    : 'bg-cyan-100 text-aiox-accent group-hover:bg-aiox-accent group-hover:text-white'
                }`}>
                  {String(index + 1).padStart(2, '0')}
                </div>
                <div className="flex-1">
                  <div className="flex items-start gap-2">
                    <div className="flex-1">
                      <h3 className={`font-bold text-lg transition-colors ${
                        isCompleted
                          ? 'text-aiox-accent line-through'
                          : 'text-gray-900 group-hover:text-aiox-accent'
                      }`}>
                        {lesson.title}
                      </h3>
                      <p className={`text-sm mt-1 ${
                        isCompleted ? 'text-aiox-accent/70' : 'text-gray-600'
                      }`}>
                        {lesson.description}
                      </p>
                    </div>
                    {isCompleted && (
                      <CheckCircle className="w-5 h-5 text-aiox-accent flex-shrink-0 mt-1" />
                    )}
                  </div>
                </div>
                <span className={`font-semibold opacity-0 group-hover:opacity-100 transition-opacity ${
                  isCompleted ? 'text-aiox-accent' : 'text-aiox-accent'
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
