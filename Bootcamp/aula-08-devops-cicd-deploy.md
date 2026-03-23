# Aula 08 — DevOps: CI/CD, Observabilidade e Deploy

<!-- metadata
module: 2
lesson: 8
title: "DevOps: CI/CD, Observabilidade e Deploy"
duration: 3-4 horas
agents: "@devops, @qa"
project: RockQuiz
phase: Entrega
prerequisites: Aula 07 concluída (código + testes + QA aprovado)
-->

---

> **Módulo 2** · RockQuiz: Pipeline Completo
> **Duração**: 3-4 horas
> **Agentes praticados**: `@devops`, `@qa`
> **Projeto**: RockQuiz

---

## 🏆 Vitória desta aula

Pipeline CI/CD funcional + observabilidade com métricas e dashboards reais + app deployada e acessível publicamente. O RockQuiz vai do seu computador para o mundo.

**Critério binário**: Push → CI roda e passa → merge → deploy automático → app acessível via URL pública.

---

## Conceito

### CI/CD: a barreira automática contra código quebrado

CI (Continuous Integration) e CD (Continuous Deployment) formam um **pipeline automático** que garante que nenhum código quebrado chega à produção. A cada push, o pipeline roda lint, testes, build e security checks. Se qualquer etapa falha, o merge é bloqueado. Sem CI/CD, a qualidade depende da disciplina individual. Com CI/CD, a qualidade é **estrutural** — impossível de contornar.

### Observabilidade: ver o que acontece em produção

Uma aplicação deployada sem observabilidade é como dirigir de olhos fechados. Você precisa saber: está funcionando? Onde está lento? Quando algo quebra? Os 3 pilares:

| Pilar | Pergunta que responde | O que coleta |
|-------|----------------------|-------------|
| **Logs** | O QUE aconteceu? | Eventos textuais estruturados |
| **Métricas** | QUANTO aconteceu? | Números ao longo do tempo |
| **Dashboards** | COMO visualizar? | Gráficos e alertas |

### O princípio aplicado: necessidade → agente → avaliação

Você vai dizer ao DevOps "preciso proteger o main contra código quebrado" — não vai ditar os jobs do GitHub Actions. Vai dizer "preciso saber quando algo está errado em produção" — não vai escrever queries do Prometheus. O agente propõe, você avalia.

---

## Contexto

Esta é a **última aula do RockQuiz**. Depois dela, o projeto estará planejado, implementado, testado, protegido, observável e deployado. Nas 6 aulas anteriores (03-07), 9 agentes produziram docs, código, testes e review. Esta aula fecha o ciclo com infraestrutura de entrega e monitoramento.

---

## Prática

### Passo 1 — Observabilidade: métricas na API

```bash
cd ~/aiox-bootcamp/rockquiz
claude
```

```
@devops

Dex-Ops, preciso de observabilidade para o RockQuiz em produção. 
Quero saber em tempo real:

- Quantos jogos estão sendo jogados por hora
- Qual a latência da API (P50, P95, P99)
- Quantas perguntas estão sendo respondidas (certas vs erradas)
- Se algum serviço está com problema

A Aria (Architect) definiu a estratégia de observabilidade no 
Architecture Doc (docs/architecture.md). Use as decisões dela 
como base.

Implemente: métricas na API expostas em formato Prometheus, 
e configure o Prometheus para coletá-las. Atualize o Docker 
Compose para incluir o serviço de coleta de métricas.
```

**Como avaliar**:

```bash
# Reiniciar a API
cd packages/api && npm run dev

# Verificar endpoint de métricas
curl http://localhost:3001/metrics
```

> **Checklist de avaliação**
> - <input type="checkbox" class="checkbox-input" /> O endpoint /metrics retorna dados no formato Prometheus?
> - <input type="checkbox" class="checkbox-input" /> Há métricas de negócio (jogos, perguntas, scores) — não apenas métricas técnicas?
> - <input type="checkbox" class="checkbox-input" /> Há métricas de latência da API (histogram com percentis)?
> - <input type="checkbox" class="checkbox-input" /> As métricas têm labels úteis (modo de jogo, dificuldade, status)?

Se faltar métricas de negócio:

