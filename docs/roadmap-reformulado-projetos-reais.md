# Análise dos Projetos Reais + Roadmap Reformulado

---

## 1. Análise Individual dos Projetos

### Projeto 1: LinkedIn Automation (Monitoragindo)

**Classificação**: Brownfield (protótipo existe no Google AI Studio)
**Complexidade AIOX**: Média
**Envolve**: Squad de conteúdo + aplicação backend + banco + integração LinkedIn API + análise de dados

**Análise técnica**:
Este projeto tem camadas distintas que servem a propósitos diferentes no curso:

A **camada de squad** é similar ao Squad LinkedIn que já planejamos, mas com diferenças cruciais que tornam muito mais rico: não é conteúdo genérico — é conteúdo com voz pessoal baseada em histórico real, tem 4 vertentes editoriais (Zabbix Quiz, artigo técnico, IA na Sexta, mentalidade/liderança), e cada vertente tem regras e formatos próprios.

A **camada de aplicação** é um backend real: persistência em banco de dados, integração com LinkedIn API para publicação e coleta de métricas, análise de engajamento com dados históricos, painel de analytics. Isso vai além de "um squad que gera texto" — é um **produto de software** orquestrado por agentes.

A **camada brownfield** é genuína: já existe um protótipo semi-funcional no Google AI Studio que precisa ser migrado para arquitetura independente. Isso é o cenário mais realista possível para exercitar o workflow brownfield do AIOX.

**O que exercita do AIOX**:
- Squad avançado com 4+ agentes especializados por vertente
- Brownfield: migrar protótipo existente para arquitetura AIOX
- @analyst para análise de voz e perfil de comunicação
- @architect para definir arquitetura de persistência + analytics
- @dev para implementar integração LinkedIn API + banco
- ADE para features incrementais

---

### Projeto 2: Squad N8N Automation

**Classificação**: Greenfield (squad puro, zero código existente)
**Complexidade AIOX**: Alta (meta-automação: AIOX criando automações no n8n)
**Envolve**: Squad customizado + integração MCP/API com n8n + definição de workflows + deploy + observabilidade

**Análise técnica**:
Este é um projeto fascinante porque é **automação que cria automação**. Agentes AIOX que projetam, criam, deployam e monitoram workflows n8n. É meta em dois níveis: usa IA para automatizar a criação de automações.

As etapas do squad seriam: entender a necessidade de automação → projetar o workflow n8n → gerar o JSON do workflow → deployar via API do n8n → testar → monitorar execuções → ajustar baseado em erros.

Isso conecta diretamente com sua stack atual (n8n com Redis e workers no Docker Compose) e exercita recursos avançados do AIOX: MCP integration para conectar agentes ao n8n, squad com workflows condicionais (se teste falhar → ajustar → re-testar), e observabilidade de automações.

**O que exercita do AIOX**:
- @squad-creator para gerar o squad automaticamente, depois refinar
- MCP integration (conectar agentes ao n8n via API)
- Workflows YAML condicionais (loops de teste/ajuste)
- Squad testing e validation
- Composição com outros squads

---

### Projeto 3: AuctionHunter

**Classificação**: Brownfield (tentativa anterior falhou, há código/conceito existente)
**Complexidade AIOX**: Média-Alta
**Envolve**: Scraping profundo + PDF parsing + fallback strategies + login/captcha handling + banco de dados + API

**Análise técnica**:
O AuctionHunter é perfeito como case de **"recomeço estruturado"** — você tentou antes sem metodologia adequada e falhou. Usar o AIOX para recomeçar demonstra exatamente o valor do framework: planejamento antes de codificar, specs antes de implementar, QA antes de deployar.

A complexidade técnica é real: scraping com fallback (Playwright browser → HTTP requests → PDF parsing), handling de login e captcha (headless browser com automação), extração de dados semi-estruturados (pdfplumber + regex + LLM fallback), e normalização de dados de veículos (placa, chassi, marca, modelo).

É um excelente projeto para o ADE porque cada "layer" de scraping pode ser uma feature desenvolvida com os 13 steps, e o Recovery System é naturalmente exercitado quando scrapers falham (sites mudam layout, captchas bloqueiam, PDFs têm formato inesperado).

**O que exercita do AIOX**:
- Pipeline de planejamento completo (domínio complexo com múltiplas fontes de dados)
- ADE Spec Pipeline para definir cada layer de scraping
- ADE Execution Engine 13 steps para implementação metódica
- ADE Recovery System (scrapers falham naturalmente — recovery real, não simulado)
- @devops para containerização e scheduling
- @qa para testes com dados reais (PDFs de exemplo, sites de teste)

---

### Projeto 4: Plataforma Zabbix Learning (SaaS)

**Classificação**: Greenfield (do zero, o mais ambicioso)
**Complexidade AIOX**: Muito Alta
**Envolve**: SaaS multi-tenant, auth com planos, gamificação, AI-driven content, labs efêmeros com containers, múltiplas ferramentas interativas, quiz engine, analytics

