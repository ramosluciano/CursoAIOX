# Aula 06 — Epic 4: Execution Engine 13 Steps

<!-- metadata
course: Mastery
module: 2
lesson: 6
title: "Epic 4: Execution Engine 13 Steps"
duration: 5-6 horas
agents: "@dev, @zabbix-expert"
project: Plataforma Zabbix Learning (Quiz Engine)
phase: ADE Deep Dive
prerequisites: Aula 05 concluída (Spec Pipeline com 3 iterações)
-->

---

> **Módulo 2** · ADE Deep Dive
> **Duração**: 5-6 horas
> **Agentes praticados**: `@dev`, `@zabbix-expert`
> **Projeto**: Plataforma Zabbix Learning (Quiz Engine)

---

## 🏆 Vitória desta aula

Quiz Engine implementado via os 13 steps do ADE Execution Engine, com cada step documentado: o que fez, quanto tempo levou, decisões tomadas, e o que aprendeu.

**Critério binário**: Quiz Engine funcional (múltiplos tipos de pergunta + dificuldade adaptativa + gamificação básica) + `docs/execution-log.md` documentando os 13 steps.

---

## Conceito

### Execution Engine: 13 steps com propósito

No Bootcamp (Aula 11, AuctionHunter), os 13 steps foram exercitados implicitamente — o Dev seguia a sequência sem documentar cada step. Aqui, cada step é **explícito e documentado**. O objetivo não é apenas implementar o Quiz Engine — é entender e registrar o processo.

Os 13 steps não são arbitrários. Cada grupo resolve um problema específico:

| Steps | Grupo | Problema que resolve |
|-------|-------|---------------------|
| 1-3 | **Análise** | "Entendo a spec e sei decompoê-la?" |
| 4-6 | **Implementação** | "Consigo codificar cada subtask?" |
| 7-8 | **Integração** | "As partes funcionam juntas?" |
| 9 | **Edge cases** | "O que quebra com input inesperado?" |
| 10 | **Self-critique** | "Onde meu código é frágil?" |
| 11-12 | **Refinamento** | "Como melhorar baseado na self-critique?" |
| 13 | **Insights** | "O que aprendi para o próximo componente?" |

O step 10 (self-critique) é o mais importante do deep dive. No Bootcamp era um parágrafo. Aqui, o Dev deve produzir uma análise honesta com pelo menos 5 pontos de fragilidade — e os steps 11-12 devem endereçar pelo menos os mais críticos.

### Internals do Execution Engine

Explore os mecanismos internos:
- `subtask-verifier.js`: Verifica se subtasks foram completadas
- `plan-tracker.js`: Rastreia progresso nos 13 steps

Esses scripts existem para automatizar o tracking — em vez de confiar na memória do Dev, o sistema verifica.

---

## Prática

### Passo 1 — Explorar internals e preparar spec

```bash
cd ~/aiox-mastery/zabbix-platform
cd feature/quiz-engine  # worktree da Aula 04
claude
```

```
Antes de implementar, preciso entender o Execution 
Engine por dentro. Mostre-me:

1. subtask-verifier.js — como verifica subtasks
2. plan-tracker.js — como rastreia progresso
3. O formato do plano de execução

E prepare a spec do Quiz Engine. Se não tiver uma spec 
formal, use estes requisitos:

O Quiz Engine da Plataforma Zabbix precisa de:
- Múltiplos tipos de pergunta: múltipla escolha, 
  verdadeiro/falso, ordenação, completar frase
- Dificuldade adaptativa: se acertou 3 fáceis seguidas, 
  sobe para médio; se errou 2 médias, volta para fácil
- Gamificação: XP por acerto (mais para perguntas difíceis), 
  streaks, badges, ranking
- Integração com @zabbix-expert para gerar perguntas
- Feedback educativo: explicação detalhada + link para 
  documentação

Gere a spec se necessário, ou referencie a existente.
```

---

### Passo 2 — Steps 1-3: Análise e planejamento

```
@dev

Dex, leia a spec do Quiz Engine e execute os steps 1-3 
do Execution Engine.

Step 1 — Análise da spec:
- Identifique todas as funcionalidades requeridas
- Liste dependências (banco, @zabbix-expert, frontend)
- Marque ambiguidades ou decisões pendentes

Step 2 — Decomposição em subtasks:
- Cada subtask deve ser implementável isoladamente
- Cada subtask deve ter critério de "feito" claro
- Estimativa de esforço por subtask

Step 3 — Plano de execução:
- Ordem das subtasks (dependências respeitadas)
- Quais podem ser paralelizadas
- Quais são bloqueantes

Documente TUDO em docs/execution-log.md. Cada step 
deve ter: o que fez, decisões tomadas, tempo estimado.
```

**O que esperar no plano**: Decomposição em algo como:

- Subtask 1: Schema do banco (questions, answers, game_sessions, scores)
- Subtask 2: Engine de perguntas (seleção, randomização, tipos)
- Subtask 3: Lógica de dificuldade adaptativa
- Subtask 4: Sistema de scoring (XP, multiplicadores)
- Subtask 5: Gamificação (streaks, badges, ranking)
- Subtask 6: Integração @zabbix-expert para geração de perguntas
- Subtask 7: API endpoints
- Subtask 8: Feedback educativo (explicação + referência)

> **Checklist de avaliação dos Steps 1-3**
> - <input type="checkbox" class="checkbox-input" /> Todas as funcionalidades da spec foram listadas (Step 1)?
> - <input type="checkbox" class="checkbox-input" /> Subtasks são granulares e independentes (Step 2)?
> - <input type="checkbox" class="checkbox-input" /> Cada subtask tem critério de "feito"?
> - <input type="checkbox" class="checkbox-input" /> Plano de execução respeita dependências (Step 3)?
> - <input type="checkbox" class="checkbox-input" /> Tudo está documentado no execution-log.md?

> **🏆 Checkpoint 1**: Steps 1-3 documentados com plano de execução.

---

### Passo 3 — Steps 4-8: Implementação e integração

Execute os steps na sequência, documentando cada um:

```
Dex, execute os steps 4-6 (implementação das subtasks).

Para CADA subtask:
1. Implemente
2. Teste isoladamente
3. Documente no execution-log.md:
   - Qual subtask
   - Tempo que levou (real, não estimado)
   - Decisões que tomou que NÃO estavam na spec
   - Dificuldades encontradas

Comece pela subtask 1 (schema) e avance na ordem 
do plano.
```

**Acompanhe o progresso** — confira o execution-log após cada subtask:

```
Dex, status: quantas subtasks de quantas estão completas? 
O tempo real está próximo da estimativa? Alguma subtask 
foi mais complexa que o esperado?
```

```
Dex, agora steps 7-8: integre as subtasks e teste o 
sistema integrado.

Step 7 — Integração:
- As subtasks funcionam juntas?
- O fluxo completo funciona? (pergunta → resposta → 
  scoring → dificuldade adaptativa → gamificação)

Step 8 — Teste integrado:
- Jogue uma sessão completa de quiz
- Verifique que dificuldade adapta
- Verifique que XP e streaks calculam correto
- Verifique que ranking atualiza

Documente resultados no execution-log.md.
```

**Como verificar**:

```bash
# Testar fluxo completo via API
# Criar sessão de quiz
curl -X POST http://localhost:3000/api/quiz/start \
  -H "Content-Type: application/json" \
  -d '{"userId":1,"topic":"triggers","difficulty":"medium"}' | jq

# Responder perguntas (repetir com IDs reais)
curl -X POST http://localhost:3000/api/quiz/answer \
  -H "Content-Type: application/json" \
  -d '{"sessionId":1,"questionId":1,"answer":"B","timeMs":4500}' | jq

# Verificar que dificuldade adapta
# Verificar scores e streaks
# Verificar ranking
curl http://localhost:3000/api/quiz/ranking | jq
```

> **🏆 Checkpoint 2**: Steps 4-8 documentados, Quiz Engine integrado e funcional.

---

### Passo 4 — Step 9: Edge cases

```
Dex, step 9: edge cases.

Teste e trate:
1. Usuário responde a mesma pergunta duas vezes
2. Sessão expira no meio do quiz
3. Pergunta sem alternativas válidas (bug de dados)
4. XP overflow (jogador com milhões de pontos)
5. Duas sessões simultâneas para o mesmo usuário
6. Quiz com zero perguntas disponíveis para o nível
7. Dificuldade adaptativa em loop (sobe → erra → desce → acerta → sobe...)

Para cada edge case: como o sistema se comporta hoje? 
Como DEVERIA se comportar? Implemente a correção e 
documente no execution-log.md.
```

> **🏆 Checkpoint 3**: Edge cases tratados e documentados.

---

### Passo 5 — Step 10: Self-critique obrigatória

Este é o step mais importante da aula:

```
Dex, step 10: self-critique OBRIGATÓRIA.

Olhe para todo o código do Quiz Engine e responda 
HONESTAMENTE — não otimistamente:

1. Quais partes do código vão quebrar primeiro em 
   produção? (com 1000 alunos simultâneos)
2. Onde há acoplamento que dificulta mudanças futuras?
3. Quais decisões você tomou por conveniência que 
   deveria ter tomado por design?
4. A dificuldade adaptativa é realmente adaptativa 
   ou é apenas uma escada fixa?
5. O sistema de gamificação é extensível? (adicionar 
   novo tipo de badge sem refatorar tudo?)
6. Quais queries vão ficar lentas com 100k registros?
7. Onde há magic numbers que deveriam ser configuráveis?

Quero pelo menos 5 pontos de fragilidade reais. 
"O código está bom" NÃO é self-critique.

Documente cada ponto no execution-log.md com:
- O que é frágil
- Por que é frágil
- O que seria necessário para corrigir
- Prioridade (corrigir agora ou dívida técnica aceitável?)
```