```
Dex-Ops, as métricas são só técnicas (CPU, memória). Preciso 
de métricas de NEGÓCIO: jogos iniciados/finalizados por modo, 
perguntas respondidas certas/erradas por dificuldade, duração 
dos jogos. Essas métricas vão alimentar os dashboards que me 
dizem se o produto está saudável.
```

> **🏆 Checkpoint 1**: Métricas expostas e coletadas.

---

### Passo 2 — Dashboards

```
Dex-Ops, agora preciso visualizar essas métricas. Configure 
o Grafana com dashboards pré-provisionados que mostrem:

1. Saúde da API: latência, throughput, taxa de erro
2. Métricas de negócio: jogos por hora, taxa de acerto, 
   categorias populares, duração média dos jogos
3. Infraestrutura: uso de recursos dos containers

Quero que os dashboards sejam provisionados automaticamente — 
quando subir o Docker Compose, o Grafana já deve ter os 
dashboards configurados sem setup manual.
```

**Como verificar**:

```bash
# Subir stack completa
docker compose up -d

# Abrir Grafana (porta que o DevOps configurou)
# Verificar que dashboards existem sem configuração manual

# Gerar tráfego (jogar alguns quizzes no browser)
# Voltar ao Grafana e verificar gráficos com dados reais
```

> **Checklist de avaliação**
> - <input type="checkbox" class="checkbox-input" /> Grafana abre sem erro de configuração?
> - <input type="checkbox" class="checkbox-input" /> Dashboards estão pré-provisionados (não precisa criar manualmente)?
> - <input type="checkbox" class="checkbox-input" /> Datasource do Prometheus está configurado automaticamente?
> - <input type="checkbox" class="checkbox-input" /> Após jogar alguns quizzes, os gráficos mostram dados?

Se os dashboards estiverem vazios após gerar tráfego:

```
Dex-Ops, joguei 3 partidas mas os dashboards não mostram 
dados. Verifique: o Prometheus está scraping a API? As 
queries do Grafana estão apontando para as métricas corretas?
```

> **🏆 Checkpoint 2**: Grafana mostrando métricas reais.

---

### Passo 3 — CI/CD Pipeline

Agora a proteção automática do main:

```
Dex-Ops, preciso proteger a branch main do RockQuiz. 
Os requisitos:

1. A cada push ou PR, o código deve ser verificado automaticamente:
   - Erros de sintaxe e tipos
   - Todos os testes (com banco e cache reais, não mocks)
   - Build das imagens Docker
   - O coverage deve atender o threshold que a Aria definiu
2. Se QUALQUER verificação falhar, o merge deve ser bloqueado
3. A cada merge na main, o frontend deve deployar automaticamente
4. A cada PR, quero um preview para testar antes de mergear

Use GitHub Actions. Consulte o Architecture Doc para decisões 
técnicas que a Aria tomou sobre o pipeline.
```

**Como avaliar**: O DevOps vai gerar os workflow files. Leia-os e verifique:

> **Checklist de avaliação do CI/CD**
> - <input type="checkbox" class="checkbox-input" /> O CI roda testes com banco real (não apenas mocks)?
> - <input type="checkbox" class="checkbox-input" /> O coverage threshold está definido no pipeline?
> - <input type="checkbox" class="checkbox-input" /> Há step de build das imagens Docker (garante que Dockerfiles funcionam)?
> - <input type="checkbox" class="checkbox-input" /> O deploy é separado do CI (não deploya se testes falharem)?
> - <input type="checkbox" class="checkbox-input" /> Há workflow de preview para PRs?

Se algo estiver faltando:

```
Dex-Ops, o pipeline não verifica se as imagens Docker 
buildaram com sucesso. Se o Dockerfile estiver quebrado, 
o CI passa mas o deploy falha. Adicione verificação de 
build no CI.
```

---

### Passo 4 — Branch Protection

```
Dex-Ops, configure branch protection para a main:
- Merge só via Pull Request
- CI deve passar antes de permitir merge
- Branch deve estar atualizada com main

Me explique como configurar isso no GitHub (pode ser via 
CLI ou instruções para a UI).
```

---

### Passo 5 — Deploy

