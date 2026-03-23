2:I[4817,["972","static/chunks/972-435ad046c10f8479.js","552","static/chunks/552-ca913c8f5aa11d94.js","188","static/chunks/app/bootcamp/%5Blesson%5D/page-3b4cd11983f1559e.js"],"LessonRenderer"]
4:I[4707,[],""]
6:I[6423,[],""]
7:I[872,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"ThemeProvider"]
8:I[3021,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Sidebar"]
9:I[8680,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Header"]
3:T2b9e,# Aula 07 — Dev + QA: Frontend, Testes e Qualidade

<!-- metadata
module: 2
lesson: 7
title: "Dev + QA: Frontend, Testes e Qualidade"
duration: 4 horas
agents: "@dev, @qa"
project: RockQuiz
phase: Desenvolvimento + Qualidade
prerequisites: Aula 06 concluída (API funcional)
-->

---

> **Módulo 2** · RockQuiz: Pipeline Completo
> **Duração**: 4 horas
> **Agentes praticados**: `@dev`, `@qa`
> **Projeto**: RockQuiz

---

## 🏆 Vitória desta aula

Frontend funcional integrado à API + testes com cobertura sólida + QA review completo com ciclo de correções aprovado.

**Critério binário**: App jogável no browser + testes passando + QA aprovou.

---

## Conceito

### O QA: o par crítico que torna o código profissional

Até agora o @dev implementou sozinho. A partir desta aula, o @qa entra como **par crítico**. Ele não procura bugs triviais (testes fazem isso) — ele avalia qualidade holística em **10 fases**, cada uma olhando por uma lente diferente:

| Fase | Lente |
|------|-------|
| 1 | Conformidade com acceptance criteria |
| 2 | Qualidade e legibilidade do código |
| 3 | Robustez do error handling |
| 4 | Cobertura e qualidade dos testes |
| 5 | Edge cases não cobertos |
| 6 | Consistência com Architecture Doc |
| 7 | Segurança |
| 8 | Performance |
| 9 | Manutenibilidade |
| 10 | Documentação |

O ciclo de feedback é formal:

```
@qa encontra issues → *request-fix → @dev corrige → *apply-qa-fix → @qa verifica → *verify-fix
```

### O princípio aplicado ao QA

Você não vai dizer ao QA **o que procurar** — ele sabe (as 10 fases são seu checklist interno). Você vai pedir o review, ler o relatório, e garantir que o Dev corrige o que foi encontrado. Seu papel é **orquestrar o ciclo**, não dirigir a análise.

---

## Contexto

Nesta aula fazemos três coisas: o Dev implementa o frontend (story correspondente), o Dev escreve testes, e o QA faz review de **tudo** (backend + frontend + testes). O QA vai encontrar problemas — e cada fix melhora o projeto.

---

## Prática

### Passo 1 — Dev implementa o frontend

```bash
cd ~/aiox-bootcamp/rockquiz
claude
```

```
@dev

Dex, leia a story de frontend em docs/stories/ e o UX Spec 
em docs/ux-spec.md.

Implemente o frontend completo do RockQuiz. A Uma (UX Expert) 
definiu o design, o fluxo de telas e os padrões visuais no 
UX Spec. A Aria (Architect) definiu a stack e a estrutura no 
Architecture Doc.

Preciso de:
- Todas as telas que o UX Spec define (landing, quiz, resultado, ranking)
- A integração com a API que você implementou na aula anterior
- O feedback visual que a Uma especificou (acerto/erro/streak/timer)
- Responsividade (funcionar em mobile e desktop)

Siga os acceptance criteria da story. Se algo do UX Spec 
não estiver claro para implementar, me pergunte.
```

**Como verificar**: Abra o browser e teste o fluxo completo.

```bash
# Garantir que API está rodando
cd packages/api && npm run dev &

# Iniciar frontend
cd packages/web && npm run dev

# Abrir http://localhost:3000
```

> **Checklist de verificação visual** (teste você mesmo no browser)
> - [ ] Landing carrega com campo de nickname e opções de modo
> - [ ] Clicar para jogar inicia um jogo e mostra pergunta
> - [ ] Alternativas são clicáveis com feedback visual
> - [ ] Timer funciona (se o UX Spec definiu timer)
> - [ ] Score atualiza a cada resposta correta
> - [ ] Streak é visualmente indicado
> - [ ] Tela de resultado mostra score e estatísticas
> - [ ] Ranking carrega e mostra dados
> - [ ] Funciona razoavelmente em tela pequena (redimensione o browser)

Se algo não funcionar ou não corresponder ao UX Spec:

```
Dex, a tela de quiz não mostra feedback quando erro uma 
pergunta — só pula para a próxima. O UX Spec diz que a 
alternativa errada deve ficar vermelha e a correta deve 
aparecer em verde com a explicação. Corrija.
```

```
Dex, no mobile as 4 alternativas ficam espremidas. 
Verifique a responsividade — em telas < 640px as 
alternativas devem empilhar verticalmente.
```

> **🏆 Checkpoint 1**: App jogável no browser — fluxo completo funciona.

---

### Passo 2 — Dev escreve testes

```
Dex, agora preciso de testes para garantir que o que 
construímos não vai quebrar quando fizermos mudanças.

Olhe os acceptance criteria de TODAS as stories implementadas 
(backend + frontend). Cada cenário de aceitação deve ter pelo 
menos um teste correspondente.

Preciso de:
- Testes unitários para a lógica de negócio (scoring, quiz engine)
- Testes de integração para os endpoints da API (com banco real)
- Pelo menos um teste E2E que percorra o fluxo completo no browser

Os testes devem cobrir tanto o caminho feliz (tudo funciona) 
quanto os caminhos de erro (input inválido, recurso não encontrado, 
estado inconsistente).

Consulte o Architecture Doc para a estratégia de testes que a 
Aria definiu.
```

**Como verificar**:

```bash
# Rodar testes
cd packages/api
npm test

# Com cobertura
npm test -- --coverage
```

> **Checklist de testes**
> - [ ] Testes passam sem erros?
> - [ ] Cobertura de linhas é razoável (≥80%)?
> - [ ] Há testes para o scoring (a lógica mais complexa)?
> - [ ] Há testes de erro (o que acontece com input inválido)?
> - [ ] Há teste E2E (fluxo completo funciona no browser)?

Se a cobertura estiver baixa:

```
Dex, a cobertura está em 65%. Os acceptance criteria do PRD 
definem vários cenários de scoring (speed bonus, streak, 
cap de multiplicador, erro). Verifique se cada cenário 
tem teste correspondente.
```

> **🏆 Checkpoint 2**: Testes passando com cobertura adequada.

---

### Passo 3 — QA Review

Agora vem o momento mais importante da aula. O QA analisa **tudo**:

```
*exit

@qa

Quinn, faça review completo do RockQuiz.

Analise todo o código implementado (backend e frontend), 
todos os testes, e verifique contra os acceptance criteria 
das stories em docs/stories/ e contra o Architecture Doc 
em docs/architecture.md.

Aplique suas 10 fases de review. Para cada issue encontrada, 
classifique por severidade (critical, high, medium, low) e 
explique exatamente o que está errado e por quê.

*review-build
```

**O que esperar**: O QA vai retornar um relatório com issues organizadas por severidade. Exemplos **reais** do tipo de coisa que o QA encontra e que testes não pegam:

- "O scoring service usa números hardcoded (100, 1.5, 0.8). Extrair para constantes nomeadas melhora manutenibilidade." *(Fase 9)*
- "Se Redis estiver indisponível, a API retorna erro 500 sem mensagem útil. Implementar fallback ou mensagem clara." *(Fase 3)*
- "O endpoint POST /api/games não valida se playerId existe antes de criar o jogo. Vai gerar erro de FK." *(Fase 5)*
- "O frontend não desabilita o botão após clicar uma alternativa. Double-click envia duas respostas." *(Fase 5)*
- "Nenhum endpoint tem rate limiting. Um usuário pode enviar 1000 requests/segundo." *(Fase 7)*
- "A query de listagem de rankings faz N+1 para buscar nicknames." *(Fase 8)*

**Como avaliar o review do QA**:

> **Checklist de qualidade do review**
> - [ ] O QA cobriu as 10 fases (não apenas testou se funciona)?
> - [ ] Cada issue tem severidade clara?
> - [ ] Cada issue explica o problema E por que é problema?
> - [ ] Há issues de segurança (fase 7)?
> - [ ] Há issues de performance (fase 8)?

Se o review parecer superficial:

```
Quinn, o review não mencionou segurança. O RockQuiz tem 
endpoints que aceitam input do usuário (nickname, respostas). 
Verifique se há validação adequada contra injection, XSS, 
e payloads malformados. Também verifique se o correctAnswer 
não vaza em nenhuma resposta antes do jogador responder.
```

---

### Passo 4 — Ciclo de correções

O QA encontrou issues. Agora o Dev corrige:

```
*exit

@dev

Dex, o QA (Quinn) encontrou issues no review. Leia o relatório 
e aplique as correções para todas as issues de severidade 
critical e high.

*apply-qa-fix

Para cada correção:
1. Implemente o fix
2. Adicione teste que cobre o cenário (se não existia)
3. Rode os testes para garantir que não quebrou nada existente
```

**Como acompanhar**: O Dev vai listar as correções que aplicou. Verifique que cada issue crítica e alta foi endereçada:

```
Dex, o QA reportou 3 issues critical e 4 high. Confirme 
que todas as 7 foram corrigidas. Liste cada issue e o que 
você fez para resolver.
```

Se o Dev disser que uma issue "não é problema":

```
Dex, você diz que o rate limiting não é necessário porque 
"o projeto é pequeno". O QA classificou como HIGH porque 
sem rate limit qualquer script pode derrubar a API. 
Implemente — é uma prática de segurança básica.
```

---

### Passo 5 — QA verifica as correções

```
*exit

@qa

Quinn, o Dev aplicou correções para as issues que você encontrou.

*verify-fix

Verifique:
1. Cada issue critical e high foi realmente corrigida?
2. As correções não introduziram novos problemas (regressão)?
3. Os testes cobrem os cenários que estavam faltando?
```

O QA deve confirmar: "Todas as issues critical/high foram resolvidas. Sem regressão detectada."

Se o QA encontrar que algo não foi corrigido adequadamente, o ciclo repete:

```
@qa → *request-fix (issue específica) → @dev → *apply-qa-fix → @qa → *verify-fix
```

Repita até o QA aprovar.

> **🏆 Checkpoint 3 — VITÓRIA DA AULA**: QA aprovou após ciclo de correções.

---

### Passo 6 — Commit consolidado

```bash
*exit

git add .
git commit -m "feat: frontend + tests + QA review fixes

- Frontend complete (all pages + components + API integration)
- Unit tests for scoring and quiz engine
- Integration tests for all API endpoints
- E2E test for complete quiz flow
- QA fixes: input validation, error handling, rate limiting,
  loading states, code quality improvements"
```

---

## Reflexão

### Testes vs QA: complementares, não redundantes

| O que testes automatizados verificam | O que o QA verifica além dos testes |
|--------------------------------------|-------------------------------------|
| "Dado input X, retorna Y?" | "O código é legível para o próximo dev?" |
| Caminho feliz funciona | Edge cases não óbvios |
| Regressão (nada quebrou) | Segurança (injection, XSS, data leak) |
| Cobertura de linhas | Performance (N+1 queries, missing indexes) |
| | Manutenibilidade (magic numbers, coupling) |
| | Consistência com Architecture Doc |

**Testes garantem que funciona. QA garante que é bom.** Ambos são necessários.

### O conceito-chave

> **O ciclo QA → Dev → QA é onde a qualidade real emerge. Cada issue encontrada e corrigida torna o projeto mais robusto de uma forma que testes sozinhos não conseguem. O QA é o agente que vê o que ninguém mais vê.**

### Conexão com a próxima aula

Na Aula 08, o @devops fecha o RockQuiz: CI/CD com GitHub Actions, observabilidade com métricas e dashboards, e deploy. Após a Aula 08, o RockQuiz estará completo, protegido e observável.

---

> **Anterior**: [Aula 06 — Dev: Backend](./aula-06-dev-backend.md)
> **Próxima**: [Aula 08 — DevOps: CI/CD, Observabilidade e Deploy](./aula-08-devops-cicd-deploy.md)
5:["lesson","aula-07-dev-qa-frontend","d"]
0:["0aCmzVh17xjX8k-qFi6hn",[[["",{"children":["bootcamp",{"children":[["lesson","aula-07-dev-qa-frontend","d"],{"children":["__PAGE__?{\"lesson\":\"aula-07-dev-qa-frontend\"}",{}]}]}]},"$undefined","$undefined",true],["",{"children":["bootcamp",{"children":[["lesson","aula-07-dev-qa-frontend","d"],{"children":["__PAGE__",{},[["$L1",["$","$L2",null,{"content":"$3","lessonSlug":"aula-07-dev-qa-frontend","module":"bootcamp","lessonIndex":6,"totalLessons":18,"nextLesson":"aula-08-devops-cicd-deploy","prevLesson":"aula-06-dev-backend"}],null],null],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","bootcamp","children","$5","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","bootcamp","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[[[["$","link","0",{"rel":"stylesheet","href":"/_next/static/css/71d217bb04404cb9.css","precedence":"next","crossOrigin":"$undefined"}]],["$","html",null,{"lang":"pt-BR","children":["$","body",null,{"className":"bg-white dark:bg-slate-900 text-gray-900 dark:text-gray-100 transition-colors","children":["$","$L7",null,{"children":["$","div",null,{"className":"flex h-screen overflow-hidden","children":[["$","$L8",null,{}],["$","div",null,{"className":"flex-1 flex flex-col overflow-hidden","children":[["$","$L9",null,{}],["$","main",null,{"className":"flex-1 overflow-y-auto bg-white dark:bg-slate-900 transition-colors","children":["$","div",null,{"className":"max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8","children":["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":[["$","title",null,{"children":"404: This page could not be found."}],["$","div",null,{"style":{"fontFamily":"system-ui,\"Segoe UI\",Roboto,Helvetica,Arial,sans-serif,\"Apple Color Emoji\",\"Segoe UI Emoji\"","height":"100vh","textAlign":"center","display":"flex","flexDirection":"column","alignItems":"center","justifyContent":"center"},"children":["$","div",null,{"children":[["$","style",null,{"dangerouslySetInnerHTML":{"__html":"body{color:#000;background:#fff;margin:0}.next-error-h1{border-right:1px solid rgba(0,0,0,.3)}@media (prefers-color-scheme:dark){body{color:#fff;background:#000}.next-error-h1{border-right:1px solid rgba(255,255,255,.3)}}"}}],["$","h1",null,{"className":"next-error-h1","style":{"display":"inline-block","margin":"0 20px 0 0","padding":"0 23px 0 0","fontSize":24,"fontWeight":500,"verticalAlign":"top","lineHeight":"49px"},"children":"404"}],["$","div",null,{"style":{"display":"inline-block"},"children":["$","h2",null,{"style":{"fontSize":14,"fontWeight":400,"lineHeight":"49px","margin":0},"children":"This page could not be found."}]}]]}]}]],"notFoundStyles":[]}]}]}]]}]]}]}]}]}]],null],null],["$La",null]]]]
a:[["$","meta","0",{"name":"viewport","content":"width=device-width, initial-scale=1"}],["$","meta","1",{"charSet":"utf-8"}],["$","title","2",{"children":"AIOX Course Platform | Professional Bootcamp & Mastery"}],["$","meta","3",{"name":"description","content":"Learn AIOX - AI-Orchestrated System for Full Stack Development. Complete bootcamp and mastery courses with hands-on projects."}],["$","meta","4",{"name":"keywords","content":"AIOX,AI Development,Full Stack,Course,Bootcamp,Learning"}]]
1:null
