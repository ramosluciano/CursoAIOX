2:I[4817,["972","static/chunks/972-435ad046c10f8479.js","552","static/chunks/552-ca913c8f5aa11d94.js","460","static/chunks/app/mastery/%5Blesson%5D/page-19f8ee117e5859d3.js"],"LessonRenderer"]
4:I[4707,[],""]
6:I[6423,[],""]
7:I[872,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"ThemeProvider"]
8:I[3021,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Sidebar"]
9:I[8680,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Header"]
3:T23ce,# Aula 13 — Quiz Engine Gamificado + Learning Path

<!-- metadata
course: Mastery
module: 4
lesson: 13
title: "Quiz Engine Gamificado + Learning Path"
duration: 4-5 horas
agents: "@dev, @zabbix-expert, @qa"
project: Plataforma Zabbix Learning
phase: Desenvolvimento Core
prerequisites: Aula 12 concluída (Content Engine com RAG)
-->

---

> **Módulo 4** · Plataforma Zabbix: Desenvolvimento Core
> **Duração**: 4-5 horas
> **Agentes praticados**: `@dev`, `@zabbix-expert`, `@qa`
> **Projeto**: Plataforma Zabbix Learning

---

## 🏆 Vitória desta aula

Quiz Engine com gamificação completa integrado ao Content Engine, e Learning Path adaptativo que ajusta a jornada baseado na performance do aluno.

**Critério binário**: Quiz jogável com XP/badges/ranking + dificuldade adaptativa + path que avança ou recua baseado em acertos + integração content ↔ quiz ↔ path funcional.

---

## Conceito

### A tríade ensino-avaliação-adaptação

O Content Engine gera aulas. O Quiz Engine avalia se o aluno aprendeu. O Learning Path decide o próximo passo. Juntos, formam um ciclo que nenhuma playlist estática oferece:

```
Content Engine → Aluno estuda aula
  → Quiz Engine → Aluno responde quiz
    → Performance? 
      → ≥80%: Learning Path avança
      → 60-80%: Revisão leve + quiz alternativo
      → <60%: Re-estudo + conteúdo suplementar
```

### Gamificação que engaja sem infantilizar

A audiência são profissionais de TI — gamificação precisa ser motivadora sem ser condescendente. XP e streaks funcionam como reconhecimento de progresso. Badges celebram conquistas reais ("Mestre de Triggers" requer acertar 50 perguntas sobre triggers). Ranking cria competição saudável entre colegas.

| Elemento | Propósito | Cuidado |
|----------|-----------|---------|
| XP | Progresso visível | Não inflacionar — pontos devem significar algo |
| Streaks | Consistência de estudo | Grace period para não punir 1 dia ausente |
| Badges | Conquistas de domínio | Baseados em competência, não tempo |
| Ranking | Competição saudável | Opt-in, não forçado |
| Levels | Progressão geral | Alinhados com a taxonomia (Nível 1 = Fundamentos) |

---

## Contexto

O Quiz Engine básico foi implementado na Aula 06 (ADE 13 steps). Agora integramos com Content Engine e Learning Path, adicionando a camada de adaptatividade que transforma a plataforma de "repositório" em "tutor personalizado".

---

## Prática

### Passo 1 — Integrar Quiz com Content Engine

```bash
cd ~/aiox-mastery/zabbix-platform
claude
```

```
@dev

Dex, integre o Quiz Engine com o Content Engine.

Requisitos:
1. Cada aula do Content Engine tem quizzes vinculados
2. @zabbix-expert gera perguntas baseadas no conteúdo 
   específico da aula (não perguntas genéricas)
3. Múltiplos tipos de pergunta:
   - Múltipla escolha (4 alternativas)
   - Verdadeiro/Falso
   - Ordenação (colocar passos na ordem correta)
   - Completar frase (preencher lacuna em config)
4. Cada pergunta tem: enunciado, alternativas, resposta 
   correta, explicação detalhada, referência à doc, 
   dificuldade (easy/medium/hard)
5. Perguntas são armazenadas no banco vinculadas à aula

Consulte a spec do Quiz Engine e o PRD shard 
docs/prd/prd-quiz-engine.md.
```

**Como verificar**:

```bash
# Gerar perguntas para uma aula existente
curl -X POST http://localhost:3000/api/quiz/generate \
  -d '{"lessonId":1,"count":5,"difficulty":"medium"}' | jq

# Iniciar sessão de quiz
curl -X POST http://localhost:3000/api/quiz/start \
  -d '{"userId":1,"lessonId":1}' | jq

# Responder
curl -X POST http://localhost:3000/api/quiz/answer \
  -d '{"sessionId":1,"questionId":1,"answer":"B","timeMs":5000}' | jq
```

> **Checklist de integração quiz ↔ content**
> - [ ] Perguntas são geradas do conteúdo da aula específica?
> - [ ] Múltiplos tipos de pergunta funcionam?
> - [ ] Explicação é educativa (não apenas "a resposta é C")?
> - [ ] Dificuldade é classificada corretamente?
> - [ ] @zabbix-expert valida precisão técnica?

> **🏆 Checkpoint 1**: Quiz integrado com Content Engine.

---

### Passo 2 — Gamificação completa

```
Dex, implemente gamificação no Quiz Engine:

1. XP: pontos por acerto
   - Easy: 10 XP
   - Medium: 25 XP
   - Hard: 50 XP
   - Multiplicador por speed (resposta rápida = mais XP)
   - Multiplicador por streak (sequência de acertos)

2. Streaks: sequência de acertos consecutivos
   - Visual na UI (🔥 x5)
   - Streak bonus a cada 5 acertos

3. Badges baseados em competência:
   - "Primeiro Quiz" (completar 1 quiz)
   - "Sem Erro" (quiz completo sem errar)
   - "Mestre de [Tópico]" (50 acertos no tópico)
   - "Maratonista" (5 quizzes no mesmo dia)
   - "Streak de 10" / "Streak de 25" / "Streak de 50"

4. Ranking: global e por módulo
   - Opt-in (aluno escolhe participar)
   - Atualiza em tempo real

5. Levels: XP acumulado → level up
   - Level 1: Novato (0-500 XP)
   - Level 2: Aprendiz (500-2000 XP)
   - Level 3: Praticante (2000-5000 XP)
   - Level 4: Especialista (5000-15000 XP)
   - Level 5: Mestre (15000+ XP)
```

> **Checklist de gamificação**
> - [ ] XP calcula com multiplicadores corretos?
> - [ ] Streaks incrementam e resetam corretamente?
> - [ ] Badges são concedidos quando critério é atingido?
> - [ ] Ranking atualiza em tempo real?
> - [ ] Levels correspondem ao XP acumulado?

> **🏆 Checkpoint 2**: Gamificação completa funcional.

---

### Passo 3 — Learning Path adaptativo

```
Dex, implemente o Learning Path Engine:

1. Jornada definida pela taxonomia da Aula 08 
   (5 níveis, múltiplos tópicos por nível)

2. Progressão adaptativa:
   - Aluno completa aula → faz quiz
   - ≥80% acertos → avança para próximo tópico
   - 60-80% → revisão leve (resumo + quiz alternativo)
   - <60% → re-estudo (conteúdo suplementar + quiz mais fácil)

3. Path é personalizado por aluno:
   - Cada aluno tem seu progresso
   - Pode avançar mais rápido em tópicos que domina
   - É direcionado para revisão em tópicos fracos

4. Visualização:
   - Mapa de progresso (quais tópicos completou)
   - Próximo passo sugerido
   - Estimativa de tempo até conclusão

5. Integração:
   - Content Engine: busca aula do próximo tópico
   - Quiz Engine: avalia e retorna performance
   - Auth: path gatado por plano (free = caminho limitado)
```

**Como verificar**: Simule dois alunos com performances diferentes e verifique que os paths divergem:

```bash
# Aluno A: acerta tudo
# Deve avançar rápido pelo path

# Aluno B: erra muito
# Deve receber conteúdo de revisão

# Comparar: /api/learning-path/1 vs /api/learning-path/2
# Os próximos passos devem ser diferentes
```

> **Checklist do Learning Path**
> - [ ] Performance ≥80% → avança?
> - [ ] Performance <60% → revisão?
> - [ ] Path é personalizado por aluno (dois alunos divergem)?
> - [ ] Mapa de progresso visualiza conquistas?
> - [ ] Feature gating funciona (free = caminho limitado)?
> - [ ] Estimativa de tempo é calculada?

> **🏆 Checkpoint 3**: Learning Path adaptativo funcional.

---

### Passo 4 — QA review da integração

```
*exit

@qa

Quinn, review da integração Content Engine ↔ Quiz Engine 
↔ Learning Path.

Foco:
- A adaptatividade REALMENTE funciona? Simule aluno que 
  acerta tudo vs aluno que erra muito — os paths divergem?
- A gamificação é consistente? XP nunca fica negativo? 
  Badges são concedidos uma vez (não repetidamente)?
- O feature gating funciona no path (free limitado)?
- Edge cases: aluno completa quiz com 0% de acerto? 
  Quiz sem perguntas disponíveis? Path sem próximo passo?

*review-build
```

Ciclo de correções até aprovação.

> **🏆 Checkpoint 4 — VITÓRIA DA AULA**: Quiz gamificado + Learning Path adaptativo + integração aprovada.

---

### Passo 5 — Commit

```bash
*exit
git add .
git commit -m "feat: gamified Quiz Engine + adaptive Learning Path

- Quiz integrated with Content Engine (contextual questions)
- 4 question types: multiple choice, true/false, ordering, fill-in
- Full gamification: XP with multipliers, streaks, badges, ranking, levels
- Adaptive Learning Path: advance/review/restudy based on performance
- Personalized per student with progress visualization
- QA integration review approved"
```

---

## Reflexão

### O conceito-chave

> **O Learning Path adaptativo transforma a plataforma de "repositório de conteúdo" em "tutor personalizado". Cada aluno tem jornada diferente baseada no que sabe e no que precisa aprender. A tríade Content Engine → Quiz Engine → Learning Path cria um ciclo de ensino-avaliação-adaptação que nenhuma playlist estática oferece.**

### Conexão com a próxima aula

Na Aula 14, o último par de subsistemas: Ferramentas Interativas (mini-apps que ensinam Zabbix na prática) e Lab Provisioner real (instâncias Zabbix efêmeras). Após a Aula 14, os 6 subsistemas da plataforma estarão implementados.

---

> **Anterior**: [Aula 12 — Content Engine com RAG](./aula-12-content-engine.md)
> **Próxima**: [Aula 14 — Ferramentas Interativas e Lab Provisioner](./aula-14-tooling-labs.md)
5:["lesson","mastery-aula-13-quiz-learning-path","d"]
0:["0aCmzVh17xjX8k-qFi6hn",[[["",{"children":["mastery",{"children":[["lesson","mastery-aula-13-quiz-learning-path","d"],{"children":["__PAGE__?{\"lesson\":\"mastery-aula-13-quiz-learning-path\"}",{}]}]}]},"$undefined","$undefined",true],["",{"children":["mastery",{"children":[["lesson","mastery-aula-13-quiz-learning-path","d"],{"children":["__PAGE__",{},[["$L1",["$","$L2",null,{"content":"$3","lessonSlug":"mastery-aula-13-quiz-learning-path","module":"mastery","lessonIndex":12,"totalLessons":22,"nextLesson":"mastery-aula-14-tooling-labs","prevLesson":"mastery-aula-12-content-engine"}],null],null],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","mastery","children","$5","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","mastery","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[[[["$","link","0",{"rel":"stylesheet","href":"/_next/static/css/71d217bb04404cb9.css","precedence":"next","crossOrigin":"$undefined"}]],["$","html",null,{"lang":"pt-BR","children":["$","body",null,{"className":"bg-white dark:bg-slate-900 text-gray-900 dark:text-gray-100 transition-colors","children":["$","$L7",null,{"children":["$","div",null,{"className":"flex h-screen overflow-hidden","children":[["$","$L8",null,{}],["$","div",null,{"className":"flex-1 flex flex-col overflow-hidden","children":[["$","$L9",null,{}],["$","main",null,{"className":"flex-1 overflow-y-auto bg-white dark:bg-slate-900 transition-colors","children":["$","div",null,{"className":"max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8","children":["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":[["$","title",null,{"children":"404: This page could not be found."}],["$","div",null,{"style":{"fontFamily":"system-ui,\"Segoe UI\",Roboto,Helvetica,Arial,sans-serif,\"Apple Color Emoji\",\"Segoe UI Emoji\"","height":"100vh","textAlign":"center","display":"flex","flexDirection":"column","alignItems":"center","justifyContent":"center"},"children":["$","div",null,{"children":[["$","style",null,{"dangerouslySetInnerHTML":{"__html":"body{color:#000;background:#fff;margin:0}.next-error-h1{border-right:1px solid rgba(0,0,0,.3)}@media (prefers-color-scheme:dark){body{color:#fff;background:#000}.next-error-h1{border-right:1px solid rgba(255,255,255,.3)}}"}}],["$","h1",null,{"className":"next-error-h1","style":{"display":"inline-block","margin":"0 20px 0 0","padding":"0 23px 0 0","fontSize":24,"fontWeight":500,"verticalAlign":"top","lineHeight":"49px"},"children":"404"}],["$","div",null,{"style":{"display":"inline-block"},"children":["$","h2",null,{"style":{"fontSize":14,"fontWeight":400,"lineHeight":"49px","margin":0},"children":"This page could not be found."}]}]]}]}]],"notFoundStyles":[]}]}]}]]}]]}]}]}]}]],null],null],["$La",null]]]]
a:[["$","meta","0",{"name":"viewport","content":"width=device-width, initial-scale=1"}],["$","meta","1",{"charSet":"utf-8"}],["$","title","2",{"children":"AIOX Course Platform | Professional Bootcamp & Mastery"}],["$","meta","3",{"name":"description","content":"Learn AIOX - AI-Orchestrated System for Full Stack Development. Complete bootcamp and mastery courses with hands-on projects."}],["$","meta","4",{"name":"keywords","content":"AIOX,AI Development,Full Stack,Course,Bootcamp,Learning"}]]
1:null