**Como avaliar a self-critique**:

> **Checklist de qualidade da self-critique**
> - <input type="checkbox" class="checkbox-input" /> Pelo menos 5 pontos de fragilidade?
> - <input type="checkbox" class="checkbox-input" /> São problemas REAIS (não hipotéticos)?
> - <input type="checkbox" class="checkbox-input" /> Cada ponto tem justificativa?
> - <input type="checkbox" class="checkbox-input" /> Há distinção entre "corrigir agora" e "dívida aceitável"?
> - <input type="checkbox" class="checkbox-input" /> A self-critique é honesta (não defensiva)?

Se a self-critique for superficial:

```
Dex, a self-critique lista "poderia ter mais testes" 
e "nomes poderiam ser melhores". Isso é genérico. 
Quero saber: a query de ranking faz full table scan? 
A lógica adaptativa tem estado persistido ou recomeça 
a cada sessão? O sistema de badges é uma cadeia de 
if/else ou é extensível? Seja específico sobre o 
CÓDIGO, não sobre boas práticas genéricas.
```

> **🏆 Checkpoint 4**: Self-critique com 5+ fragilidades reais documentadas.

---

### Passo 6 — Steps 11-13: Refinamento e insights

```
Dex, steps 11-12: refine baseado na self-critique.

Dos 5+ pontos que identificou, corrija os 2-3 mais 
críticos. Os demais ficam como dívida técnica 
documentada (não esquecida).

Step 13: capture insights para o próximo subsistema.

*capture-insights

O que aprendeu implementando o Quiz Engine que vai 
ajudar no Content Engine, Lab Provisioner e outros 
subsistemas da Plataforma?
```

**Documente o execution-log.md final com todos os 13 steps**.

> **🏆 Checkpoint 5 — VITÓRIA DA AULA**: Quiz Engine funcional + execution-log.md com 13 steps documentados.

---

### Passo 7 — Commit

```bash
*exit

git add .
git commit -m "feat: Quiz Engine via ADE 13 steps with full execution log

- Multiple question types, adaptive difficulty, gamification
- XP, streaks, badges, ranking system
- @zabbix-expert integration for question generation
- Edge cases handled (concurrent sessions, difficulty loops, overflow)
- Self-critique: 5+ fragilities documented
- Top 3 fragilities addressed, remainder as documented tech debt
- execution-log.md with all 13 steps detailed"
```

---

## Reflexão

### O valor de documentar o processo

O Quiz Engine implementado sem os 13 steps documentados teria o mesmo código. Mas você não teria:

- Registro de quanto cada subtask realmente levou (vs estimativa)
- Decisões tomadas que não estavam na spec (para refinar specs futuras)
- 5+ fragilidades conhecidas e priorizadas (não surpresas em produção)
- Insights capturados para o próximo subsistema

O execution-log é o meta-dado do desenvolvimento — o código conta O QUE foi construído, o log conta COMO e POR QUÊ.

### Self-critique: o step que ninguém quer fazer

A self-critique (step 10) é desconfortável porque pede ao Dev que aponte falhas no próprio trabalho. Mas é o step com maior ROI: cada fragilidade identificada pelo Dev no step 10 é um bug que não vai para produção sem ser consciente.

A diferença entre self-critique boa e ruim:
- **Ruim**: "O código poderia ter mais testes" (genérico, sem ação)
- **Boa**: "A query de ranking faz JOIN sem index na coluna topic — com 100k sessões vai degradar. Prioridade: adicionar index antes de lançamento." (específico, acionável, priorizado)

### O conceito-chave

> **Os 13 steps do Execution Engine não são checklist burocrático — são um framework que força rigor em cada fase da implementação. Documentar cada step transforma implementação de "eu acho que está bom" em "eu sei o que está bom, o que é frágil, e o que precisa de atenção". Em projetos do tamanho da Plataforma Zabbix, esse rigor é o que impede dívida técnica invisível.**

### Conexão com a próxima aula

Na Aula 07, os Epics 5-7 são exercitados juntos: Recovery System no Lab Provisioner (a feature que VAI falhar — containers efêmeros são complexos), QA Evolution com 10 fases aplicadas em segurança de containers, e Memory Layer consolidando insights de Content Engine + Quiz Engine + Lab Provisioner. É a aula mais densa do Módulo 2.

---

> **Anterior**: Aula 05 — Epic 3: Spec Pipeline com Iteração Real
> **Próxima**: Aula 07 — Epics 5-7: Recovery, QA Evolution, Memory Layer
