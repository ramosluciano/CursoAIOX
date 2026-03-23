# Projetos dos Cursos AIOX — Resumo Descritivo

## Visão Geral

Dois cursos, **5 projetos** que se complementam em complexidade e propósito. Cada projeto exercita um conjunto diferente de capacidades do AIOX.

```
BOOTCAMP (18 aulas)
├── Projeto 1: RockQuiz (Greenfield — app completa)
└── Projeto 2: Squad LinkedIn Autopilot (Squad de automação)

MASTERY (22 aulas)
├── Projeto 3: SentinelAI (Greenfield — plataforma complexa)
├── Projeto 4: SentinelAI Brownfield (adaptar AIOX a projeto existente)
├── Projeto 5: Squad DevOps Intelligent Ops (Squad técnico)
└── Projeto 6: Squad AI Course Factory (Squad meta + @squad-creator)
```

---

## CURSO 1 — AIOX Professional Bootcamp

---

### Projeto 1: RockQuiz

**O que é**: Aplicação web de quiz interativo sobre conhecimentos de rock — história, bandas, álbuns, curiosidades, letras e instrumentos. O jogador escolhe um modo de jogo, responde perguntas com dificuldade progressiva, acumula pontos com sistema de multiplicadores (velocidade, streak, dificuldade) e compete em um ranking público em tempo real.

**Por que este projeto**: É complexo o suficiente para exercitar toda a stack (API, banco relacional, cache, frontend SSR, testes, Docker, CI/CD, observabilidade) mas temático e divertido o bastante para manter o aluno engajado durante 15 aulas. O domínio "quiz de rock" é rico em entidades (perguntas, categorias, dificuldades, modos de jogo, jogadores, rankings) sem ser intimidante. O sistema de scoring com multiplicadores cria lógica de negócio não-trivial que justifica testes robustos.

**Stack técnica**:

| Camada | Tecnologia | Justificativa |
|--------|-----------|---------------|
| Frontend | Next.js 14 (App Router) + Tailwind CSS | SSR nativo, deploy Vercel otimizado, Server Components para ranking |
| Backend | Node.js + Fastify | Performance 2-3x superior ao Express, JSON Schema validation nativo, Pino integrado |
| Banco de dados | PostgreSQL 16 + Prisma ORM | Relacional robusto, JSONB para options de perguntas, Prisma type-safe com migrations |
| Cache | Redis 7 | Sorted Sets nativos (perfeito para ranking), cache de listagens, rate limiting |
| Testes | Jest + Supertest + Playwright | Pirâmide completa: unitários, integração com DB real, E2E no browser |
| Observabilidade | Pino (logs) + Prometheus (métricas) + Grafana (dashboards) | Os 3 pilares: logs estruturados, métricas de negócio, visualização |
| Containers | Docker Compose (5 serviços: api, web, postgres, redis, grafana) | Dev e prod isolados, multi-stage builds, health checks |
| CI/CD | GitHub Actions + Vercel | Pipeline: lint → test → build → security scan → deploy, preview por PR |

**Funcionalidades desenvolvidas** (ao longo de 15 aulas):

- CRUD de categorias, perguntas e jogadores
- 3 modos de jogo: clássico (20 perguntas), blitz (10 perguntas em 60s), sobrevivência (erra e sai)
- Sistema de pontuação com multiplicadores: dificuldade (1x a 3x), velocidade (<5s = 1.5x), streak (acumulativo até 2x)
- Ranking em tempo real com Redis Sorted Sets (top 50 por modo)
- Frontend com tema dark/rock, timer visual, feedback animado de acerto/erro, badge de streak
- Seed com 50+ perguntas reais categorizadas por dificuldade
- Dashboard Grafana com métricas de negócio (games/hora, accuracy rate, categorias populares)
- Pipeline CI/CD completo: PR → lint → test (≥85%) → build → preview → deploy

**Agentes AIOX exercitados**: @analyst, @pm, @architect, @ux-expert, @sm, @po, @dev, @qa, @devops — 9 de 11 agentes core.

**Recursos AIOX exercitados**: Pipeline de planejamento completo (Brief → PRD com Gherkin → Architecture com C4 → Stories hiperdetalhadas), DevContainer, Docker Compose, GitHub Actions, Spec Pipeline do ADE, Execution Engine 13 steps (praticado de verdade), QA review 10 fases, observabilidade.

---

### Projeto 2: Squad LinkedIn Autopilot

**O que é**: Um squad customizado de 6 agentes de IA especializados que automatizam o ciclo completo de geração de conteúdo para LinkedIn — da pesquisa de tendências até a publicação agendada. O pipeline semanal produz 3 posts prontos para publicar, cada um com texto otimizado, hashtags e prompt de imagem.

