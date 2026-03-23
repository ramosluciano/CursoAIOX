# Aula 18 — Automação, Brownfield e Consolidação do Bootcamp

<!-- metadata
module: 4
lesson: 18
title: "Automação, Brownfield e Consolidação do Bootcamp"
duration: 4-5 horas
agents: "@architect, @dev, @devops, @qa"
project: Squad LinkedIn Monitoragindo
phase: Entrega + Consolidação
prerequisites: Aula 17 concluída (analytics + feedback loop)
-->

---

> **Módulo 4** · Squad LinkedIn Monitoragindo
> **Duração**: 4-5 horas
> **Agentes praticados**: `@architect`, `@dev`, `@devops`, `@qa`
> **Projeto**: Squad LinkedIn Monitoragindo

---

## 🏆 Vitória desta aula

Sistema LinkedIn completamente automatizado (scheduling semanal), protótipo do Google AI Studio migrado via brownfield, e retrospectiva completa do Bootcamp com os 3 projetos entregues.

**Critério binário**: Scheduling funcional (pesquisa → geração → revisão → publicação) + brownfield migrado + retrospectiva documentada.

---

## Conceito

### Brownfield real: migrar o que existe

O AuctionHunter foi um "recomeço" — o projeto anterior falhou e começamos do zero com metodologia. Aqui o brownfield é diferente: existe um **protótipo semi-funcional** no Google AI Studio que gera conteúdo para o LinkedIn. Funciona, parcialmente. Tem prompts calibrados, fluxos definidos, output aceitável.

O desafio não é jogar fora e recomeçar. É **extrair o que funciona** do protótipo (prompts, lógica de geração, padrões de voz capturados) e integrar na arquitetura independente que construímos. Brownfield real é isso: respeitar o trabalho anterior enquanto eleva a arquitetura.

O AIOX tem comandos específicos para brownfield:

| Comando | O que faz |
|---------|-----------|
| `*map-codebase` | Analisa codebase existente e mapeia estrutura |
| `*extract-patterns` | Identifica padrões e decisões que funcionam |

### Automação end-to-end: o squad que roda sozinho

O último passo de qualquer squad é automação: ele deve gerar conteúdo periodicamente sem intervenção manual. O ciclo semanal completo:

```
Segunda: Trend Scout pesquisa tendências da semana
Terça:   Quiz Crafter gera quiz + Content Writer gera artigo
Quarta:  Content Writer gera IA na Sexta + Mentalidade
Quinta:  Editor revisa tudo + Humano aprova
Sexta:   Publisher publica os posts aprovados
D+1/3/7: Coleta de métricas automática
```

O scheduling não é "cron que roda um script". É **orquestração de múltiplos agentes em sequência**, com checkpoint humano no meio (aprovação antes de publicar).

### O princípio aplicado

Você vai descrever a necessidade de automação e migração brownfield. **Não vai ditar** a configuração do scheduler, quais arquivos do protótipo migrar ou como orquestrar. Os agentes propõem, você avalia.

---

## Contexto

Esta é a **última aula do Bootcamp**. O sistema LinkedIn está quase completo: squad arquitetado (14), conteúdo gerado com voz autêntica (15), backend com persistência e publicação (16), analytics com feedback loop (17). Falta: automação para rodar sozinho, migração do protótipo existente, e a retrospectiva dos 3 projetos.

---

## Prática

### Passo 1 — Brownfield: mapear o protótipo do Google AI Studio

```bash
cd ~/aiox-bootcamp/linkedin-squad

# Preparar: exportar/copiar o protótipo do Google AI Studio
# para um diretório local
mkdir -p legacy/google-ai-studio
# Copie os prompts, configurações e outputs do protótipo

claude
```

```
@architect

Aria, preciso migrar um protótipo existente do Google AI 
Studio para a arquitetura que construímos.

O protótipo está em legacy/google-ai-studio/. Ele faz 
geração de conteúdo LinkedIn com prompts calibrados.

*map-codebase legacy/google-ai-studio/

Analise o protótipo e me diga:
1. O que existe e funciona? (prompts, fluxos, padrões)
2. O que pode ser aproveitado na nova arquitetura?
3. O que deve ser descartado? (hacks, workarounds, 
   limitações da plataforma)
4. Qual o plano de migração? (ordem, prioridades, riscos)
```

