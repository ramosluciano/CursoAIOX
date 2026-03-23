2:I[4817,["972","static/chunks/972-435ad046c10f8479.js","552","static/chunks/552-ca913c8f5aa11d94.js","188","static/chunks/app/bootcamp/%5Blesson%5D/page-3b4cd11983f1559e.js"],"LessonRenderer"]
4:I[4707,[],""]
6:I[6423,[],""]
7:I[872,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"ThemeProvider"]
8:I[3021,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Sidebar"]
9:I[8680,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Header"]
3:T26f9,# Aula 06 — Dev: Backend do RockQuiz

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

> **Anterior**: [Aula 05 — DevOps: Infra](./aula-05-devops-infra.md)
> **Próxima**: [Aula 07 — Dev + QA: Frontend, Testes e Qualidade](./aula-07-dev-qa-frontend.md)
5:["lesson","aula-06-dev-backend","d"]
0:["0aCmzVh17xjX8k-qFi6hn",[[["",{"children":["bootcamp",{"children":[["lesson","aula-06-dev-backend","d"],{"children":["__PAGE__?{\"lesson\":\"aula-06-dev-backend\"}",{}]}]}]},"$undefined","$undefined",true],["",{"children":["bootcamp",{"children":[["lesson","aula-06-dev-backend","d"],{"children":["__PAGE__",{},[["$L1",["$","$L2",null,{"content":"$3","lessonSlug":"aula-06-dev-backend","module":"bootcamp","lessonIndex":5,"totalLessons":18,"nextLesson":"aula-07-dev-qa-frontend","prevLesson":"aula-05-devops-infra"}],null],null],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","bootcamp","children","$5","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","bootcamp","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[[[["$","link","0",{"rel":"stylesheet","href":"/_next/static/css/71d217bb04404cb9.css","precedence":"next","crossOrigin":"$undefined"}]],["$","html",null,{"lang":"pt-BR","children":["$","body",null,{"className":"bg-white dark:bg-slate-900 text-gray-900 dark:text-gray-100 transition-colors","children":["$","$L7",null,{"children":["$","div",null,{"className":"flex h-screen overflow-hidden","children":[["$","$L8",null,{}],["$","div",null,{"className":"flex-1 flex flex-col overflow-hidden","children":[["$","$L9",null,{}],["$","main",null,{"className":"flex-1 overflow-y-auto bg-white dark:bg-slate-900 transition-colors","children":["$","div",null,{"className":"max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8","children":["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":[["$","title",null,{"children":"404: This page could not be found."}],["$","div",null,{"style":{"fontFamily":"system-ui,\"Segoe UI\",Roboto,Helvetica,Arial,sans-serif,\"Apple Color Emoji\",\"Segoe UI Emoji\"","height":"100vh","textAlign":"center","display":"flex","flexDirection":"column","alignItems":"center","justifyContent":"center"},"children":["$","div",null,{"children":[["$","style",null,{"dangerouslySetInnerHTML":{"__html":"body{color:#000;background:#fff;margin:0}.next-error-h1{border-right:1px solid rgba(0,0,0,.3)}@media (prefers-color-scheme:dark){body{color:#fff;background:#000}.next-error-h1{border-right:1px solid rgba(255,255,255,.3)}}"}}],["$","h1",null,{"className":"next-error-h1","style":{"display":"inline-block","margin":"0 20px 0 0","padding":"0 23px 0 0","fontSize":24,"fontWeight":500,"verticalAlign":"top","lineHeight":"49px"},"children":"404"}],["$","div",null,{"style":{"display":"inline-block"},"children":["$","h2",null,{"style":{"fontSize":14,"fontWeight":400,"lineHeight":"49px","margin":0},"children":"This page could not be found."}]}]]}]}]],"notFoundStyles":[]}]}]}]]}]]}]}]}]}]],null],null],["$La",null]]]]
a:[["$","meta","0",{"name":"viewport","content":"width=device-width, initial-scale=1"}],["$","meta","1",{"charSet":"utf-8"}],["$","title","2",{"children":"AIOX Course Platform | Professional Bootcamp & Mastery"}],["$","meta","3",{"name":"description","content":"Learn AIOX - AI-Orchestrated System for Full Stack Development. Complete bootcamp and mastery courses with hands-on projects."}],["$","meta","4",{"name":"keywords","content":"AIOX,AI Development,Full Stack,Course,Bootcamp,Learning"}]]
1:null