**Por que este projeto**: Demonstra a extensibilidade do AIOX para domínios não-técnicos. Enquanto o RockQuiz usa os agentes core para construir software, o Squad LinkedIn mostra que o mesmo framework pode orquestrar agentes para marketing, conteúdo, educação ou qualquer outro domínio. Para o contexto profissional do aluno (presença no LinkedIn, estratégia de conteúdo), é diretamente aplicável.

**Os 6 agentes do squad**:

| Agente | Persona | Função | Output |
|--------|---------|--------|--------|
| **Trend Scout** | Tara | Pesquisa tendências da semana em tech, IA, carreira | 10 tendências ranqueadas por potencial |
| **Topic Curator** | Tom | Seleciona 3 melhores tópicos com ângulo único | 3 tópicos com formato, tom e hook outline |
| **Copywriter** | Clara | Escreve posts otimizados para o algoritmo LinkedIn | 3 drafts com hook, corpo, CTA |
| **Editor** | Ed | Revisa em 10 critérios, otimiza engajamento, adiciona hashtags | 3 posts finais polidos |
| **Image Prompter** | Iris | Cria prompts detalhados para geração de imagem AI | 3 prompts para Midjourney/DALL-E |
| **Publisher** | Pete | Formata para LinkedIn API, agenda melhor horário | Schedule semanal + payloads prontos |

**Pipeline**: Trend Scout → Topic Curator → Copywriter → Editor → Image Prompter → Publisher

**Artefatos produzidos**:
- config.yaml completo com 6 agentes e workflow YAML
- Templates (post-template.md, image-brief.md, editorial-calendar.md)
- Checklists (post-quality.md com 15 critérios, brand-voice.md)
- Base de conhecimento (linkedin-best-practices.md, hashtag-database.md)
- Documentação de automação com n8n/Make (arquitetura de pipeline automatizado)
- Documentação da LinkedIn API (OAuth, endpoints, rate limits)

**Recursos AIOX exercitados**: Sistema de Squads (L1 local), config.yaml, agent definitions, workflow YAML, templates, checklists, knowledge base, @aiox-master para orquestração.

---

## CURSO 2 — AIOX Mastery

---

### Projeto 3: SentinelAI (Greenfield)

**O que é**: Plataforma de monitoramento inteligente com resposta a incidentes assistida por IA. O sistema recebe alertas de ferramentas de monitoramento (Zabbix, Prometheus, Uptime Kuma) via webhooks, classifica a severidade usando a API do Claude, sugere e executa ações de remediação automatizadas via n8n, e mantém um histórico completo de incidentes com dashboards real-time.

**Por que este projeto**: É deliberadamente mais complexo que o RockQuiz em todas as dimensões — mais serviços (8 containers vs 5), mais integrações (n8n, Anthropic API, webhooks externos), mais camadas de segurança (auth com RBAC, audit log, API keys), mais patterns (WebSocket real-time, filas assíncronas com Bull, OpenTelemetry traces). Cada camada extra exercita recursos avançados do AIOX que o RockQuiz não alcança: agentes custom no core, ADE com os 7 Epics em profundidade, Recovery System com falhas reais, Memory Layer com pattern extraction entre features.

**Stack técnica**:

| Camada | Tecnologia | O que adiciona vs RockQuiz |
|--------|-----------|--------------------------|
| Frontend | Next.js 14 + shadcn/ui + WebSocket client | WebSocket para real-time (novo), component library (novo) |
| Backend | Fastify + Bull (filas) | Processamento assíncrono via filas (novo) |
| Auth | NextAuth.js + JWT + RBAC | Autenticação completa com roles (novo) |
| Banco | PostgreSQL + Prisma | Schema mais complexo (incidentes, ações, audit log) |
| Cache/Filas | Redis (cache + Bull queues) | Redis como broker de filas (novo) |
| AI | Anthropic API (Claude) | IA como parte da lógica de negócio, não apenas dev tool (novo) |
| Automação | n8n self-hosted | Orquestração de runbooks via webhooks (novo) |
| Observabilidade | Pino + Prometheus + Grafana + OpenTelemetry | Traces distribuídos API → Worker → n8n (novo) |
| Containers | Docker Compose (8 serviços) | 3 serviços a mais: bull-worker, n8n, prometheus |
| Testes | Jest + Supertest + Playwright + k6 | Load testing com k6 (novo) |

**Funcionalidades desenvolvidas** (ao longo das aulas):

