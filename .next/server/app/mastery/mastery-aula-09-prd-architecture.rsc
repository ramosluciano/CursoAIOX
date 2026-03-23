2:I[4817,["972","static/chunks/972-435ad046c10f8479.js","552","static/chunks/552-ca913c8f5aa11d94.js","460","static/chunks/app/mastery/%5Blesson%5D/page-19f8ee117e5859d3.js"],"LessonRenderer"]
4:I[4707,[],""]
6:I[6423,[],""]
7:I[872,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"ThemeProvider"]
8:I[3021,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Sidebar"]
9:I[8680,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Header"]
3:T21d5,# Aula 09 — PM + Architect: PRD e Arquitetura de SaaS

<!-- metadata
course: Mastery
module: 3
lesson: 9
title: "PM + Architect: PRD e Arquitetura de SaaS"
duration: 5-6 horas
agents: "@pm, @architect, @po, @qa"
project: Plataforma Zabbix Learning
phase: Planejamento
prerequisites: Aula 08 concluída (domínio pesquisado)
-->

---

> **Módulo 3** · Plataforma Zabbix: Planejamento e Arquitetura
> **Duração**: 5-6 horas
> **Agentes praticados**: `@pm`, `@architect`, `@po`, `@qa`
> **Projeto**: Plataforma Zabbix Learning

---

## 🏆 Vitória desta aula

PRD com 30+ FRs organizados por subsistema, Architecture Doc com 10+ containers e decisões de infraestrutura SaaS, e document sharding aplicado pela primeira vez (PRD grande demais para um doc).

**Critério binário**: PRD em `docs/prd/` (sharded) + `docs/architecture.md` com diagrama C4 + análise de viabilidade de labs.

---

## Conceito

### Document sharding: quando um documento é grande demais

No Bootcamp, cada PRD era um arquivo. Para a Plataforma Zabbix, com 6 subsistemas e 30+ FRs, um único PRD seria ilegível — e pior, nenhum agente conseguiria processar tudo de uma vez sem perder contexto.

Document sharding é a solução do AIOX: o @po divide documentos grandes em partes gerenciáveis, cada uma com escopo claro e referências cruzadas. O PRD vira `docs/prd/`:
- `prd-overview.md` (visão geral, NFRs globais)
- `prd-content-engine.md` (FRs do Content Engine)
- `prd-quiz-engine.md` (FRs do Quiz Engine)
- `prd-lab-provisioner.md` (FRs do Lab Provisioner)
- `prd-tooling.md` (FRs do Tooling Interativo)
- `prd-learning-path.md` (FRs do Learning Path)
- `prd-auth-billing.md` (FRs do Auth/Billing)

### Arquitetura SaaS: decisões que definem o projeto

A arquitetura da Plataforma é a maior e mais complexa do programa. Decisões que o Architect precisa tomar:

| Decisão | Impacto |
|---------|---------|
| Monolito vs microserviços | Complexidade de deploy vs escalabilidade |
| Estratégia de RAG | Qualidade do Content Engine inteiro |
| Labs: DinD vs K8s vs fixed | Custo, escala, complexidade |
| Multi-tenancy approach | Isolamento de dados, planos de acesso |
| 10+ containers orchestration | DevOps, CI/CD, observabilidade |

---

## Prática

### Passo 1 — PRD com document sharding

```bash
cd ~/aiox-mastery/zabbix-platform
claude
```

```
@pm

Patty, escreva o PRD da Plataforma Zabbix Learning.

Input:
- docs/project-brief.md
- docs/competitive-analysis.md
- docs/content-taxonomy.md
- docs/personas.md
- docs/rag-vs-finetuning.md

Este PRD é GRANDE — 6 subsistemas, cada um com FRs 
próprios. Use document sharding:

1. docs/prd/prd-overview.md — Visão geral, NFRs globais, 
   personas referenciadas, glossário
2. docs/prd/prd-content-engine.md — FRs de ingestão, 
   RAG pipeline, geração, renderização
3. docs/prd/prd-quiz-engine.md — FRs de tipos de pergunta, 
   dificuldade adaptativa, gamificação
4. docs/prd/prd-lab-provisioner.md — FRs de provisioning, 
   configuração, lifecycle, cleanup
5. docs/prd/prd-tooling.md — FRs de cada ferramenta 
   interativa (item creator, trigger creator, etc.)
6. docs/prd/prd-learning-path.md — FRs de jornada 
   adaptativa, progressão, recomendação
7. docs/prd/prd-auth-billing.md — FRs de auth, 
   multi-tenant, planos, gating

Cada shard deve:
- Ter FRs com acceptance criteria em Gherkin
- Referenciar personas relevantes
- Listar dependências entre subsistemas
- Ser independente o suficiente para spec e implementação

*write-spec
```

```
*exit

@po

Percy, o PRD é grande. Aplique document sharding:
- Verifique que cada shard é autocontido
- Crie índice de referências cruzadas entre shards
- Verifique que nenhum FR está duplicado entre shards
- Verifique que dependências estão explícitas
```

> **Checklist de avaliação do PRD sharded**
> - [ ] 7 shards criados com escopo claro?
> - [ ] Cada shard tem FRs com acceptance criteria?
> - [ ] Overview tem NFRs globais (performance, segurança, escalabilidade)?
> - [ ] Referências cruzadas entre shards existem?
> - [ ] Total de 30+ FRs distribuídos?
> - [ ] Não há FR duplicado entre shards?

> **🏆 Checkpoint 1**: PRD sharded com 30+ FRs.

---

### Passo 2 — Architecture Doc SaaS

```
*exit

@architect

Aria, projete a arquitetura SaaS da Plataforma Zabbix.

Input: docs/prd/ (todos os shards) + pesquisa da Aula 08.

O Architecture Doc deve cobrir:

1. CONTAINERS (10+):
   - web (Next.js frontend)
   - api (backend principal)
   - content-worker (RAG + geração de conteúdo)
   - lab-provisioner (gestão de containers efêmeros)
   - quiz-engine (lógica de quiz + gamificação)
   - postgres (banco principal)
   - redis (cache + sessions + queues)
   - minio (assets: imagens, PDFs)
   - vector-store (embeddings para RAG)
   - prometheus + grafana (observabilidade)

2. DECISÕES ARQUITETURAIS com justificativa:
   - RAG pipeline: chunk strategy, embedding model, 
     vector store choice
   - Lab strategy: DinD vs K8s vs fixed (com análise 
     de custo por aluno × escala)
   - Auth: NextAuth.js com providers + RBAC
   - Multi-tenancy: schema isolation vs row-level
   - Communication: REST vs events vs hybrid

3. DIAGRAMAS:
   - C4 Context (sistema e atores)
   - C4 Container (10+ containers e relações)
   - Fluxo do Content Engine (RAG pipeline)
   - Fluxo do Lab Provisioner (lifecycle)

4. ANÁLISE DE VIABILIDADE DOS LABS:
   - Opção A: Docker-in-Docker
   - Opção B: Kubernetes pods temporários
   - Opção C: Ambiente fixo com config variável
   - Trade-offs: custo, escala, complexidade, latência
   - RECOMENDAÇÃO com justificativa

*create-plan
```

> **Checklist de avaliação da arquitetura**
> - [ ] 10+ containers definidos com responsabilidades claras?
> - [ ] Cada decisão arquitetural tem justificativa?
> - [ ] RAG pipeline está detalhado (chunk → embed → store → retrieve → generate)?
> - [ ] Análise de viabilidade dos labs compara 3 opções?
> - [ ] Diagramas C4 estão presentes (context + container)?
> - [ ] Multi-tenancy approach está definido?
> - [ ] Estimativa de custo por aluno para labs?

Se a análise de labs for superficial:

```
Aria, a análise de labs diz "DinD é mais simples". 
Preciso de números: quanto custa provisionar 1 lab? 
Quanto tempo leva? Quantos simultâneos suporta com 
4GB RAM no host? E com 16GB? Sem números, a decisão 
é achismo.
```

> **🏆 Checkpoint 2**: Architecture Doc completo com decisões fundamentadas.

---

### Passo 3 — QA critique das specs

```
*exit

@qa

Quinn, critique o PRD e o Architecture Doc.

Foco:
1. Os 30+ FRs cobrem todos os subsistemas da pesquisa?
2. As dependências entre subsistemas estão mapeadas?
3. A arquitetura suporta os NFRs? (ex: "1000 alunos 
   simultâneos" — o Lab Provisioner aguenta?)
4. A decisão de labs é defensável? Os trade-offs estão 
   honestos?
5. Algum FR é não-testável?

*critique-spec
```

Ciclo PM → QA → PM conforme Aula 10 do Bootcamp.

> **🏆 Checkpoint 3 — VITÓRIA DA AULA**: PRD sharded + Arch Doc + QA aprovado.

---

### Passo 4 — Commit

```bash
*exit
git add .
git commit -m "docs: PRD (30+ FRs, 7 shards) + SaaS Architecture (10+ containers)

- Document sharding applied to PRD (6 subsystems + overview)
- Architecture with C4 diagrams and justified decisions
- Lab Provisioner viability analysis (DinD vs K8s vs fixed)
- RAG pipeline architecture for Content Engine
- QA critique cycle completed"
```

---

## Reflexão

### Document sharding: a habilidade que escala

No Bootcamp, documentos eram monolíticos. Isso funciona para projetos com 5-8 FRs. Com 30+, o sharding é obrigatório — tanto para legibilidade humana quanto para processamento por agentes. O @po como "editor" de documentos grandes é um papel que não existia no Bootcamp e que qualquer projeto enterprise precisa.

### O conceito-chave

> **Projetos SaaS com múltiplos subsistemas exigem planejamento proporcional: PRD sharded para manter escopo gerenciável, arquitetura com decisões fundamentadas em trade-offs reais (não preferências), e análise de viabilidade com números (não achismos). A Plataforma Zabbix é a prova de que o AIOX escala para projetos enterprise.**

### Conexão com a próxima aula

Na Aula 10, o @devops configura a infraestrutura SaaS: Docker Compose de 10+ serviços, design detalhado do Lab Provisioner baseado na decisão desta aula, e CI/CD para build matrix.

---

> **Anterior**: [Aula 08 — Analyst: Domínio Educacional + Zabbix](./aula-08-analyst-domain.md)
> **Próxima**: [Aula 10 — Infraestrutura SaaS + Lab Provisioner Design](./aula-10-infra-saas.md)
5:["lesson","mastery-aula-09-prd-architecture","d"]
0:["0aCmzVh17xjX8k-qFi6hn",[[["",{"children":["mastery",{"children":[["lesson","mastery-aula-09-prd-architecture","d"],{"children":["__PAGE__?{\"lesson\":\"mastery-aula-09-prd-architecture\"}",{}]}]}]},"$undefined","$undefined",true],["",{"children":["mastery",{"children":[["lesson","mastery-aula-09-prd-architecture","d"],{"children":["__PAGE__",{},[["$L1",["$","$L2",null,{"content":"$3","lessonSlug":"mastery-aula-09-prd-architecture","module":"mastery","lessonIndex":8,"totalLessons":22,"nextLesson":"mastery-aula-10-infra-saas","prevLesson":"mastery-aula-08-analyst-domain"}],null],null],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","mastery","children","$5","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","mastery","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[[[["$","link","0",{"rel":"stylesheet","href":"/_next/static/css/71d217bb04404cb9.css","precedence":"next","crossOrigin":"$undefined"}]],["$","html",null,{"lang":"pt-BR","children":["$","body",null,{"className":"bg-white dark:bg-slate-900 text-gray-900 dark:text-gray-100 transition-colors","children":["$","$L7",null,{"children":["$","div",null,{"className":"flex h-screen overflow-hidden","children":[["$","$L8",null,{}],["$","div",null,{"className":"flex-1 flex flex-col overflow-hidden","children":[["$","$L9",null,{}],["$","main",null,{"className":"flex-1 overflow-y-auto bg-white dark:bg-slate-900 transition-colors","children":["$","div",null,{"className":"max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8","children":["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":[["$","title",null,{"children":"404: This page could not be found."}],["$","div",null,{"style":{"fontFamily":"system-ui,\"Segoe UI\",Roboto,Helvetica,Arial,sans-serif,\"Apple Color Emoji\",\"Segoe UI Emoji\"","height":"100vh","textAlign":"center","display":"flex","flexDirection":"column","alignItems":"center","justifyContent":"center"},"children":["$","div",null,{"children":[["$","style",null,{"dangerouslySetInnerHTML":{"__html":"body{color:#000;background:#fff;margin:0}.next-error-h1{border-right:1px solid rgba(0,0,0,.3)}@media (prefers-color-scheme:dark){body{color:#fff;background:#000}.next-error-h1{border-right:1px solid rgba(255,255,255,.3)}}"}}],["$","h1",null,{"className":"next-error-h1","style":{"display":"inline-block","margin":"0 20px 0 0","padding":"0 23px 0 0","fontSize":24,"fontWeight":500,"verticalAlign":"top","lineHeight":"49px"},"children":"404"}],["$","div",null,{"style":{"display":"inline-block"},"children":["$","h2",null,{"style":{"fontSize":14,"fontWeight":400,"lineHeight":"49px","margin":0},"children":"This page could not be found."}]}]]}]}]],"notFoundStyles":[]}]}]}]]}]]}]}]}]}]],null],null],["$La",null]]]]
a:[["$","meta","0",{"name":"viewport","content":"width=device-width, initial-scale=1"}],["$","meta","1",{"charSet":"utf-8"}],["$","title","2",{"children":"AIOX Course Platform | Professional Bootcamp & Mastery"}],["$","meta","3",{"name":"description","content":"Learn AIOX - AI-Orchestrated System for Full Stack Development. Complete bootcamp and mastery courses with hands-on projects."}],["$","meta","4",{"name":"keywords","content":"AIOX,AI Development,Full Stack,Course,Bootcamp,Learning"}]]
1:null
