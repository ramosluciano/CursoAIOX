'use client';

import { Code2, Zap, Lightbulb, BookOpen, GraduationCap } from 'lucide-react';
import Link from 'next/link';
import { useState } from 'react';
import { TechnologiesModal } from '@/components/modals/TechnologiesModal';
import { AgentsModal } from '@/components/modals/AgentsModal';

const PROJECTS = [
  {
    id: 1,
    name: 'RockQuiz',
    module: 'Bootcamp',
    complexity: 'Médio',
    description: 'Aplicativo web interativo de quiz de rock com níveis de dificuldade progressivos, acumulação de pontos com multiplicadores e sistema de ranking público em tempo real.',
    technologies: [
      'Next.js 14',
      'Tailwind CSS',
      'Fastify',
      'PostgreSQL',
      'Redis',
      'Docker',
      'GitHub Actions',
      'Claude API',
    ],
    learningFocus: [
      'Pipeline AIOX completo ponta a ponta',
      'Frontend com React e Next.js',
      'API Backend com Fastify',
      'Dados em tempo real com Redis',
      'Testes e implantação',
    ],
    agents: [
      '@pm',
      '@architect',
      '@dev',
      '@qa',
      '@devops',
      '@analyst',
      '@sm',
      '@po',
      '@ux-design-expert',
    ],
    color: 'from-red-50 to-orange-50',
    borderColor: 'border-red-200',
    accentColor: 'text-red-600',
  },
  {
    id: 2,
    name: 'AuctionHunter',
    module: 'Bootcamp',
    complexity: 'Médio-Alto',
    description: 'Aplicação de web scraping para extrair dados de veículos de leilões online com estratégia de fallback de múltiplas camadas e tratamento de CAPTCHA.',
    technologies: [
      'Playwright',
      'pdfplumber',
      'Fastify',
      'PostgreSQL',
      'Docker',
      'LLM fallback',
    ],
    learningFocus: [
      'Motor de Execução ADE (13 passos)',
      'Sistema de Recuperação para falhas reais',
      'Implementação da Camada de Memória',
      'Especificação de documento com iteração',
      'Padrões de web scraping',
    ],
    agents: [
      '@dev',
      '@devops',
      '@qa',
      '@analyst',
      '@architect',
    ],
    color: 'from-blue-50 to-cyan-50',
    borderColor: 'border-blue-200',
    accentColor: 'text-blue-600',
  },
  {
    id: 3,
    name: 'Squad LinkedIn Automation',
    module: 'Bootcamp',
    complexity: 'Médio',
    description: 'Pipeline de automação de conteúdo alimentado por IA com quatro verticais editoriais produzindo posts LinkedIn personalizados usando squads de agentes especializados.',
    technologies: [
      'Arquitetura AIOX Squad',
      'Claude API',
      'LinkedIn API',
      'Node.js',
      'PostgreSQL',
      'n8n',
    ],
    learningFocus: [
      'Arquitetura e design de squads',
      'Criação de agentes personalizados',
      'YAML de fluxo AIOX',
      'Perfilamento de voz e correspondência de tom',
      'Integração MCP',
    ],
    agents: [
      '@squad-creator',
      '@dev',
      '@analyst',
      '@pm',
      '@devops',
    ],
    color: 'from-blue-50 to-indigo-50',
    borderColor: 'border-blue-300',
    accentColor: 'text-indigo-600',
  },
  {
    id: 4,
    name: 'Plataforma Zabbix Learning (SaaS)',
    module: 'Mastery',
    complexity: 'Muito Alto',
    description: 'Plataforma SaaS educacional abrangente com aulas geradas por IA, mecanismo de quiz adaptativo, ferramentas interativas e ambientes de laboratório efêmeros.',
    technologies: [
      'Next.js 14',
      'shadcn/ui',
      'Fastify',
      'PostgreSQL',
      'Redis',
      'Bull',
      'NextAuth.js',
      'Docker-in-Docker',
      'Kubernetes',
      'Claude API',
      'OpenTelemetry',
      'Zabbix',
    ],
    learningFocus: [
      'Mergulho profundo nos Internals AIOX',
      'ADE completo (todas as 7 Epics)',
      'Hooks personalizados',
      'Validação multi-IDE',
      'Pipelines RAG',
      'Arquitetura SaaS',
      'Padrões de observabilidade',
    ],
    agents: [
      '@architect',
      '@dev',
      '@devops',
      '@qa',
      '@pm',
      '@analyst',
      '@data-engineer',
      '@ux-design-expert',
    ],
    color: 'from-purple-50 to-pink-50',
    borderColor: 'border-purple-200',
    accentColor: 'text-purple-600',
  },
  {
    id: 5,
    name: 'LinkedIn Automation Brownfield',
    module: 'Mastery',
    complexity: 'Médio-Alto',
    description: 'Migração e aprimoramento de protótipo em aplicação de qualidade de produção com armazenamento persistente, painel de análises e agendamento automatizado.',
    technologies: [
      'Stack anterior',
      'PostgreSQL',
      'LinkedIn API',
      'React',
      'Agendamento Cron',
      'Webhooks',
    ],
    learningFocus: [
      'Fluxo Brownfield',
      'Fragmentação de documentos',
      'Mapeamento de codebase',
      'Extração de padrões',
      'Otimização de desempenho',
      'Hooks para automação',
    ],
    agents: [
      '@architect',
      '@dev',
      '@devops',
      '@analyst',
      '@qa',
    ],
    color: 'from-sky-50 to-cyan-50',
    borderColor: 'border-sky-200',
    accentColor: 'text-sky-600',
  },
  {
    id: 6,
    name: 'Squad N8N Automation',
    module: 'Mastery',
    complexity: 'Alto',
    description: 'Squad avançado que automatiza a criação de automações usando agentes AIOX para projetar, gerar, implantar e monitorar fluxos de trabalho n8n.',
    technologies: [
      'AIOX Squad',
      '@squad-creator',
      'n8n API',
      'Servidores MCP',
      'GitHub',
      'Versionamento semântico',
    ],
    learningFocus: [
      'Automação @squad-creator',
      'Integração MCP',
      'Composição de squads',
      'Procedimentos de testes formais',
      'Publicação no marketplace',
      'Padrões de meta-automação',
    ],
    agents: [
      '@squad-creator',
      '@dev',
      '@architect',
      '@devops',
    ],
    color: 'from-amber-50 to-orange-50',
    borderColor: 'border-amber-200',
    accentColor: 'text-amber-600',
  },
];

