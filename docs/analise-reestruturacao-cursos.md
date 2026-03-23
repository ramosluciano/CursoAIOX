# Análise Crítica — Cursos 1 e 2: Reestruturar ou Fundir?

## 1. Dados Quantitativos

| Métrica | Curso 1 (Fundamentals) | Curso 2 (Professional) |
|---------|:---:|:---:|
| Aulas | 10 | 20 |
| Linhas totais | 1.592 | 4.007 |
| Média por aula | 159 linhas | 200 linhas |
| Menor aula | 113 linhas (Dia 08) | 109 linhas (Aula 12) |
| Maior aula | 218 linhas (Dia 10) | 393 linhas (Aula 10) |
| Horas estimadas | ~25h | ~65h |

**Primeiro problema**: O Curso 1 é **fino demais**. Aulas com 113-150 linhas são esqueletos, não aulas completas. Falta profundidade, exemplos concretos, outputs esperados detalhados e troubleshooting.

---

## 2. Análise de Sobreposição

### O pipeline de planejamento é repetido integralmente

| Fase | Curso 1 | Curso 2 | Diferença real |
|------|---------|---------|---------------|
| Analyst → Brief | Dia 02 (153L) | Aula 01 (170L) | Curso 2 adiciona competitive analysis e domain map |
| PM → PRD | Dia 03 (154L) | Aula 02 (258L) | Curso 2 adiciona Gherkin, risk matrix, MoSCoW |
| Architect → Arch Doc | Dia 04 (160L) | Aula 03 (365L) | Curso 2 adiciona C4, trade-offs, schema Prisma |
| SM → Stories | Dia 05 (125L) | Aula 07 (318L) | Curso 2 adiciona stories rastreáveis, worktrees |
| Dev → Implementação | Dias 06-08 | Aulas 07-11 | Curso 2 usa Fastify/Prisma/Next.js vs Express/SQLite |
| QA → Review | Dia 07 (163L) | Aulas 09+12 | Curso 2 adiciona security/performance review |

**O Curso 2 não constrói SOBRE o Curso 1 — ele SUBSTITUI o Curso 1 com versão melhor.** O aluno que faz ambos aprende o mesmo pipeline de planejamento duas vezes. A primeira vez com um projeto simples e raso, a segunda vez com um projeto complexo e profundo.

### Agentes cobertos

| Agente | Curso 1 | Curso 2 | Sobreposição |
|--------|:---:|:---:|:---:|
| @analyst | ✅ | ✅ | 100% — mesma função, projeto diferente |
| @pm | ✅ | ✅ | 100% — mesma função, mais profundo no C2 |
| @architect | ✅ | ✅ | 100% — mesma função, mais profundo no C2 |
| @ux-expert | ✅ | ✅ | 100% |
| @sm | ✅ | ✅ | 100% |
| @dev | ✅ | ✅ | 100% — stack diferente mas mesmo papel |
| @qa | ✅ | ✅ | 100% — mais profundo no C2 |
| @po | ✅ | ✅ (breve) | Ambos usam superficialmente |
| @devops | ❌ | ✅ | Único exclusivo substancial do C2 |
| @aiox-master | ✅ (Dia 10) | ✅ | Ambos usam superficialmente |
| @aiox-orchestrator | ✅ (Dia 10) | ❌ | Curso 1 mencionou, Curso 2 não explorou |

**9 de 11 agentes são cobertos identicamente.** O @devops é o único agente que justifica o Curso 2 existir como curso separado. Os agentes meta (@aiox-master, @aiox-orchestrator) são subutilizados em ambos.

### Comandos praticados

Os mesmos comandos core aparecem em ambos os cursos:

- `*gather-requirements`, `*write-spec` (PM)
- `*assess-complexity`, `*create-plan`, `*create-context` (Architect)
- `*research-deps`, `*extract-patterns` (Analyst)
- `*execute-subtask`, `*capture-insights`, `*rollback` (Dev)
- `*review-build`, `*request-fix`, `*verify-fix`, `*critique-spec` (QA)

