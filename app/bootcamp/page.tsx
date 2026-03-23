import Link from 'next/link';

const LESSONS = [
  { slug: 'aula-01-setup-anatomia', title: '01. Setup & Anatomia', description: 'Fundação do AIOX' },
  { slug: 'aula-02-conceitos-fluxo', title: '02. Conceitos & Fluxo', description: 'Conceitos fundamentais' },
  { slug: 'aula-03-analyst-pm', title: '03. Analyst & PM', description: 'Product e Analysis' },
  { slug: 'aula-04-architect-stories', title: '04. Architect & Stories', description: 'Arquitetura e histórias' },
  { slug: 'aula-05-devops-infra', title: '05. DevOps & Infra', description: 'Infraestrutura' },
  { slug: 'aula-06-dev-backend', title: '06. Dev Backend', description: 'Desenvolvimento backend' },
  { slug: 'aula-07-dev-qa-frontend', title: '07. Dev QA Frontend', description: 'Frontend e QA' },
  { slug: 'aula-08-devops-cicd-deploy', title: '08. DevOps CI/CD Deploy', description: 'Pipeline CI/CD' },
  { slug: 'aula-09-auction-analyst', title: '09. Auction Analyst', description: 'Projeto Auction' },
  { slug: 'aula-10-pm-architect-spec', title: '10. PM Architect Spec', description: 'Spec & Architecture' },
  { slug: 'aula-11-dev-scrapers', title: '11. Dev Scrapers', description: 'Web scraping' },
  { slug: 'aula-12-dev-normalization-api', title: '12. Dev Normalization API', description: 'API development' },
  { slug: 'aula-13-devops-deploy-retro', title: '13. DevOps Deploy Retro', description: 'Deployment' },
  { slug: 'aula-14-squad-architecture', title: '14. Squad Architecture', description: 'Squad design' },
  { slug: 'aula-15-voice-content', title: '15. Voice Content', description: 'Content automation' },
  { slug: 'aula-16-backend-persistence', title: '16. Backend Persistence', description: 'Database' },
  { slug: 'aula-17-analytics-patterns', title: '17. Analytics Patterns', description: 'Analytics' },
  { slug: 'aula-18-automation-brownfield-retro', title: '18. Automation Brownfield', description: 'Brownfield' },
];

export default function BootcampPage() {
  return (
    <div className="space-y-8">
      <div className="text-center">
        <h1 className="text-4xl font-bold text-aiox-700 mb-4">Bootcamp Profissional AIOX</h1>
        <p className="text-lg text-gray-600">18 aulas abrangentes cobrindo todo o pipeline de desenvolvimento AIOX</p>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        {LESSONS.map((lesson, index) => (
          <Link
            key={lesson.slug}
            href={`/bootcamp/${lesson.slug}`}
            className="group p-6 bg-white border border-gray-200 rounded-lg hover:border-aiox-purple hover:shadow-lg transition-all duration-300"
          >
            <div className="flex items-start gap-4">
              <div className="flex-shrink-0 w-12 h-12 bg-aiox-100 text-aiox-purple rounded-lg flex items-center justify-center font-bold group-hover:bg-aiox-purple group-hover:text-white transition-colors">
                {String(index + 1).padStart(2, '0')}
              </div>
              <div className="flex-1">
                <h3 className="font-bold text-lg text-gray-900 group-hover:text-aiox-purple transition-colors">
                  {lesson.title}
                </h3>
                <p className="text-sm text-gray-600 mt-1">{lesson.description}</p>
              </div>
              <span className="text-aiox-purple font-semibold opacity-0 group-hover:opacity-100 transition-opacity">→</span>
            </div>
          </Link>
        ))}
      </div>
    </div>
  );
}
