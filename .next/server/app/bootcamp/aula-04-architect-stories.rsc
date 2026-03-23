2:I[4817,["972","static/chunks/972-435ad046c10f8479.js","552","static/chunks/552-ca913c8f5aa11d94.js","188","static/chunks/app/bootcamp/%5Blesson%5D/page-3b4cd11983f1559e.js"],"LessonRenderer"]
4:I[4707,[],""]
6:I[6423,[],""]
7:I[872,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"ThemeProvider"]
8:I[3021,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Sidebar"]
9:I[8680,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Header"]
3:T2be7,# Aula 04 — Architect + UX + SM: Da Especificação às Stories

<!-- metadata
module: 2
lesson: 4
title: "Architect + UX + SM: Da Especificação às Stories"
duration: 3-4 horas
agents: "@architect, @ux-expert, @sm, @po"
project: RockQuiz
phase: Planejamento (Fase 1) → Transição para Fase 2
prerequisites: Aula 03 concluída (docs/prd.md existe)
-->

---

> **Módulo 2** · RockQuiz: Pipeline Completo
> **Duração**: 3-4 horas
> **Agentes praticados**: `@architect`, `@ux-expert`, `@sm`, `@po`
> **Projeto**: RockQuiz

---

## 🏆 Vitória desta aula

Architecture Doc + UX Spec + stories hiperdetalhadas prontas para implementação. Ao final, qualquer Dev poderia abrir uma story e implementar sem perguntas adicionais.

**Critério binário**: `docs/architecture.md` + `docs/ux-spec.md` + pelo menos 6 stories em `docs/stories/`.

---

## Conceito

### O Architect transforma "O QUÊ" em "COMO"

O Analyst disse o que o problema é. O PM disse o que a solução faz. O @architect diz **como** a solução é construída. Ele pega requisitos e os transforma em decisões técnicas: stack, schema de banco, endpoints de API, padrões de código, estratégia de cache.

A diferença entre um Architecture Doc bom e um ruim: **trade-offs documentados**. Não basta listar tecnologias — é preciso justificar cada escolha e registrar o que foi considerado e descartado.

### O SM traduz documentos em tarefas

O @sm (Scrum Master) é a ponte entre planejamento e código. Ele lê **todos** os documentos e os transforma em stories hiperdetalhadas — arquivos que contêm absolutamente tudo que o Dev precisa: o quê entregar (acceptance criteria testáveis), como implementar (detalhes técnicos), e por quê assim (decisões arquiteturais).

### Nesta aula: descreva necessidades, avalie propostas

Você vai dizer ao Architect "preciso de uma arquitetura para 5 serviços containerizados com banco relacional e cache" — **não** vai ditar o schema, os endpoints ou os padrões. O Architect propõe, você avalia, refina até estar satisfeito.

---

## Contexto

Esta aula completa a Fase 1 (planejamento) e transiciona para a Fase 2 (desenvolvimento). O Architect e o SM produzem os últimos documentos antes de começar a codificar. A qualidade desses documentos determina a qualidade de tudo que vem depois.

---

## Prática

### Passo 1 — Architect avalia complexidade

```bash
cd ~/aiox-bootcamp/rockquiz
claude
```

```
@architect

Aria, leia os documentos que o Analyst e o PM produziram:
- docs/project-brief.md
- docs/domain-map.md
- docs/prd.md

Quero que você avalie a complexidade técnica desse projeto 
antes de projetar a arquitetura. Considere: número de serviços, 
complexidade da lógica de negócio, necessidades de cache e 
real-time, e a infraestrutura de deploy.

*assess-complexity
```

**Como avaliar**: O Architect deve classificar a complexidade e identificar pontos de atenção. Se ele classificar como "simples" sem mencionar a lógica de scoring ou a estratégia de cache para ranking, questione:

```
Aria, você classificou como complexidade baixa, mas o sistema 
de scoring tem multiplicadores que dependem de tempo real e streak.
E o ranking precisa ser atualizado em tempo real para múltiplos 
jogadores. Isso não adiciona complexidade?
```

---

### Passo 2 — Gerar o Architecture Doc

Descreva **o que precisa** — não **como fazer**:

```
Aria, projete a arquitetura completa do RockQuiz baseada no PRD.

Preciso de:
- Uma API REST performante que suporte o gameplay em tempo real
- Um banco de dados relacional para perguntas, jogos e jogadores
- Cache para rankings (precisa ser rápido e atualizar em tempo real)
- Frontend com server-side rendering para SEO e performance
- Tudo containerizado para desenvolvimento e produção
- Observabilidade (saber quando algo está errado em produção)

Decida a stack, o schema do banco, os endpoints, os padrões 
de código e a estratégia de cache. Justifique cada decisão — 
quero saber por que escolheu cada tecnologia e o que descartou.

Salve em docs/architecture.md
```

Note: **não listamos as tecnologias** (Fastify, PostgreSQL, Redis). O Architect pode recomendar essas ou outras. O valor está na justificativa e nos trade-offs — se ele escolher Express em vez de Fastify, precisa explicar por quê.

**Como avaliar o Architecture Doc gerado:**

> **Checklist de avaliação**
> - [ ] Cada tecnologia tem justificativa com trade-off (não apenas nome)?
> - [ ] O schema do banco cobre todas as entidades do Domain Map?
> - [ ] Os endpoints cobrem todos os requisitos funcionais do PRD?
> - [ ] A estratégia de cache é clara (o que cachear, quanto tempo, quando invalidar)?
> - [ ] Os padrões de código são específicos (naming, error handling, estrutura)?
> - [ ] A estratégia de testes está definida?

Se algo estiver incompleto, peça ajuste **descrevendo a lacuna**, não a solução:

```
Aria, o Architecture Doc não menciona como lidar com o 
caso de o cache estar indisponível. O que acontece com o 
ranking se o Redis cair? Preciso de uma estratégia de 
fallback.
```

```
Aria, os padrões de código estão genéricos demais. Preciso 
que um dev novo no projeto saiba: como nomear arquivos, como 
estruturar um endpoint, como tratar erros, e onde colocar 
lógica de negócio. Detalhe mais.
```

> **🏆 Checkpoint 1**: `docs/architecture.md` com stack justificada, schema, endpoints e padrões.

---

### Passo 3 — Gerar contexto para os Devs

```
*create-context

Aria, gere um documento de contexto técnico que o Dev vai 
consultar durante a implementação. Deve incluir: as decisões 
mais importantes resumidas, armadilhas que você antecipa, 
e referências às seções relevantes do Architecture Doc.
```

---

### Passo 4 — UX Spec

```
*exit

@ux-expert

Uma, leia o PRD (docs/prd.md) e o Architecture Doc 
(docs/architecture.md) e projete a experiência do usuário 
do RockQuiz.

O jogo precisa ser visualmente atraente (tema rock/dark), 
dar feedback imediato a cada resposta (acertou/errou com 
explicação), ter um senso de progressão e urgência (timer, 
streak, pontuação subindo), e funcionar bem em mobile e desktop.

Preciso de:
- O fluxo completo do usuário (de entrar no site até ver o ranking)
- Como cada tela deve funcionar e se comportar
- Cores, tipografia e identidade visual
- Como mostrar feedback de acerto/erro de forma satisfatória
- Como funciona a gamificação visual (streak, timer, score)
- Considerações de acessibilidade

Salve em docs/ux-spec.md
```

**Note**: Não prescrevemos cores hex, não listamos componentes, não definimos breakpoints. A UX Expert sabe o que um quiz game precisa. Se o resultado não tiver acessibilidade ou responsividade, refinamos:

```
Uma, o UX spec não menciona como o quiz funciona no mobile. 
Em telas pequenas, 4 alternativas em grid 2x2 podem ficar 
apertadas. Como resolver?
```

> **🏆 Checkpoint 2**: `docs/ux-spec.md` com UX completo.

---

### Passo 5 — Revisão cruzada

Antes de criar stories, garanta que os documentos são consistentes:

```
*exit

@architect

Aria, faça uma revisão cruzada:
- O PRD (docs/prd.md) define requisitos que a arquitetura 
  (docs/architecture.md) não cobre?
- A arquitetura tem algo que não está nos requisitos?
- Os NFRs são viáveis com a stack escolhida?
- O UX spec é implementável com a stack escolhida?

Se encontrar inconsistências, corrija.
```

**Por que este passo existe**: Inconsistências entre documentos são bombas-relógio. Se o PRD diz "ranking atualiza em tempo real" mas a arquitetura não tem WebSocket nem cache, o Dev vai descobrir isso no meio da implementação — quando é 10x mais caro corrigir.

---

### Passo 6 — SM cria stories

Agora a transição: o SM lê todos os documentos e cria tarefas implementáveis.

```
*exit

@sm

Sam, leia todos os documentos de planejamento:
- docs/project-brief.md
- docs/domain-map.md
- docs/prd.md
- docs/architecture.md
- docs/ux-spec.md

Crie stories para o desenvolvimento do RockQuiz. Cada story deve 
conter tudo que o Dev precisa para implementar sem perguntas:
- O que entregar (critérios testáveis)
- Como implementar (detalhes técnicos baseados no Architecture Doc)
- Por que fazer assim (decisões relevantes)
- Quais arquivos criar ou modificar
- Quais testes são esperados
- Estimativa de complexidade

Organize as stories por ordem de dependência — o que precisa 
existir antes do que.

Salve cada story em docs/stories/STORY-XX.md
```

**Note**: Não listamos as stories específicas (STORY-01: Setup, STORY-02: CRUD...). O SM sabe como decompor um projeto — faz parte do seu papel. Ele vai ler a arquitetura e decidir a melhor decomposição. Se a decomposição não fizer sentido, refinamos:

```
Sam, você colocou frontend e backend na mesma story. Isso 
é muito grande — um dev não vai conseguir implementar tudo 
de uma vez. Quebre em stories menores: uma para API, outra 
para frontend.
```

**Como avaliar cada story:**

> **Checklist de qualidade de story**
> - [ ] Tem critérios de aceitação testáveis (não vagos)?
> - [ ] Tem detalhes de implementação (não apenas "faça o CRUD")?
> - [ ] Referencia decisões do Architecture Doc quando relevante?
> - [ ] Tem lista de arquivos a criar/modificar?
> - [ ] Tem seção de testes esperados?
> - [ ] É pequena o suficiente para ser implementada em uma sessão?
> - [ ] Um Dev que leia APENAS esta story (sem ler o PRD) sabe o que fazer?

A última pergunta é o teste definitivo.

---

### Passo 7 — PO prioriza

```
*exit

@po

Pia, revise as stories em docs/stories/ e defina a ordem 
de implementação. Considere: dependências técnicas, valor 
para o MVP e risco técnico.
```

> **🏆 Checkpoint 3 — VITÓRIA DA AULA**: Stories priorizadas em docs/stories/.

---

### Passo 8 — Verificar estado completo

```bash
*exit
ls -la docs/
ls -la docs/stories/
```

Você deve ter ~7 documentos + 6-8 stories — todo o contexto para construir o RockQuiz, produzido por 6 agentes.

---

## Reflexão

### O padrão que emergiu

Em todas as interações com agentes nesta aula, o padrão foi o mesmo:

1. **Descrever a necessidade**: "preciso de uma arquitetura para..."
2. **Agente propõe**: gera documento/solução
3. **Avaliar criticamente**: "faltou X", "Y está vago", "Z é inconsistente"
4. **Refinar**: agente ajusta baseado no feedback
5. **Validar**: checklist de qualidade confirma completude

Esse padrão se repete em TODA interação com AIOX — planejamento, desenvolvimento, testes, deploy. Domine o padrão e você domina o framework.

### O conceito-chave

> **O SM é a ponte entre documentos e código. Ele garante que NENHUM contexto se perde na transição — tudo que os agentes de planejamento decidiram está nas stories que o Dev vai implementar.**

### Conexão com a próxima aula

Na Aula 05, o @devops entra para criar a infraestrutura. Você vai descrever suas necessidades de ambiente (desenvolvimento e produção) e o DevOps vai propor e implementar a solução containerizada.

---

> **Anterior**: [Aula 03 — Analyst + PM](./aula-03-analyst-pm.md)
> **Próxima**: [Aula 05 — DevOps: Infra do RockQuiz](./aula-05-devops-infra.md)
5:["lesson","aula-04-architect-stories","d"]
0:["0aCmzVh17xjX8k-qFi6hn",[[["",{"children":["bootcamp",{"children":[["lesson","aula-04-architect-stories","d"],{"children":["__PAGE__?{\"lesson\":\"aula-04-architect-stories\"}",{}]}]}]},"$undefined","$undefined",true],["",{"children":["bootcamp",{"children":[["lesson","aula-04-architect-stories","d"],{"children":["__PAGE__",{},[["$L1",["$","$L2",null,{"content":"$3","lessonSlug":"aula-04-architect-stories","module":"bootcamp","lessonIndex":3,"totalLessons":18,"nextLesson":"aula-05-devops-infra","prevLesson":"aula-03-analyst-pm"}],null],null],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","bootcamp","children","$5","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","bootcamp","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[[[["$","link","0",{"rel":"stylesheet","href":"/_next/static/css/71d217bb04404cb9.css","precedence":"next","crossOrigin":"$undefined"}]],["$","html",null,{"lang":"pt-BR","children":["$","body",null,{"className":"bg-white dark:bg-slate-900 text-gray-900 dark:text-gray-100 transition-colors","children":["$","$L7",null,{"children":["$","div",null,{"className":"flex h-screen overflow-hidden","children":[["$","$L8",null,{}],["$","div",null,{"className":"flex-1 flex flex-col overflow-hidden","children":[["$","$L9",null,{}],["$","main",null,{"className":"flex-1 overflow-y-auto bg-white dark:bg-slate-900 transition-colors","children":["$","div",null,{"className":"max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8","children":["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":[["$","title",null,{"children":"404: This page could not be found."}],["$","div",null,{"style":{"fontFamily":"system-ui,\"Segoe UI\",Roboto,Helvetica,Arial,sans-serif,\"Apple Color Emoji\",\"Segoe UI Emoji\"","height":"100vh","textAlign":"center","display":"flex","flexDirection":"column","alignItems":"center","justifyContent":"center"},"children":["$","div",null,{"children":[["$","style",null,{"dangerouslySetInnerHTML":{"__html":"body{color:#000;background:#fff;margin:0}.next-error-h1{border-right:1px solid rgba(0,0,0,.3)}@media (prefers-color-scheme:dark){body{color:#fff;background:#000}.next-error-h1{border-right:1px solid rgba(255,255,255,.3)}}"}}],["$","h1",null,{"className":"next-error-h1","style":{"display":"inline-block","margin":"0 20px 0 0","padding":"0 23px 0 0","fontSize":24,"fontWeight":500,"verticalAlign":"top","lineHeight":"49px"},"children":"404"}],["$","div",null,{"style":{"display":"inline-block"},"children":["$","h2",null,{"style":{"fontSize":14,"fontWeight":400,"lineHeight":"49px","margin":0},"children":"This page could not be found."}]}]]}]}]],"notFoundStyles":[]}]}]}]]}]]}]}]}]}]],null],null],["$La",null]]]]
a:[["$","meta","0",{"name":"viewport","content":"width=device-width, initial-scale=1"}],["$","meta","1",{"charSet":"utf-8"}],["$","title","2",{"children":"AIOX Course Platform | Professional Bootcamp & Mastery"}],["$","meta","3",{"name":"description","content":"Learn AIOX - AI-Orchestrated System for Full Stack Development. Complete bootcamp and mastery courses with hands-on projects."}],["$","meta","4",{"name":"keywords","content":"AIOX,AI Development,Full Stack,Course,Bootcamp,Learning"}]]
1:null
