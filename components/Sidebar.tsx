'use client';

import Link from 'next/link';
import { usePathname } from 'next/navigation';
import { ChevronDown, CheckCircle } from 'lucide-react';
import React, { useState, useEffect } from 'react';

export function Sidebar() {
  const pathname = usePathname();
  const [expandedModule, setExpandedModule] = useState<'bootcamp' | 'mastery' | null>(
    pathname.startsWith('/bootcamp')
      ? 'bootcamp'
      : pathname.startsWith('/mastery')
        ? 'mastery'
        : null
  );
  const [completedLessons, setCompletedLessons] = useState<Set<string>>(new Set());

  useEffect(() => {
    const loadCompleted = () => {
      const progress = localStorage.getItem('courseProgress');
      if (progress) {
        const { completedLessons: completed } = JSON.parse(progress);
        setCompletedLessons(new Set(completed));
      }
    };

    loadCompleted();

    const handleProgressUpdate = () => {
      loadCompleted();
    };

    window.addEventListener('progressUpdate', handleProgressUpdate);
    return () => {
      window.removeEventListener('progressUpdate', handleProgressUpdate);
    };
  }, []);

  return (
    <aside className="w-64 bg-aiox-50 dark:bg-slate-800 border-r border-gray-200 dark:border-slate-700 overflow-y-auto hidden md:flex flex-col transition-colors">
      {/* Navigation Modules */}
      <nav className="flex-1 p-6 space-y-4">
        {/* Bootcamp Module */}
        <div>
          <button
            onClick={() =>
              setExpandedModule(
                expandedModule === 'bootcamp' ? null : 'bootcamp'
              )
            }
            className="w-full flex items-center justify-between px-4 py-2 font-bold text-lg rounded-lg hover:bg-white dark:hover:bg-slate-700 transition-colors text-aiox-700 dark:text-aiox-accent group"
          >
            📚 Bootcamp
            <ChevronDown
              className={`w-5 h-5 transition-transform ${
                expandedModule === 'bootcamp' ? 'rotate-180' : ''
              }`}
            />
          </button>

          {expandedModule === 'bootcamp' && (
            <div className="mt-2 space-y-1 ml-4">
              {BOOTCAMP_LESSONS.map((lesson) => {
                const isCompleted = completedLessons.has(`bootcamp/${lesson.slug}`);
                const isCurrent = pathname === `/bootcamp/${lesson.slug}`;

                return (
                  <Link
                    key={lesson.slug}
                    href={`/bootcamp/${lesson.slug}`}
                    className={`flex items-center gap-2 px-4 py-2 rounded text-sm transition-colors ${
                      isCurrent
                        ? 'bg-aiox-purple text-white font-semibold'
                        : isCompleted
                          ? 'bg-gray-200 dark:bg-slate-700 text-gray-500 dark:text-gray-400 line-through'
                          : 'text-gray-700 dark:text-gray-300 hover:bg-white dark:hover:bg-slate-700'
                    }`}
                  >
                    {isCompleted && !isCurrent && (
                      <CheckCircle className="w-4 h-4 flex-shrink-0 text-green-600" />
                    )}
                    <span className="flex-1">{lesson.title}</span>
                  </Link>
                );
              })}
            </div>
          )}
        </div>

        {/* Mastery Module */}
        <div className="pt-4 border-t border-gray-300 dark:border-slate-700">
          <button
            onClick={() =>
              setExpandedModule(
                expandedModule === 'mastery' ? null : 'mastery'
              )
            }
            className="w-full flex items-center justify-between px-4 py-2 font-bold text-lg rounded-lg hover:bg-white dark:hover:bg-slate-700 transition-colors text-aiox-600 dark:text-aiox-accent group"
          >
            🎓 Mastery
            <ChevronDown
              className={`w-5 h-5 transition-transform ${
                expandedModule === 'mastery' ? 'rotate-180' : ''
              }`}
            />
          </button>

          {expandedModule === 'mastery' && (
            <div className="mt-2 space-y-1 ml-4">
              {MASTERY_LESSONS.map((lesson) => {
                const isCompleted = completedLessons.has(`mastery/${lesson.slug}`);
                const isCurrent = pathname === `/mastery/${lesson.slug}`;

                return (
                  <Link
                    key={lesson.slug}
                    href={`/mastery/${lesson.slug}`}
                    className={`flex items-center gap-2 px-4 py-2 rounded text-sm transition-colors ${
                      isCurrent
                        ? 'bg-aiox-accent text-white font-semibold'
                        : isCompleted
                          ? 'bg-gray-200 dark:bg-slate-700 text-gray-500 dark:text-gray-400 line-through'
                          : 'text-gray-700 dark:text-gray-300 hover:bg-white dark:hover:bg-slate-700'
                    }`}
                  >
                    {isCompleted && !isCurrent && (
                      <CheckCircle className="w-4 h-4 flex-shrink-0 text-green-600" />
                    )}
                    <span className="flex-1">{lesson.title}</span>
                  </Link>
                );
              })}
            </div>
          )}
        </div>
      </nav>

      {/* Footer */}
      <div className="p-6 border-t border-gray-200 dark:border-slate-700 bg-white dark:bg-slate-800 transition-colors">
        <Link
          href="/projects"
          className="flex items-center gap-2 px-4 py-2 rounded-lg bg-aiox-purple text-white font-semibold hover:bg-aiox-purple/90 transition-colors text-center justify-center"
        >
          🚀 View Projects
        </Link>
      </div>
    </aside>
  );
}

