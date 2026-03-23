# Aula 06 — Dev: Backend do RockQuiz

<!-- metadata
module: 2
lesson: 6
title: "Dev: Backend do RockQuiz"
duration: 4 horas
agents: "@dev"
project: RockQuiz
phase: Desenvolvimento (Fase 2)
prerequisites: Aula 05 concluída (infraestrutura pronta)
-->

---

> **Módulo 2** · RockQuiz: Pipeline Completo
> **Duração**: 4 horas
> **Agentes praticados**: `@dev`
> **Projeto**: RockQuiz

---

## 🏆 Vitória desta aula

API backend completa e funcional, implementada pelo @dev a partir das stories. Testável com curl ou browser.

**Critério binário**: Conseguir iniciar um jogo, responder perguntas com score calculado e ver ranking via API.

---

## Conceito

### O Dev no AIOX: implementação dirigida por story

O @dev do AIOX não improvisa — ele implementa a partir de **stories hiperdetalhadas** que contêm critérios testáveis, detalhes técnicos e decisões arquiteturais. Ele não decide o schema do banco (Architect decidiu), não inventa a fórmula de scoring (PM especificou) e não escolhe a estrutura de diretórios (Architect definiu).

Isso libera o Dev para focar no que faz de melhor: **código limpo, error handling robusto e implementação precisa**. As decisões de design já foram tomadas por especialistas.

Comandos do @dev:

| Comando | O que faz |
|---------|-----------|
| `*execute-subtask` | Executa uma subtask específica |
| `*capture-insights` | Registra aprendizados para Memory Layer |
| `*track-attempt` | Registra tentativa (sucesso/falha) |
| `*rollback` | Desfaz alterações se algo der errado |

### O princípio: o Dev lê a story, não o seu prompt

Nesta aula, você vai **apontar o Dev para a story** e deixar ele implementar. Seu papel é: verificar se o output está correto (testes manuais), pedir ajustes quando algo não funcionar, e capturar insights ao final.

Você NÃO vai ditar quais arquivos criar, qual lógica implementar ou como estruturar o código. Tudo isso está na story + no Architecture Doc. Se a story estiver incompleta (algo que o Dev precisa saber não está lá), isso é feedback para o SM — não para você resolver na hora.

---

## Contexto

As stories foram criadas na Aula 04 pelo @sm, baseadas no PRD e no Architecture Doc. A infraestrutura foi criada na Aula 05 pelo @devops. Agora o @dev implementa, story por story, na ordem priorizada pelo @po.

---

## Prática

### Passo 1 — Preparar o ambiente

```bash
cd ~/aiox-bootcamp/rockquiz

# Garantir que banco e cache estão rodando
docker compose -f .devcontainer/docker-compose.yml up -d

claude
```

---

### Passo 2 — Implementar a primeira story (Setup/Fundação)

Aponte o Dev para a story — ele lê e implementa:

```
@dev

Dex, leia a primeira story na ordem de prioridade em docs/stories/ 
(a story de setup/fundação do projeto).

Leia também docs/architecture.md para contexto técnico.

Implemente seguindo os acceptance criteria e os implementation 
details da story. Marque os checkboxes conforme completar cada item.

Se encontrar algo que a story não cobre, me pergunte antes de 
decidir por conta própria.
```

**O que observar**: O Dev vai ler a story, entender o escopo e implementar. Se a story foi bem escrita (Aula 04), ele terá tudo que precisa. Se precisar perguntar algo, isso é feedback valioso: anote para melhorar as stories nos próximos projetos.

**Como verificar**:

```bash
# Após o Dev implementar, teste o que a story define
# Se é a story de setup com health check:
cd packages/api
npm run dev

# Em outro terminal:
curl http://localhost:3001/health
```

O output deve corresponder ao que os acceptance criteria da story definem. Se não corresponder, peça ao Dev para corrigir — referenciando a story:

```
Dex, o health check retorna apenas {"status":"ok"} mas o 
acceptance criteria da story diz que deve incluir status 
de conexão com banco e cache. Revise.
```

> **🏆 Checkpoint 1**: Primeira story implementada e validada contra acceptance criteria.

---

### Passo 3 — Implementar stories de CRUD e dados

```
Dex, implemente a próxima story na sequência — a que cobre 
CRUD de categorias, perguntas e o seed de dados.

Siga os acceptance criteria da story. Ao terminar o seed, 
quero poder listar categorias e perguntas via API.
```

**Verificar**:

```bash
# Listar categorias
curl http://localhost:3001/api/categories | jq

# Listar perguntas (verifique que há perguntas reais sobre rock)
curl http://localhost:3001/api/questions | jq

# Filtrar por categoria (use o ID de uma categoria retornada)
curl "http://localhost:3001/api/questions?categoryId=1" | jq
```

Se os dados não fizerem sentido (perguntas genéricas em vez de sobre rock), peça ajuste:

```
Dex, as perguntas do seed são genéricas. A story especifica 
perguntas reais sobre rock distribuídas nas 6 categorias 
(História, Bandas, Álbuns, Curiosidades, Letras, Instrumentos). 
Refaça o seed com perguntas que um fã de rock reconheceria.
```

> **🏆 Checkpoint 2**: CRUD funcionando com perguntas reais de rock.

---

### Passo 4 — Implementar o quiz engine

