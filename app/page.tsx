import Link from 'next/link';
import { BookOpen, Code2, GraduationCap, BarChart3 } from 'lucide-react';
import { ModuleCard } from '@/components/module/ModuleCard';

export default function Home() {
  return (
    <div className="space-y-8">
      {/* Hero Section */}
      <section className="text-center py-12">
        <h1 className="text-5xl font-bold text-aiox-700 mb-4">
          Plataforma de Curso AIOX
        </h1>
        <p className="text-xl text-gray-600 mb-8 max-w-2xl mx-auto">
          Domine o Sistema Orquestrado por IA para Desenvolvimento Full Stack através de nossos programas progressivos de aprendizado.
        </p>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mt-8">
          {/* Básico Claude Code Card */}
          <ModuleCard
            module="basico-claude-code"
            title="Básico Claude Code"
            description="Introdução ao Claude Code"
            lessonCount={8}
            icon={<BookOpen className="w-8 h-8" />}
            href="/basico-claude-code"
            gradient="from-green-50 to-emerald-50"
            textColor="text-green-700"
            badgeColor="border-green-500"
          />

          {/* Bootcamp Card */}
          <ModuleCard
            module="bootcamp"
            title="Bootcamp"
            description="Programa de Fundação Profissional"
            lessonCount={18}
            icon={<Code2 className="w-8 h-8" />}
            href="/bootcamp"
            gradient="from-blue-50 to-blue-100"
            textColor="text-blue-700"
            badgeColor="border-blue-500"
          />

          {/* Mastery Card */}
          <ModuleCard
            module="mastery"
            title="Mastery"
            description="Programa de Especialização Avançada"
            lessonCount={22}
            icon={<GraduationCap className="w-8 h-8" />}
            href="/mastery"
            gradient="from-stone-50 to-stone-100"
            textColor="text-stone-700"
            badgeColor="border-stone-500"
          />
        </div>
      </section>

      {/* Features Section */}
      <section className="py-12 border-t pt-12">
        <h2 className="text-3xl font-bold text-center mb-8 text-aiox-700">
          O Que Você Aprenderá
        </h2>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          <div className="p-6 bg-blue-50 rounded-lg border border-blue-200">
            <Code2 className="w-8 h-8 text-blue-600 mb-3" />
            <h3 className="font-bold text-lg mb-2">Desenvolvimento Full Stack</h3>
            <p className="text-gray-600">
              Domine Next.js, TypeScript, PostgreSQL e práticas modernas de DevOps
            </p>
          </div>

          <div className="p-6 bg-purple-50 rounded-lg border border-purple-200">
            <GraduationCap className="w-8 h-8 text-purple-600 mb-3" />
            <h3 className="font-bold text-lg mb-2">Integração com IA</h3>
            <p className="text-gray-600">
              Construa aplicações alimentadas por IA usando Claude API e técnicas avançadas de LLM
            </p>
          </div>

          <div className="p-6 bg-pink-50 rounded-lg border border-pink-200">
            <BookOpen className="w-8 h-8 text-pink-600 mb-3" />
            <h3 className="font-bold text-lg mb-2">Projetos Reais</h3>
            <p className="text-gray-600">
              Construa 6 aplicações prontas para produção usadas em cenários do mundo real
            </p>
          </div>
        </div>
      </section>

      {/* Projects Preview */}
      <section className="py-12 border-t pt-12">
        <h2 className="text-3xl font-bold text-center mb-8 text-aiox-700">
          Vitrine de Projetos
        </h2>
        <p className="text-center text-gray-600 mb-6">
          Construa aplicações reais em diferentes domínios
        </p>
        <Link
          href="/projects"
          className="flex items-center justify-center gap-2 mx-auto w-fit px-6 py-3 bg-aiox-purple text-white rounded-lg hover:bg-aiox-purple/90 transition-colors font-semibold"
        >
          Ver Todos os Projetos →
        </Link>
      </section>

      {/* Admin Link */}
      <section className="py-8 border-t pt-8 text-center">
        <Link
          href="/admin/feedbacks"
          className="inline-flex items-center gap-2 text-sm text-gray-600 dark:text-gray-400 hover:text-aiox-purple dark:hover:text-aiox-purple transition-colors"
        >
          <BarChart3 className="w-4 h-4" />
          Painel de Feedbacks
        </Link>
      </section>
    </div>
  );
}