O Curso 2 adiciona os comandos do @devops (`*create-worktree`, `*list-worktrees`, etc.) e os comandos dos agentes do Squad LinkedIn — mas os comandos core são idênticos.

---

## 3. Problemas Estruturais Identificados

### Problema 1: O Curso 1 é um rascunho do Curso 2

O Curso 1 (TaskFlow — Express + SQLite) é uma versão simplificada do que o Curso 2 faz melhor (RockQuiz — Fastify + PostgreSQL + Redis + Docker + CI/CD). O aluno que faz os dois sente que o Curso 1 foi "treino descartável".

O TaskFlow não ensina nada que o RockQuiz não cubra de forma mais completa. A stack do TaskFlow (Express + SQLite + HTML vanilla) é artificialmente simples — não representa projetos reais e não prepara para o Curso 3 que usa Fastify, PostgreSQL, Redis, Docker.

### Problema 2: Não há progressão real entre os dois cursos

Uma boa sequência de cursos tem **progressão**: cada curso assume o conhecimento do anterior e vai além. O que temos é:

```
Curso 1: Analyst → PM → Architect → SM → Dev → QA (projeto simples)
Curso 2: Analyst → PM → Architect → SM → Dev → QA (projeto complexo) + DevOps + Squad
```

Não é progressão — é **repetição com melhoria**. O aluno do Curso 2 repete 70% do que já fez no Curso 1.

### Problema 3: O Curso 1 não prepara para o Curso 3

O Curso 3 (Mastery) assume domínio de: DevContainer, Docker Compose, CI/CD, testes ≥85%, observabilidade, multi-IDE, worktrees, squads. O Curso 1 não ensina nenhuma dessas coisas. Quem faz Curso 1 → Curso 3 estaria perdido. Na prática, o Curso 2 é que serve de pré-requisito para o Curso 3.

### Problema 4: O projeto TaskFlow não agrega valor na jornada

O TaskFlow é uma API CRUD com frontend HTML vanilla. Depois do Curso 1, o aluno descarta o projeto completamente e começa o RockQuiz do zero. Nenhum aprendizado do TaskFlow é reutilizado — nem o código, nem os documentos, nem os padrões.

### Problema 5: Squads são cobertos superficialmente em ambos

- Curso 1 (Dia 10): Squad doc-ops com 2 agentes — muito raso, parece afterthought
- Curso 2 (Aulas 16-20): Squad LinkedIn com 6 agentes — melhor, mas desconectado do projeto principal (RockQuiz)

Nenhum dos dois cursos demonstra o poder real dos squads: composição, @squad-creator, testing, marketplace, MCP.

### Problema 6: Conceitos avançados mencionados mas não praticados

Ambos os cursos mencionam conceitos sem explorá-los na prática:

| Conceito | Onde aparece | Praticado? |
|----------|-------------|:---:|
| ADE Execution Engine 13 steps | Curso 1 Dia 09 | ❌ Conceitual |
| Recovery System | Curso 1 Dia 09 | ❌ Menção |
| Memory Layer | Curso 1 Dia 09 | ❌ Menção |
| Document Sharding | Nenhum | ❌ |
| Hooks de lifecycle | Nenhum | ❌ |
| Validação multi-IDE | Nenhum | ❌ |
| Constitution/Principles | Nenhum | ❌ |

---

## 4. Veredito

### Recomendação: FUNDIR os Cursos 1 e 2 em um único curso reestruturado.

**Motivos**:

1. **Elimina 70% de sobreposição** — o pipeline de planejamento é ensinado UMA vez, com profundidade adequada desde o início
2. **Projeto único coeso** — em vez de TaskFlow descartável + RockQuiz, usar apenas o RockQuiz (ou projeto equivalente) desde a aula 1
3. **Progressão limpa** — cada aula adiciona algo novo, sem repetir
4. **Prepara adequadamente para o Curso 3** — ao final, o aluno domina DevOps, CI/CD, testes, observabilidade, squads
5. **Volume mais adequado** — um curso de ~18-20 aulas bem escritas em vez de 30 aulas com repetição

