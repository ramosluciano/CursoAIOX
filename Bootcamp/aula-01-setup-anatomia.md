# Aula 01 — Setup e Anatomia do AIOX

<!-- metadata
module: 1
lesson: 1
title: Setup e Anatomia do AIOX
duration: 2-3 horas
agents: nenhum (preparação)
project: nenhum (fundamentos)
phase: CCPR
prerequisites: Node.js 18+, Git, Claude Code (ou Codex/Gemini CLI)
-->

---

> **Módulo 1** · Fundamentos AIOX
> **Duração**: 2-3 horas
> **Agentes praticados**: Nenhum (preparação do ambiente)
> **Projeto**: Nenhum ainda — esta aula é sobre dominar o terreno

---

## 🏆 Vitória desta aula

Ao final, você terá o AIOX instalado, terá explorado sua estrutura interna, ativado seus primeiros agentes e entendido a anatomia do framework que vai usar nos próximos meses.

**Critério binário**: AIOX instalado + `doctor` passando + pelo menos 3 agentes ativados com greeting + `*help` executado com sucesso.

---

## Conceito

### O que é o Synkra AIOX

O Synkra AIOX (AI-Orchestrated System) é um framework que transforma seu coding agent — Claude Code, Codex CLI, Gemini CLI — em uma **equipe ágil completa de desenvolvimento de software**. Em vez de um assistente genérico que faz tudo (e nada especialmente bem), você passa a ter 11 agentes especializados que simulam os papéis reais de uma equipe profissional: analyst, product manager, architect, scrum master, developer, QA, DevOps, product owner.

Pense assim: usar Claude Code sozinho é como ter um estagiário muito inteligente mas sem experiência. Ele faz o que você pede, mas não sabe planejar, não questiona decisões ruins, não testa o que fez e não documenta nada. O AIOX transforma esse estagiário em uma equipe onde cada pessoa sabe seu papel, questiona quando algo não faz sentido e passa o bastão para o próximo com todo o contexto necessário.

### A premissa fundamental: CLI First

O AIOX segue uma hierarquia clara de prioridades:

```
CLI First → Observability Second → UI Third
```

Toda a inteligência, execução e automação acontecem no terminal — no seu coding agent. Dashboards e interfaces visuais são secundários: existem para observar o que o CLI está fazendo, não para controlá-lo. Funcionalidades novas devem funcionar 100% via CLI antes de ter qualquer interface gráfica.

**Por que isso importa para você**: significa que tudo que vamos fazer neste curso acontece dentro do Claude Code (ou do coding agent que você escolher). Não há interface web obrigatória, não há app para instalar. Seu terminal é o cockpit.

### As duas inovações que tornam o AIOX diferente

**1. Planejamento Agêntico**: Antes de escrever uma única linha de código, agentes dedicados (analyst, PM, architect) colaboram com você para criar documentos de especificação detalhados. Não é "gere um PRD" — é um processo iterativo onde o agente pergunta, você responde, ele refina, você valida. Cada iteração melhora a qualidade.

**2. Desenvolvimento Contextualizado**: O Scrum Master transforma os documentos de planejamento em stories hiperdetalhadas que contêm absolutamente tudo que o agente Dev precisa: o quê fazer, como fazer, por quê fazer assim, quais arquivos criar, quais testes escrever. O Dev abre uma story e tem compreensão completa — não precisa adivinhar nada.

A combinação dessas duas coisas elimina os dois maiores problemas do desenvolvimento assistido por IA: **inconsistência de planejamento** (quando o agente não sabe o que construir) e **perda de contexto** (quando o agente esquece o que já foi decidido).

---

## Contexto

Esta aula é puramente preparatória — não vamos trabalhar em nenhum projeto ainda. O objetivo é garantir que seu ambiente está configurado corretamente e que você sente conforto navegando pelo AIOX antes de mergulhar no primeiro projeto (RockQuiz, a partir da Aula 03).

Pense nesta aula como o dia em que você chega em um novo emprego e o TI configura seu computador. Ninguém espera que você produza código no primeiro dia — mas espera que no segundo dia sua máquina esteja pronta para trabalhar.