```
Dex-Ops, configure o deploy do frontend. Quero que ao 
mergear na main, o frontend seja deployado automaticamente 
e fique acessível via URL pública.

A Aria definiu a plataforma de deploy no Architecture Doc. 
Configure a integração.
```

**Como verificar**:

```bash
# Fazer uma mudança pequena
git checkout -b test/deploy-pipeline

# Alterar algo visível (ex: texto na landing)
# Commit e push
git add . && git commit -m "test: verify deploy pipeline"
git push -u origin test/deploy-pipeline

# Abrir PR
gh pr create --title "test: deploy pipeline" --body "Testing CI/CD"

# OBSERVAR:
# 1. CI inicia automaticamente
# 2. Status checks aparecem na PR
# 3. Preview URL é gerada (se configurado)
```

Se tudo funcionar, merge e verifique o deploy de produção.

> **🏆 Checkpoint 3**: Pipeline CI/CD end-to-end funcionando.

---

### Passo 6 — QA valida o pipeline completo

```
*exit

@qa

Quinn, valide o pipeline end-to-end do RockQuiz:

1. Se eu pushar código com teste quebrado, o merge é bloqueado?
2. Se todos os checks passam, o deploy acontece automaticamente?
3. O Grafana mostra métricas reais de jogos?
4. O health check confirma API saudável?
5. O pipeline completo executa em tempo razoável?
```

> **🏆 Checkpoint 4 — VITÓRIA DA AULA E DO MÓDULO**: RockQuiz completo e deployado.

---

### Passo 7 — Commit e retrospectiva

```bash
*exit

git add .
git commit -m "infra: CI/CD pipeline + observability + deploy"
```

---

## Reflexão

### O que o RockQuiz é agora (retrospectiva do Módulo 2)

Olhe para trás e veja o que 6 aulas produziram:

```
Aula 03: @analyst + @pm       → Brief + Domain Map + PRD
Aula 04: @architect + @sm     → Arch Doc + UX Spec + Stories
Aula 05: @devops              → DevContainer + Docker Compose
Aula 06: @dev                 → Backend completo (API + quiz + scoring + ranking)
Aula 07: @dev + @qa           → Frontend + testes + QA review aprovado
Aula 08: @devops + @qa        → CI/CD + Observabilidade + Deploy
```

**9 de 11 agentes** usados. De uma ideia a uma aplicação deployada com pipeline de proteção, testes, observabilidade e documentação completa.

Em **nenhum momento** você precisou ditar configurações técnicas. Você descreveu necessidades, avaliou resultados e pediu refinamentos. Os agentes fizeram o trabalho técnico. E isso é exatamente como vai funcionar nos projetos reais: AuctionHunter, LinkedIn Automation e Plataforma Zabbix.

### O conceito-chave

> **CI/CD e observabilidade protegem o trabalho de todos os agentes. Sem eles, um deploy quebrado ou um bug invisível em produção desperdiça o esforço de planejamento, implementação e review.**

### Conexão com o Módulo 3

O RockQuiz está completo. No Módulo 3 (Aulas 09-13), vamos atacar o **AuctionHunter** — um projeto que você já tentou antes e não conseguiu levar adiante. Desta vez, com o pipeline AIOX, a abordagem será estruturada. E a complexidade técnica (scraping multi-layer, PDF parsing, captcha, fallback) vai exercitar recursos do AIOX que o RockQuiz não precisou: Recovery System (scrapers falham naturalmente) e Memory Layer (insights entre layers de scraping).

---

## Exercício extra (opcional)

1. Quebre propositalmente um teste e abra uma PR. Observe o CI bloquear o merge. Corrija e observe o CI passar. Essa é a proteção em ação.

2. Jogue 10 partidas e depois analise os dashboards do Grafana — quais categorias são mais populares? Qual modo tem jogos mais longos?

3. Peça ao DevOps para documentar um plano de alertas:

```
@devops
Dex-Ops, se o RockQuiz estivesse em produção com usuários 
reais, quais alertas você configuraria? Que métricas devem 
acionar notificação, e quais thresholds? Documente em 
docs/devops/alerting-plan.md
```

---

> **Anterior**: Aula 07 — Dev + QA: Frontend e Testes
> **Próxima**: Aula 09 — AuctionHunter: Entendendo o Domínio *(Módulo 3)*