**Análise técnica**:
Este é um **sistema de sistemas**. Não é uma app — é uma plataforma com pelo menos 6 subsistemas:

1. **Content Engine**: Geração de aulas por IA com base na documentação oficial do Zabbix (RAG), traduzidas para linguagem acessível. Renderização de Markdown com imagens e infográficos.

2. **Quiz/Game Engine**: Similar ao RockQuiz mas muito mais amplo — múltiplos tipos de perguntas, níveis de dificuldade adaptativos, gamificação completa (XP, badges, streaks, ranking).

3. **Lab Provisioner**: O subsistema mais complexo tecnicamente — provisionar instâncias reais de Zabbix em containers efêmeros para cada exercício, com configuração pré-definida (hosts, templates, eventos), tempo de vida limitado, e acesso via iframe. Precisa escalar para milhares de usuários.

4. **Tooling Interativo**: Criador de itens de coleta, criador de triggers, pesquisa de macros, gerador de scripts, criador de LLD — cada um é uma mini-app com lógica própria, alimentada por documentação oficial e IA.

5. **Learning Path Engine**: Jornada guiada por IA que adapta o caminho do aluno baseado em performance nos quizzes e labs. Progressão adaptativa.

6. **Subscription/Billing**: Planos de acesso (free/mid/premium), gating de conteúdo por plano, payment integration.

Este projeto sozinho justificaria um curso inteiro. Para fins do programa AIOX, é perfeito como o projeto "master" do Mastery: complexo o suficiente para exercitar absolutamente todos os recursos avançados (ADE deep, hooks, multi-IDE, squads técnicos, observabilidade com traces, infra com 10+ containers).

**O que exercita do AIOX**:
- Planejamento profundo com @analyst (domínio enorme, competitive analysis de plataformas educacionais)
- @pm com PRD de 30+ FRs (cada subsistema tem seus requisitos)
- @architect com arquitetura de microserviços (10+ containers)
- ADE completo: cada subsistema é um épico com múltiplas features
- Hooks de lifecycle para automação do processo de dev
- Multi-IDE na prática
- Squads técnicos: squad de geração de conteúdo educacional, squad de QA de labs
- Observabilidade de produção real (SaaS com usuários)

---

### Projeto 5: RockQuiz (mantido)

**Classificação**: Greenfield (do zero)
**Complexidade AIOX**: Média
**Análise**: Mantido conforme planejado. Serve como **primeiro projeto** do Bootcamp — simples o suficiente para aprender o pipeline sem se afogar, complexo o bastante para exercitar a stack real (Fastify, PostgreSQL, Redis, Docker, CI/CD). E é algo que você quer construir de verdade — win-win.

---

## 2. Mapeamento: Projetos × Recursos AIOX

| Recurso AIOX | RockQuiz | LinkedIn | AuctionHunter | Plataforma Zabbix | Squad N8N |
|:---|:---:|:---:|:---:|:---:|:---:|
| Pipeline planejamento | ✅ Aprende | ✅ Brownfield | ✅ Recomeço | ✅ Profundo | — |
| @analyst profundo | Básico | ✅ Voz/perfil | ✅ Domínio scraping | ✅ Domínio educação | — |
| @pm PRD complexo | Básico | Médio | Médio | ✅ 30+ FRs | — |
| @architect C4 | ✅ 5 serviços | Médio | ✅ Multi-layer | ✅ 10+ serviços | — |
| @devops Docker | ✅ Aprende | ✅ Migração | ✅ Containers | ✅ Efêmeros | — |
| @devops CI/CD | ✅ Aprende | ✅ Aplica | ✅ Aplica | ✅ Complexo | — |
| @dev implementation | ✅ CRUD+lógica | ✅ API+integração | ✅ Scraping | ✅ SaaS | — |
| @qa review 10 fases | ✅ Aprende | ✅ Aplica | ✅ Segurança | ✅ Profundo | — |
| ADE Spec Pipeline | ✅ Básico | ✅ Aplica | ✅ Cada layer | ✅ Cada subsistema | — |
| ADE 13 steps | ✅ Pratica | — | ✅ Metódico | ✅ Profundo | — |
| ADE Recovery | — | — | ✅ Natural | ✅ Complexo | — |
| ADE Memory Layer | — | — | ✅ Entre layers | ✅ Entre subsistemas | — |
| AIOX Internals | — | — | — | ✅ Config avançado | — |
| Hooks lifecycle | — | — | — | ✅ Automação dev | — |
| Multi-IDE | — | — | — | ✅ 3 IDEs | — |
| Brownfield workflow | — | ✅ Migração | ✅ Recomeço | — | — |
| Document sharding | — | — | — | ✅ PRD enorme | — |
| Squad criação manual | — | ✅ 4 vertentes | — | ✅ Conteúdo edu | — |
| @squad-creator | — | — | — | — | ✅ |
| Squad composition | — | — | — | ✅ + N8N squad | ✅ |
| MCP integration | — | ✅ LinkedIn API | — | — | ✅ N8N |
| Squad testing | — | — | — | — | ✅ |
| Marketplace | — | — | — | — | ✅ |

