2:I[4817,["972","static/chunks/972-435ad046c10f8479.js","552","static/chunks/552-ca913c8f5aa11d94.js","188","static/chunks/app/bootcamp/%5Blesson%5D/page-3b4cd11983f1559e.js"],"LessonRenderer"]
4:I[4707,[],""]
6:I[6423,[],""]
7:I[872,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"ThemeProvider"]
8:I[3021,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Sidebar"]
9:I[8680,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Header"]
3:T3fe2,# Aula 02 — Conceitos-Chave e Fluxo de Trabalho AIOX

<!-- metadata
module: 1
lesson: 2
title: Conceitos-Chave e Fluxo de Trabalho AIOX
duration: 2-3 horas
agents: todos (exploração conceitual)
project: nenhum (fundamentos)
phase: CCPR
prerequisites: Aula 01 concluída
-->

---

> **Módulo 1** · Fundamentos AIOX
> **Duração**: 2-3 horas
> **Agentes praticados**: Todos (exploração conceitual com exercícios de fixação)
> **Projeto**: Nenhum — esta aula constrói o modelo mental que sustenta tudo

---

## 🏆 Vitória desta aula

Ao final, você terá um entendimento claro e completo de **como o AIOX funciona** — não apenas quais botões apertar, mas por que o pipeline é desenhado assim, como os documentos carregam contexto entre agentes, e o que diferencia essa abordagem de simplesmente "pedir para a IA codificar".

**Critério binário**: Conseguir explicar em suas palavras o fluxo completo do AIOX (do briefing ao deploy) e saber qual agente usar em cada situação.

---

## Conceito

### Por que "Agentic Agile Development" e não apenas "Vibe Coding"

Existem hoje duas abordagens dominantes para desenvolvimento com IA:

**Abordagem 1 — Vibe Coding (prompt → código)**: Você abre o ChatGPT, Claude ou Cursor e diz "crie um app de quiz". A IA gera código. Funciona para coisas pequenas. Mas em projetos reais, os problemas aparecem rápido: o código não é consistente entre sessões, decisões arquiteturais mudam sem motivo, ninguém sabe por que algo foi feito de um jeito e não de outro, testes não existem, e cada vez que o contexto da conversa reseta, informação se perde.

**Abordagem 2 — Agentic Agile (planejar → especificar → implementar → validar)**: O AIOX propõe uma abordagem estruturada onde **antes de codificar, você planeja com agentes especializados**. O resultado do planejamento (documentos de PRD, arquitetura, stories) se torna o contexto do desenvolvimento. A IA não inventa do nada — ela implementa a partir de especificações detalhadas que ela mesma ajudou a criar.

A diferença não é filosófica — é prática. No vibe coding, a qualidade depende da sorte da sessão. No Agentic Agile, a qualidade é **estrutural** — está embedded nos documentos e nos processos, não na memória volátil de uma conversa.

### O fluxo de trabalho em duas fases

O AIOX opera em duas fases distintas:

#### Fase 1 — Planejamento (qualquer interface: web, Claude.ai, CLI)

Nesta fase, agentes de planejamento colaboram com você para produzir **documentos de especificação**. O foco é na qualidade das decisões, não na velocidade de execução.

```
@analyst (pesquisa) → @pm (requisitos) → @architect (design) → @ux-expert (UX)
     ↓                    ↓                    ↓                    ↓
Project Brief         PRD (requisitos)    Architecture Doc      UX Spec
                      Risk Matrix         API Contract
                                          DB Schema
```

Cada agente lê os documentos produzidos pelos anteriores e os usa como insumo para produzir o seu. O Analyst cria o briefing, o PM lê o briefing e cria o PRD, o Architect lê o PRD e cria a arquitetura. Contexto nunca se perde porque está em arquivos — não na memória de uma conversa.

**Human-in-the-loop**: Em cada etapa, o agente faz perguntas, você responde, ele refina. Não é "gere o documento" em um comando — é uma conversa iterativa onde você valida cada decisão.

#### Fase 2 — Desenvolvimento (IDE: Claude Code, Codex, Gemini)

Nesta fase, agentes de desenvolvimento transformam as especificações em código funcional. O foco é na implementação precisa e qualidade do código.

```
@sm cria stories → @dev implementa → @qa valida
       ↓                  ↓                ↓
  docs/stories/      src/ (código)    Review report
  STORY-01..N.md     tests/           Fix requests
```

O ponto crítico aqui é a **transição entre fases**: os documentos de planejamento (PRD, Architecture Doc) são o input do Scrum Master, que os transforma em stories hiperdetalhadas. Essas stories são o input do Dev, que implementa exatamente o que está especificado. O QA valida contra os acceptance criteria que estão na story.

Em nenhum momento alguém precisa "lembrar" o que foi decidido — está tudo nos documentos.

### Documentos como veículos de contexto

Este é o conceito mais importante do AIOX e o que o diferencia de qualquer outra abordagem.

Em uma conversa normal com uma IA, o contexto existe apenas na **janela de conversa**. Quando a conversa acaba (ou o contexto enche), tudo se perde. O agente da próxima sessão não sabe o que foi decidido na sessão anterior.

No AIOX, o contexto vive em **arquivos no seu repositório**:

```
docs/
├── project-brief.md      ← O que estamos construindo e por quê
├── prd.md                ← Requisitos detalhados com critérios testáveis
├── architecture.md       ← Como construir (stack, schema, endpoints, padrões)
├── ux-spec.md            ← Como deve parecer e se comportar
├── risk-matrix.md        ← O que pode dar errado e como mitigar
└── stories/
    ├── STORY-01.md       ← Tarefa específica com tudo que o Dev precisa
    ├── STORY-02.md
    └── ...
```

Quando o Dev abre `STORY-03.md`, ele encontra:

- **Acceptance Criteria** em formato Given/When/Then (o quê entregar)
- **Implementation Details** com pseudo-código (como construir)
- **Architecture Notes** referenciando decisões do Architect (por quê assim)
- **Checkboxes** para rastrear progresso
- **File List** dos arquivos que serão criados/modificados

O Dev não precisa adivinhar nada. O QA não precisa interpretar nada. O contexto completo está no arquivo.

**Analogia**: Se o vibe coding é uma conversa telefônica (informação volátil, se não anotou perdeu), o AIOX é um escritório com pastas de projeto (tudo documentado, acessível, rastreável).

### Os 11 agentes: quem faz o quê e quando

Cada agente tem um papel **exclusivo** e **bem definido**. Não existe sobreposição — se um comando pertence a um agente, nenhum outro agente tem esse comando.

#### Agentes de Planejamento (Fase 1)

| Agente | Persona | Quando usar | O que produz |
|--------|---------|-------------|-------------|
| **@analyst** | Ana | Início do projeto — pesquisar o domínio | Brief, competitive analysis, domain map |
| **@pm** | Pete | Após o brief — definir requisitos | PRD com FRs, NFRs, risk matrix, specs |
| **@architect** | Aria | Após o PRD — projetar a solução | Architecture doc, schema, API contract |
| **@ux-expert** | Uma | Junto com architect — definir UX | UX spec, wireframes, design system |

**Fluxo natural**: analyst → pm → architect + ux-expert (em paralelo ou sequência)

#### Agentes de Desenvolvimento (Fase 2)

| Agente | Persona | Quando usar | O que produz |
|--------|---------|-------------|-------------|
| **@sm** | Sam | Após planejamento — criar stories | Stories hiperdetalhadas em docs/stories/ |
| **@po** | Pia | Junto com SM — priorizar | Backlog priorizado |
| **@dev** | Dex | Após stories — implementar | Código em src/, testes em tests/ |
| **@qa** | Quinn | Após implementação — validar | Review reports, fix requests |

**Fluxo natural**: sm → dev → qa → dev (correções) → qa (verificação)

#### Agentes de Infraestrutura e Orquestração

| Agente | Persona | Quando usar | O que produz |
|--------|---------|-------------|-------------|
| **@devops** | Dex-Ops | Infra e deploy — containers, CI/CD | Dockerfiles, compose, workflows CI/CD |
| **@aiox-master** | Pax | Coordenação geral — visão macro | Orquestração de workflows |
| **@aiox-orchestrator** | Orion | Automação — executar fluxos | Execução de pipelines entre agentes |

**Quando usar**: @devops entra na fase de infraestrutura (antes ou durante desenvolvimento). @aiox-master e @aiox-orchestrator são usados para coordenar workflows complexos ou ativar squads.

### O ciclo de feedback: QA → Dev → QA

O AIOX implementa um ciclo formal de feedback entre QA e Dev que é central para a qualidade:

```
@dev implementa story
         ↓
@qa *review-build STORY-XX
         ↓
    QA encontra issues?
    ├── Sim → @qa *request-fix (com detalhes)
    │              ↓
    │         @dev *apply-qa-fix (corrige)
    │              ↓
    │         @qa *verify-fix (verifica)
    │              ↓
    │         Resolvido? → Sim: ✅ Aprovado
    │                    → Não: volta para *request-fix
    │
    └── Não → ✅ Story aprovada
```

Este ciclo garante que problemas são encontrados e corrigidos **antes** de ir para produção. O QA não é opcional — é parte estrutural do processo.

### O ADE (Autonomous Development Engine) — visão geral

O ADE é o sistema que automatiza partes do ciclo de desenvolvimento. Ele tem 7 Epics (subsistemas) que se complementam:

| Epic | Nome | O que faz |
|------|------|-----------|
| 1 | Worktree Manager | Isola cada feature em branch/diretório separado |
| 2 | Migration | Migra agentes entre versões do framework |
| 3 | Spec Pipeline | Transforma requisitos vagos em specs executáveis |
| 4 | Execution Engine | Executa specs em 13 steps com self-critique |
| 5 | Recovery System | Recupera automaticamente quando implementação falha |
| 6 | QA Evolution | Review em 10 fases estruturadas |
| 7 | Memory Layer | Persiste padrões e insights entre sessões |

No Bootcamp, vamos usar o ADE como ferramenta — ativar seus comandos nas situações certas. No Mastery, vamos mergulhar nos internals de cada Epic e entender como funcionam por dentro.

---

## Contexto

Na próxima aula (Aula 03), vamos aplicar tudo isso ao **RockQuiz** — o primeiro projeto real. Você vai ativar o @analyst pela primeira vez em um contexto real, fazer perguntas sobre o domínio de quiz de rock, e produzir o primeiro documento do pipeline (Project Brief). 

Tudo que você aprendeu aqui — fluxo em 2 fases, documentos como veículos de contexto, qual agente usar quando — vai ser exercitado na prática.

---

## Prática

### Exercício 1 — Mapear o fluxo em seus projetos

Antes de mergulhar no RockQuiz, pense nos seus projetos reais. Para cada um, identifique em qual fase do AIOX ele está:

```
Projeto: AuctionHunter
Estado atual: Tem código anterior que não funcionou
Fase AIOX: Brownfield — precisa de @architect *map-codebase antes de tudo
Primeiro agente a ativar: @analyst (entender por que falhou antes)

Projeto: LinkedIn Automation
Estado atual: Protótipo no Google AI Studio
Fase AIOX: Brownfield — precisa migrar para arquitetura independente
Primeiro agente a ativar: @architect (mapear o que existe)

Projeto: Plataforma Zabbix Learning
Estado atual: Ideia na cabeça, zero código
Fase AIOX: Greenfield total — começa com @analyst
Primeiro agente a ativar: @analyst (pesquisa de domínio profunda)

Projeto: RockQuiz
Estado atual: Ideia definida, zero código
Fase AIOX: Greenfield — começa com @analyst
Primeiro agente a ativar: @analyst (brief + domain map)
```

Faça este mapeamento mental agora. Não precisa escrever um documento formal — apenas visualize qual agente seria o primeiro a ativar em cada projeto e por quê.

### Exercício 2 — Simular o pipeline com um agente

Vamos fazer um exercício rápido de simulação. Ative o @analyst e peça uma análise exploratória de um dos seus projetos — não para produzir o documento final, mas para sentir como é o human-in-the-loop:

```bash
cd ~/aiox-bootcamp/rockquiz
claude
```

```
@analyst

Ana, quero te dar uma visão geral de um projeto que vou desenvolver 
nas próximas aulas. É um quiz interativo sobre conhecimentos de rock.
O jogador responde perguntas, acumula pontos e compete em ranking.

Antes de criar qualquer documento, me faça 5 perguntas que você 
considera essenciais para entender bem o projeto.
```

Observe o que acontece:

- O Analyst faz perguntas **relevantes e específicas** (não genéricas)
- As perguntas são sobre o domínio (rock, quiz), não sobre tecnologia
- Cada resposta sua vai influenciar o que o Analyst produz depois

Responda as 5 perguntas com o que sabe. Não precisa ser perfeito — o objetivo é sentir o processo, não produzir output final.

Depois de responder:

```
Ana, obrigado. Não precisa gerar nenhum documento agora — vamos 
fazer isso formalmente na próxima aula. Era só para aquecer.

*exit
```

> **🏆 Checkpoint**: Você experimentou o human-in-the-loop com o @analyst.

### Exercício 3 — Comparar agentes

Ative dois agentes diferentes e peça a mesma coisa para ambos. Observe como cada um responde de forma diferente baseado no seu papel:

```
@dev
Dex, o que você precisa para implementar um sistema de quiz com ranking?
*exit

@architect
Aria, o que você precisa para projetar um sistema de quiz com ranking?
*exit
```

O Dev vai falar sobre código, bibliotecas, implementação. O Architect vai falar sobre componentes, comunicação entre serviços, padrões, trade-offs. **Mesma pergunta, perspectivas completamente diferentes** — é isso que torna o sistema de agentes especializados poderoso.

> **🏆 Checkpoint**: Você viu como agentes diferentes interpretam o mesmo problema.

### Exercício 4 — Validação e verificação de integridade

Rode os comandos de validação disponíveis para garantir que sua instalação está íntegra:

```bash
# Verificar saúde geral
npx aiox-core doctor

# Verificar estrutura de diretórios
ls .aiox-core/development/agents/ | wc -l
# Esperado: 11 arquivos (1 por agente)

# Verificar que os templates existem
ls .aiox-core/product/templates/

# Verificar que os checklists existem
ls .aiox-core/product/checklists/

# Se disponível, validar integração da IDE
npm run validate:claude-sync 2>/dev/null || echo "Comando não disponível"
```

> **🏆 Checkpoint 4**: Validação de integridade executada.

---

## Reflexão

### O que você construiu nesta aula

Não código — algo mais valioso: um **modelo mental** de como o AIOX funciona. Você agora sabe:

- Que o AIOX opera em 2 fases (planejamento → desenvolvimento) conectadas por documentos
- Que cada agente tem papel exclusivo com comandos únicos
- Que o contexto vive em arquivos (`docs/`) e não em memória de conversa
- Que o QA tem ciclo formal de feedback com o Dev
- Que o ADE automatiza partes do processo com 7 subsistemas
- Qual agente ativar primeiro dependendo do estado do projeto (greenfield vs brownfield)

### O conceito-chave desta aula

> **No AIOX, documentos são mais importantes que código. O código é consequência de bons documentos — nunca o contrário.**

Se o briefing for ruim, o PRD será ruim. Se o PRD for ruim, a arquitetura será ruim. Se a arquitetura for ruim, as stories serão ruins. Se as stories forem ruins, o código será ruim. A qualidade flui de cima para baixo. É por isso que investir tempo no planejamento (Fase 1) é o melhor investimento que você pode fazer.

### Conexão com a próxima aula

Na Aula 03, o aprendizado conceitual encontra a prática real. Vamos iniciar o **RockQuiz** ativando o @analyst para pesquisa profunda e o @pm para criar o PRD. Pela primeira vez, você vai produzir documentos de especificação reais que vão guiar o desenvolvimento nas aulas seguintes.

A partir de agora, **cada aula produz output real** — documentos, código, testes, infraestrutura. O período conceitual acabou.

---

## Exercício extra (opcional)

Se quiser ir mais fundo antes da Aula 03:

1. Leia o guia oficial do AIOX: `docs/guides/user-guide.md` no repositório (se disponível no seu projeto).

2. Explore os `docs/GUIDING-PRINCIPLES.md` — são os princípios que vamos seguir durante todo o curso.

3. Pense no seu projeto mais complexo (Plataforma Zabbix Learning) e liste mentalmente: quais seriam os 5 maiores riscos técnicos? Qual agente do AIOX ajudaria a identificar cada risco? (Dica: @analyst para riscos de domínio, @architect para riscos técnicos, @pm para riscos de escopo.)

---

> **Anterior**: [Aula 01 — Setup e Anatomia](./aula-01-setup-anatomia.md)
> **Próxima aula**: [Aula 03 — Analyst + PM: Do Conceito ao PRD](../modulo-02/aula-03-analyst-pm.md)
5:["lesson","aula-02-conceitos-fluxo","d"]
0:["0aCmzVh17xjX8k-qFi6hn",[[["",{"children":["bootcamp",{"children":[["lesson","aula-02-conceitos-fluxo","d"],{"children":["__PAGE__?{\"lesson\":\"aula-02-conceitos-fluxo\"}",{}]}]}]},"$undefined","$undefined",true],["",{"children":["bootcamp",{"children":[["lesson","aula-02-conceitos-fluxo","d"],{"children":["__PAGE__",{},[["$L1",["$","$L2",null,{"content":"$3","lessonSlug":"aula-02-conceitos-fluxo","module":"bootcamp","lessonIndex":1,"totalLessons":18,"nextLesson":"aula-03-analyst-pm","prevLesson":"aula-01-setup-anatomia"}],null],null],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","bootcamp","children","$5","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","bootcamp","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[[[["$","link","0",{"rel":"stylesheet","href":"/_next/static/css/71d217bb04404cb9.css","precedence":"next","crossOrigin":"$undefined"}]],["$","html",null,{"lang":"pt-BR","children":["$","body",null,{"className":"bg-white dark:bg-slate-900 text-gray-900 dark:text-gray-100 transition-colors","children":["$","$L7",null,{"children":["$","div",null,{"className":"flex h-screen overflow-hidden","children":[["$","$L8",null,{}],["$","div",null,{"className":"flex-1 flex flex-col overflow-hidden","children":[["$","$L9",null,{}],["$","main",null,{"className":"flex-1 overflow-y-auto bg-white dark:bg-slate-900 transition-colors","children":["$","div",null,{"className":"max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8","children":["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":[["$","title",null,{"children":"404: This page could not be found."}],["$","div",null,{"style":{"fontFamily":"system-ui,\"Segoe UI\",Roboto,Helvetica,Arial,sans-serif,\"Apple Color Emoji\",\"Segoe UI Emoji\"","height":"100vh","textAlign":"center","display":"flex","flexDirection":"column","alignItems":"center","justifyContent":"center"},"children":["$","div",null,{"children":[["$","style",null,{"dangerouslySetInnerHTML":{"__html":"body{color:#000;background:#fff;margin:0}.next-error-h1{border-right:1px solid rgba(0,0,0,.3)}@media (prefers-color-scheme:dark){body{color:#fff;background:#000}.next-error-h1{border-right:1px solid rgba(255,255,255,.3)}}"}}],["$","h1",null,{"className":"next-error-h1","style":{"display":"inline-block","margin":"0 20px 0 0","padding":"0 23px 0 0","fontSize":24,"fontWeight":500,"verticalAlign":"top","lineHeight":"49px"},"children":"404"}],["$","div",null,{"style":{"display":"inline-block"},"children":["$","h2",null,{"style":{"fontSize":14,"fontWeight":400,"lineHeight":"49px","margin":0},"children":"This page could not be found."}]}]]}]}]],"notFoundStyles":[]}]}]}]]}]]}]}]}]}]],null],null],["$La",null]]]]
a:[["$","meta","0",{"name":"viewport","content":"width=device-width, initial-scale=1"}],["$","meta","1",{"charSet":"utf-8"}],["$","title","2",{"children":"AIOX Course Platform | Professional Bootcamp & Mastery"}],["$","meta","3",{"name":"description","content":"Learn AIOX - AI-Orchestrated System for Full Stack Development. Complete bootcamp and mastery courses with hands-on projects."}],["$","meta","4",{"name":"keywords","content":"AIOX,AI Development,Full Stack,Course,Bootcamp,Learning"}]]
1:null
