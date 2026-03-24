'use client';

import { X } from 'lucide-react';
import React from 'react';

interface TechnologiesModalProps {
  isOpen: boolean;
  onClose: () => void;
}

const PROJECTS_TECH = [
  {
    name: 'RockQuiz',
    technologies: ['Next.js 14', 'Tailwind CSS', 'Fastify', 'PostgreSQL', 'Redis', 'Docker', 'GitHub Actions', 'Claude API'],
  },
  {
    name: 'AuctionHunter',
    technologies: ['Playwright', 'pdfplumber', 'Fastify', 'PostgreSQL', 'Docker', 'LLM fallback'],
  },
  {
    name: 'Squad LinkedIn Automation',
    technologies: ['Arquitetura AIOX Squad', 'Claude API', 'LinkedIn API', 'Node.js', 'PostgreSQL', 'n8n'],
  },
  {
    name: 'Plataforma Zabbix Learning',
    technologies: ['Next.js 14', 'shadcn/ui', 'Fastify', 'PostgreSQL', 'Redis', 'Bull', 'NextAuth.js', 'Docker-in-Docker', 'Kubernetes', 'Claude API', 'OpenTelemetry', 'Zabbix'],
  },
  {
    name: 'LinkedIn Automation Brownfield',
    technologies: ['Stack anterior', 'PostgreSQL', 'LinkedIn API', 'React', 'Agendamento Cron', 'Webhooks'],
  },
  {
    name: 'Squad N8N Automation',
    technologies: ['AIOX Squad', 'n8n API', 'Servidores MCP', 'GitHub', 'Versionamento semântico'],
  },
];

export function TechnologiesModal({ isOpen, onClose }: TechnologiesModalProps) {
  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 p-4">
      <div className="bg-white dark:bg-slate-800 rounded-lg max-w-4xl max-h-[80vh] overflow-y-auto w-full">
        <div className="sticky top-0 bg-white dark:bg-slate-800 border-b border-gray-200 dark:border-slate-700 p-6 flex items-center justify-between">
          <h2 className="text-2xl font-bold text-gray-900 dark:text-white">Tecnologias dos Projetos</h2>
          <button
            onClick={onClose}
            className="p-2 hover:bg-gray-100 dark:hover:bg-slate-700 rounded-lg transition-colors"
          >
            <X className="w-5 h-5 text-gray-600 dark:text-gray-400" />
          </button>
        </div>

        <div className="p-6 space-y-6">
          {PROJECTS_TECH.map((project) => (
            <div key={project.name}>
              <h3 className="font-bold text-lg text-gray-900 dark:text-white mb-3">{project.name}</h3>
              <div className="flex flex-wrap gap-2">
                {project.technologies.map((tech) => (
                  <span
                    key={tech}
                    className="px-3 py-1 bg-blue-100 dark:bg-blue-900 text-blue-700 dark:text-blue-300 rounded-full text-sm font-semibold"
                  >
                    {tech}
                  </span>
                ))}
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}
