# Aula 09 — PM + Architect: PRD e Arquitetura de SaaS

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
> - <input type="checkbox" class="checkbox-input" /> 7 shards criados com escopo claro?
> - <input type="checkbox" class="checkbox-input" /> Cada shard tem FRs com acceptance criteria?
> - <input type="checkbox" class="checkbox-input" /> Overview tem NFRs globais (performance, segurança, escalabilidade)?
> - <input type="checkbox" class="checkbox-input" /> Referências cruzadas entre shards existem?
> - <input type="checkbox" class="checkbox-input" /> Total de 30+ FRs distribuídos?
> - <input type="checkbox" class="checkbox-input" /> Não há FR duplicado entre shards?

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
> - <input type="checkbox" class="checkbox-input" /> 10+ containers definidos com responsabilidades claras?
> - <input type="checkbox" class="checkbox-input" /> Cada decisão arquitetural tem justificativa?
> - <input type="checkbox" class="checkbox-input" /> RAG pipeline está detalhado (chunk → embed → store → retrieve → generate)?
> - <input type="checkbox" class="checkbox-input" /> Análise de viabilidade dos labs compara 3 opções?
> - <input type="checkbox" class="checkbox-input" /> Diagramas C4 estão presentes (context + container)?
> - <input type="checkbox" class="checkbox-input" /> Multi-tenancy approach está definido?
> - <input type="checkbox" class="checkbox-input" /> Estimativa de custo por aluno para labs?

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

> **Anterior**: Aula 08 — Analyst: Domínio Educacional + Zabbix
> **Próxima**: Aula 10 — Infraestrutura SaaS + Lab Provisioner Design