---

## 3. Distribuição nos Cursos

### Princípio de distribuição

**Bootcamp**: Projetos onde o aluno está APRENDENDO o AIOX. Pipeline é novo, agentes são novos, Docker é novo. Precisa de andaimes. Projetos de complexidade baixa-média.

**Mastery**: Projetos onde o aluno está DOMINANDO o AIOX. Já sabe o pipeline, já usou os agentes. Agora vai fundo nos internals, ADE, hooks, brownfield. Projetos de complexidade média-alta a muito alta.

### Distribuição proposta

```
BOOTCAMP (18 aulas)
├── RockQuiz (greenfield simples → aprende o pipeline completo)
├── AuctionHunter (brownfield/recomeço → aplica o pipeline com mais autonomia)
└── Squad LinkedIn Monitoragindo (squad de conteúdo → aprende squads)

MASTERY (22 aulas)
├── Plataforma Zabbix Learning (greenfield complexo → domina AIOX por inteiro)
├── LinkedIn Automation avançado (brownfield do protótipo → hooks, integração, analytics)
└── Squad N8N Automation (squad avançado → @squad-creator, MCP, composition, testing)
```

### Por que esta distribuição

**RockQuiz no Bootcamp**: É o "hello world" sofisticado. Projeto divertido, stack real (Fastify, PostgreSQL, Redis, Docker), complexidade controlada. O aluno aprende todo o pipeline AIOX (analyst → pm → architect → sm → dev → qa → devops) sem se perder em complexidade de domínio. Depois disso, sabe usar o framework.

**AuctionHunter no Bootcamp**: Logo após o RockQuiz, o aluno aplica o que aprendeu em um projeto real que já tentou e falhou. Isso é poderoso pedagogicamente — demonstra o valor do AIOX ("antes falhei sem metodologia, agora consigo com"). A complexidade técnica (scraping, PDF, captcha) é alta, mas a complexidade de domínio é menor que a Plataforma Zabbix. É o passo intermediário perfeito. E como há código/conceito anterior, exercita brownfield naturalmente.

**Squad LinkedIn no Bootcamp**: Após 2 projetos de software, o aluno aprende squads construindo algo diretamente útil para o seu negócio (Monitoragindo). As 4 vertentes editoriais (Zabbix Quiz, artigo, IA na Sexta, mentalidade) criam um squad rico mas compreensível.

**Plataforma Zabbix no Mastery**: O projeto master — SaaS completo com 6 subsistemas. Cada módulo do Mastery aplica recursos avançados do AIOX em subsistemas diferentes: internals na configuração do projeto, ADE deep no Content Engine e Quiz Engine, hooks no Lab Provisioner, multi-IDE em todo o projeto. É grande o suficiente para exercitar tudo.

**LinkedIn avançado no Mastery**: O protótipo do Google AI Studio é migrado para arquitetura independente usando brownfield workflow. Adiciona: análise de voz com IA, persistência em banco, integração LinkedIn API para publicação e coleta de métricas, analytics de engajamento. Exercita hooks (automatizar publicação), integração com APIs externas, e observabilidade.

**Squad N8N no Mastery**: O squad mais técnico e avançado — meta-automação. Exercita @squad-creator, MCP integration com n8n, composition com outros squads, testing formal, marketplace. É o grand finale do ecossistema de squads.

---

## 4. Roadmap Reformulado

### BOOTCAMP — AIOX Professional Bootcamp (18 aulas)

---

#### Módulo 1 — Fundamentos AIOX (Aulas 1-2)

**Aula 01 — Setup + Anatomia do AIOX**
- Instalar AIOX, ativar agentes, sintaxe @agent e *comando
- Tour pela estrutura .aiox-core/ (visão geral, não profunda — profundidade no Mastery)
- core-config.yaml básico
- Configurar IDE (Claude Code como referência)
- Validar com `npx aiox-core doctor`
- 🏆 Greeting de agentes + *help funcionando
- **Projeto**: Nenhum ainda (preparação)

**Aula 02 — Conceitos-Chave e Fluxo de Trabalho AIOX**
- O que é Agentic Agile Development (teoria condensada)
- Fluxo em 2 fases: planejamento (web/CLI) → desenvolvimento (IDE)
- Como documentos carregam contexto entre agentes (stories como veículos)
- Diferença entre AIOX e "pedir pro ChatGPT codificar"
- Todos os 11 agentes apresentados com papel e comandos principais
- 🏆 Mapa mental pessoal dos agentes + fluxo
- **Projeto**: Nenhum ainda (conceitual)

---

#### Módulo 2 — RockQuiz: Pipeline Completo (Aulas 3-8)

> Greenfield simples. Aprender o pipeline AIOX inteiro.