**O que esperar**: O Architect deve produzir um mapeamento do protótipo que identifica ativos reutilizáveis (prompts calibrados, regras de formatação, exemplos de output) vs artefatos descartáveis (configurações específicas do Google AI Studio, workarounds de limitação da plataforma).

```
@architect

*extract-patterns legacy/google-ai-studio/

Agora extraia os padrões que funcionam:
- Prompts que geraram bom conteúdo (lógica, não plataforma)
- Regras de formatação que foram calibradas
- Padrões de voz capturados (se houver)
- Qualquer lógica de decisão (quando gerar quiz vs artigo)

Esses padrões devem ser integrados ao squad como 
knowledge base adicional.
```

**Como avaliar**:

> **Checklist de avaliação do mapeamento brownfield**
> - <input type="checkbox" class="checkbox-input" /> O protótipo foi mapeado (não ignorado)?
> - <input type="checkbox" class="checkbox-input" /> Há separação clara entre "aproveitar" e "descartar"?
> - <input type="checkbox" class="checkbox-input" /> Prompts reutilizáveis foram identificados?
> - <input type="checkbox" class="checkbox-input" /> Limitações da plataforma anterior foram documentadas?
> - <input type="checkbox" class="checkbox-input" /> O plano de migração tem ordem e prioridade?

Se o Architect quiser descartar tudo:

```
Aria, descartar o protótipo inteiro desperdiça meses de 
calibração de prompts. Mesmo que a plataforma mude, a 
LÓGICA dos prompts (como descrever tom, como estruturar 
quiz, como formatar post) pode ser migrada para os 
templates do squad. Extraia essa lógica.
```

> **🏆 Checkpoint 1**: Mapeamento brownfield com ativos reutilizáveis identificados.

---

### Passo 2 — Migrar ativos para o squad

```
*exit

@dev

Dex, a Aria mapeou o protótipo do Google AI Studio. 
Leia o relatório de mapeamento.

Migre os ativos reutilizáveis para o squad:
1. Prompts calibrados → templates do squad 
   (integre com os templates da Aula 14)
2. Regras de formatação → knowledge base do Editor
3. Padrões de voz capturados → merge com Voice Profile 
   (docs/voice-profile.md)
4. Lógica de decisão → enriquecer workflows do config.yaml

Atenção: não é copy-paste. Os prompts do Google AI Studio 
são específicos daquela plataforma. A lógica precisa ser 
ADAPTADA para o formato de squad AIOX (templates em 
markdown, instruções no config.yaml, knowledge base nos 
agentes).

Após migração, rode o squad com os templates enriquecidos 
e compare o output com o da Aula 15. Deve ser igual ou 
melhor — não pior.
```

**Como verificar**: Gere conteúdo com os templates migrados e compare com as peças da Aula 15:

> **Checklist de verificação da migração**
> - <input type="checkbox" class="checkbox-input" /> Templates foram enriquecidos (não substituídos)?
> - <input type="checkbox" class="checkbox-input" /> Voice Profile foi atualizado com insights do protótipo?
> - <input type="checkbox" class="checkbox-input" /> Conteúdo gerado com templates migrados mantém qualidade da Aula 15?
> - <input type="checkbox" class="checkbox-input" /> Nenhum artefato específico do Google AI Studio ficou no código?

> **🏆 Checkpoint 2**: Ativos do protótipo migrados e integrados ao squad.

---

### Passo 3 — Automação end-to-end

