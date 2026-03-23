# Contexto para Continuação — Cursos AIOX

> **Use este documento para dar contexto a um novo chat.**
> Cole o conteúdo ou diga: "Leia /mnt/user-data/outputs/contexto-continuacao-cursos.md"

---

## Quem sou eu

Luciano (Luci) — profissional de TI brasileiro, 25+ anos experiência, Zabbix Expert certificado (~15 anos), consultoria **Monitoragindo** (solo). Trabalha com monitoramento, automação Python, AWS, n8n, Grafana. Pós-graduação em Design Instrucional. LinkedIn com audiência técnica crescente.

---

## O que estamos construindo

Dois cursos completos sobre o framework **Synkra AIOX** (AI-Orchestrated System), usando projetos reais meus como veículo de aprendizado:
Documentação oficial do Synkra AIOX:
https://github.com/SynkraAI/aiox-core

### Curso 1: AIOX Professional Bootcamp (18 aulas)
**Foco**: Aprender o pipeline AIOX completo — do zero ao deploy.

### Curso 2: AIOX Mastery (22 aulas)
**Foco**: Dominar internals, ADE deep, hooks, multi-IDE, brownfield, squads avançados.

---

## Decisões Críticas Já Tomadas

### 1. Fusão de cursos
Originalmente eram 3 cursos (10 + 20 + 22 aulas). Análise mostrou 70% de sobreposição entre os dois primeiros. Decisão: fundir em 1 Bootcamp (18 aulas) + 1 Mastery (22 aulas). Zero repetição.

**Documento**: `/mnt/user-data/outputs/analise-reestruturacao-cursos.md`

### 2. Projetos reais em vez de fictícios
Substituímos projetos fictícios pelos projetos reais do Luciano. Aprender construindo algo que vai usar de verdade.

**Documento**: `/mnt/user-data/outputs/roadmap-reformulado-projetos-reais.md`

### 3. Abordagem pedagógica: Agent-Driven

> **O aluno descreve O QUÊ precisa e POR QUÊ. O agente decide COMO implementar. A aula ensina a AVALIAR se o resultado está bom.**

- ✅ "Preciso proteger o main contra código quebrado" → agente propõe CI/CD
- ❌ "Crie .github/workflows/ci.yml com jobs lint, test-api..." → aluno dita solução

O aluno desenvolve 3 skills:
- **Skill de prompt**: descrever necessidades para agentes
- **Skill de avaliação**: saber se o output está correto (checklists)
- **Skill técnica**: entender conceitualmente o que foi gerado

### 4. Modelo de aula: CCPR
Cada aula segue o ciclo **Conceito → Contexto → Prática → Reflexão**:
- **Conceito** (15-20%): O que é e por que existe
- **Contexto** (10-15%): Conectar ao projeto real
- **Prática** (55-65%): Mão na massa com prompts de necessidade + checklists de avaliação
- **Reflexão** (10-15%): Conceito-chave + conexão com próxima aula

### 5. Diferença Bootcamp vs Mastery
- **Bootcamp**: Conceito pesa mais, prática mais guiada, prompts mais detalhados
- **Mastery**: Conceito pesa menos, prática mais autônoma, reflexão mais profunda

---

## Projetos e Distribuição

### BOOTCAMP (18 aulas)

| Módulo | Projeto | Aulas | Tipo |
|--------|---------|:---:|------|
| 1 | Fundamentos AIOX | 01-02 | Conceitual |
| 2 | **RockQuiz** | 03-08 | Greenfield (quiz de rock) |
| 3 | **AuctionHunter** | 09-13 | Brownfield/recomeço (scraping de leilões) |
| 4 | **Squad LinkedIn Monitoragindo** | 14-18 | Squad de conteúdo + app backend |

### MASTERY (22 aulas)

| Módulo | Projeto | Aulas | Tipo |
|--------|---------|:---:|------|
| 1 | AIOX Internals | 01-03 | Plataforma Zabbix (config) |
| 2 | ADE Deep Dive | 04-07 | Plataforma Zabbix (ADE) |
| 3 | Plataforma Zabbix: Planejamento | 08-10 | Greenfield SaaS |
| 4 | Plataforma Zabbix: Dev Core | 11-14 | Greenfield SaaS |
| 5 | Hooks + Multi-IDE + Brownfield | 15-17 | Plataforma + LinkedIn brownfield |
| 6 | Squads Avançados | 18-22 | Zabbix Content + N8N + Composition |

### Descrição dos Projetos

**RockQuiz**: Quiz interativo de rock. Fastify + PostgreSQL + Redis + Next.js + Docker (5 serviços) + CI/CD + Grafana. Exercita 9/11 agentes, pipeline completo.

**AuctionHunter**: Scraping de leilões de veículos apreendidos. PDF parsing + web scraping + login/captcha handling + fallback layers. Projeto que falhou antes — agora com AIOX estruturado. Exercita ADE Recovery System e Memory Layer.

**Squad LinkedIn Monitoragindo**: 6 agentes para 4 vertentes editoriais (Zabbix Quiz, artigo técnico, IA na Sexta, mentalidade). Voice profiling, persistência em banco, analytics de engajamento. Brownfield do protótipo Google AI Studio.

**Plataforma Zabbix Learning**: SaaS educacional com 6 subsistemas — Content Engine (RAG), Quiz gamificado, Lab Provisioner (containers efêmeros Zabbix), Tooling interativo, Learning Path adaptativo, auth multi-tenant com planos. 10+ containers.