export default function ProjectsPage() {
  const bootcampProjects = PROJECTS.filter((p) => p.module === 'Bootcamp');
  const masteryProjects = PROJECTS.filter((p) => p.module === 'Mastery');
  const [techModalOpen, setTechModalOpen] = useState(false);
  const [agentsModalOpen, setAgentsModalOpen] = useState(false);

  return (
    <div className="space-y-12">
      <div className="text-center">
        <h1 className="text-4xl font-bold text-aiox-700 mb-4">Projetos</h1>
        <p className="text-lg text-gray-600">
          Construa 6 aplicações prontas para produção com complexidade real
        </p>
      </div>

      {/* Bootcamp Projects */}
      <section>
        <div className="mb-6">
          <h2 className="text-3xl font-bold text-aiox-700 flex items-center gap-2">
            <Code2 className="w-8 h-8" />
            Projetos Bootcamp
          </h2>
          <p className="text-gray-600 mt-2">
            Projetos de nível básico construindo habilidades fundamentais do AIOX
          </p>
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
          {bootcampProjects.map((project) => (
            <ProjectCard key={project.id} project={project} />
          ))}
        </div>
      </section>

      {/* Mastery Projects */}
      <section className="pt-12 border-t">
        <div className="mb-6">
          <h2 className="text-3xl font-bold text-aiox-600 flex items-center gap-2">
            <GraduationCap className="w-8 h-8" />
            Projetos Mastery
          </h2>
          <p className="text-gray-600 mt-2">
            Projetos avançados para desenvolvimento em nível de especialista
          </p>
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
          {masteryProjects.map((project) => (
            <ProjectCard key={project.id} project={project} />
          ))}
        </div>
      </section>

      {/* Summary Stats */}
      <section className="pt-12 border-t">
        <h2 className="text-2xl font-bold text-center mb-8 text-aiox-700">
          Visão Geral dos Projetos
        </h2>

        <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
          <Link
            href="/projects"
            className="p-6 bg-blue-50 rounded-lg border border-blue-200 hover:shadow-lg hover:scale-105 transition-all duration-300 cursor-pointer group"
          >
            <Code2 className="w-8 h-8 text-blue-600 mb-3 group-hover:scale-110 transition-transform" />
            <div className="font-bold text-2xl text-blue-600">6</div>
            <p className="text-sm text-gray-600 mt-1">Projetos Totais</p>
          </Link>

          <button
            onClick={() => setTechModalOpen(true)}
            className="p-6 bg-green-50 rounded-lg border border-green-200 hover:shadow-lg hover:scale-105 transition-all duration-300 cursor-pointer group text-left"
          >
            <Zap className="w-8 h-8 text-green-600 mb-3 group-hover:scale-110 transition-transform" />
            <div className="font-bold text-2xl text-green-600">30+</div>
            <p className="text-sm text-gray-600 mt-1">Tecnologias</p>
          </button>

          <Link
            href="/"
            className="p-6 bg-purple-50 rounded-lg border border-purple-200 hover:shadow-lg hover:scale-105 transition-all duration-300 cursor-pointer group"
          >
            <Lightbulb className="w-8 h-8 text-purple-600 mb-3 group-hover:scale-110 transition-transform" />
            <div className="font-bold text-2xl text-purple-600">48</div>
            <p className="text-sm text-gray-600 mt-1">Aulas</p>
          </Link>

          <button
            onClick={() => setAgentsModalOpen(true)}
            className="p-6 bg-pink-50 rounded-lg border border-pink-200 hover:shadow-lg hover:scale-105 transition-all duration-300 cursor-pointer group text-left"
          >
            <BookOpen className="w-8 h-8 text-pink-600 mb-3 group-hover:scale-110 transition-transform" />
            <div className="font-bold text-2xl text-pink-600">12</div>
            <p className="text-sm text-gray-600 mt-1">Agentes AIOX</p>
          </button>
        </div>

        <TechnologiesModal isOpen={techModalOpen} onClose={() => setTechModalOpen(false)} />
        <AgentsModal isOpen={agentsModalOpen} onClose={() => setAgentsModalOpen(false)} />
      </section>
    </div>
  );
}