**Aula 03 — Analyst + PM: Do Conceito ao PRD**
- @analyst: brief + domain map do quiz de rock
- @pm: PRD com FRs em Gherkin, NFRs mensuráveis, Epics
- *gather-requirements, *research-deps, *extract-patterns, *write-spec
- 🏆 docs/project-brief.md + docs/prd.md
- **Conceito AIOX**: Human-in-the-loop, PRD como contrato

**Aula 04 — Architect + UX + SM: Da Especificação às Stories**
- @architect: Architecture Doc (stack, schema, endpoints, C4 básico)
- @ux-expert: UX guidelines (tema rock, feedback visual)
- @sm: 6-8 stories hiperdetalhadas a partir do PRD + Arch Doc
- @po: priorização do backlog
- *assess-complexity, *create-plan, *create-context
- 🏆 docs/architecture.md + docs/ux-guidelines.md + docs/stories/STORY-01..08.md
- **Conceito AIOX**: Stories como veículos de contexto, revisão cruzada

**Aula 05 — DevOps: Infra do RockQuiz**
- @devops: DevContainer (app + PostgreSQL + Redis)
- Docker Compose produção (5 serviços, multi-stage builds)
- *create-worktree para feature isolada
- Conceito de worktrees para paralelismo
- 🏆 .devcontainer/ + docker-compose.yml + Dockerfiles
- **Conceito AIOX**: @devops como guardião da infra

**Aula 06 — Dev: Backend do RockQuiz**
- @dev implementando stories: Fastify + Prisma + PostgreSQL
- CRUD de categorias, perguntas, jogadores
- Quiz engine: seleção de perguntas, modos de jogo
- Scoring service com multiplicadores
- Rankings com Redis Sorted Sets
- Checkboxes marcados nas stories conforme progresso
- 🏆 API completa rodando com seed de 50+ perguntas
- **Conceito AIOX**: Dev dirigido por story, *execute-subtask, *capture-insights

**Aula 07 — Dev + QA: Frontend, Testes e Qualidade**
- @dev: Next.js com tema dark/rock, páginas (home, quiz, resultado, ranking)
- @dev: Testes (Jest unitários + Supertest integração + Playwright E2E)
- @qa: Review em 10 fases (primeira vez praticando todas as fases)
- Ciclo completo: *review-build → *request-fix → *apply-qa-fix → *verify-fix
- 🏆 Frontend integrado + testes ≥85% + QA aprovado
- **Conceito AIOX**: QA como última linha de defesa, feedback loop

**Aula 08 — DevOps: CI/CD, Observabilidade e Deploy**
- @devops: GitHub Actions (CI em PR, deploy em merge, preview)
- @devops: Observabilidade (Pino + Prometheus + Grafana)
- Deploy Vercel (frontend) + Docker (backend)
- Pipeline end-to-end: PR → lint → test → build → preview → deploy
- Branch protection configurada
- 🏆 Pipeline CI/CD completo + Grafana com métricas + app deployada
- **Conceito AIOX**: Pipeline como guardião automático de qualidade

---

#### Módulo 3 — AuctionHunter: Recomeço Estruturado (Aulas 9-13)

> Brownfield/recomeço. Aplicar o pipeline em projeto real que antes falhou.

**Aula 09 — Analyst: Entendendo o Domínio de Leilões**
- @analyst: pesquisa profunda do domínio de leilões de veículos apreendidos
- Domain map: editais (PDF), sites de leiloeiras, dados de veículos
- Cenários: PDF publicado vs website navegável vs sites com login/captcha
- Estratégias de scraping: multi-layer com fallback
- Análise do que foi tentado antes e por que falhou
- 🏆 docs/project-brief.md + docs/domain-map.md + docs/failure-analysis.md
- **Conceito AIOX**: Analyst como redutor de risco, aprender com falhas anteriores

**Aula 10 — PM + Architect: Spec Completa do AuctionHunter**
- @pm: PRD com FRs por layer (PDF parser, web scraper, login handler, captcha solver, data normalizer)
- @architect: Arquitetura com 3 layers de fallback + pipeline de extração
- Definição de schemas de dados de veículos (placa, chassi, marca, modelo, cor, ano, cidade)
- API contract para os endpoints de resultado
- *write-spec para cada layer (specs executáveis para o ADE)
- @qa: *critique-spec — iterar até aprovação
- 🏆 PRD + Arch Doc + 5 specs aprovadas
- **Conceito AIOX**: Spec Pipeline completo com iteração (Epic 3 do ADE na prática)

**Aula 11 — Dev: Implementando os Scrapers**
- @devops: *create-worktree para cada layer
- @dev: Layer 1 — PDF parser (pdfplumber + regex + LLM fallback)
- @dev: Layer 2 — Web scraper (Playwright para sites com navegação)
- @dev: Layer 3 — Login + captcha handler (headless browser, 2captcha ou similar)
- ADE Execution Engine: 13 steps aplicados por layer
- Self-critique obrigatório após implementação de cada layer
- *capture-insights entre layers (Memory Layer em ação)
- 🏆 3 layers de scraping funcionando com dados reais de teste
- **Conceito AIOX**: ADE 13 steps na prática, Memory Layer, self-critique

