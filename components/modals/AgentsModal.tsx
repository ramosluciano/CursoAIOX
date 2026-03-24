'use client';

import { X } from 'lucide-react';
import React from 'react';

interface AgentsModalProps {
  isOpen: boolean;
  onClose: () => void;
}

const AGENTS = [
  {
    id: '@aiox-master',
    name: 'Orion (Master Orchestrator)',
    role: 'Maestro do Framework',
    description: 'Orquestra todos os agentes, governa o framework AIOX e executa operações meta-sistema',
  },
  {
    id: '@pm',
    name: 'Morgan (Product Manager)',
    role: 'Gerente de Produto',
    description: 'Responsável pela estratégia de produto, PRDs e visão do sistema',
  },
  {
    id: '@architect',
    name: 'Aria (Architect)',
    role: 'Arquiteto de Sistemas',
    description: 'Design de arquitetura, seleção de tecnologias e padrões técnicos',
  },
  {
    id: '@dev',
    name: 'Dex (Developer)',
    role: 'Desenvolvedor Senior',
    description: 'Implementação de features, coding e resolução de bugs',
  },
  {
    id: '@qa',
    name: 'Quinn (QA)',
    role: 'Especialista em Testes',
    description: 'Testes, garantia de qualidade e validação de código',
  },
  {
    id: '@devops',
    name: 'Gage (DevOps)',
    role: 'Engenheiro DevOps',
    description: 'CI/CD, infraestrutura, deploy e operações em produção',
  },
  {
    id: '@analyst',
    name: 'Atlas (Analyst)',
    role: 'Analista de Negócio',
    description: 'Pesquisa, análise de mercado e elicitação de requisitos',
  },
  {
    id: '@sm',
    name: 'River (Scrum Master)',
    role: 'Facilitador de Processo',
    description: 'Criação de stories, gestão de sprint e facilitação ágil',
  },
  {
    id: '@po',
    name: 'Pax (Product Owner)',
    role: 'Dono do Produto',
    description: 'Validação de stories, priorização e decisões de negócio',
  },
  {
    id: '@ux-design-expert',
    name: 'Uma (UX Design Expert)',
    role: 'Designer de UX/UI',
    description: 'Design de interfaces, experiência do usuário e prototipagem',
  },
  {
    id: '@squad-creator',
    name: 'Squad Creator',
    role: 'Criador de Squads',
    description: 'Orquestração de agentes especializados e automação em squads',
  },
  {
    id: '@data-engineer',
    name: 'Dara (Data Engineer)',
    role: 'Engenheiro de Dados',
    description: 'Design de schemas, otimização de queries e arquitetura de dados',
  },
];

export function AgentsModal({ isOpen, onClose }: AgentsModalProps) {
  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 p-4">
      <div className="bg-white dark:bg-slate-800 rounded-lg max-w-5xl max-h-[80vh] overflow-y-auto w-full">
        <div className="sticky top-0 bg-white dark:bg-slate-800 border-b border-gray-200 dark:border-slate-700 p-6 flex items-center justify-between">
          <h2 className="text-2xl font-bold text-gray-900 dark:text-white">Agentes AIOX</h2>
          <button
            onClick={onClose}
            className="p-2 hover:bg-gray-100 dark:hover:bg-slate-700 rounded-lg transition-colors"
          >
            <X className="w-5 h-5 text-gray-600 dark:text-gray-400" />
          </button>
        </div>

        <div className="p-6 space-y-4">
          {AGENTS.map((agent) => (
            <div
              key={agent.id}
              className="border border-gray-200 dark:border-slate-700 rounded-lg p-4 hover:shadow-md transition-shadow"
            >
              <div className="flex items-start gap-4">
                <div className="w-12 h-12 rounded-full bg-gradient-to-br from-purple-400 to-blue-500 flex items-center justify-center text-white font-bold text-lg flex-shrink-0">
                  {agent.id.charAt(1).toUpperCase()}
                </div>
                <div className="flex-1">
                  <div className="flex items-start justify-between gap-2">
                    <div>
                      <h3 className="font-bold text-gray-900 dark:text-white">{agent.name}</h3>
                      <p className="text-sm text-purple-600 dark:text-purple-400 font-semibold">{agent.role}</p>
                    </div>
                    <span className="text-xs font-mono bg-gray-100 dark:bg-slate-700 px-2 py-1 rounded text-gray-700 dark:text-gray-300">
                      {agent.id}
                    </span>
                  </div>
                  <p className="text-sm text-gray-600 dark:text-gray-400 mt-2">{agent.description}</p>
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}