### O que o curso unificado GANHA vs os dois separados:

- O aluno investe tempo em UM projeto que evolui (não dois descartáveis)
- DevOps, CI/CD, Docker entram mais cedo (aula ~5, não aula ~14 contando os dois cursos)
- Squads ganham mais espaço e profundidade
- Sobra tempo para cobrir coisas que NENHUM dos dois cursos cobre: `core-config.yaml`, validação de stories, `aiox-validator.js`, worktrees práticos
- O ADE é praticado de verdade (não apenas mencionado)

### O que MUDA vs os cursos atuais:

| Aspecto | Cursos 1+2 Atuais | Curso Unificado Proposto |
|---------|-------------------|-------------------------|
| Projeto | TaskFlow (descartável) + RockQuiz | RockQuiz desde o início |
| Planning | Repetido 2x (simples + avançado) | 1x com profundidade desde o início |
| Stack | Express/SQLite → Fastify/PostgreSQL | Fastify/PostgreSQL desde o início |
| DevOps | Aparece na aula ~14 (Curso 2) | Aparece na aula ~5-6 |
| ADE | Mencionado no Curso 1, ignorado no 2 | Praticado de verdade (1 módulo dedicado) |
| Squad | 2 agentes raso + 6 agentes desconectado | 1 squad bem feito + conexão com projeto |
| Aulas totais | 30 (10+20) | ~18-20 |
| Horas | ~90h (com repetição) | ~55-65h (sem repetição) |
| Pré-requisito p/ Curso 3 | Só Curso 2 serve | Curso unificado serve integralmente |

---

## 5. Estrutura Proposta do Curso Unificado

**Nome**: AIOX Professional Bootcamp
**Projeto**: RockQuiz (do zero ao deploy)
**Aulas**: 18
**Horas**: ~55-65h
**Pré-requisito para**: Curso 3 (AIOX Mastery)

### Módulo 1 — Setup e Fundamentos (Aulas 1-2)
| Aula | Tema | Novidade vs cursos atuais |
|------|------|--------------------------|
| 01 | Setup AIOX + Primeiro contato com agentes + Sintaxe | Combina C1-Dia01 (condensado) |
| 02 | Estrutura .aiox-core/ + core-config.yaml + Validação | **NOVO** — nunca coberto antes |

### Módulo 2 — Planejamento (Aulas 3-5)
| Aula | Tema | Novidade |
|------|------|---------|
| 03 | Analyst: Pesquisa profunda + Domain Map + Competitive | Combina C1-Dia02 + C2-Aula01 (melhor dos dois) |
| 04 | PM: PRD com Gherkin + Risk Matrix + Write-Spec | Combina C1-Dia03 + C2-Aula02 (sem repetição) |
| 05 | Architect + UX: C4 + Schema + API Contract + UX Spec | Combina C1-Dia04 + C2-Aula03 (sem repetição) |

### Módulo 3 — Infraestrutura (Aulas 6-8)
| Aula | Tema | Novidade |
|------|------|---------|
| 06 | DevOps: DevContainer + Worktrees | Do C2-Aula04, com mais profundidade em worktrees |
| 07 | DevOps: Docker Compose Produção (5 serviços) | Do C2-Aula05, mantido |
| 08 | DevOps: GitHub Actions CI/CD + Branch Protection | Do C2-Aula06, mantido |

### Módulo 4 — Desenvolvimento (Aulas 9-12)
| Aula | Tema | Novidade |
|------|------|---------|
| 09 | SM Stories + Dev: API Core + Banco (Fastify + Prisma) | Combina C2-Aula07 |
| 10 | Dev: Quiz Engine + Scoring + Redis Rankings | Do C2-Aula08 |
| 11 | Dev: Frontend Next.js + Integração API | Combina C2-Aulas10+11 (condensado) |
| 12 | Dev + QA: Testes completos (Unit + Integration + E2E) | Combina C2-Aulas09+11 (melhor dos dois) |