- **Webhook Receiver**: Endpoints dedicados para Zabbix, Prometheus Alertmanager e webhooks genéricos. Validação de payload por source, deduplicação de alertas, enfileiramento assíncrono no Bull.

- **AI Classification**: Bull worker que chama a API do Claude com prompt estruturado para classificar severidade (critical/high/medium/low/info) e sugerir ações de remediação. Fallback para classificação rule-based se a API falhar.

- **Sistema de Autenticação**: NextAuth.js com providers (credentials + GitHub OAuth), JWT com refresh tokens, RBAC com 3 roles (admin, operator, viewer), middleware de autorização granular, audit log de todas as ações.

- **Integração n8n**: Comunicação bidirecional — SentinelAI dispara runbooks no n8n via webhook, n8n retorna resultados via callback. 3 runbooks automatizados: restart de serviço, scale up, notification chain (Slack → Email → SMS).

- **Dashboard Real-time**: WebSocket com canais por tenant, eventos de new_incident/status_changed/severity_updated, charts de incidentes por hora/severidade/MTTR, timeline de eventos por incidente.

- **Observabilidade Completa**: Logs estruturados (Pino), métricas Prometheus (custom + default), traces OpenTelemetry (request → API → worker → n8n → callback), 4 dashboards Grafana (API, business, infra, AI service).

- **Agente Custom @incident-responder**: Agente AIOX criado pelo aluno (não pré-existente), integrado ao framework core, com comandos e tasks próprios. Demonstra que o AIOX é extensível no nível mais profundo.

**Agentes AIOX exercitados**: Todos os 11 agentes core + 1 agente custom (@incident-responder). Inclui uso profundo do ADE (todos os 7 Epics), hooks de lifecycle, multi-IDE.

**Recursos AIOX exercitados**: ADE completo (13 steps do Execution Engine, Recovery System, QA Evolution 10 fases, Memory Layer com capture-insights e pattern-extractor), hooks de lifecycle (pre-tool, post-tool, session hooks, monitor hooks), validação multi-IDE (Claude Code + Gemini CLI + Codex CLI com `validate:parity`), agente custom no core (definição autoClaude V3), workflow YAML authoring.

---

### Projeto 4: SentinelAI Brownfield

**O que é**: Exercício de adaptação do AIOX a um projeto já existente. O aluno pega o SentinelAI (construído nas aulas anteriores) e finge que é um projeto legado sem AIOX. Aplica o workflow `brownfield-integration` completo: instalação sobre código existente, análise automatizada do codebase, geração de PRD retroativo, document sharding, e criação de stories para evolução.

**Por que este projeto**: O caso de uso mais comum no mundo real é adaptar AIOX a um projeto que já existe — não começar do zero. Nenhum curso ou tutorial disponível cobre brownfield. Este exercício demonstra: como o @architect mapeia um codebase existente, como o @po faz document sharding de documentos grandes, como o @sm gera stories a partir de código (fluxo inverso), e como o performance tuning do AIOX funciona em projetos grandes.

**Atividades específicas**:

- `npx aiox-core install` em projeto existente — observar o que o instalador detecta e configura
- `@architect *map-codebase` — gerar dependency graph, module map, API inventory automaticamente
- `@analyst *extract-patterns` — extrair padrões e anti-padrões do código
- `@po` fazendo document sharding — fragmentar PRD e Architecture em pedaços digeríveis quando são grandes demais para o context window
- `@sm` gerando stories retroativas — descrever o que já existe + o que falta
- Performance tuning — otimizar o AIOX para projetos com muitos arquivos e contexto pesado
- Migration guide — atualizar AIOX entre versões sem quebrar

**Recursos AIOX exercitados**: Workflow brownfield-integration, document sharding, *map-codebase, *extract-patterns, performance tuning, migration guide — todos 100% inéditos.

---

### Projeto 5: Squad DevOps Intelligent Ops

**O que é**: Squad de 4 agentes especializados em operações DevOps inteligentes que **se integra ao SentinelAI** como consumidor. Os agentes analisam logs de incidentes, detectam anomalias em métricas, sugerem otimizações de infraestrutura e geram relatórios estruturados.

**Por que este projeto**: Demonstra um padrão avançado: squads que **consomem** produtos construídos com AIOX. O Squad LinkedIn (Bootcamp) era standalone — produzia posts independentes. Este squad se conecta ao SentinelAI via API, consulta dados reais de incidentes e produz outputs que alimentam decisões. Também demonstra workflows condicionais (se anomalia detectada → trigger runbook).

**Os 4 agentes**:

