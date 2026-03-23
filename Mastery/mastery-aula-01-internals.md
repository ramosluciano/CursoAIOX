# Aula 01 — Por Dentro do .aiox-core/

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
> - <input type="checkbox" class="checkbox-input" /> Todos os 17+ subdiretórios foram documentados?
> - <input type="checkbox" class="checkbox-input" /> Cada entrada tem propósito, arquivos-chave e relação com outros?
> - <input type="checkbox" class="checkbox-input" /> Identificou onde ficam os schemas de validação?
> - <input type="checkbox" class="checkbox-input" /> Identificou o formato de definição de agentes?
> - <input type="checkbox" class="checkbox-input" /> Identificou como presets funcionam?
> - <input type="checkbox" class="checkbox-input" /> Identificou os arquivos do ADE (spec pipeline, execution engine, recovery)?

> **🏆 Checkpoint 1**: Mapa completo do .aiox-core/ documentado.

---

### Passo 3 — core-config.yaml aprofundado

O core-config é o centro nervoso. Explore cada seção:

```bash
cat .aiox-core/core-config.yaml
```

Documente:

> **Checklist de entendimento do core-config**
> - <input type="checkbox" class="checkbox-input" /> Quais seções existem? (project, agents, ade, workflows, quality...)
> - <input type="checkbox" class="checkbox-input" /> O que cada seção controla?
> - <input type="checkbox" class="checkbox-input" /> Quais valores são customizáveis para a Plataforma Zabbix?
> - <input type="checkbox" class="checkbox-input" /> Quais valores NÃO devem ser alterados (e por quê)?
> - <input type="checkbox" class="checkbox-input" /> Como ativar/desativar features do ADE?

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
> - <input type="checkbox" class="checkbox-input" /> O preset reflete a complexidade do projeto (SaaS, 6 subsistemas)?
> - <input type="checkbox" class="checkbox-input" /> Configurações específicas estão justificadas?
> - <input type="checkbox" class="checkbox-input" /> `npx aiox-core doctor` passa sem erros?
> - <input type="checkbox" class="checkbox-input" /> O preset não quebra funcionalidades padrão?

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

> **Anterior**: Bootcamp — Aula 18: Consolidação
> **Próxima**: Aula 02 — Elicitação, Workflow Intelligence e Definição de Agentes