---

## Prática

### Passo 1 — Verificar pré-requisitos

Abra seu terminal e confirme que todas as ferramentas estão instaladas. Execute cada comando abaixo e verifique que a saída mostra uma versão válida:

```bash
# Node.js (precisa ser 18 ou superior, recomendado 20+)
node --version
# Esperado: v20.x.x ou v18.x.x

# npm (precisa ser 9 ou superior)
npm --version
# Esperado: 10.x.x ou 9.x.x

# Git
git --version
# Esperado: git version 2.x.x

# Seu coding agent (pelo menos um dos três)
claude --version    # Claude Code
# OU
codex --version     # Codex CLI
# OU
gemini --version    # Gemini CLI
```

> **Checklist de pré-requisitos**
> - <input type="checkbox" class="checkbox-input" /> Node.js v18+ instalado
> - <input type="checkbox" class="checkbox-input" /> npm v9+ instalado
> - <input type="checkbox" class="checkbox-input" /> Git instalado e configurado (`git config user.name` retorna seu nome)
> - <input type="checkbox" class="checkbox-input" /> Pelo menos um coding agent CLI instalado
> - <input type="checkbox" class="checkbox-input" /> Editor de código disponível (VS Code recomendado)

> **Troubleshooting**
> 
> **Node.js não encontrado**: Instale via [nodejs.org](https://nodejs.org) — baixe a versão LTS.
> 
> **npm desatualizado**: Execute `npm install -g npm@latest`.
> 
> **Claude Code não instalado**: Siga as instruções em [docs.anthropic.com](https://docs.anthropic.com) para instalar o Claude Code CLI.

---

### Passo 2 — Criar o workspace do curso

Vamos criar uma pasta que será o workspace para todos os projetos do curso. Cada projeto terá seu próprio subdiretório.

```bash
# Criar workspace raiz do curso
mkdir -p ~/aiox-bootcamp
cd ~/aiox-bootcamp

# Criar diretório para o primeiro projeto (RockQuiz)
mkdir rockquiz
cd rockquiz

# Inicializar o AIOX com o assistente interativo
npx aiox-core init .
```

O assistente interativo vai aparecer no terminal com prompts coloridos (estilo Vite/Next.js). Responda assim:

```
◆ What is your project name?
│  rockquiz

◇ Which directory should we use?
│  . (diretório atual)

◆ Choose components to install:
│  ● Core Framework (Required)
│  ● Agent System (Required)
│  ● Squads (optional) ← selecione também
│  ○ Example Projects (optional) ← pode pular

◇ Select package manager:
│  ● npm

◆ Initialize Git repository?
│  Yes

◆ Install dependencies?
│  Yes
```

Aguarde a instalação completar. Você deve ver:

```
✔ Installation completed successfully! (XX.Xs)
```

> **🏆 Checkpoint 1**: A mensagem "Installation completed successfully" apareceu.

> **Troubleshooting**
> 
> **Erro de permissão**: Tente `sudo npx aiox-core init .` ou verifique permissões do diretório.
> 
> **Timeout no npm install**: Execute `npx aiox-core init . --skip-install` e depois `npm install` separadamente.
> 
> **"aiox-core not found"**: Verifique Node.js v18+ com `node --version`. O npx precisa de Node moderno.

---

### Passo 3 — Verificar saúde da instalação

```bash
npx aiox-core doctor
```

A saída esperada mostra checks verdes para cada componente:

```
🏥 AIOX System Diagnostics

✔ Node.js version: v20.x.x (meets requirement: >=18.0.0)
✔ npm version: 10.x.x
✔ Git installed: version 2.x.x
✔ Synkra AIOX: v4.x.x

Configuration:
✔ .aiox-core/ directory exists
✔ Agent files: 11 found
✔ Workflow files: X found
✔ Templates: X found

✅ All checks passed! Your installation is healthy.
```

Se houver erros, anote quais checks falharam e tente:

```bash
# Forçar reinstalação
npx aiox-core install --force
```

> **🏆 Checkpoint 2**: `doctor` passa sem erros críticos.

---

### Passo 4 — Explorar a anatomia do .aiox-core/

Este é o momento mais importante da aula. Vamos abrir a caixa preta e entender o que o AIOX instalou no seu projeto.

```bash
# Ver a estrutura de alto nível
ls -la

# Ver o conteúdo do .aiox-core/
ls .aiox-core/
```

A estrutura que você vai encontrar:

```
rockquiz/
├── .aiox-core/              ← 🧠 Cérebro do framework
│   ├── cli/                 ← Comandos CLI internos
│   ├── core/                ← Configuração runtime
│   ├── data/                ← Base de conhecimento interna
│   ├── development/
│   │   ├── agents/          ← ⭐ Definições dos 11 agentes
│   │   ├── tasks/           ← Tasks executáveis por agente
│   │   └── workflows/       ← Workflows YAML (sequências de ações)
│   ├── elicitation/         ← Sistema de perguntas inteligentes
│   ├── hooks/               ← Hooks de lifecycle (automação)
│   ├── infrastructure/      ← Scripts de infra e DevOps
│   ├── monitor/hooks/       ← Hooks de monitoramento
│   ├── presets/             ← Configurações pré-definidas
│   ├── product/
│   │   ├── templates/       ← ⭐ Templates de documentos (PRD, stories)
│   │   └── checklists/      ← Checklists de validação de qualidade
│   ├── quality/             ← Regras de qualidade
│   ├── schemas/             ← JSON Schemas de validação
│   ├── scripts/             ← Scripts utilitários
│   ├── utils/               ← Utilitários internos
│   ├── workflow-intelligence/ ← Motor de decisão de workflows
│   ├── constitution.md      ← ⭐ "Lei suprema" do framework
│   └── core-config.yaml     ← ⭐ Configuração central
├── .claude/                 ← Config para Claude Code (auto-gerado)
├── .codex/                  ← Config para Codex CLI (auto-gerado)
├── .gemini/                 ← Config para Gemini CLI (auto-gerado)
├── docs/                    ← Onde ficarão seus documentos de projeto
├── squads/                  ← Onde ficarão seus squads customizados
└── package.json
```

Vamos explorar os 4 pontos marcados com ⭐:

#### 4a. Os agentes (`.aiox-core/development/agents/`)

```bash
ls .aiox-core/development/agents/
```

Cada arquivo neste diretório é a **definição completa de um agente** — sua persona, papel, comandos disponíveis, e como se comporta. Abra qualquer um para espiar:

```bash
# Olhe a definição do agente Dev (o que ele é, o que sabe fazer)
cat .aiox-core/development/agents/dev.md | head -50
```

Observe que cada agente tem: uma identidade (nome, persona), um role description (o que faz), comandos (com `*` prefix), e regras de comportamento. Não precisa entender tudo agora — vamos explorar em profundidade quando usar cada agente nos próximos dias.

#### 4b. Os templates (`.aiox-core/product/templates/`)

```bash
ls .aiox-core/product/templates/
```

Templates são modelos de documentos que os agentes usam para produzir outputs padronizados. Quando o PM cria um PRD, ele segue o template de PRD. Quando o SM cria uma story, segue o template de story. Isso garante consistência — todo PRD tem as mesmas seções, toda story tem os mesmos campos.

#### 4c. A constitution (`.aiox-core/constitution.md`)

```bash
cat .aiox-core/constitution.md | head -30
```

A constitution é o documento fundacional que define os princípios que **todos os agentes seguem**. É como a constituição de um país — a lei suprema que nenhum agente pode violar. Ela define: como agentes devem se comunicar, o que é obrigatório em cada fase, e quais padrões de qualidade são inegociáveis.

No Bootcamp, vamos respeitar esses princípios. No Mastery, vamos mergulhar fundo neles e aprender a customizar.

#### 4d. A configuração central (`core-config.yaml`)

```bash
cat .aiox-core/core-config.yaml
```

Este arquivo controla o comportamento global do AIOX: qual provider de IA usar, qual modelo, quais features estão habilitadas, configurações de ambiente. No Bootcamp, usamos a configuração default. No Mastery, vamos customizar extensivamente.

> **🏆 Checkpoint 3**: Você explorou .aiox-core/ e sabe onde ficam agentes, templates, constitution e config.

---

### Passo 5 — Configurar sua IDE

O AIOX pré-configura regras para sua IDE durante a instalação. Dependendo do seu coding agent, verifique:

#### Se você usa Claude Code (recomendado para este curso)

O arquivo `.claude/CLAUDE.md` já foi criado automaticamente. Este arquivo é carregado toda vez que você inicia o Claude Code no projeto — é como um "briefing" que o Claude recebe antes de você falar qualquer coisa.

```bash
# Verificar que existe
cat .claude/CLAUDE.md | head -20

# Validar a integração (se o comando existir)
npm run validate:claude-sync 2>/dev/null && echo "✅ Claude sync OK" || echo "⚠️ Comando não disponível — OK para continuar"
```

#### Se você usa Codex CLI

O arquivo `AGENTS.md` na raiz é carregado automaticamente.

```bash
cat AGENTS.md | head -20

# Sincronizar skills (se o comando existir)
npm run sync:ide:codex 2>/dev/null || echo "⚠️ Sync não disponível — OK"
```

#### Se você usa Gemini CLI

```bash
# Sincronizar regras e agentes
npm run sync:ide:gemini 2>/dev/null || echo "⚠️ Sync não disponível — OK"

# Verificar arquivos gerados
ls .gemini/ 2>/dev/null
```

> **Nota**: Claude Code é a IDE com **paridade completa** de hooks e features do AIOX. Gemini CLI tem paridade alta. Codex e Cursor têm paridade parcial. Para este curso, recomendamos Claude Code como referência. No Mastery, vamos testar o mesmo projeto em 3 IDEs e comparar.

> **🏆 Checkpoint 4**: IDE configurada para o AIOX.

---

### Passo 6 — Ativar seu primeiro agente

Agora vem o momento que torna tudo real. Abra uma sessão do seu coding agent dentro do projeto:

```bash
# Certifique-se de estar no diretório do projeto
cd ~/aiox-bootcamp/rockquiz

# Inicie o Claude Code (ou seu coding agent)
claude
```

Dentro da sessão, ative o agente Dev:

```
@dev
```

Você deve ver o **greeting** — uma mensagem de boas-vindas onde o agente se apresenta, explica suas capacidades e mostra seus comandos principais. O agente Dev (persona "Dex") vai se apresentar como o desenvolvedor da equipe.

Agora execute o comando de ajuda:

```
*help
```

O agente lista todos os seus comandos disponíveis com descrição. Observe a estrutura:

- Comandos com `*` prefix (ex: `*help`, `*execute-subtask`, `*capture-insights`)
- Cada comando tem uma descrição curta do que faz
- Alguns comandos aceitam parâmetros (ex: `*execute-subtask 1.1`)

Agora desative o agente e ative outro:

```
*exit

@qa
```

O QA (persona "Quinn") se apresenta com um greeting diferente — focado em qualidade, testes, review. Seus comandos são diferentes dos comandos do Dev:

```
*help
```

Note: `*review-build`, `*critique-spec`, `*request-fix`, `*verify-fix` — comandos que o Dev não tem.

```
*exit
```

> **🏆 Checkpoint 5**: Pelo menos 2 agentes ativados com greeting + `*help` executados.

---

### Passo 7 — Tour pelos 11 agentes

Ative cada um dos 11 agentes, leia o greeting e rode `*help`. Para cada um, anote mentalmente: qual o papel deste agente? Quais comandos parecem mais importantes?

A ordem sugerida segue o fluxo natural de uso do AIOX:

```
@analyst       → Ana: pesquisa de domínio, briefings, análise competitiva
*help
*exit

@pm            → Pete: requisitos, PRD, specs, priorização
*help
*exit

@architect     → Aria: arquitetura, design técnico, avaliação de complexidade
*help
*exit

@ux-expert     → Uma: design de experiência, wireframes, usabilidade
*help
*exit

@sm            → Sam: stories, sprints, decomposição de trabalho
*help
*exit

@po            → Pia: backlog, priorização, validação de entregas
*help
*exit

@dev           → Dex: implementação, código, testes, insights
*help
*exit

@qa            → Quinn: review, qualidade, segurança, performance
*help
*exit

@devops        → Dex-Ops: Docker, CI/CD, worktrees, infraestrutura
*help
*exit

@aiox-master   → Pax: orquestração geral, coordenação de workflows
*help
*exit

@aiox-orchestrator → Orion: automação de fluxos entre agentes
*help
*exit
```

Observe os padrões:

- **Agentes de planejamento** (analyst, pm, architect, ux-expert): produzem documentos
- **Agentes de desenvolvimento** (sm, dev, qa, po): trabalham com código e stories
- **Agentes de infraestrutura** (devops): cuidam de containers, CI/CD, deploy
- **Agentes de orquestração** (aiox-master, aiox-orchestrator): coordenam os outros

Cada agente tem **comandos exclusivos** — nenhum outro agente tem o mesmo comando. Se o PM tem `*gather-requirements`, nenhum outro agente tem esse comando. Isso é proposital: **cada comando tem um dono autoritativo**.

> **🏆 Checkpoint 6 — VITÓRIA DA AULA**: Todos os 11 agentes ativados pelo menos uma vez.

---

### Passo 8 — A sintaxe AIOX (referência rápida)

Antes de encerrar, grave esta referência:

```
@agente         → Ativa um agente (ex: @dev, @qa, @architect)
*comando        → Executa comando do agente ativo (ex: *help, *create-story)
*exit           → Desativa o agente atual
*help           → Lista comandos do agente ativo
```

Quando você ativa um agente com `@`, ele permanece ativo até você usar `*exit` ou ativar outro com `@`. Todos os prompts que você digitar serão interpretados pelo agente ativo.

Exemplo de fluxo:

```
@pm                          ← Ativa o PM
Crie o PRD do meu projeto    ← PM interpreta e responde
*gather-requirements         ← PM executa o comando
*exit                        ← PM desativado

@architect                   ← Architect ativado
Leia o PRD e crie a arquitetura  ← Architect interpreta
*assess-complexity           ← Architect executa
*exit                        ← Architect desativado
```

Você também pode falar em linguagem natural com o agente ativo — não é obrigatório usar comandos `*`. Os comandos são atalhos para ações específicas, mas o agente entende português perfeitamente.

---

## Reflexão

### O que você conquistou

Você preparou o terreno completo para o restante do curso:

- **Ambiente instalado e validado** — AIOX rodando, doctor passando, IDE configurada
- **Anatomia compreendida** — sabe onde ficam agentes, templates, constitution, config
- **Agentes experimentados** — ativou todos os 11, viu greetings, explorou comandos
- **Sintaxe dominada** — `@agente`, `*comando`, `*exit`, `*help`

### O conceito-chave desta aula

> **O AIOX não é um chatbot que gera código — é um sistema de agentes especializados que colaboram através de documentos estruturados.**

Cada agente sabe seu papel, tem comandos exclusivos, e produz outputs que alimentam o próximo agente no pipeline. Nenhum agente tenta fazer tudo — cada um faz uma coisa bem.

### Conexão com a próxima aula

Na Aula 02, vamos entender o **fluxo completo de trabalho** do AIOX — como os agentes se conectam, como os documentos carregam contexto entre fases, e por que isso é fundamentalmente diferente de "pedir pro ChatGPT codificar". É a teoria que vai fazer a prática (a partir da Aula 03) fazer sentido.

---

## Exercício extra (opcional)

Se sobrar tempo e curiosidade:

1. Abra `.aiox-core/constitution.md` inteiro e leia. Anote 3 princípios que chamaram sua atenção.

2. Abra a definição de um agente (ex: `.aiox-core/development/agents/dev.md`) e compare com outro (ex: `qa.md`). O que é similar? O que é diferente?

3. Explore `.aiox-core/product/templates/` — abra um template de story e um template de PRD. Que seções cada um tem?

---

> **Próxima aula**: Aula 02 — Conceitos-Chave e Fluxo de Trabalho AIOX