```
*exit

@devops

Dex-Ops, preciso automatizar o ciclo semanal completo 
do squad LinkedIn.

O fluxo:
1. Trend Scout pesquisa tendências (automatizado)
2. Quiz Crafter gera quiz da semana (automatizado)
3. Content Writer gera artigo + IA na Sexta (automatizado)
4. Editor revisa (automatizado)
5. ⏸️ PAUSA: posts ficam como "draft" aguardando 
   aprovação humana
6. Após aprovação manual → Publisher publica (automatizado)
7. D+1, D+3, D+7: coleta de métricas (automatizado)
8. Semanal: analytics atualiza padrões e feedback loop

Configure:
- Scheduling: steps 1-4 toda segunda às 7h
- Step 5: notificação (email ou webhook) pedindo aprovação
- Step 6: trigger manual ou aprovação via API
- Steps 7-8: cron jobs nos intervalos corretos

Integre com n8n para orquestração (webhook triggers) 
conforme o Architecture Doc.

O checkpoint humano (step 5) é OBRIGATÓRIO — conteúdo 
gerado por IA não deve ser publicado automaticamente 
sem revisão.
```

**Como verificar** (trigger manual para teste):

```bash
# Trigger manual do ciclo completo
curl -X POST http://localhost:3000/api/automation/run-weekly | jq

# Verificar que conteúdo foi gerado e está como draft
curl "http://localhost:3000/api/posts?status=draft" | jq

# Aprovar um post
curl -X PATCH http://localhost:3000/api/posts/1 \
  -d '{"status":"approved"}' | jq

# Publicar aprovados
curl -X POST http://localhost:3000/api/automation/publish-approved | jq

# Verificar status
curl http://localhost:3000/api/automation/status | jq
```

> **Checklist de avaliação da automação**
> - <input type="checkbox" class="checkbox-input" /> Ciclo completo roda com trigger manual?
> - <input type="checkbox" class="checkbox-input" /> Conteúdo gerado automaticamente chega como draft?
> - <input type="checkbox" class="checkbox-input" /> Notificação de aprovação funciona?
> - <input type="checkbox" class="checkbox-input" /> Publicação só acontece após aprovação explícita?
> - <input type="checkbox" class="checkbox-input" /> Coleta de métricas está agendada?
> - <input type="checkbox" class="checkbox-input" /> Analytics atualiza feedback loop automaticamente?

Se a publicação for totalmente automática:

```
Dex-Ops, a automação publica sem aprovação humana. Isso 
é arriscado — conteúdo gerado por IA pode ter imprecisões 
ou tom inadequado. O checkpoint humano é obrigatório: 
conteúdo é gerado automaticamente, mas publicação depende 
de aprovação explícita. Adicione essa barreira.
```

> **🏆 Checkpoint 3**: Automação end-to-end com checkpoint humano.

---

### Passo 4 — Deploy e observabilidade

```
Dex-Ops, containerize e prepare o sistema LinkedIn 
completo para deploy:

1. Docker Compose atualizado com todos os serviços
2. Observabilidade: métricas de automação (execuções, 
   posts gerados, posts publicados, falhas)
3. Health check do sistema completo
4. Variáveis de ambiente para LinkedIn API 
   (simulated → real quando pronto)
```

```
*exit

@qa

Quinn, valide o sistema LinkedIn completo:
1. Automação roda e gera conteúdo?
2. Checkpoint humano funciona?
3. Métricas são coletadas?
4. Analytics funciona com dados reais?
5. Feedback loop está ativo?
6. Docker Compose sobe tudo?
```

> **🏆 Checkpoint 4**: Sistema deployado e validado.

---

### Passo 5 — Retrospectiva do Bootcamp

Este é o momento de olhar para trás e reconhecer o que 18 aulas produziram:

```bash
*exit

# Criar documento de retrospectiva
```

Crie manualmente (não com agente — esta reflexão é sua):