**Squad N8N Automation**: Meta-automação — agentes que criam workflows n8n. @squad-creator, MCP integration, composition, testing, marketplace.

**Documento completo**: `/mnt/user-data/outputs/projetos-descricao-detalhada.md`

---

## Status de Produção das Aulas

### Módulo 1 — Fundamentos ✅ COMPLETO

| Aula | Arquivo | Linhas | Status |
|------|---------|:---:|:---:|
| 01 | `aula-01-setup-anatomia.md` | 533 | ✅ |
| 02 | `aula-02-conceitos-fluxo.md` | 350 | ✅ |

**Localização**: `/mnt/user-data/outputs/bootcamp-aiox/modulo-01/`

### Módulo 2 — RockQuiz Pipeline ✅ COMPLETO (reescrito agent-driven)

| Aula | Arquivo | Linhas | Status |
|------|---------|:---:|:---:|
| 03 | `aula-03-analyst-pm.md` | 395 | ✅ Agent-driven |
| 04 | `aula-04-architect-stories.md` | 328 | ✅ Agent-driven |
| 05 | `aula-05-devops-infra.md` | 273 | ✅ Agent-driven |
| 06 | `aula-06-dev-backend.md` | 317 | ✅ Agent-driven |
| 07 | `aula-07-dev-qa-frontend.md` | 362 | ✅ Agent-driven |
| 08 | `aula-08-devops-cicd-deploy.md` | 336 | ✅ Agent-driven |

**Localização**: `/mnt/user-data/outputs/bootcamp-aiox/modulo-02/`

### Módulo 3 — AuctionHunter ⏳ PRÓXIMO

| Aula | Tema | Status |
|------|------|:---:|
| 09 | Analyst: domínio de leilões + análise de falha anterior | ⏳ |
| 10 | PM + Architect: spec completa multi-layer | ⏳ |
| 11 | Dev: scrapers (PDF + web + login/captcha) | ⏳ |
| 12 | Dev: normalização + API + persistência | ⏳ |
| 13 | DevOps: containerização + scheduling + retrospectiva | ⏳ |

### Módulo 4 — Squad LinkedIn ⏳ PENDENTE

| Aula | Tema | Status |
|------|------|:---:|
| 14 | Arquitetura do squad (6 agentes, 4 vertentes) | ⏳ |
| 15 | Voice analysis + geração de conteúdo | ⏳ |
| 16 | Backend: persistência + LinkedIn API | ⏳ |
| 17 | Analytics de engajamento + feedback loop | ⏳ |
| 18 | Brownfield (protótipo Google AI Studio) + consolidação | ⏳ |

### MASTERY — Todo ⏳ PENDENTE (22 aulas)

Roadmap detalhado em: `/mnt/user-data/outputs/aiox-mastery-curso3-roadmap.md`

---

## Arquivos de Referência no /outputs

| Arquivo | O que contém |
|---------|-------------|
| `roadmap-reformulado-projetos-reais.md` | Roadmap completo Bootcamp (18 aulas) com projetos reais, aula por aula |
| `aiox-mastery-curso3-roadmap.md` | Roadmap completo Mastery (22 aulas), aula por aula |
| `projetos-descricao-detalhada.md` | Descrição profunda de cada projeto (propósito, funcionalidades, stack, AIOX skills) |
| `analise-reestruturacao-cursos.md` | Análise que levou à fusão dos cursos 1+2 |
| `analise-lacunas-aiox-cursos.md` | Cruzamento de recursos AIOX × cobertura dos cursos |
| `bootcamp-aiox/modulo-01/` | 2 aulas completas (Fundamentos) |
| `bootcamp-aiox/modulo-02/` | 6 aulas completas (RockQuiz Pipeline) |
| `aiox-core-resumo-tecnico.md` | Resumo técnico do AIOX (11 agentes, ADE, squads) |
| `gas-town-resumo-tecnico.md` | Resumo técnico do Gas Town (framework concorrente) |
| `comparativo-gastown-vs-aiox.md` | Comparativo em 11 dimensões |

---

## Próximo Passo

**Criar as aulas do Módulo 3 (AuctionHunter, aulas 09-13)** seguindo a abordagem agent-driven.

O AuctionHunter é um projeto que o Luciano já tentou antes sem sucesso. A narrativa do módulo é "recomeço estruturado" — demonstrar o valor do AIOX em um projeto que falhou sem metodologia. A complexidade técnica (scraping multi-layer, PDF parsing, captcha, fallback) exercita naturalmente o ADE Recovery System (scrapers falham de verdade) e a Memory Layer (insights entre layers de scraping).

---

## Regras para Criação das Aulas

1. **Abordagem agent-driven**: Aluno descreve necessidade → agente implementa → aluno avalia (checklist) → refina
2. **Modelo CCPR**: Conceito → Contexto → Prática (~60%) → Reflexão
3. **Cada aula tem**: Metadata HTML, vitória binária, checkpoints, checklists de avaliação
4. **Nunca prescrever** configurações técnicas nos prompts — o agente gera, o aluno avalia
5. **Arquivos .md** otimizados para renderização futura em plataforma de curso
6. **Profundidade**: ~300-500 linhas por aula (conteúdo real, não filler)
