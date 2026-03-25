'use client';

import { useState, useEffect } from 'react';
import { Trash2, Download, Filter } from 'lucide-react';
import Link from 'next/link';

// Mapa de cores para categorias (Tailwind CSS classes)
const CATEGORY_COLOR_MAP: Record<string, { bg: string; text: string }> = {
  red: { bg: 'bg-red-600', text: 'text-white' },
  yellow: { bg: 'bg-yellow-600', text: 'text-white' },
  blue: { bg: 'bg-blue-600', text: 'text-white' },
  purple: { bg: 'bg-purple-600', text: 'text-white' },
  orange: { bg: 'bg-orange-600', text: 'text-white' },
  pink: { bg: 'bg-pink-600', text: 'text-white' },
  amber: { bg: 'bg-amber-600', text: 'text-white' },
  slate: { bg: 'bg-slate-600', text: 'text-white' },
  green: { bg: 'bg-green-600', text: 'text-white' },
  indigo: { bg: 'bg-indigo-600', text: 'text-white' },
};

interface FeedbackItem {
  id: string;
  module: string;
  lesson: string;
  category: {
    name: string;
    slug: string;
    color: string;
  };
  text: string;
  ipAddress: string | null;
  createdAt: string;
}

interface PaginationData {
  data: FeedbackItem[];
  pagination: {
    total: number;
    limit: number;
    offset: number;
    pages: number;
  };
}

