2:I[4817,["972","static/chunks/972-435ad046c10f8479.js","552","static/chunks/552-ca913c8f5aa11d94.js","460","static/chunks/app/mastery/%5Blesson%5D/page-19f8ee117e5859d3.js"],"LessonRenderer"]
4:I[4707,[],""]
6:I[6423,[],""]
7:I[872,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"ThemeProvider"]
8:I[3021,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Sidebar"]
9:I[8680,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Header"]
3:T2435,# Aula 01 — Por Dentro do .aiox-core/

<!-- metadata
course: Mastery
module: 1
lesson: 1
title: "Por Dentro do .aiox-core/"
duration: 3-4 horas
agents: "nenhum (exploração de internals)"
project: Plataforma Zabbix Learning
phase: Configuração
prerequisites: Bootcamp completo (18 aulas)
-->

---

> **Módulo 1** · AIOX Internals
> **Duração**: 3-4 horas
> **Agentes praticados**: Nenhum diretamente — exploração da estrutura interna
> **Projeto**: Plataforma Zabbix Learning

---

## 🏆 Vitória desta aula

Mapa completo do `.aiox-core/` com entendimento de cada diretório, e preset customizado para a Plataforma Zabbix configurado e validado.

**Critério binário**: Documento `docs/aiox-internals-map.md` com descrição de todos os 17 subdiretórios + preset custom em `.aiox-core/presets/zabbix-platform.yaml` que funciona com `npx aiox-core doctor`.

---

## Conceito

### De usuário a operador

No Bootcamp você usou o AIOX como **usuário**: chamou agentes, recebeu outputs, avaliou resultados. Funcionou — 3 projetos entregues. Mas você nunca olhou por dentro. É como dirigir um carro sem abrir o capô: funciona até que precisa de ajuste fino.

No Mastery, você vira **operador**. Precisa saber: onde o AIOX guarda as decisões dos agentes? Como o sistema decide qual agente chamar? Onde ficam os schemas que validam stories? Como customizar o comportamento sem quebrar a arquitetura?

A Plataforma Zabbix Learning é complexa demais para configuração default. Com 6 subsistemas, 10+ containers, e agentes customizados, você vai precisar de presets, workflows customizados e configuração avançada. Tudo isso mora dentro do `.aiox-core/`.

### O que não muda entre Bootcamp e Mastery

O princípio agent-driven permanece: você descreve necessidades, agentes implementam, você avalia. O que muda é que agora você **configura** os agentes em vez de apenas usá-los. A abordagem CCPR permanece, mas o peso muda: menos conceito (você já sabe o básico), mais prática autônoma, reflexão mais profunda.

---

## Prática

### Passo 1 — Iniciar o projeto da Plataforma Zabbix

```bash
mkdir -p ~/aiox-mastery/zabbix-platform
cd ~/aiox-mastery/zabbix-platform
git init

# Inicializar AIOX
npx aiox-core init
```

---

### Passo 2 — Tour profundo pelo .aiox-core/

Explore sistematicamente cada diretório. Não use agente — este é **seu** tour de reconhecimento:

```bash
# Visão geral
tree .aiox-core/ -L 2

# Ou se preferir no Claude Code
claude
```

```
Liste a estrutura completa de .aiox-core/ com 2 níveis 
de profundidade e me descreva o propósito de cada 
diretório e arquivo-chave.
```

Para cada diretório, investigue o conteúdo. Aqui está o roteiro — explore cada um e documente o que encontrar:

**Grupo 1 — Configuração core**

```bash
# constitution.md — a "constituição" que governa todos os agentes
cat .aiox-core/constitution.md

# core-config.yaml — configuração central do projeto
cat .aiox-core/core-config.yaml

# schemas/ — schemas de validação
ls .aiox-core/schemas/
```

> **O que procurar em constitution.md**: Quais regras governam os agentes? Que comportamentos são mandatórios? Que restrições existem? Este documento é o "contrato social" do AIOX.

> **O que procurar em core-config.yaml**: Quais configurações existem? O que é customizável? Quais valores default estão definidos?

**Grupo 2 — Agentes e workflows**

```bash
# agents/ — definições dos agentes
ls .aiox-core/agents/
cat .aiox-core/agents/analyst.md  # exemplo

# workflows/ — workflows disponíveis
ls .aiox-core/development/workflows/

# tasks/ — tasks disponíveis
ls .aiox-core/development/tasks/
```

> **O que procurar nos agentes**: Como cada agente é definido? Quais comandos tem? Qual é o template de definição? Identifique o formato que vai usar para criar o agente customizado @zabbix-expert na Aula 02.

**Grupo 3 — ADE e desenvolvimento**

```bash
# ADE — Agentic Development Environment
ls .aiox-core/development/ade/

# presets/ — configurações pré-definidas
ls .aiox-core/presets/

# manifests/ — manifestos de projeto
ls .aiox-core/manifests/
```

> **O que procurar no ADE**: A estrutura do Epic Pipeline, os 13 steps do Execution Engine, os arquivos de Recovery e Memory Layer. Você usou tudo isso no Bootcamp — agora vê a mecânica.

**Grupo 4 — Qualidade e validação**

```bash
# quality/ — checklists e padrões de qualidade
ls .aiox-core/quality/

# security/ — regras de segurança
ls .aiox-core/security/
```

Para cada diretório explorado, documente em `docs/aiox-internals-map.md`:

```markdown
## .aiox-core/agents/
**Propósito**: Definições de todos os agentes disponíveis
**Arquivos-chave**: analyst.md, architect.md, dev.md, qa.md...
**Formato**: Markdown com metadata (nome, role, commands)
**Customização**: Criar novos agentes neste diretório
**Relação**: Referenciado por workflows e constitution
```

> **Checklist de avaliação do mapa**
> - [ ] Todos os 17+ subdiretórios foram documentados?
> - [ ] Cada entrada tem propósito, arquivos-chave e relação com outros?
> - [ ] Identificou onde ficam os schemas de validação?
> - [ ] Identificou o formato de definição de agentes?
> - [ ] Identificou como presets funcionam?
> - [ ] Identificou os arquivos do ADE (spec pipeline, execution engine, recovery)?

> **🏆 Checkpoint 1**: Mapa completo do .aiox-core/ documentado.

---

### Passo 3 — core-config.yaml aprofundado

O core-config é o centro nervoso. Explore cada seção:

```bash
cat .aiox-core/core-config.yaml
```

Documente:

> **Checklist de entendimento do core-config**
> - [ ] Quais seções existem? (project, agents, ade, workflows, quality...)
> - [ ] O que cada seção controla?
> - [ ] Quais valores são customizáveis para a Plataforma Zabbix?
> - [ ] Quais valores NÃO devem ser alterados (e por quê)?
> - [ ] Como ativar/desativar features do ADE?

---

### Passo 4 — Criar preset para a Plataforma Zabbix

Presets são configurações pré-definidas para tipos de projeto. A Plataforma Zabbix precisa de um preset customizado:

```bash
# Verificar presets existentes
ls .aiox-core/presets/
cat .aiox-core/presets/default.yaml  # ou o nome que existir
```

Crie o preset:

```yaml
# .aiox-core/presets/zabbix-platform.yaml

# Preset para a Plataforma Zabbix Learning
# SaaS educacional com 6 subsistemas, 10+ containers

project:
  name: "Zabbix Learning Platform"
  type: "saas"
  complexity: "high"
  
# Configurações específicas para o projeto
# [Complete baseado no que aprendeu explorando o core-config]
```

O conteúdo exato depende do que você encontrou no core-config. A ideia é: customize para as necessidades específicas da Plataforma (projeto grande, múltiplos subsistemas, agente customizado, workflows de geração de conteúdo educacional).

**Como validar**:

```bash
# Ativar o preset
# [comando depende da versão do AIOX — verifique na documentação]

# Validar configuração
npx aiox-core doctor
```

> **Checklist de avaliação do preset**
> - [ ] O preset reflete a complexidade do projeto (SaaS, 6 subsistemas)?
> - [ ] Configurações específicas estão justificadas?
> - [ ] `npx aiox-core doctor` passa sem erros?
> - [ ] O preset não quebra funcionalidades padrão?

> **🏆 Checkpoint 2 — VITÓRIA DA AULA**: Mapa completo + preset customizado + doctor passing.

---

### Passo 5 — Commit

```bash
git add .
git commit -m "docs: AIOX internals map + custom preset for Zabbix Platform

- Complete map of .aiox-core/ 17 subdirectories
- core-config.yaml analysis and documentation
- Custom preset zabbix-platform.yaml for SaaS project
- npx aiox-core doctor passing"
```

---

## Reflexão

### A diferença entre usar e entender

No Bootcamp, `@analyst *research-domain` era uma caixa preta — você chamou, recebeu output. Agora sabe: o Analyst é definido em `.aiox-core/agents/analyst.md`, seus comandos são declarados lá, ele obedece à constitution.md, e seu comportamento é configurável no core-config.yaml.

Isso muda como você trabalha. Quando um agente não faz o que espera, você não fica tentando prompts diferentes — vai na definição e entende por quê. Quando precisa de um agente que não existe, sabe o formato para criar. Quando a configuração padrão não serve, sabe qual arquivo alterar.

### O conceito-chave

> **Dominar o AIOX significa dominar o .aiox-core/. Cada comportamento que você observou no Bootcamp tem uma causa nessa estrutura de diretórios: a constitution governa, o core-config configura, os schemas validam, os presets especializam. Entender essa mecânica é o que separa quem usa de quem customiza.**

### Conexão com a próxima aula

Na Aula 02, você vai usar esse conhecimento para criar o agente customizado @zabbix-expert no formato autoClaude V3, configurar o sistema de elicitação customizada, e explorar o Workflow Intelligence. O mapa desta aula é pré-requisito — sem ele, customizar é chute.

---

> **Anterior**: [Bootcamp — Aula 18: Consolidação](../../bootcamp-aiox/modulo-04/aula-18-automation-brownfield-retro.md)
> **Próxima**: [Aula 02 — Elicitação, Workflow Intelligence e Definição de Agentes](./aula-02-elicitation-agents.md)
5:["lesson","mastery-aula-01-internals","d"]
0:["0aCmzVh17xjX8k-qFi6hn",[[["",{"children":["mastery",{"children":[["lesson","mastery-aula-01-internals","d"],{"children":["__PAGE__?{\"lesson\":\"mastery-aula-01-internals\"}",{}]}]}]},"$undefined","$undefined",true],["",{"children":["mastery",{"children":[["lesson","mastery-aula-01-internals","d"],{"children":["__PAGE__",{},[["$L1",["$","$L2",null,{"content":"$3","lessonSlug":"mastery-aula-01-internals","module":"mastery","lessonIndex":0,"totalLessons":22,"nextLesson":"mastery-aula-02-elicitation-agents","prevLesson":"$undefined"}],null],null],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","mastery","children","$5","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","mastery","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[[[["$","link","0",{"rel":"stylesheet","href":"/_next/static/css/71d217bb04404cb9.css","precedence":"next","crossOrigin":"$undefined"}]],["$","html",null,{"lang":"pt-BR","children":["$","body",null,{"className":"bg-white dark:bg-slate-900 text-gray-900 dark:text-gray-100 transition-colors","children":["$","$L7",null,{"children":["$","div",null,{"className":"flex h-screen overflow-hidden","children":[["$","$L8",null,{}],["$","div",null,{"className":"flex-1 flex flex-col overflow-hidden","children":[["$","$L9",null,{}],["$","main",null,{"className":"flex-1 overflow-y-auto bg-white dark:bg-slate-900 transition-colors","children":["$","div",null,{"className":"max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8","children":["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":[["$","title",null,{"children":"404: This page could not be found."}],["$","div",null,{"style":{"fontFamily":"system-ui,\"Segoe UI\",Roboto,Helvetica,Arial,sans-serif,\"Apple Color Emoji\",\"Segoe UI Emoji\"","height":"100vh","textAlign":"center","display":"flex","flexDirection":"column","alignItems":"center","justifyContent":"center"},"children":["$","div",null,{"children":[["$","style",null,{"dangerouslySetInnerHTML":{"__html":"body{color:#000;background:#fff;margin:0}.next-error-h1{border-right:1px solid rgba(0,0,0,.3)}@media (prefers-color-scheme:dark){body{color:#fff;background:#000}.next-error-h1{border-right:1px solid rgba(255,255,255,.3)}}"}}],["$","h1",null,{"className":"next-error-h1","style":{"display":"inline-block","margin":"0 20px 0 0","padding":"0 23px 0 0","fontSize":24,"fontWeight":500,"verticalAlign":"top","lineHeight":"49px"},"children":"404"}],["$","div",null,{"style":{"display":"inline-block"},"children":["$","h2",null,{"style":{"fontSize":14,"fontWeight":400,"lineHeight":"49px","margin":0},"children":"This page could not be found."}]}]]}]}]],"notFoundStyles":[]}]}]}]]}]]}]}]}]}]],null],null],["$La",null]]]]
a:[["$","meta","0",{"name":"viewport","content":"width=device-width, initial-scale=1"}],["$","meta","1",{"charSet":"utf-8"}],["$","title","2",{"children":"AIOX Course Platform | Professional Bootcamp & Mastery"}],["$","meta","3",{"name":"description","content":"Learn AIOX - AI-Orchestrated System for Full Stack Development. Complete bootcamp and mastery courses with hands-on projects."}],["$","meta","4",{"name":"keywords","content":"AIOX,AI Development,Full Stack,Course,Bootcamp,Learning"}]]
1:null
