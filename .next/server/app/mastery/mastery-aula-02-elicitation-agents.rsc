2:I[4817,["972","static/chunks/972-435ad046c10f8479.js","552","static/chunks/552-ca913c8f5aa11d94.js","460","static/chunks/app/mastery/%5Blesson%5D/page-19f8ee117e5859d3.js"],"LessonRenderer"]
4:I[4707,[],""]
6:I[6423,[],""]
7:I[872,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"ThemeProvider"]
8:I[3021,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Sidebar"]
9:I[8680,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Header"]
3:T2b8b,# Aula 02 — Elicitação, Workflow Intelligence e Definição de Agentes

<!-- metadata
course: Mastery
module: 1
lesson: 2
title: "Elicitação, Workflow Intelligence e Definição de Agentes"
duration: 3-4 horas
agents: "agente custom @zabbix-expert (criado nesta aula)"
project: Plataforma Zabbix Learning
phase: Configuração
prerequisites: Aula 01 concluída (mapa do .aiox-core/ + preset)
-->

---

> **Módulo 1** · AIOX Internals
> **Duração**: 3-4 horas
> **Agentes praticados**: Agente customizado `@zabbix-expert` (criado nesta aula)
> **Projeto**: Plataforma Zabbix Learning

---

## 🏆 Vitória desta aula

Agente custom `@zabbix-expert` criado no formato autoClaude V3 e funcional, sistema de elicitação customizado para o domínio Zabbix, e Workflow Intelligence explorado com decisões documentadas.

**Critério binário**: `@zabbix-expert *help` retorna comandos customizados + elicitação faz perguntas específicas sobre Zabbix + Workflow Intelligence documentado em `docs/workflow-intelligence.md`.

---

## Conceito

### Agentes customizados: além dos 11 core

Os 11 agentes core do AIOX cobrem o pipeline genérico de desenvolvimento. Mas a Plataforma Zabbix tem necessidades que nenhum agente core atende: gerar conteúdo educacional sobre Zabbix com precisão técnica, validar configurações contra a documentação oficial, e planejar exercícios práticos em ambientes Zabbix reais.

O `@zabbix-expert` é um agente de domínio — ele sabe Zabbix como o @analyst sabe pesquisa e o @dev sabe código. Na Plataforma Zabbix, ele vai participar de múltiplos subsistemas: Content Engine (gerar aulas), Quiz Engine (gerar perguntas), Lab Provisioner (projetar exercícios).

### Elicitação: como agentes fazem perguntas inteligentes

Quando você chama `@analyst *research-domain`, o Analyst não pula direto para a pesquisa. Primeiro, ele faz **perguntas de esclarecimento** — elicitação. Essas perguntas são governadas pelo sistema de elicitação em `.aiox-core/`.

A elicitação padrão é genérica. Para a Plataforma Zabbix, você quer perguntas específicas: "Qual versão do Zabbix a plataforma vai cobrir?", "O conteúdo deve seguir a estrutura da documentação oficial ou uma estrutura pedagógica própria?", "Os labs práticos usam Zabbix Server ou Zabbix Proxy?"

### Workflow Intelligence: o motor de decisão

O Workflow Intelligence é o sistema que decide automaticamente qual workflow aplicar baseado no contexto. Quando você diz "preciso de uma nova feature", ele decide: usar o ADE Spec Pipeline? Direto para o Dev? Precisa de Architect review? Essas decisões são configuráveis — e para um projeto da escala da Plataforma Zabbix, os defaults não são suficientes.

---

## Prática

### Passo 1 — Explorar definições de agentes existentes

Antes de criar, entenda o formato:

```bash
cd ~/aiox-mastery/zabbix-platform

# Examinar um agente core em detalhe
cat .aiox-core/agents/analyst.md

# Examinar outro para comparar formato
cat .aiox-core/agents/dev.md

# Verificar se existe documentação sobre formato V3
find .aiox-core/ -name "*.md" | xargs grep -l "autoClaude\|V3\|agent format" 2>/dev/null
```

Documente o formato que encontrar:

> **Checklist de entendimento do formato de agente**
> - [ ] Quais campos são obrigatórios? (name, role, commands...)
> - [ ] Como os comandos são declarados?
> - [ ] Onde fica a system prompt / personality do agente?
> - [ ] Como um agente referencia outros agentes?
> - [ ] Como um agente acessa knowledge base?

---

### Passo 2 — Criar @zabbix-expert

Crie o agente baseado no formato que explorou:

```bash
claude
```

```
Preciso criar um agente customizado chamado @zabbix-expert 
para a Plataforma Zabbix Learning.

Com base no formato autoClaude V3 que encontrei em 
.aiox-core/agents/, crie o agente com:

ROLE: Especialista em Zabbix com 15+ anos de experiência. 
Conhece a documentação oficial profundamente. Sabe traduzir 
conceitos complexos para linguagem acessível. Domina:
- Instalação e configuração (Server, Proxy, Agent, Agent2)
- Monitoramento (items, triggers, discovery, templates)
- Automação (API, scripts, webhooks, actions)
- Arquitetura (HA, partitioning, proxy distribution)
- Troubleshooting (performance, logs, capacity planning)

COMMANDS:
- *generate-lesson: Gerar aula sobre um conceito Zabbix 
  (input: conceito, nível, formato)
- *generate-quiz: Gerar pergunta de quiz com 4 alternativas 
  (input: tema, dificuldade)
- *design-lab: Projetar exercício prático com configuração 
  Zabbix (input: objetivo, nível, duração)
- *validate-config: Validar se uma configuração Zabbix está 
  correta contra a documentação
- *explain-concept: Explicar um conceito com analogia e 
  exemplo prático

KNOWLEDGE BASE: 
- Documentação oficial do Zabbix (referenciada, não embutida)
- Best practices de monitoramento enterprise
- Patterns de configuração para diferentes escalas

Salve em .aiox-core/agents/zabbix-expert.md no formato V3.
```

**Como verificar**:

```bash
# Verificar que o arquivo existe e está no formato correto
cat .aiox-core/agents/zabbix-expert.md

# Tentar usar o agente
@zabbix-expert *help

# Testar um comando
@zabbix-expert *explain-concept "Zabbix LLD (Low-Level Discovery)"
```

> **Checklist de avaliação do agente**
> - [ ] Arquivo segue o formato V3 (mesma estrutura dos agentes core)?
> - [ ] `*help` lista os 5 comandos customizados?
> - [ ] `*explain-concept` gera explicação com profundidade técnica?
> - [ ] `*generate-quiz` gera pergunta que um Zabbix Expert consideraria boa?
> - [ ] `*design-lab` gera exercício com configuração Zabbix real?
> - [ ] O agente referencia documentação oficial (não inventa features)?

Se o agente gerar conteúdo genérico:

```
O @zabbix-expert gerou uma explicação de LLD que poderia 
ser sobre qualquer ferramenta de discovery. Preciso de 
especificidade Zabbix: menção a discovery rules, item 
prototypes, trigger prototypes, host prototypes. Exemplos 
com macros como {#FSNAME}, {#IFNAME}. O agente é um 
EXPERT, não um generalista.
```

Se o formato não bater com V3:

```
O arquivo não segue o formato dos agentes core. Compare 
com .aiox-core/agents/analyst.md — as seções devem ser 
as mesmas. Adapte o conteúdo para o formato V3 correto.
```

> **🏆 Checkpoint 1**: @zabbix-expert funcional com 5 comandos customizados.

---

### Passo 3 — Customizar elicitação

O sistema de elicitação determina quais perguntas os agentes fazem antes de executar. Configure para o domínio Zabbix:

```bash
# Encontrar onde elicitação é configurada
find .aiox-core/ -name "*elicit*" -o -name "*question*" | head -20
cat .aiox-core/[caminho que encontrar]
```

```
Preciso customizar o sistema de elicitação para a 
Plataforma Zabbix. Quando o @analyst pesquisa domínio 
para esta plataforma, as perguntas de esclarecimento 
devem incluir:

- Qual versão do Zabbix cobrir? (6.0 LTS, 6.4, 7.0?)
- Conteúdo segue estrutura da doc oficial ou pedagógica?
- Labs usam Server, Proxy ou Agent standalone?
- Público-alvo: iniciantes, intermediários ou certificação?
- Idioma do conteúdo: PT-BR, EN, ambos?

Quando o @zabbix-expert gera aulas, deve perguntar:
- Nível do aluno (conceitos → configuração → automação → API)
- Formato (texto, vídeo script, hands-on lab)
- Duração estimada da aula
- Pré-requisitos assumidos

Configure no local correto do .aiox-core/ para que 
essas perguntas sejam feitas automaticamente.
```

> **Checklist de avaliação da elicitação**
> - [ ] Perguntas customizadas estão no local correto?
> - [ ] Ao chamar `@analyst *research-domain`, as perguntas Zabbix aparecem?
> - [ ] Ao chamar `@zabbix-expert *generate-lesson`, as perguntas de aula aparecem?
> - [ ] As perguntas são específicas (não genéricas)?

> **🏆 Checkpoint 2**: Elicitação customizada funcionando.

---

### Passo 4 — Explorar e documentar Workflow Intelligence

```bash
# Localizar o workflow intelligence
find .aiox-core/ -path "*workflow*intelligence*" -o -path "*workflow*decision*"
cat .aiox-core/[caminho encontrado]
```

```
Explore o Workflow Intelligence do AIOX e documente:

1. Como o sistema decide qual workflow aplicar?
2. Quais inputs o motor de decisão usa?
3. Quais decisões são automáticas vs humanas?
4. Como customizar as regras de decisão para a 
   Plataforma Zabbix?

Exemplo: quando eu digo "preciso de uma nova feature 
para o Content Engine", o Workflow Intelligence deve 
decidir automaticamente que isso requer ADE Spec Pipeline 
(porque é um subsistema complexo), não implementação 
direta pelo Dev.

Documente em docs/workflow-intelligence.md com:
- Mapeamento das regras de decisão existentes
- Regras customizadas para a Plataforma Zabbix
- Fluxograma de decisão
```

> **Checklist de avaliação**
> - [ ] O motor de decisão foi identificado e documentado?
> - [ ] As regras de decisão estão mapeadas?
> - [ ] Há proposta de customização para a Plataforma Zabbix?
> - [ ] O fluxograma mostra o caminho de decisão?

> **🏆 Checkpoint 3 — VITÓRIA DA AULA**: Agente custom + elicitação + Workflow Intelligence documentados.

---

### Passo 5 — Commit

```bash
*exit

git add .
git commit -m "feat: custom @zabbix-expert agent, elicitation, and workflow intelligence

- @zabbix-expert agent in autoClaude V3 format (5 custom commands)
- Custom elicitation questions for Zabbix domain
- Workflow Intelligence analysis and customization plan
- Documentation of decision engine for Zabbix Platform context"
```

---

## Reflexão

### O poder do agente de domínio

O @zabbix-expert é qualitativamente diferente dos agentes core. Os agentes core sabem *como* trabalhar (pesquisar, especificar, implementar, testar). O @zabbix-expert sabe *sobre o quê* trabalhar (Zabbix: conceitos, configurações, troubleshooting, API). Quando os dois trabalham juntos, o resultado é superior: @analyst pesquisa + @zabbix-expert valida a profundidade técnica.

Na Plataforma Zabbix, o @zabbix-expert participa de quase tudo: valida aulas geradas pelo Content Engine, gera quizzes para o Quiz Engine, projeta labs para o Lab Provisioner, e verifica configurações. Sem ele, cada agente core improvisaria sobre Zabbix. Com ele, há um especialista dedicado.

### O conceito-chave

> **Agentes customizados no formato V3 estendem o AIOX para domínios específicos sem alterar o core. O @zabbix-expert não substitui nenhum agente — ele complementa todos. Elicitação customizada garante que as perguntas são relevantes para o domínio. Workflow Intelligence garante que as decisões refletem a complexidade do projeto.**

### Conexão com a próxima aula

Na Aula 03, você cria tasks, workflows YAML e checklists customizados para a Plataforma Zabbix. O @zabbix-expert criado aqui será referenciado nos workflows — é a peça que faltava entre "agente de domínio" e "processo customizado".

---

> **Anterior**: [Aula 01 — Por Dentro do .aiox-core/](./aula-01-internals.md)
> **Próxima**: [Aula 03 — Tasks, Workflows YAML e Customização Avançada](./aula-03-tasks-workflows.md)
5:["lesson","mastery-aula-02-elicitation-agents","d"]
0:["0aCmzVh17xjX8k-qFi6hn",[[["",{"children":["mastery",{"children":[["lesson","mastery-aula-02-elicitation-agents","d"],{"children":["__PAGE__?{\"lesson\":\"mastery-aula-02-elicitation-agents\"}",{}]}]}]},"$undefined","$undefined",true],["",{"children":["mastery",{"children":[["lesson","mastery-aula-02-elicitation-agents","d"],{"children":["__PAGE__",{},[["$L1",["$","$L2",null,{"content":"$3","lessonSlug":"mastery-aula-02-elicitation-agents","module":"mastery","lessonIndex":1,"totalLessons":22,"nextLesson":"mastery-aula-03-tasks-workflows","prevLesson":"mastery-aula-01-internals"}],null],null],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","mastery","children","$5","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","mastery","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[[[["$","link","0",{"rel":"stylesheet","href":"/_next/static/css/71d217bb04404cb9.css","precedence":"next","crossOrigin":"$undefined"}]],["$","html",null,{"lang":"pt-BR","children":["$","body",null,{"className":"bg-white dark:bg-slate-900 text-gray-900 dark:text-gray-100 transition-colors","children":["$","$L7",null,{"children":["$","div",null,{"className":"flex h-screen overflow-hidden","children":[["$","$L8",null,{}],["$","div",null,{"className":"flex-1 flex flex-col overflow-hidden","children":[["$","$L9",null,{}],["$","main",null,{"className":"flex-1 overflow-y-auto bg-white dark:bg-slate-900 transition-colors","children":["$","div",null,{"className":"max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8","children":["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":[["$","title",null,{"children":"404: This page could not be found."}],["$","div",null,{"style":{"fontFamily":"system-ui,\"Segoe UI\",Roboto,Helvetica,Arial,sans-serif,\"Apple Color Emoji\",\"Segoe UI Emoji\"","height":"100vh","textAlign":"center","display":"flex","flexDirection":"column","alignItems":"center","justifyContent":"center"},"children":["$","div",null,{"children":[["$","style",null,{"dangerouslySetInnerHTML":{"__html":"body{color:#000;background:#fff;margin:0}.next-error-h1{border-right:1px solid rgba(0,0,0,.3)}@media (prefers-color-scheme:dark){body{color:#fff;background:#000}.next-error-h1{border-right:1px solid rgba(255,255,255,.3)}}"}}],["$","h1",null,{"className":"next-error-h1","style":{"display":"inline-block","margin":"0 20px 0 0","padding":"0 23px 0 0","fontSize":24,"fontWeight":500,"verticalAlign":"top","lineHeight":"49px"},"children":"404"}],["$","div",null,{"style":{"display":"inline-block"},"children":["$","h2",null,{"style":{"fontSize":14,"fontWeight":400,"lineHeight":"49px","margin":0},"children":"This page could not be found."}]}]]}]}]],"notFoundStyles":[]}]}]}]]}]]}]}]}]}]],null],null],["$La",null]]]]
a:[["$","meta","0",{"name":"viewport","content":"width=device-width, initial-scale=1"}],["$","meta","1",{"charSet":"utf-8"}],["$","title","2",{"children":"AIOX Course Platform | Professional Bootcamp & Mastery"}],["$","meta","3",{"name":"description","content":"Learn AIOX - AI-Orchestrated System for Full Stack Development. Complete bootcamp and mastery courses with hands-on projects."}],["$","meta","4",{"name":"keywords","content":"AIOX,AI Development,Full Stack,Course,Bootcamp,Learning"}]]
1:null