**Aula 12 — Dev: Normalização, API e Persistência**
- @dev: Data normalizer (padronizar dados extraídos de fontes diferentes)
- @dev: API FastAPI/Fastify para consulta de resultados
- @dev: Persistência em PostgreSQL com schema normalizado
- @dev: Testes com PDFs reais e sites de exemplo
- @qa: Review com foco em edge cases (PDF malformado, site offline, captcha falhou)
- ADE Recovery System: quando scraper falha, fallback para próxima layer
- 🏆 Pipeline completo: input (URL/PDF) → scraping → normalização → persistência → API
- **Conceito AIOX**: Recovery System real (não simulado), QA de edge cases

**Aula 13 — DevOps: Containerização e Scheduling + ADE Review**
- @devops: Docker Compose para AuctionHunter (API + workers + PostgreSQL + Redis)
- Scheduling: cron jobs para scraping periódico
- Observabilidade: logs de scraping, métricas de sucesso/falha por source
- @qa: Review final de todo o AuctionHunter
- ADE Memory Layer: consolidar insights do projeto inteiro
- Retrospectiva: "antes falhei, agora o AIOX estruturou o processo"
- 🏆 AuctionHunter containerizado + scheduled + observável
- **Conceito AIOX**: Valor do AIOX em projetos que antes falharam

---

#### Módulo 4 — Squad LinkedIn Monitoragindo (Aulas 14-18)

> Squad de conteúdo para negócio real. Aprender squads construindo algo útil.

**Aula 14 — Arquitetura do Squad de Conteúdo**
- Definir as 4 vertentes editoriais como workflows distintos:
  - Zabbix Quiz (enquete + resposta)
  - Artigo técnico (mini-artigo sobre o tema do quiz)
  - IA na Sexta (notícia/ferramenta/dica da semana)
  - Mentalidade & Liderança (reflexão sobre carreira/tech)
- 6+ agentes especializados:
  - Voice Analyst: analisa perfil de comunicação baseado em posts históricos
  - Trend Scout: pesquisa tendências por vertente
  - Quiz Crafter: cria perguntas técnicas de Zabbix com alternativas
  - Content Writer: escreve com a VOZ do Luciano (não genérico)
  - Editor: revisa, otimiza para LinkedIn, adiciona hashtags
  - Publisher: formata para API, agenda, prepara primeiro comentário
- config.yaml + workflow por vertente
- 🏆 Squad definido com 6 agentes + 4 workflows + templates + checklists
- **Conceito AIOX**: Squad profissional, múltiplos workflows por vertente

**Aula 15 — Voice Analysis e Geração de Conteúdo**
- Voice Analyst: analisar posts históricos do LinkedIn do Luciano
  - Tom de voz, expressões recorrentes, estrutura preferida, emojis, hashtags
  - Gerar "Voice Profile" documento que todos os outros agentes referenciam
- Quiz Crafter: gerar Zabbix Quiz da semana
  - Acessar documentação Zabbix para temas
  - Criar pergunta técnica + 4 alternativas + explicação detalhada
- Content Writer: escrever artigo técnico do quiz + post IA na Sexta
  - Usar Voice Profile para manter a voz autêntica
- 🏆 Voice Profile + 1 quiz + 1 artigo + 1 post IA na Sexta gerados
- **Conceito AIOX**: Agentes com knowledge base personalizada, voice profiling

**Aula 16 — Backend de Persistência e Analytics**
- @dev: Banco de dados para posts (PostgreSQL)
  - Schema: posts, metrics, engagement_snapshots, voice_profiles
  - Cada post salvo com: texto, vertente, hashtags, data publicação, métricas
- @dev: Integração LinkedIn API
  - OAuth 2.0 para publicação
  - Coleta de métricas pós-publicação (likes, comments, impressions, shares)
  - Snapshot de métricas em D+1, D+3, D+7 (cron job)
- 🏆 Backend de persistência + coleta de métricas funcionando
- **Conceito AIOX**: @dev construindo infra para o squad (squad + produto)

**Aula 17 — Analytics de Engajamento e Padrões**
- @dev: Dashboard de analytics
  - Métricas por vertente (qual tipo de post performa melhor?)
  - Métricas por horário de publicação
  - Evolução de engajamento ao longo do tempo
  - Identificar padrões de sucesso (temas, formatos, hooks que funcionaram)
- @dev: Feedback loop — padrões de sucesso alimentam o Content Writer
  - "Posts com hook de pergunta tiveram 2x mais comentários"
  - "Posts sobre Zabbix API tiveram 50% mais saves"
- @qa: Review do sistema completo (squad + backend + analytics)
- 🏆 Dashboard de analytics + feedback loop implementado
- **Conceito AIOX**: Squad como produto vivo com feedback loop data-driven

