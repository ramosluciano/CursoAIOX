import { ReactNode } from 'react';
import Link from 'next/link';
import { BarChart3, MessageSquare } from 'lucide-react';

export default function AdminLayout({ children }: { children: ReactNode }) {
  return (
    <div className="min-h-screen bg-gray-50 dark:bg-slate-900">
      {/* Admin Header */}
      <header className="bg-white dark:bg-slate-800 border-b border-gray-200 dark:border-slate-700">
        <div className="max-w-6xl mx-auto px-6 py-4 flex items-center justify-between">
          <div className="flex items-center gap-3">
            <BarChart3 className="w-6 h-6 text-aiox-purple" />
            <h1 className="text-2xl font-bold text-gray-900 dark:text-white">Painel Admin</h1>
          </div>
          <nav className="flex items-center gap-4">
            <Link
              href="/admin/feedbacks"
              className="flex items-center gap-2 px-4 py-2 rounded-lg hover:bg-gray-100 dark:hover:bg-slate-700 text-gray-900 dark:text-white transition"
            >
              <MessageSquare className="w-4 h-4" />
              Feedbacks
            </Link>
            <Link
              href="/"
              className="text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white transition"
            >
              Sair
            </Link>
          </nav>
        </div>
      </header>

      {/* Content */}
      <main className="max-w-6xl mx-auto px-6 py-8">
        {children}
      </main>
    </div>
  );
}