### Módulo 5 — Qualidade e Deploy (Aulas 13-15)
| Aula | Tema | Novidade |
|------|------|---------|
| 13 | QA: Review 10 fases + Security + Performance | Do C2-Aula12, mais profundo |
| 14 | DevOps: Observabilidade (Pino + Prometheus + Grafana) | Do C2-Aula13 |
| 15 | DevOps: Deploy Vercel + Pipeline end-to-end | Combina C2-Aulas14+15 |

### Módulo 6 — ADE e Squads (Aulas 16-18)
| Aula | Tema | Novidade |
|------|------|---------|
| 16 | ADE: Spec Pipeline + Execution Engine (feature via ADE) | **MELHORADO** — pratica os 13 steps de verdade (C1-Dia09 era conceitual) |
| 17 | Squad LinkedIn: Arquitetura + 6 agentes + Pipeline | Condensa C2-Aulas16-19 (sem perder profundidade) |
| 18 | Squad: Workflow completo + Automação + Consolidação | Condensa C2-Aulas19-20 + retrospectiva |

### O que foi cortado e por quê:

| Cortado | Motivo |
|---------|--------|
| C1-Dia01 a Dia05 inteiros | Repetidos no C2 com mais profundidade |
| C1-Dia06 a Dia08 (TaskFlow dev) | Projeto descartável, substituído por RockQuiz |
| C1-Dia10 (Squad doc-ops) | Raso demais, substituído por Squad LinkedIn |
| C2-Aula01 (setup repetido) | Setup acontece 1x na Aula 01 |
| C1-Dia09 (ADE conceitual) | Substituído pela Aula 16 que pratica de verdade |

### O que foi ADICIONADO que não existia:

| Adição | Aula | Justificativa |
|--------|------|---------------|
| Estrutura .aiox-core/ e core-config.yaml | 02 | Base conceitual que faltava — prepara para Curso 3 |
| aiox-validator.js e validate:* commands | 02 | Sistema de validação nunca explorado |
| Story validation (pre-push) | 08 | Quality gate que faltava |
| ADE 13 steps praticados | 16 | Era apenas conceitual, agora é hands-on |

---

## 6. Impacto no Curso 3

Com o curso unificado como pré-requisito, o Curso 3 (Mastery) pode assumir que o aluno:

- ✅ Domina todos os 11 agentes com profundidade
- ✅ Conhece a estrutura `.aiox-core/` e `core-config.yaml`
- ✅ Praticou DevContainer, Docker Compose, CI/CD
- ✅ Fez testes ≥85% (unit + integration + E2E)
- ✅ Implementou observabilidade (logs + métricas + dashboards)
- ✅ Praticou o ADE com os 13 steps (não apenas conceitual)
- ✅ Criou um Squad profissional (6 agentes + workflow)
- ✅ Conhece validation commands básicos

O Curso 3 então vai DIRETAMENTE para: constitution, elicitation, hooks de lifecycle, multi-IDE profundo, brownfield, ADE deep dive nos 7 Epics internos, squad composition, MCP, marketplace. Zero repetição.

---

## 7. Recomendação Final

**Ação**: Criar o curso unificado (18 aulas) como **"AIOX Professional Bootcamp"** para substituir os Cursos 1 e 2.

**Sequência de trabalho**:
1. Aprovar esta estrutura
2. Desenvolver as 18 aulas do Bootcamp (reaproveitando ~60% do conteúdo existente do Curso 2, melhorando e adicionando as lacunas)
3. Desenvolver as 22 aulas do Curso 3 (Mastery) — já planejado no roadmap

**Resultado final**: 2 cursos em vez de 3, cobrindo ~95% do AIOX com zero repetição.

| Curso | Nome | Aulas | Horas | Foco |
|-------|------|:---:|:---:|------|
| **Bootcamp** | AIOX Professional Bootcamp | 18 | ~60h | Setup → Planning → Infra → Dev → QA → Deploy → ADE → Squad |
| **Mastery** | AIOX Mastery | 22 | ~75h | Internals → ADE Deep → Hooks → Multi-IDE → Brownfield → Squads Avançado |