export default function FeedbacksAdminPage() {
  const [feedbacks, setFeedbacks] = useState<FeedbackItem[]>([]);
  const [loading, setLoading] = useState(true);
  const [pagination, setPagination] = useState({ total: 0, limit: 50, offset: 0, pages: 1 });
  const [filters, setFilters] = useState({ module: '', lesson: '', category: '' });
  const [categories, setCategories] = useState<any[]>([]);

  // Fetch categories
  useEffect(() => {
    const fetchCategories = async () => {
      try {
        const res = await fetch('/api/feedback/categories');
        if (res.ok) {
          const data = await res.json();
          setCategories(data);
        }
      } catch (err) {
        console.error('Erro ao carregar categorias:', err);
      }
    };
    fetchCategories();
  }, []);

  // Fetch feedbacks
  useEffect(() => {
    const fetchFeedbacks = async () => {
      setLoading(true);
      try {
        const params = new URLSearchParams();
        if (filters.module) params.append('module', filters.module);
        if (filters.lesson) params.append('lesson', filters.lesson);
        if (filters.category) params.append('categoryId', filters.category);
        params.append('limit', String(pagination.limit));
        params.append('offset', String(pagination.offset));

        const res = await fetch(`/api/feedback?${params.toString()}`);
        if (res.ok) {
          const data: PaginationData = await res.json();
          setFeedbacks(data.data);
          setPagination(data.pagination);
        }
      } catch (err) {
        console.error('Erro ao carregar feedbacks:', err);
      } finally {
        setLoading(false);
      }
    };

    fetchFeedbacks();
  }, [filters, pagination.offset]);

  const handleDelete = async (id: string) => {
    if (!confirm('Tem certeza que deseja deletar este feedback?')) return;

    try {
      const res = await fetch(`/api/feedback/${id}`, { method: 'DELETE' });
      if (res.ok) {
        setFeedbacks(feedbacks.filter(f => f.id !== id));
      } else {
        alert('Erro ao deletar feedback');
      }
    } catch (err) {
      console.error('Erro ao deletar:', err);
      alert('Erro ao deletar feedback');
    }
  };

  const handleExport = () => {
    const csv = [
      ['ID', 'Módulo', 'Aula', 'Categoria', 'Feedback', 'IP', 'Data'].join(','),
      ...feedbacks.map(f =>
        [
          f.id,
          f.module,
          f.lesson,
          f.category.name,
          `"${f.text.replace(/"/g, '""')}"`,
          f.ipAddress || '',
          new Date(f.createdAt).toLocaleString('pt-BR')
        ].join(',')
      )
    ].join('\n');

    const blob = new Blob([csv], { type: 'text/csv' });
    const url = window.URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `feedbacks-${new Date().toISOString().split('T')[0]}.csv`;
    a.click();
  };

  const modules = ['basico-claude-code', 'bootcamp', 'mastery'];

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h1 className="text-3xl font-bold text-gray-900 dark:text-white">
          📊 Feedbacks do Curso
        </h1>
        <button
          onClick={handleExport}
          disabled={feedbacks.length === 0}
          className="flex items-center gap-2 px-4 py-2 bg-green-600 hover:bg-green-700 disabled:bg-gray-400 text-white rounded-lg transition"
        >
          <Download className="w-4 h-4" />
          Exportar CSV
        </button>
      </div>

      {/* Filtros */}
      <div className="bg-white dark:bg-slate-800 rounded-lg p-6 border border-gray-200 dark:border-slate-700">
        <div className="flex items-center gap-2 mb-4">
          <Filter className="w-5 h-5" />
          <h2 className="text-lg font-semibold text-gray-900 dark:text-white">Filtros</h2>
        </div>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
              Módulo
            </label>
            <select
              value={filters.module}
              onChange={(e) => {
                setFilters({ ...filters, module: e.target.value, lesson: '' });
                setPagination({ ...pagination, offset: 0 });
              }}
              className="w-full px-3 py-2 border border-gray-300 dark:border-slate-600 rounded-lg bg-white dark:bg-slate-700 text-gray-900 dark:text-white"
            >
              <option value="">Todos</option>
              {modules.map(m => (
                <option key={m} value={m}>{m}</option>
              ))}
            </select>
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
              Categoria
            </label>
            <select
              value={filters.category}
              onChange={(e) => {
                setFilters({ ...filters, category: e.target.value });
                setPagination({ ...pagination, offset: 0 });
              }}
              className="w-full px-3 py-2 border border-gray-300 dark:border-slate-600 rounded-lg bg-white dark:bg-slate-700 text-gray-900 dark:text-white"
            >
              <option value="">Todas</option>
              {categories.map(c => (
                <option key={c.id} value={c.id}>{c.name}</option>
              ))}
            </select>
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
              Total
            </label>
            <div className="px-3 py-2 bg-gray-100 dark:bg-slate-700 rounded-lg text-gray-900 dark:text-white font-semibold">
              {pagination.total} feedbacks
            </div>
          </div>
        </div>
      </div>

      {/* Tabela */}
      {loading ? (
        <div className="text-center py-12 text-gray-500">Carregando...</div>
      ) : feedbacks.length === 0 ? (
        <div className="text-center py-12 text-gray-500">Nenhum feedback encontrado</div>
      ) : (
        <>
          <div className="overflow-x-auto bg-white dark:bg-slate-800 rounded-lg border border-gray-200 dark:border-slate-700">
            <table className="w-full">
              <thead className="bg-gray-50 dark:bg-slate-700 border-b border-gray-200 dark:border-slate-600">
                <tr>
                  <th className="px-6 py-3 text-left text-sm font-semibold text-gray-900 dark:text-white">Módulo</th>
                  <th className="px-6 py-3 text-left text-sm font-semibold text-gray-900 dark:text-white">Aula</th>
                  <th className="px-6 py-3 text-left text-sm font-semibold text-gray-900 dark:text-white">Categoria</th>
                  <th className="px-6 py-3 text-left text-sm font-semibold text-gray-900 dark:text-white">Feedback</th>
                  <th className="px-6 py-3 text-left text-sm font-semibold text-gray-900 dark:text-white">Data</th>
                  <th className="px-6 py-3 text-left text-sm font-semibold text-gray-900 dark:text-white">Ação</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-200 dark:divide-slate-700">
                {feedbacks.map(feedback => (
                  <tr key={feedback.id} className="hover:bg-gray-50 dark:hover:bg-slate-700 transition">
                    <td className="px-6 py-4 text-sm text-gray-900 dark:text-gray-300">{feedback.module}</td>
                    <td className="px-6 py-4 text-sm text-gray-900 dark:text-gray-300">{feedback.lesson}</td>
                    <td className="px-6 py-4 text-sm">
                      <span className={`inline-block px-3 py-1 rounded-full text-xs font-semibold ${CATEGORY_COLOR_MAP[feedback.category.color]?.bg || 'bg-gray-600'} ${CATEGORY_COLOR_MAP[feedback.category.color]?.text || 'text-white'}`}>
                        {feedback.category.name}
                      </span>
                    </td>
                    <td className="px-6 py-4 text-sm text-gray-900 dark:text-gray-300 max-w-md truncate">
                      {feedback.text}
                    </td>
                    <td className="px-6 py-4 text-sm text-gray-500 dark:text-gray-400">
                      {new Date(feedback.createdAt).toLocaleString('pt-BR')}
                    </td>
                    <td className="px-6 py-4 text-sm">
                      <button
                        onClick={() => handleDelete(feedback.id)}
                        className="text-red-600 hover:text-red-800 dark:hover:text-red-400 transition"
                        title="Deletar"
                      >
                        <Trash2 className="w-4 h-4" />
                      </button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>

          {/* Paginação */}
          <div className="flex items-center justify-between">
            <div className="text-sm text-gray-600 dark:text-gray-400">
              Mostrando {feedbacks.length > 0 ? pagination.offset + 1 : 0} a{' '}
              {Math.min(pagination.offset + pagination.limit, pagination.total)} de {pagination.total}
            </div>
            <div className="flex gap-2">
              <button
                onClick={() => setPagination({ ...pagination, offset: Math.max(0, pagination.offset - pagination.limit) })}
                disabled={pagination.offset === 0}
                className="px-4 py-2 bg-gray-200 dark:bg-slate-700 disabled:opacity-50 text-gray-900 dark:text-white rounded-lg"
              >
                ← Anterior
              </button>
              <div className="flex items-center px-4 py-2 text-gray-900 dark:text-white">
                Página {Math.floor(pagination.offset / pagination.limit) + 1} de {pagination.pages}
              </div>
              <button
                onClick={() => setPagination({ ...pagination, offset: pagination.offset + pagination.limit })}
                disabled={pagination.offset + pagination.limit >= pagination.total}
                className="px-4 py-2 bg-gray-200 dark:bg-slate-700 disabled:opacity-50 text-gray-900 dark:text-white rounded-lg"
              >
                Próxima →
              </button>
            </div>
          </div>
        </>
      )}

      {/* Voltar */}
      <div>
        <Link href="/" className="text-aiox-purple hover:underline">
          ← Voltar para home
        </Link>
      </div>
    </div>
  );
}