| Agente | Função |
|--------|--------|
| **Log Analyst** | Analisa logs do SentinelAI e identifica padrões de erro recorrentes |
| **Anomaly Detector** | Detecta anomalias em métricas Prometheus (spikes, degradação, padrões sazonais) |
| **Infra Optimizer** | Sugere otimizações: tuning de queries, ajuste de cache TTLs, scaling recommendations |
| **Incident Reporter** | Gera relatórios de incidentes: timeline, root cause analysis, ações tomadas, recomendações |

**Diferencial técnico**: Workflow YAML com branches condicionais, integração squad ↔ API do produto, outputs que alimentam decisões operacionais reais.

**Recursos AIOX exercitados**: Squad que consome API de produto, workflows YAML condicionais, inter-squad patterns.

---

### Projeto 6: Squad AI Course Factory

**O que é**: Um squad meta — uma fábrica de cursos que usa o AIOX para criar programas de aprendizado. O squad é gerado automaticamente pelo `@squad-creator` e depois refinado manualmente, demonstrando o ciclo criação automatizada → refinamento humano.

**Por que este projeto**: Exercita os recursos mais avançados do ecossistema de squads: `@squad-creator` para geração automatizada, composição de squads (combinar Course Factory + DevOps Ops), testing e validação formal de squads, integração MCP (conectar agentes a Google Drive, Notion), e publicação no marketplace L3. É também meta-relevante — o aluno está usando o AIOX para criar material educacional sobre o AIOX.

**Os 5 agentes**:

| Agente | Função |
|--------|--------|
| **Curriculum Designer** | Analisa domínio e projeta estrutura do curso (módulos, aulas, progressão) |
| **Content Writer** | Escreve o conteúdo das aulas (teoria, exemplos, passo a passo) |
| **Exercise Creator** | Cria exercícios práticos, projetos e desafios para cada aula |
| **Reviewer** | Revisa conteúdo para clareza, precisão técnica e pedagogia |
| **Publisher** | Formata, organiza e publica o material (Markdown, PDF, plataforma) |

**Atividades específicas**:

- Usar `@squad-creator *create-squad ai-course-factory` — observar o que o agente gera automaticamente
- Comparar output automático com criação manual (qual é melhor?)
- Refinar o squad gerado: ajustar personas, adicionar comandos, criar templates
- Compor com o Squad DevOps Ops: o DevOps gera insights → Course Factory cria tutorial sobre os insights
- Testar o squad formalmente (validar config, verificar workflows, checar outputs)
- Conectar via MCP a Google Drive (buscar materiais de referência)
- Versionar o squad com semantic versioning
- Publicar no marketplace L3 (processo completo)

**Recursos AIOX exercitados**: @squad-creator (100% inédito), squad composition cross-squad, squad testing/validation, MCP integration, marketplace L3 publishing, semantic versioning de squads.

---

## Mapa de Progressão dos Projetos

```
BOOTCAMP
  RockQuiz ──────────────── Aprender o pipeline AIOX completo
  Squad LinkedIn ─────────── Aprender a criar squads

MASTERY
  SentinelAI ────────────── Dominar ADE, hooks, multi-IDE, infra complexa
  SentinelAI Brownfield ──── Dominar adaptação a projetos existentes
  Squad DevOps Ops ────────── Squads que consomem produtos, workflows condicionais
  Squad AI Course Factory ─── @squad-creator, composition, MCP, marketplace
```

**Complexidade crescente**:

| Projeto | Serviços | Agentes envolvidos | Recurso AIOX mais avançado |
|---------|:---:|:---:|---|
| RockQuiz | 5 | 9 core | Pipeline completo + ADE básico |
| Squad LinkedIn | — | 6 custom | Config.yaml + workflow YAML |
| SentinelAI | 8 | 11 core + 1 custom | ADE 7 Epics + hooks + multi-IDE |
| Brownfield | — | 5 core | Workflow brownfield + document sharding |
| Squad DevOps Ops | — | 4 custom | Workflows condicionais + integração com produto |
| Squad Course Factory | — | 5 custom | @squad-creator + composition + MCP + marketplace |

---

## Resumo Quantitativo

| Métrica | Bootcamp | Mastery | Total |
|---------|:---:|:---:|:---:|
| Aulas | 18 | 22 | 40 |
| Horas estimadas | ~60h | ~75h | ~135h |
| Projetos de software | 1 (RockQuiz) | 2 (SentinelAI green + brown) | 3 |
| Squads criados | 1 (LinkedIn) | 2 (DevOps + Course Factory) | 3 |
| Containers Docker | 5 | 8 | — |
| Agentes core usados | 9/11 | 11/11 + 1 custom | 11 + 1 |
| Agentes de squad | 6 | 9 | 15 |
| Total de agentes praticados | 15 | 21 | 27 |