// Lesson data - generated from file system
const BOOTCAMP_LESSONS = [
  { slug: 'aula-01-setup-anatomia', title: '01. Setup & Anatomia' },
  { slug: 'aula-02-conceitos-fluxo', title: '02. Conceitos & Fluxo' },
  { slug: 'aula-03-analyst-pm', title: '03. Analyst & PM' },
  { slug: 'aula-04-architect-stories', title: '04. Architect & Stories' },
  { slug: 'aula-05-devops-infra', title: '05. DevOps & Infra' },
  { slug: 'aula-06-dev-backend', title: '06. Dev Backend' },
  { slug: 'aula-07-dev-qa-frontend', title: '07. Dev QA Frontend' },
  { slug: 'aula-08-devops-cicd-deploy', title: '08. DevOps CI/CD Deploy' },
  { slug: 'aula-09-auction-analyst', title: '09. Auction Analyst' },
  { slug: 'aula-10-pm-architect-spec', title: '10. PM Architect Spec' },
  { slug: 'aula-11-dev-scrapers', title: '11. Dev Scrapers' },
  { slug: 'aula-12-dev-normalization-api', title: '12. Dev Normalization API' },
  { slug: 'aula-13-devops-deploy-retro', title: '13. DevOps Deploy Retro' },
  { slug: 'aula-14-squad-architecture', title: '14. Squad Architecture' },
  { slug: 'aula-15-voice-content', title: '15. Voice Content' },
  { slug: 'aula-16-backend-persistence', title: '16. Backend Persistence' },
  { slug: 'aula-17-analytics-patterns', title: '17. Analytics Patterns' },
  { slug: 'aula-18-automation-brownfield-retro', title: '18. Automation Brownfield' },
];

const MASTERY_LESSONS = [
  { slug: 'mastery-aula-01-internals', title: '01. Internals' },
  { slug: 'mastery-aula-02-elicitation-agents', title: '02. Elicitation & Agents' },
  { slug: 'mastery-aula-03-tasks-workflows', title: '03. Tasks & Workflows' },
  { slug: 'mastery-aula-04-worktrees-migration', title: '04. Worktrees Migration' },
  { slug: 'mastery-aula-05-spec-pipeline', title: '05. Spec Pipeline' },
  { slug: 'mastery-aula-06-execution-engine', title: '06. Execution Engine' },
  { slug: 'mastery-aula-07-recovery-qa-memory', title: '07. Recovery QA Memory' },
  { slug: 'mastery-aula-08-analyst-domain', title: '08. Analyst Domain' },
  { slug: 'mastery-aula-09-prd-architecture', title: '09. PRD Architecture' },
  { slug: 'mastery-aula-10-infra-saas', title: '10. Infra SaaS' },
  { slug: 'mastery-aula-11-auth-billing', title: '11. Auth & Billing' },
  { slug: 'mastery-aula-12-content-engine', title: '12. Content Engine' },
  { slug: 'mastery-aula-13-quiz-learning-path', title: '13. Quiz Learning Path' },
  { slug: 'mastery-aula-14-tooling-labs', title: '14. Tooling Labs' },
  { slug: 'mastery-aula-15-hooks', title: '15. Hooks' },
  { slug: 'mastery-aula-16-multi-ide', title: '16. Multi IDE' },
  { slug: 'mastery-aula-17-brownfield-linkedin', title: '17. Brownfield LinkedIn' },
  { slug: 'mastery-aula-18-squad-zabbix-content', title: '18. Squad Zabbix Content' },
  { slug: 'mastery-aula-19-squad-creator-n8n', title: '19. Squad Creator N8N' },
  { slug: 'mastery-aula-20-mcp-testing', title: '20. MCP Testing' },
  { slug: 'mastery-aula-21-composition', title: '21. Composition' },
  { slug: 'mastery-aula-22-marketplace-consolidation', title: '22. Marketplace Consolidation' },
];
