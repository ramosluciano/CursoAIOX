/**
 * Centralized course modules configuration
 * Single source of truth for all module data
 */

export type ModuleKey = 'basico-claude-code' | 'bootcamp' | 'mastery';

export interface CourseModule {
  key: ModuleKey;
  name: string;
  emoji: string;
  color: {
    text: string;
    bg: string;
    bgDark: string;
    heading: string;
    completed: string;
  };
  lessons: string[];
  filesDirectory: string;
}

export const COURSE_MODULES: Record<ModuleKey, CourseModule> = {
  'basico-claude-code': {
    key: 'basico-claude-code',
    name: 'Básico Claude Code',
    emoji: '🌱',
    color: {
      text: 'text-green-700',
      bg: 'bg-green-50',
      bgDark: 'dark:text-green-400',
      heading: 'text-aiox-700 dark:text-aiox-purple',
      completed: 'text-green-700',
    },
    lessons: [
      'aula-01-o-que-e-claude-code',
      'aula-02-setup-primeira-sessao',
      'aula-03-anatomia-claude-md',
      'aula-04-sistema-permissoes',
      'aula-05-memoria-persistente',
      'aula-06-rules-system-contexto',
      'aula-07-agentes-tasks-orquestracao',
      'aula-08-mcp-integracao-advanced',
    ],
    filesDirectory: 'Básico-Claude-Code',
  },
  bootcamp: {
    key: 'bootcamp',
    name: 'Professional Bootcamp',
    emoji: '📚',
    color: {
      text: 'text-aiox-700',
      bg: 'bg-aiox-50',
      bgDark: 'dark:text-aiox-accent',
      heading: 'text-aiox-700 dark:text-aiox-purple',
      completed: 'text-aiox-accent',
    },
    lessons: [
      'aula-01-setup-anatomia',
      'aula-02-conceitos-fluxo',
      'aula-03-analyst-pm',
      'aula-04-architect-stories',
      'aula-05-devops-infra',
      'aula-06-dev-backend',
      'aula-07-dev-qa-frontend',
      'aula-08-devops-cicd-deploy',
      'aula-09-auction-analyst',
      'aula-10-pm-architect-spec',
      'aula-11-dev-scrapers',
      'aula-12-dev-normalization-api',
      'aula-13-devops-deploy-retro',
      'aula-14-squad-architecture',
      'aula-15-voice-content',
      'aula-16-backend-persistence',
      'aula-17-analytics-patterns',
      'aula-18-automation-brownfield-retro',
    ],
    filesDirectory: 'Bootcamp',
  },
  mastery: {
    key: 'mastery',
    name: 'Programa Mastery AIOX',
    emoji: '🎓',
    color: {
      text: 'text-aiox-600',
      bg: 'bg-purple-50',
      bgDark: 'dark:text-aiox-accent',
      heading: 'text-aiox-700 dark:text-aiox-purple',
      completed: 'text-aiox-accent',
    },
    lessons: [
      'mastery-aula-01-internals',
      'mastery-aula-02-elicitation-agents',
      'mastery-aula-03-tasks-workflows',
      'mastery-aula-04-worktrees-migration',
      'mastery-aula-05-spec-pipeline',
      'mastery-aula-06-execution-engine',
      'mastery-aula-07-recovery-qa-memory',
      'mastery-aula-08-analyst-domain',
      'mastery-aula-09-prd-architecture',
      'mastery-aula-10-infra-saas',
      'mastery-aula-11-auth-billing',
      'mastery-aula-12-content-engine',
      'mastery-aula-13-quiz-learning-path',
      'mastery-aula-14-tooling-labs',
      'mastery-aula-15-hooks',
      'mastery-aula-16-multi-ide',
      'mastery-aula-17-brownfield-linkedin',
      'mastery-aula-18-squad-zabbix-content',
      'mastery-aula-19-squad-creator-n8n',
      'mastery-aula-20-mcp-testing',
      'mastery-aula-21-composition',
      'mastery-aula-22-marketplace-consolidation',
    ],
    filesDirectory: 'Mastery',
  },
};

export function getCourseModule(key: ModuleKey): CourseModule {
  const module = COURSE_MODULES[key];
  if (!module) {
    throw new Error(`Unknown course module: ${key}`);
  }
  return module;
}