```
Dex, implemente a story do quiz engine — iniciar jogo 
e seleção de perguntas.

Atenção especial: a resposta do endpoint de início de jogo 
NÃO deve incluir a resposta correta das perguntas. Se incluir, 
o jogador vê a resposta antes de responder.

Siga os acceptance criteria da story para os 3 modos de jogo.
```

**Verificar**:

```bash
# Criar jogador
curl -X POST http://localhost:3001/api/players \
  -H "Content-Type: application/json" \
  -d '{"nickname":"RockFan42"}' | jq

# Iniciar jogo
curl -X POST http://localhost:3001/api/games \
  -H "Content-Type: application/json" \
  -d '{"playerId":1,"mode":"CLASSIC"}' | jq
```

**Validação crítica**: Inspecione o JSON retornado e confirme que `correctAnswer` NÃO está presente na pergunta. Se estiver:

```
Dex, a resposta da API inclui correctAnswer na pergunta. 
Isso é um bug de segurança — o jogador pode ver a resposta 
no DevTools do browser. Remova do response e garanta que 
correctAnswer só aparece DEPOIS que o jogador responde.
```

> **🏆 Checkpoint 3**: Jogo inicia com perguntas selecionadas, sem vazar resposta.

---

### Passo 5 — Implementar scoring

```
Dex, implemente a story de scoring (responder pergunta + 
cálculo de pontuação).

A fórmula de scoring está definida nos acceptance criteria 
do PRD (docs/prd.md). Implemente EXATAMENTE conforme 
especificado — os testes vão verificar os valores exatos.

Quero poder responder uma pergunta e receber: se acertou/errou, 
a resposta correta, a explicação, os pontos ganhos, o streak 
atual e o score total.
```

**Verificar com teste manual**:

```bash
# Responder uma pergunta (use IDs reais do seu jogo)
curl -X POST http://localhost:3001/api/games/1/answer \
  -H "Content-Type: application/json" \
  -d '{"questionId":5,"answer":2,"timeMs":3200}' | jq
```

Confira no JSON retornado:
- `isCorrect` está coerente com a resposta?
- `scoreEarned` reflete os multiplicadores? (Se respondeu rápido uma pergunta difícil, o score deve ser alto)
- `currentStreak` incrementou (se acertou) ou resetou (se errou)?
- `explanation` tem conteúdo relevante?

Se os valores parecerem errados:

```
Dex, respondi corretamente uma pergunta HARD em 3 segundos 
e recebi 150 pontos. Pela fórmula do PRD deveria ser 
100 × 2.0 (hard) × 1.5 (speed <5s) = 300. Verifique a 
implementação do scoring service.
```

> **🏆 Checkpoint 4**: Scoring funcionando com multiplicadores corretos.

---

### Passo 6 — Implementar rankings

```
Dex, implemente a story de rankings. Preciso que:
- Ao finalizar um jogo, o score do jogador entre no ranking 
  (se for high score para aquele modo)
- O ranking seja consultável por modo de jogo
- O ranking seja rápido (use cache conforme o Architecture Doc)

Siga os acceptance criteria da story.
```

**Verificar**:

```bash
# Completar um jogo inteiro (responder todas as perguntas)
# ... (múltiplas chamadas de answer até o jogo finalizar)

# Consultar ranking
curl "http://localhost:3001/api/rankings?mode=CLASSIC" | jq
```

Confirme que o jogador aparece no ranking com o score correto.

> **🏆 Checkpoint 5 — VITÓRIA DA AULA**: API completa — CRUD + quiz + scoring + ranking.

---

### Passo 7 — Capturar insights

```
*capture-insights

Dex, registre o que aprendeu durante a implementação:
- Quais decisões você tomou que NÃO estavam nas stories?
- Onde as stories foram insuficientes (faltou informação)?
- Quais padrões de código se repetiram?
- O que daria para melhorar no processo?
```

Esses insights alimentam a **Memory Layer** e serão revisitados no Módulo 3 (AuctionHunter).

---

### Passo 8 — Commit

```bash
*exit

git add .
git commit -m "feat: complete backend API (CRUD + quiz engine + scoring + rankings)"
```

---

## Reflexão

### O que você fez vs o que o Dev fez

**Você**: Descreveu qual story implementar. Verificou outputs contra acceptance criteria. Pediu correções quando algo não bateu.

**O Dev**: Leu stories e Architecture Doc. Tomou decisões de implementação. Escreveu código. Marcou checkboxes.

Essa divisão é intencional: você é o **Product Owner** verificando se o que foi entregue corresponde ao que foi pedido. O Dev é o **executor** que sabe transformar specs em código. Nos projetos futuros (AuctionHunter, LinkedIn, Plataforma Zabbix), esse padrão se repete.

### O conceito-chave

> **O Dev lê a story, não o seu prompt. Se a story está boa, o Dev produz bom código. Se a story está ruim, o problema está no SM (Aula 04), não no Dev.**

### Conexão com a próxima aula

Na Aula 07, o @dev constrói o frontend e escreve testes, e o @qa faz review completo. Você vai experimentar o ciclo de feedback QA → Dev → QA — onde a qualidade é forjada.

---

> **Anterior**: Aula 05 — DevOps: Infra
> **Próxima**: Aula 07 — Dev + QA: Frontend, Testes e Qualidade
