import type { Metadata } from 'next';
import './globals.css';
import { Sidebar } from '@/components/Sidebar';
import { Header } from '@/components/Header';
import { ThemeProvider } from '@/app/theme-provider';

export const metadata: Metadata = {
  title: 'AIOX Course Platform | Professional Bootcamp & Mastery',
  description:
    'Learn AIOX - AI-Orchestrated System for Full Stack Development. Complete bootcamp and mastery courses with hands-on projects.',
  keywords: [
    'AIOX',
    'AI Development',
    'Full Stack',
    'Course',
    'Bootcamp',
    'Learning',
  ],
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="pt-BR">
      <body className="bg-white dark:bg-slate-900 text-gray-900 dark:text-gray-100 transition-colors">
        <ThemeProvider>
          <div className="flex h-screen overflow-hidden">
            {/* Sidebar */}
            <Sidebar />

            {/* Main Content */}
            <div className="flex-1 flex flex-col overflow-hidden">
              {/* Header */}
              <Header />

              {/* Content Area */}
              <main className="flex-1 overflow-y-auto bg-white dark:bg-slate-900 transition-colors">
                <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
                  {children}
                </div>
              </main>
            </div>
          </div>
        </ThemeProvider>
      </body>
    </html>
  );
}