**Aula 18 — Automação, Brownfield e Consolidação do Bootcamp**
- Brownfield: migrar protótipo do Google AI Studio para a nova arquitetura
  - @architect: *map-codebase no protótipo existente
  - Identificar o que aproveitar vs o que refazer
  - Document sharding se documentação for grande
- Automação end-to-end:
  - Scheduling semanal (cron): pesquisa → geração → revisão → publicação
  - Integração com n8n para orquestração (webhook triggers)
- Deploy e observabilidade do sistema completo
- Retrospectiva do Bootcamp: RockQuiz + AuctionHunter + LinkedIn
- 🏆 Sistema LinkedIn automatizado + deploy + retrospectiva
- **Conceito AIOX**: Brownfield real (protótipo existente), consolidação de tudo

---

### MASTERY — AIOX Mastery (22 aulas)

---

#### Módulo 1 — AIOX Internals (Aulas 1-3)

**Aula 01 — Por Dentro do .aiox-core/**
- Tour profundo: 17 subdiretórios, constitution.md, core-config.yaml completo
- Schemas, manifests, presets
- Criar preset customizado para a Plataforma Zabbix
- 🏆 Mapa completo do .aiox-core/ + preset custom
- **Projeto base**: Plataforma Zabbix Learning

**Aula 02 — Elicitação, Workflow Intelligence e Definição de Agentes**
- Sistema de elicitação: como agentes fazem perguntas inteligentes
- workflow-intelligence/: motor de decisão automática
- Formato autoClaude V3 para definição de agentes
- Criar agente custom @zabbix-expert para a Plataforma
- 🏆 Agente custom criado em formato V3 + elicitação customizada
- **Projeto**: Plataforma Zabbix

**Aula 03 — Tasks, Workflows YAML e Customização Avançada**
- .aiox-core/development/tasks/: anatomia e criação
- .aiox-core/development/workflows/: YAML authoring
- Criar workflow custom para o ciclo de geração de conteúdo educacional
- Checklists customizados para qualidade de conteúdo Zabbix
- 🏆 Workflow YAML custom + tasks + checklists para a Plataforma
- **Projeto**: Plataforma Zabbix

---

#### Módulo 2 — ADE Deep Dive (Aulas 4-7)

**Aula 04 — Epic 1-2: Worktrees Avançados e Migration**
- Worktree Manager: 3 subsistemas da Plataforma em worktrees paralelos
- Migration V2→V3: migrar squad LinkedIn do Bootcamp para formato V3
- asset-inventory.js, migrate-agent.js, schemas de validação
- 🏆 3 worktrees ativos + squad migrado + validado
- **Projeto**: Plataforma Zabbix + LinkedIn (migration)

**Aula 05 — Epic 3: Spec Pipeline com Iteração Real**
- Spec Pipeline completo para o Content Engine da Plataforma
  - 7 etapas com 3 iterações reais entre PM e QA
  - Documentar cada iteração e o que mudou
- spec-tmpl.md, self-critique-checklist.md
- 🏆 Spec do Content Engine aprovada após 3 iterações
- **Projeto**: Plataforma Zabbix (Content Engine)

**Aula 06 — Epic 4: Execution Engine 13 Steps**
- Implementar o Quiz Engine da Plataforma usando os 13 steps
- Documentar cada step: o que fez, quanto tempo levou, o que aprendeu
- Self-critique obrigatório no step 10
- subtask-verifier.js, plan-tracker.js por dentro
- 🏆 Quiz Engine implementado via 13 steps documentados
- **Projeto**: Plataforma Zabbix (Quiz Engine)

**Aula 07 — Epics 5-7: Recovery, QA Evolution, Memory Layer**
- Recovery: implementar Lab Provisioner (containers efêmeros) — feature que VAI falhar (infra complexa), exercitando recovery real
- QA Evolution: 10 fases aplicadas ao Lab Provisioner (segurança de containers é crítica)
- Memory Layer: consolidar insights de Content Engine + Quiz Engine + Lab Provisioner
- recovery-tracker.js, qa-loop-orchestrator.js, codebase-mapper.js, pattern-extractor.js
- 🏆 Recovery documentado + QA 10 fases + Memory Layer com insights reais
- **Projeto**: Plataforma Zabbix (Lab Provisioner)

---

#### Módulo 3 — Plataforma Zabbix: Planejamento e Arquitetura (Aulas 8-10)

**Aula 08 — Analyst: Domínio Educacional + Zabbix**
- @analyst: pesquisa profunda — plataformas educacionais técnicas (Pluralsight, A Cloud Guru, KodeKloud, labs da AWS)
- Domain map: conteúdos Zabbix (conceitos → instalação → configuração → monitoramento → automação → API)
- Análise de documentação oficial do Zabbix como fonte primária
- Avaliação de RAG vs fine-tuning para geração de conteúdo
- Personas de alunos: iniciante, intermediário, avançado, expert
- 🏆 Brief + competitive analysis + domain map + content taxonomy
- **Projeto**: Plataforma Zabbix

**Aula 09 — PM + Architect: PRD e Arquitetura de SaaS**
- @pm: PRD com 30+ FRs organizados em 6 subsistemas
- @architect: Arquitetura SaaS completa:
  - 10+ containers: web, api, content-worker, lab-provisioner, quiz-engine, postgres, redis, minio (assets), prometheus, grafana
  - Auth multi-tenant com planos (free/mid/premium)
  - Estratégia de RAG para documentação Zabbix
  - Arquitetura de labs efêmeros (Docker-in-Docker ou Kubernetes pods)
  - Avaliação técnico-financeira de labs (custo por aluno × escala)
- Document sharding com @po (PRD será grande)
- 🏆 PRD 30+ FRs + Arch Doc 10+ serviços + análise de viabilidade de labs
- **Projeto**: Plataforma Zabbix

**Aula 10 — Infraestrutura SaaS + Lab Provisioner Design**
- @devops: DevContainer para a Plataforma (6 serviços dev)
- @devops: Docker Compose produção (10+ serviços)
- Design detalhado do Lab Provisioner:
  - Opção A: Docker-in-Docker (DinD) com containers efêmeros
  - Opção B: Kubernetes com pods temporários
  - Opção C: Ambiente fixo com configuração variável por aluno
  - Trade-offs de custo, escala e complexidade
- @devops: CI/CD pipeline para SaaS (build matrix, staging environment)
- 🏆 Infra completa definida + decisão de arquitetura de labs
- **Projeto**: Plataforma Zabbix

---

#### Módulo 4 — Plataforma Zabbix: Desenvolvimento Core (Aulas 11-14)

**Aula 11 — Auth, Multi-Tenant e Billing**
- Auth com NextAuth.js: credentials + GitHub/Google OAuth
- Multi-tenant: cada organização/aluno isolado
- Planos de acesso: 3 tiers com feature gating
- RBAC: admin, instructor, student
- Usando ADE 13 steps para implementação metódica
- 🏆 Auth + planos + gating funcionando
- **Projeto**: Plataforma Zabbix

**Aula 12 — Content Engine com RAG**
- Ingestão da documentação oficial do Zabbix
- RAG pipeline: chunk → embed → vector store → retrieve → generate
- Geração de aulas em Markdown com linguagem acessível
- Renderização de conteúdo (Markdown → componentes React)
- Agente custom @zabbix-expert (criado na Aula 02) gerando conteúdo
- 🏆 Content Engine gerando aulas a partir da documentação Zabbix
- **Projeto**: Plataforma Zabbix

**Aula 13 — Quiz Engine Gamificado + Learning Path**
- Quiz engine: múltiplos tipos de pergunta, dificuldade adaptativa
- Gamificação: XP, badges, streaks, ranking, levels
- Learning Path: jornada adaptativa guiada por IA
  - Se acertou 80%+ do quiz → avança
  - Se < 60% → revisão do conceito + quiz alternativo
- Integração quiz ↔ content ↔ path
- 🏆 Quiz gamificado + learning path adaptativo funcionando
- **Projeto**: Plataforma Zabbix

**Aula 14 — Ferramentas Interativas e Lab Provisioner**
- Tooling: criador de itens, criador de triggers, pesquisa de macros
  - Cada ferramenta = mini-app alimentada por documentação + IA
  - Gerador de scripts (Duktape, Python, Shell) via prompt → IA → código
  - Criador de LLD interativo
- Lab Provisioner (implementação da decisão da Aula 10):
  - Provisionar instância Zabbix efêmera para exercício
  - Configuração pré-definida por exercício (hosts, templates, triggers)
  - Acesso via iframe na tela da aula
  - Tempo de vida limitado + cleanup automático
- 🏆 Ferramentas interativas + primeiro lab funcional
- **Projeto**: Plataforma Zabbix

---

#### Módulo 5 — Hooks, Multi-IDE e Brownfield (Aulas 15-17)

**Aula 15 — Hooks de Lifecycle + Automação**
- Sistema completo de hooks: pre-tool, post-tool, session start/end, monitor
- Criar hooks custom para a Plataforma Zabbix:
  - Hook que auto-testa conteúdo gerado pelo Content Engine
  - Hook que notifica quando lab provisioning falha
  - Hook que coleta métricas de uso dos agentes
- Aplicar na Plataforma Zabbix e no LinkedIn Automation
- 🏆 3+ hooks custom criados e funcionando
- **Projeto**: Plataforma Zabbix + LinkedIn

**Aula 16 — Multi-IDE na Prática**
- Configurar Plataforma Zabbix em Claude Code, Gemini CLI e Codex CLI
- Mesma feature implementada em 3 IDEs (comparação real)
- `npm run validate:parity` + todos os validate:* commands
- Documentar diferenças, friction points, workarounds por IDE
- 🏆 Projeto configurado e testado em 3 IDEs + relatório de paridade
- **Projeto**: Plataforma Zabbix

**Aula 17 — Brownfield: LinkedIn Automation Protótipo → Produção**
- Migrar protótipo do Google AI Studio para arquitetura independente
- @architect: *map-codebase no protótipo existente
- @analyst: *extract-patterns do que funciona
- @po: document sharding do PRD (projeto grande)
- @sm: stories retroativas + stories de evolução
- Conectar com o squad LinkedIn do Bootcamp (agora migrado para V3)
- Adicionar: persistência, analytics, feedback loop, scheduling
- Performance tuning do AIOX para o projeto combinado (squad + app)
- 🏆 LinkedIn Automation migrado e expandido via brownfield
- **Projeto**: LinkedIn Automation (brownfield completo)

---

#### Módulo 6 — Squads Avançados (Aulas 18-22)

**Aula 18 — Squad Zabbix Content (para a Plataforma)**
- Squad de geração de conteúdo educacional Zabbix:
  - Curriculum Planner: planeja jornada de aprendizado
  - Lesson Writer: escreve aulas com base na documentação (RAG)
  - Quiz Generator: gera perguntas por tema/dificuldade
  - Lab Designer: projeta exercícios práticos e configurações de lab
  - Reviewer: revisa conteúdo para precisão técnica e clareza pedagógica
- Workflows para geração em lote (módulo inteiro de uma vez)
- Integração squad ↔ Content Engine da Plataforma
- 🏆 Squad gerando conteúdo real para a Plataforma Zabbix
- **Projeto**: Plataforma Zabbix

**Aula 19 — @squad-creator + Squad N8N Automation**
- @squad-creator: gerar squad de automação n8n automaticamente
- Comparar output automático vs design manual
- Refinar: ajustar agentes, adicionar comandos, criar templates
- Agentes do squad:
  - Automation Analyst: entende a necessidade de automação
  - Workflow Designer: projeta o workflow n8n (nodes, connections, logic)
  - Workflow Builder: gera o JSON do workflow
  - Deployer: deploya via API do n8n
  - Tester: executa workflow e valida resultado
  - Monitor: observa execuções e detecta erros
- 🏆 Squad N8N criado via @squad-creator + refinado + funcional
- **Projeto**: Squad N8N Automation

**Aula 20 — MCP Integration e Squad Testing**
- MCP integration para o Squad N8N:
  - Conectar agente Deployer ao n8n via MCP server
  - Conectar agente Monitor para observar execuções
- Squad testing formal:
  - Validar config.yaml contra schema
  - Testar cada workflow (happy path + error path)
  - Checklist de qualidade de squad
- Aplicar MCP também no squad LinkedIn (publicação automática)
- 🏆 MCP conectado + squad testado formalmente
- **Projeto**: Squad N8N + LinkedIn

**Aula 21 — Squad Composition e Ecossistema**
- Compor squads:
  - Squad N8N + Squad LinkedIn: automação que cria workflow n8n que publica no LinkedIn
  - Squad Zabbix Content + Squad N8N: geração de conteúdo que trigger deploys de lab
- Inter-squad communication via @aiox-orchestrator
- Versioning semântico para cada squad
- 🏆 Composição cross-squad funcionando
- **Projeto**: Todos os squads conectados

**Aula 22 — Marketplace, Contribuição e Consolidação Final**
- Publicar squads: L1 → L2 (GitHub) → L3 (marketplace)
- Contribuir para o AIOX core: CONTRIBUTING.md, feature process, preparar PR
- Security best practices aplicadas a todos os projetos
- Observabilidade de produção da Plataforma Zabbix (dashboards completos)
- Retrospectiva final:
  - 5 projetos construídos (RockQuiz, AuctionHunter, LinkedIn, Plataforma Zabbix, Squad N8N)
  - 3 squads criados (LinkedIn, Zabbix Content, N8N Automation)
  - 11/11 agentes core + 1 custom (@zabbix-expert) + 17 agentes de squad = 29 agentes
  - ~95% dos recursos AIOX cobertos
- 🏆 Squads publicados + PR draft + retrospectiva completa
- **Projeto**: Consolidação de tudo

---

## 5. Sobre os detalhes dos projetos

Você perguntou se os detalhes devem ser trabalhados agora ou durante design docs. A resposta: **durante design docs, usando o AIOX**. Isso é proposital.

Os detalhes que você não especificou (schema exato do banco, endpoints da API, estratégia de RAG, modelo de precificação dos planos) são exatamente o tipo de decisão que o pipeline AIOX existe para facilitar: o @analyst pesquisa, o @pm estrutura requisitos, o @architect decide a stack. Se eu definir tudo aqui, estaria roubando a experiência de aprendizado.

O que defini acima é o **escopo macro** — funcionalidades de alto nível, subsistemas e complexidade. Os detalhes emergem naturalmente quando o aluno (você) conversa com os agentes durante o curso. Cada projeto vai ter seu próprio conjunto de docs/ gerados pelo pipeline AIOX — e esses docs serão mais ricos do que qualquer coisa que eu pre-definisse aqui, porque terão suas decisões, seu contexto e seu domínio.