function ProjectCard({
  project,
}: {
  project: (typeof PROJECTS)[0];
}) {
  return (
    <div
      className={`bg-gradient-to-br ${project.color} border-2 ${project.borderColor} rounded-lg p-6 transition-all hover:shadow-lg hover:scale-105 flex flex-col h-full`}
    >
      <div className="mb-4">
        <div className="mb-2">
          <h3 className="text-2xl font-bold text-gray-900 mb-2">{project.name}</h3>
          <div className="flex items-center gap-2 mb-2">
            <span className="text-xs font-semibold px-3 py-1 bg-white rounded-full text-gray-700">
              {project.complexity}
            </span>
            <p className="text-sm text-gray-600 font-semibold">{project.module}</p>
          </div>
        </div>
        <p className="text-gray-700">{project.description}</p>
      </div>

      <div className="mb-4">
        <p className="text-xs font-semibold text-gray-600 uppercase mb-2">
          Tecnologias
        </p>
        <div className="flex flex-wrap gap-2">
          {project.technologies.slice(0, 4).map((tech) => (
            <span
              key={tech}
              className="text-xs bg-white px-2 py-1 rounded text-gray-700 font-semibold"
            >
              {tech}
            </span>
          ))}
          {project.technologies.length > 4 && (
            <span className="text-xs bg-white px-2 py-1 rounded text-gray-700 font-semibold">
              +{project.technologies.length - 4}
            </span>
          )}
        </div>
      </div>

      <div className="mb-4">
        <p className="text-xs font-semibold text-gray-600 uppercase mb-2">
          Foco de Aprendizado
        </p>
        <ul className="text-sm space-y-1">
          {project.learningFocus.slice(0, 2).map((item, i) => (
            <li key={i} className="text-gray-700">
              ✓ {item}
            </li>
          ))}
          {project.learningFocus.length > 2 && (
            <li className="text-gray-600 font-semibold">
              + {project.learningFocus.length - 2} mais
            </li>
          )}
        </ul>
      </div>

      <div className="pt-4 border-t border-gray-300">
        <p className="text-xs font-semibold text-gray-600 uppercase mb-2">
          Agentes AIOX
        </p>
        <div className="flex flex-wrap gap-1">
          {project.agents.map((agent) => (
            <span
              key={agent}
              className="text-xs bg-white px-2 py-1 rounded text-gray-700"
            >
              {agent}
            </span>
          ))}
        </div>
      </div>
    </div>
  );
}
