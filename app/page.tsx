import Link from 'next/link';
import { BookOpen, Code2, Zap } from 'lucide-react';

export default function Home() {
  return (
    <div className="space-y-8">
      {/* Hero Section */}
      <section className="text-center py-12">
        <h1 className="text-5xl font-bold text-aiox-700 mb-4">
          Plataforma de Curso AIOX
        </h1>
        <p className="text-xl text-gray-600 mb-8 max-w-2xl mx-auto">
          Domine o Sistema Orquestrado por IA para Desenvolvimento Full Stack através de nossos programas de bootcamp e mastery abrangentes.
        </p>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-6 mt-8">
          {/* Bootcamp Card */}
          <Link
            href="/bootcamp"
            className="group p-8 bg-gradient-to-br from-aiox-50 to-blue-50 rounded-lg border-2 border-aiox-purple hover:border-aiox-purple/80 transition-all hover:shadow-lg"
          >
            <div className="flex items-center gap-3 mb-4">
              <BookOpen className="w-8 h-8 text-aiox-purple" />
              <h2 className="text-2xl font-bold text-aiox-700">Bootcamp</h2>
            </div>
            <p className="text-gray-600 mb-4">
              Programa de Fundação Profissional
            </p>
            <ul className="text-sm text-gray-600 space-y-2 mb-4 text-left">
              <li>✓ 18 aulas abrangentes</li>
              <li>✓ 3 projetos do mundo real</li>
              <li>✓ Pipeline de desenvolvimento completo</li>
              <li>✓ Conhecimento fundamental</li>
            </ul>
            <span className="text-aiox-purple font-semibold group-hover:translate-x-1 inline-block transition-transform">
              Começar a Aprender →
            </span>
          </Link>

          {/* Mastery Card */}
          <Link
            href="/mastery"
            className="group p-8 bg-gradient-to-br from-purple-50 to-pink-50 rounded-lg border-2 border-aiox-accent hover:border-aiox-accent/80 transition-all hover:shadow-lg"
          >
            <div className="flex items-center gap-3 mb-4">
              <Code2 className="w-8 h-8 text-aiox-accent" />
              <h2 className="text-2xl font-bold text-aiox-600">Mastery</h2>
            </div>
            <p className="text-gray-600 mb-4">
              Programa de Especialização Avançada
            </p>
            <ul className="text-sm text-gray-600 space-y-2 mb-4 text-left">
              <li>✓ 22 aulas avançadas</li>
              <li>✓ 3 projetos sofisticados</li>
              <li>✓ Arquitetura SaaS</li>
              <li>✓ Expertise em produção</li>
            </ul>
            <span className="text-aiox-accent font-semibold group-hover:translate-x-1 inline-block transition-transform">
              Aprofundar Conhecimento →
            </span>
          </Link>
        </div>
      </section>

      {/* Features Section */}
      <section className="py-12 border-t pt-12">
        <h2 className="text-3xl font-bold text-center mb-8 text-aiox-700">
          O Que Você Aprenderá
        </h2>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          <div className="p-6 bg-blue-50 rounded-lg border border-blue-200">
            <Zap className="w-8 h-8 text-blue-600 mb-3" />
            <h3 className="font-bold text-lg mb-2">Desenvolvimento Full Stack</h3>
            <p className="text-gray-600">
              Domine Next.js, TypeScript, PostgreSQL e práticas modernas de DevOps
            </p>
          </div>

          <div className="p-6 bg-purple-50 rounded-lg border border-purple-200">
            <Code2 className="w-8 h-8 text-purple-600 mb-3" />
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
    </div>
  );
}