```markdown
# Retrospectiva — AIOX Professional Bootcamp

## Projetos entregues

### RockQuiz (Módulo 2, Aulas 03-08)
- Quiz interativo de rock com 5 serviços Docker
- Pipeline AIOX completo exercitado pela primeira vez
- 9/11 agentes core usados
- CI/CD + Grafana + deploy público

### AuctionHunter (Módulo 3, Aulas 09-13)
- Pipeline de scraping multi-layer com Recovery System
- Projeto que falhou antes — recomeço estruturado com AIOX
- Memory Layer acumulando insights entre layers
- Scheduling automático + observabilidade de pipeline

### Squad LinkedIn Monitoragindo (Módulo 4, Aulas 14-18)
- Squad de 6 agentes com Voice Profile personalizado
- 4 vertentes editoriais com tom diferenciado
- Backend com persistência, publicação e métricas
- Analytics com feedback loop data-driven
- Brownfield: migração do protótipo Google AI Studio
- Automação end-to-end com checkpoint humano

## Recursos AIOX exercitados
- Pipeline de planejamento completo (Analyst → PM → Architect → SM)
- 9/11 agentes core + 6 agentes de squad = 15 agentes
- ADE Execution Engine 13 steps (AuctionHunter)
- ADE Recovery System (scraping)
- ADE Memory Layer (insights entre layers)
- Brownfield workflow (AuctionHunter + LinkedIn)
- Spec Pipeline com iteração QA (AuctionHunter)
- Squad com múltiplos workflows (LinkedIn)

## O que aprendi sobre trabalhar com agentes
[Preencha pessoalmente]

## O que faria diferente
[Preencha pessoalmente]
```

Salve em `docs/retrospectiva-bootcamp.md`.

> **🏆 Checkpoint 5 — VITÓRIA DA AULA E DO BOOTCAMP**: Retrospectiva documentada.

---

### Passo 6 — Commit final

```bash
git add .
git commit -m "feat: automation, brownfield migration, and bootcamp retrospective

- Brownfield: Google AI Studio prototype mapped and migrated
- Weekly automation: generation → approval → publish → metrics
- Human checkpoint enforced before publication
- n8n integration for orchestration
- Deploy with full observability
- Bootcamp retrospective documenting 3 projects delivered"
```

---

## Reflexão

### O Bootcamp em números

```
18 aulas · 3 projetos · 4 módulos
15 agentes exercitados (9 core + 6 squad)
~70% dos recursos AIOX cobertos

Módulo 1: Fundamentos (2 aulas)
Módulo 2: RockQuiz — aprendeu o pipeline (6 aulas)
Módulo 3: AuctionHunter — aplicou em domínio hostil (5 aulas)
Módulo 4: Squad LinkedIn — construiu sistema de conteúdo (5 aulas)
```

Cada módulo adicionou complexidade de forma progressiva:

| Módulo | O que era novo |
|--------|---------------|
| 2 (RockQuiz) | Pipeline AIOX inteiro, do zero ao deploy |
| 3 (AuctionHunter) | Recovery System, Memory Layer, brownfield, domínio hostil |
| 4 (Squad LinkedIn) | Squads, voice profiling, knowledge base, feedback loop, automação |

### O que o Bootcamp não cobriu (e o Mastery cobre)

O Bootcamp ensinou a **usar** o AIOX. O Mastery vai ensinar a **dominar**:

| Bootcamp | Mastery |
|----------|---------|
| Pipeline como usuário | AIOX Internals (17 diretórios, constitution, schemas) |
| ADE básico (13 steps, recovery) | ADE Deep Dive (spec pipeline com 3 iterações, memory layer avançada) |
| Brownfield simples | Brownfield completo com document sharding |
| 1 squad | Squads avançados (@squad-creator, composition, MCP, testing) |
| 1 IDE (Claude Code) | Multi-IDE (Claude Code + Gemini CLI + Codex CLI) |
| Hooks implícitos | Hooks de lifecycle customizados |
| Projeto médio | SaaS completo (Plataforma Zabbix, 10+ containers) |

### O conceito-chave

> **O Bootcamp provou que o pipeline AIOX funciona — em 3 projetos reais, com complexidade crescente, cada um entregando valor concreto. O RockQuiz mostrou o fluxo. O AuctionHunter mostrou a resiliência. O Squad LinkedIn mostrou a inteligência. Agora você sabe usar. O Mastery vai ensinar a construir.**

---

> **Anterior**: Aula 17 — Analytics de Engajamento e Padrões
> **Próxima**: Mastery — Aula 01: Por Dentro do .aiox-core/ *(Novo curso)*
