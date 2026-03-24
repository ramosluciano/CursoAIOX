# Claude Code — Guia Educacional Abrangente

**Versão:** 1.0
**Data:** Março 2026
**Nível:** Iniciante a Intermediário
**Público-alvo:** Desenvolvedores iniciando com Claude Code da Anthropic

---

## Índice

1. [Introdução ao Claude Code](#introdução-ao-claude-code)
2. [Fundamentos — Conceitos Principais](#fundamentos--conceitos-principais)
3. [Configuração Inicial](#configuração-inicial)
4. [Sistema de Memória](#sistema-de-memória)
5. [Sistema de Regras (Rules)](#sistema-de-regras-rules)
6. [Sistema de Agentes](#sistema-de-agentes)
7. [Sistema de Tasks](#sistema-de-tasks)
8. [Slash Commands](#slash-commands)
9. [Integração MCP](#integração-mcp)
10. [Keybindings e Atalhos](#keybindings-e-atalhos)
11. [Permissões e Segurança](#permissões-e-segurança)
12. [Hooks e Automação](#hooks-e-automação)
13. [Skills — Estendendo Funcionalidades](#skills--estendendo-funcionalidades)
14. [Integração com IDEs](#integração-com-ides)
15. [Boas Práticas e Patterns](#boas-práticas-e-patterns)
16. [Error Handling e Debugging](#error-handling-e-debugging)
17. [Referências e Recursos](#referências-e-recursos)

---

## Introdução ao Claude Code

### O que é Claude Code?

Claude Code é a ferramenta CLI oficial da Anthropic para desenvolvimento assistido por IA. Trata-se de um agente codificador que vive no seu terminal, compreende seu codebase e ajuda você a codificar mais rapidamente, executando tarefas rotineiras, explicando código complexo e lidando com workflows de git — tudo através de comandos em linguagem natural.

**Características principais:**

- **CLI-First**: Ferramenta de linha de comando nativa
- **Codebase Awareness**: Entende a estrutura do seu projeto
- **Multi-model Support**: Suporta múltiplos modelos Claude (Haiku, Sonnet, Opus)
- **Git Integration**: Manipulação de workflows git
- **MCP Integration**: Conexão com centenas de ferramentas via Model Context Protocol
- **Context Management**: Sistema sofisticado de gerenciamento de contexto

### Quando Usar Claude Code

✅ **Bom para:**
- Explicar código complexo
- Refatorar e otimizar código existente
- Gerar testes automaticamente
- Criar documentação
- Revisar Pull Requests
- Debugar bugs complexos
- Migração de código entre versões

❌ **Menos ideal para:**
- Problemas que requerem teste manual extenso
- Tarefas que precisam de interação visual complexa
- Decisões arquiteturais críticas (use agentes especializados)

---

## Fundamentos — Conceitos Principais

### 1. O Modelo de Camadas do Claude Code

Claude Code opera em 4 camadas contextuais:

```
┌─────────────────────────────────────────┐
│ L1: Global Settings                     │ ~/.claude/
│ • CLAUDE.md (global)                    │
│ • keybindings.json                      │
│ • settings.json                         │
└─────────────────────────────────────────┘
         ↓
┌─────────────────────────────────────────┐
│ L2: Project Configuration               │ .claude/
│ • CLAUDE.md (project-specific)          │
│ • rules/                                │
│ • commands/                             │
│ • agents/                               │
└─────────────────────────────────────────┘
         ↓
┌─────────────────────────────────────────┐
│ L3: Session Context                     │
│ • Memory (auto-generated)               │
│ • Session state                         │
│ • Task list                             │
└─────────────────────────────────────────┘
         ↓
┌─────────────────────────────────────────┐
│ L4: Runtime                             │
│ • Tool execution                        │
│ • File modifications                    │
│ • Git operations                        │
└─────────────────────────────────────────┘
```

### 2. Hierarquia de Contexto

Nem todos os tokens têm o mesmo peso em Claude Code:

```
Priority Alta   → .claude/settings.json (permite/nega ferramentas)
                → CLAUDE.md (instrções do projeto)
                → Regras contextuais (.claude/rules/)

Priority Média  → Memory files (sessão anterior)
                → Task lists

Priority Baixa  → Histórico de chat
                → Dados históricos
```

### 3. Ciclo de Vida de uma Sessão

```
1. Inicialização
   ├─ Carrega ~/.claude/CLAUDE.md
   ├─ Carrega .claude/CLAUDE.md (projeto)
   ├─ Carrega .claude/rules/*.md
   └─ Restaura memory da sessão anterior

2. Interaction Loop
   ├─ Aguarda input do usuário
   ├─ Aplica permissões (ask/auto/deny)
   ├─ Executa ferramentas
   └─ Atualiza memory

3. Finalização
   ├─ Salva memory
   ├─ Limpa contexto temporário
   └─ Aguarda próxima sessão
```

---

## Configuração Inicial

### Instalação

```bash
# Instalar globalmente via npm
npm install -g @anthropic-ai/claude-code

# Verificar versão
claude --version

# Autenticar (requer Claude Pro ou Max)
claude auth
```

### Primeira Execução

```bash
# Iniciar uma sessão
claude "descreva seu código"

# Resumir última conversa
claude -c

# Gerar CLAUDE.md template
/init
```

### Estrutura de Diretórios

Após a primeira execução, Claude Code cria:

```
~/.claude/                    # Configuração global
├── CLAUDE.md               # Instruções globais
├── settings.json           # Permissões e config
├── keybindings.json        # Atalhos de teclado
├── commands/               # Comandos globais
├── agents/                 # Agentes globais
└── memory/                 # Memory persistente

.claude/                     # Configuração do projeto
├── CLAUDE.md              # Instruções do projeto
├── settings.json          # Permissões do projeto
├── rules/                 # Regras contextuais
├── commands/              # Comandos do projeto
└── agents/                # Agentes especializados
```

---

## Sistema de Memória

### O que é Memory?

Memory é o sistema de persistência de contexto entre sessões. Existem duas formas:

#### 1. Auto Memory (Automático)

Claude escreve notas para si mesmo baseado em correções e preferências que você fornece:

```yaml
# .claude/memory/auto.md (gerado automaticamente)

## Build Commands
- npm run dev: starts dev server on port 3000
- npm test: run jest tests
- npm run lint: eslint + prettier check

## Code Style
- Use TypeScript for new files
- 2 spaces indentation
- Trailing commas in objects/arrays

## Architecture
- React components in src/components/
- API calls via src/api/
- State managed with Zustand
```

**Requisitos:** Claude Code v2.1.59 ou posterior, ativo por padrão

#### 2. Session Memory (Automático)

Sistema de background que rastreia conversas e extrai partes importantes:

- **Primeira extração**: ~10,000 tokens de conversa
- **Atualizações posteriores**: a cada ~5,000 tokens ou 3 tool calls
- **Armazenamento**: .claude/memory/sessions/

### CLAUDE.md — Instruções Persistentes

CLAUDE.md é o arquivo que **você escreve** com instruções que Claude deve conhecer:

```markdown
# Nossa Stack

## Tecnologias
- React 18 + TypeScript
- Node.js 18+
- PostgreSQL + Prisma ORM
- Vercel para deploy

## Convenções de Código
- PascalCase para componentes
- camelCase para funções/variáveis
- Sempre use `const` (nunca `let`/`var`)
- Adicione prop-types em componentes

## Arquitetura
- /pages → rotas Next.js
- /components → componentes React
- /lib → utilitários reutilizáveis
- /api → endpoints de API

## Testing
```bash
npm test          # Roda testes
npm run test:cov  # Coverage
```

## Deploy
- main branch → vercel.com
- Preview branches → vercel preview URLs
```

**Locais:**

- `~/.claude/CLAUDE.md` — Aplicado a TODOS os projetos
- `.claude/CLAUDE.md` — Específico do projeto (sobrescreve global)

**Como Editar Durante a Sessão:**

Pressione `#` para abrir prompt que atualiza automaticamente seu CLAUDE.md

### Memory Best Practices

1. **Não coloque código em Memory**: Use referências a arquivos ao invés
2. **Mantenha Memory atualizado**: Corrija confusões assim que surgirem
3. **Estruture por tópicos**: Uma seção por assunto
4. **Use entre sessões**: Termine uma sessão deixando notas para a próxima

---

## Sistema de Regras (Rules)

### O que são Rules?

Rules são instruções contextuais armazenadas em `.claude/rules/*.md` que carregam automaticamente baseado no arquivo que você está editando.

**Problema que resolvem:**

Quando CLAUDE.md cresce, TUDO carrega em toda sessão — regras de migrations ao editar um botão React, padrões frontend ao escrever queries SQL. Rules solve this.

### Estrutura de uma Rule

```markdown
---
paths:
  - "src/migrations/*.ts"
  - "src/db/**/*.sql"
severity: high
---

# Database Migration Rules

## Safety Guidelines
1. Never use DROP TABLE without backups
2. Always add rollback function
3. Test on staging before production

## Pattern: Adding Columns

\`\`\`typescript
// Schema change
alter table users add column email_verified boolean default false;

// Migration file structure
export async function up(sql) {
  return sql`ALTER TABLE users ADD COLUMN email_verified boolean DEFAULT false`
}

export async function down(sql) {
  return sql`ALTER TABLE users DROP COLUMN email_verified`
}
\`\`\`
```

### Yaml Frontmatter

```yaml
---
# paths: Globos para quando a regra carrega (obrigatório)
# Exemplos:
paths:
  - "src/components/**/*.tsx"      # Todos arquivos .tsx em components
  - "**/*.md"                      # Todos markdown
  - "src/api/*/handlers.ts"        # Padrão específico

# severity: Quanto Claude deve priorizar (padrão: normal)
severity: high|normal|low

# tags: Categorização (opcional)
tags: ["security", "performance", "testing"]

# contexts: Quando carregar (opcional)
contexts: ["initial", "always", "on-edit"]
---
```

### Carregamento Automático

1. Claude abre/edita um arquivo
2. Sistema verifica `paths:` em todas as rules
3. Rules que combinam carregam com **prioridade alta**
4. Permanecem no contexto enquanto trabalha com esses arquivos

### Exemplo Prático: React Component Rule

```markdown
---
paths:
  - "src/components/**/*.tsx"
severity: high
---

# React Component Standards

## File Organization
\`\`\`
MyComponent.tsx
├─ imports
├─ types (interface Props { ... })
├─ component (export const MyComponent = ...)
└─ export default
\`\`\`

## Accessibility
- Use semantic HTML (`<button>` not `<div onClick>`)
- Add ARIA labels where needed
- Test keyboard navigation

## Performance
- Memoize expensive operations with useMemo
- Use React.memo for pure components
- Lazy load heavy components
```

### Best Practices para Rules

1. **Uma regra por domínio**: Não misture auth rules com styling rules
2. **Globos específicos**: `src/auth/**/*.ts` não `src/**/*.ts`
3. **Severity apropriada**: high para segurança, normal para estilo
4. **Exemplos concretos**: Sempre inclua código real

---

## Sistema de Agentes

### Conceito Fundamental

Agentes são personas especializadas que Claude pode ativar para tarefas específicas. Cada agente:

- Roda em seu próprio contexto (sem poluição)
- Tem acesso a ferramentas específicas
- Segue instruções customizadas
- Retorna apenas o resultado final

### Agentes Built-in

#### 1. Explore Agent
**Uso**: Pesquisa e descoberta sem fazer mudanças

```bash
claude "explore the codebase and find authentication logic"
```

- Read-only (sem permissão para editar)
- Busca padrões e dependências
- Bom para onboarding em projetos novos

#### 2. Plan Agent
**Uso**: Planejar antes de implementar

```bash
claude "plan a refactor of the authentication system"
```

- Apenas análise, sem execução
- Retorna plano estruturado
- Use para revisar abordagem

#### 3. General Purpose Agent
**Uso**: Implementação padrão (padrão)

- Acesso completo a ferramentas (com permissões)
- Executa mudanças
- Modo padrão

### Criando Agentes Customizados

Crie em `.claude/agents/nome.md`:

```markdown
---
name: "Frontend-Specialist"
description: "Specialized in React, TypeScript, and CSS"
model: "claude-3-5-sonnet"  # ou "haiku" para tarefas leves
toolAccess:
  allow:
    - read
    - editFile
    - bash
  deny:
    - gitPush
    - networkRequest
permissionMode: "auto-accept-edits"
tags: ["frontend", "react"]
---

# Frontend Specialist Agent

## Expertise
You are a React + TypeScript specialist focused on:
- Component architecture and reusability
- Performance optimization (React.memo, useMemo, lazy loading)
- Accessibility and semantic HTML
- CSS-in-JS and Tailwind CSS

## Rules
1. Always use TypeScript strict mode
2. Prefer functional components with hooks
3. Write tests for every component
4. Never use `any` type — be specific

## Context
Working on e-commerce platform:
- React 18 + Next.js
- Tailwind CSS for styling
- Zod for validation
- Jest + React Testing Library for tests
```

### Ativando um Agente

```bash
# Via slash command
/agent frontend-specialist

# Via @mention
@frontend-specialist Refactor the product card component

# Programaticamente em CLAUDE.md
/agent plan
```

### Boas Práticas com Agentes

1. **Nome descritivo**: "Backend-Specialist" não "agent1"
2. **Escopo claro**: Defina exatamente o que o agente faz
3. **Tool restrictions**: Deny ferramentas desnecessárias
4. **Context específico**: Inclua arquitetura do projeto
5. **Reutilizar globalmente**: Salve em `~/.claude/agents/` para todos projetos

---

## Sistema de Tasks

### O que é Task?

Tasks é o sistema de gerenciamento de trabalho em Claude Code que permite:

- **Criação de listas**: Tarefas com status (pending → in_progress → completed)
- **Dependências**: Tarefa A bloqueia Tarefa B
- **Multi-sessão**: Aponta múltiplas instâncias de Claude para mesma task list
- **Parallelização**: Até 10 tasks concorrentes

### Anatomia de uma Task

```javascript
{
  id: "task-1",
  subject: "Implement user authentication",
  description: "Add JWT-based auth system with refresh tokens",
  status: "pending",           // pending | in_progress | completed | deleted
  owner: "dex",               // Qual agente/pessoa está trabalhando

  // Dependências
  blockedBy: ["task-0"],      // Não pode iniciar até task-0 completar
  blocks: ["task-2", "task-3"], // Estas tarefas dependem desta

  // Timestamps
  createdAt: "2026-03-24T10:00:00Z",
  startedAt: "2026-03-24T10:05:00Z",
  completedAt: null,

  // Metadados
  priority: "high",
  tags: ["auth", "backend"],
  metadata: {
    estimatedHours: 4,
    actualHours: 3.5
  }
}
```

### Fluxo de Vida da Task

```
┌─────────────┐
│   pending   │  Tarefa criada, não iniciada
└──────┬──────┘
       │ Claude inicia trabalho
┌──────▼──────────────┐
│   in_progress      │  Tarefa em execução
└──────┬──────────────┘
       │ Trabalho completo
       ├─ Se sucesso → completed ✓
       └─ Se cancelado → deleted ✗

┌─────────────┐
│  completed  │  Tarefa finalizada
└─────────────┘
```

### Criando Tasks Programaticamente

```bash
# Via CLI
claude task create "Implement password reset flow"

# Via slash command
/task add "Fix bug in payment processing"

# Via CLAUDE.md (usando notation)
[ ] Task: Update documentation
[x] Task: Deploy to staging
```

### Dependências Entre Tasks

```markdown
# Fluxo Correto de Desenvolvimento

[ ] Task 1: Design database schema
    └─ Task 2: Create migrations (blockedBy: Task 1)
       └─ Task 3: Implement API endpoints (blockedBy: Task 2)
          └─ Task 4: Write tests (blockedBy: Task 3)
             └─ Task 5: Deploy (blockedBy: Task 4)
```

**Evita:**
```
❌ Implementar endpoint (Task 3) antes de migration (Task 2)
❌ Deployar (Task 5) antes de testes (Task 4)
```

### Task Best Practices

1. **Tamanho certo**: 15-30 minutos de trabalho cada
2. **Descrição clara**: Aceita critérios específicos
3. **Dependências reais**: Não crie bloqueadores falsos
4. **Owner específico**: Assigne a um agente ou pessoa
5. **Tags para busca**: Facilitam filtrar tarefas

---

## Slash Commands

### O que são Slash Commands?

Slash commands são atalhos que você digita para executar workflows pré-definidos:

```
/help          → Mostra todos os comandos
/clear         → Limpa contexto da sessão
/abort         → Para tarefa atual
/undo          → Desfaz últimas mudanças
```

### Built-in Commands

| Comando | Função | Exemplo |
|---------|--------|---------|
| `/help` | Lista todos comandos disponíveis | `/help` |
| `/init` | Gera template CLAUDE.md | `/init` |
| `/keybindings` | Abre editor de atalhos | `/keybindings` |
| `/permissions` | Configura permissões | `/permissions` |
| `/status` | Mostra estado de CLAUDE.md e settings | `/status` |
| `/clear` | Limpa contexto (não deleta history) | `/clear` |
| `/abort` | Para execução atual | `/abort` |
| `/undo` | Desfaz últimas mudanças | `/undo` |
| `/mcp` | Gerencia MCP servers | `/mcp add http://localhost:3000` |
| `/agent` | Ativa agente específico | `/agent plan` |
| `/memory` | Gerencia memory files | `/memory view` |

### Criando Slash Commands Customizados

Crie em `.claude/commands/commit.md`:

```markdown
---
name: "commit"
description: "Create an atomic git commit with conventional commit message"
icon: "📝"
shortcut: "ctrl+shift+c"
---

# Commit Command

Follow these steps for a quality commit:

1. Run \`git diff --stat\` to show changed files
2. Analyze changes for logical grouping
3. Write commit message in conventional format:
   - feat: new feature
   - fix: bug fix
   - docs: documentation
   - refactor: code reorganization
4. Include reference if applicable: [Story 2.1]
5. Run \`git commit -m "message"\`

Example:
\`\`\`bash
git commit -m "feat: add user authentication with JWT"
\`\`\`

## Tips
- Keep commits atomic (one logical change)
- Use imperative mood: "add" not "adds" or "added"
- Reference story IDs if applicable
- Sign commits if configured: \`git commit -S\`
```

**Usando:**

```bash
/commit
```

### Command Best Practices

1. **Se usa 2x, vira comando**: Rule of thumb
2. **Nome descritivo**: `/test-coverage` não `/run`
3. **Documento bem**: Inclua exemplos
4. **Coloque no controle de versão**: `.claude/commands/` → git commit
5. **Faça reutilizável**: Parametrize onde possível

---

## Integração MCP

### O que é MCP?

Model Context Protocol é um padrão aberto para integração de ferramentas com Claude Code. Permite conectar:

- Ferramentas de desenvolvimento (git, docker, k8s)
- Serviços em nuvem (AWS, GCP, Azure)
- Bancos de dados
- APIs customizadas
- Sistemas internos da empresa

### Arquitetura MCP

```
Claude Code
    ↓ (usando MCP)
MCP Server
    ↓ (comunica via HTTP/stdio)
Ferramenta/Serviço
(git, Docker, GitHub, Slack, etc.)
```

### Configurando um MCP Server

```bash
# Adicionar GitHub MCP
claude mcp add \
  --transport http \
  --url "https://github.com/anthropics/mcp-github" \
  --auth-token "ghp_xxx"

# Adicionar Docker MCP local
claude mcp add \
  --transport stdio \
  --command "/usr/local/bin/docker-mcp" \
  --args '["--mode=server"]'
```

### MCPs Populares

| MCP | Uso |
|-----|-----|
| **GitHub** | Criar issues, PRs, codebase search |
| **Docker** | Build/run containers, gerenciar imagens |
| **Slack** | Enviar notificações, ler mensagens |
| **Linear** | Criar/atualizar issues |
| **Calendar** | Verificar disponibilidade |
| **Database** | Query SQL, migrations |
| **Cloud (AWS/GCP)** | Deploy, gerenciar recursos |

### Usando MCP Tools

```bash
# Após adicionar GitHub MCP:
claude "create a GitHub issue for bug in auth"

# Após adicionar Slack MCP:
claude "send a message to #devs channel: deployment complete"

# Referenciar MCP resources com @
claude "@github:repo:main/src/App.tsx explain this file"
```

### MCP Best Practices

1. **Autenticação segura**: Use variáveis de ambiente, nunca hardcode tokens
2. **Escreva permissões**: Restrinja MCP servers às ferramentas necessárias
3. **Teste em plano**: Use plan mode antes de ações destrutivas
4. **Documentar**: Deixe claro qual MCP faz o quê
5. **Graceful degradation**: Configure fallbacks se MCP falhar

---

## Keybindings e Atalhos

### O que são Keybindings?

Configurações que mapeiam combinações de teclas a ações em Claude Code:

```
Ctrl+E → Abrir editor externo
Cmd+K → Limpar contexto
Shift+Tab → Ciclar modos de permissão
```

### Estrutura de keybindings.json

```json
{
  "$schema": "https://www.schemastore.org/claude-code-keybindings.json",
  "$docs": "https://code.claude.com/docs/en/keybindings",
  "bindings": [
    {
      "context": "Chat",
      "bindings": {
        "ctrl+e": "chat:externalEditor",
        "ctrl+k": "chat:clear",
        "ctrl+s": "chat:submit",
        "ctrl+u": null
      }
    },
    {
      "context": "Terminal",
      "bindings": {
        "ctrl+c": "terminal:interrupt",
        "shift+enter": "terminal:submit"
      }
    }
  ]
}
```

### Contextos Disponíveis

- **Chat**: Entrada de texto do chat principal
- **Terminal**: Terminal integrado
- **Command Palette**: Quando typing commands
- **Global**: Todos contextos

### Actions Disponíveis

| Ação | Contexto | Descrição |
|------|----------|-----------|
| `chat:submit` | Chat | Enviar mensagem |
| `chat:clear` | Chat | Limpar contexto |
| `chat:externalEditor` | Chat | Abrir editor externo |
| `terminal:submit` | Terminal | Executar comando |
| `terminal:interrupt` | Terminal | Interrupt (Ctrl+C) |
| `modeSwitch:cycle` | Global | Ciclar modos (Ask→Auto→Plan→Ask) |
| `/slash-command` | Global | Executar qualquer slash command |

### Criar Keybinding para Custom Command

```json
{
  "context": "Chat",
  "bindings": {
    "ctrl+shift+c": "/commit",
    "ctrl+shift+t": "/test",
    "ctrl+shift+l": "/lint"
  }
}
```

### Keybinding Best Practices

1. **Não conflitar**: Evite conflitar com atalhos do SO/IDE
2. **Nmemônico**: Ctrl+T para test (mnemônico)
3. **Consistência**: Siga padrão do seu IDE (VS Code, Vim, etc)
4. **Documentar**: Deixe comentários para equipe
5. **Testar**: Certifique que não conflita com SO

---

## Permissões e Segurança

### O que é o Sistema de Permissões?

Sistema que controla QUAIS ferramentas Claude pode usar e QUANDO precisa pedir permissão:

```
┌─────────────────────────────────────────┐
│ Arquivo a editar?                       │
├─────────────────────────────────────────┤
│ Verificar: settings.json                │
│ • allow: executa sem pedir             │
│ • ask: pede confirmação                │
│ • deny: bloqueia                       │
└─────────────────────────────────────────┘
```

### Três Tipos de Regras

```json
{
  "permissions": {
    "allow": [
      "read",
      "editFile:src/**/*.ts"
    ],
    "ask": [
      "bash:*.sh",
      "gitPush"
    ],
    "deny": [
      "bash:rm -rf",
      "networkRequest:external-api.com"
    ]
  }
}
```

#### Allow — Sem Confirmação
```json
"allow": [
  "read",                    // Ler qualquer arquivo
  "editFile:src/**/*.ts",   // Editar TypeScript em src/
  "bash:npm"                // Rodar npm sem pedir
]
```

#### Ask — Pedir Confirmação
```json
"ask": [
  "gitPush",                // Sempre perguntar antes de push
  "bash:*",                 // Toda vez antes de bash
  "deleteFile"              // Confirmar deleção
]
```

#### Deny — Bloqueador Total
```json
"deny": [
  "bash:rm",                // Nunca rodar rm
  "gitPushForce",          // Nunca fazer force push
  "editFile:.env"           // Nunca editar .env
]
```

### Modos de Permissão

**Mudar rapidamente:** Pressione `Shift+Tab` para ciclar

#### 1. Ask Mode (Padrão)
- Claude pede confirmação para ações
- Seguro, um pouco mais lento
- **Ideal para**: Desenvolvimento normal

#### 2. Auto-Accept Edits
- Aceita edições automaticamente
- Ainda pede para bash/git
- **Ideal para**: Já confiam no código

#### 3. Plan Mode
- Read-only (zero modificações)
- Apenas análise e planejamento
- **Ideal para**: Reviews e arquitetura

#### 4. Don't Ask Mode (Perigoso)
- Auto-nega tudo não na allow list
- Sem prompts, silencioso
- **Ideal para**: CI/CD automatizado

#### 5. Auto Mode
- Classificador revisa cada ação
- Ações seguras passam, suspeitas bloqueiam
- **Ideal para**: Equilíbrio entre velocidade e segurança

### Configurando Permissões

#### Via settings.json
```json
{
  "permissions": {
    "defaultMode": "ask",
    "allow": [
      "read",
      "editFile:src/**/*"
    ],
    "ask": [
      "bash",
      "gitPush"
    ]
  }
}
```

#### Via slash command
```bash
/permissions set allow read editFile bash:npm
/permissions set deny bash:rm
/permissions set ask gitPush
```

#### Projeto-específico
Crie `.claude/settings.json` para sobrescrever global:

```json
{
  "permissions": {
    "allow": ["read", "editFile"],
    "ask": ["bash", "gitPush"]
  }
}
```

### Security Best Practices

1. **Deny por padrão**: Whitelist, não blacklist
2. **Específico possível**: `editFile:src/**/*.ts` não `editFile`
3. **Review permissões**: Revise quando novo no projeto
4. **Use Plan Mode**: Antes de fazer mudanças grandes
5. **Never `--dangerously-skip-permissions`**: Exceto em Docker isolado

### Sandboxing

Bash commands executam em sandbox OS-level que restringe:
- Filesystem (pode-se configurar /home whitelist)
- Network access
- Resource limits
- Processo killing

---

## Hooks e Automação

### O que são Hooks?

Hooks são comandos shell que executam em pontos-chave do lifecycle de Claude Code, permitindo automação determinística.

**Diferença de LLM:**
```
❌ LLM: "Claude, por favor, rode prettier após editar código"
       (Claude pode esquecer, fazer errado, pular)

✓ Hook: SEMPRE roda prettier, garantido
        (determinístico, não depende do LLM)
```

### Lifecycle Hooks

```
┌──────────────────────────────────────────┐
│ 1. SessionStart                          │
│    (antes de tudo na sessão)            │
└────────────────┬─────────────────────────┘
                 ↓
┌──────────────────────────────────────────┐
│ 2. UserPromptSubmit                      │
│    (usuário digita e aperta enter)       │
└────────────────┬─────────────────────────┘
                 ↓
┌──────────────────────────────────────────┐
│ 3. PreToolUse (ANTES da ferramenta)      │
│    • Validar inputs                      │
│    • Adicionar contexto                  │
│    • Bloquear ações perigosas            │
└────────────────┬─────────────────────────┘
                 ↓
        [Ferramenta Executa]
                 ↓
┌──────────────────────────────────────────┐
│ 4. PostToolUse (DEPOIS da ferramenta)    │
│    • Rodar formatadores                  │
│    • Executar testes                     │
│    • Fazer log                           │
└────────────────┬─────────────────────────┘
                 ↓
┌──────────────────────────────────────────┐
│ 5. Notification (Claude quer alertar)    │
│    • Integração com Slack/Discord        │
│    • Registros importantes              │
└────────────────┬─────────────────────────┘
                 ↓
┌──────────────────────────────────────────┐
│ 6. Stop (Claude terminou resposta)       │
│    • Cleanup final                       │
│    • Registos                            │
└──────────────────────────────────────────┘
```

### Definindo Hooks

Crie em `.claude/hooks/hook-name.sh`:

```bash
#!/bin/bash
# .claude/hooks/post-file-edit.sh
# Executa após qualquer edição de arquivo

set -e  # Exit on error

if [[ $EDITED_FILE == *.ts ]]; then
  echo "🔍 Linting TypeScript..."
  npx eslint "$EDITED_FILE" --fix

  echo "✨ Formatando..."
  npx prettier "$EDITED_FILE" --write
fi

if [[ $EDITED_FILE == *.md ]]; then
  echo "📝 Verificando markdown..."
  npx markdownlint-cli2 "$EDITED_FILE"
fi
```

### PreToolUse Hook (Mais Sofisticado)

```bash
#!/bin/bash
# .claude/hooks/pre-git-push.sh
# Valida antes de fazer push

if [[ "$TOOL_NAME" == "bash" ]]; then
  if [[ "$TOOL_INPUT" == *"rm -rf"* ]]; then
    echo "❌ BLOQUEADO: Comando rm -rf detectado!"
    exit 1
  fi
fi

if [[ "$TOOL_NAME" == "editFile" ]]; then
  if [[ "$EDITED_FILE" == ".env"* ]]; then
    echo "❌ BLOQUEADO: Tentativa de editar arquivo sensível"
    exit 1
  fi
fi
```

### Registrando Hooks no CLAUDE.md

```yaml
hooks:
  post-file-edit:
    - script: ".claude/hooks/post-file-edit.sh"
      filePattern: "**/*.ts"
      description: "Run linter and formatter"

  pre-tool-use:
    - script: ".claude/hooks/pre-git-push.sh"
      tool: ["bash", "gitPush"]
      description: "Validate before git operations"
```

### Hook Best Practices

1. **Falhe rápido**: Use `set -e` para exit em erro
2. **Logging claro**: Indique sucesso/falha com emojis
3. **Sem surpresas**: Documente o que faz
4. **Idempotente**: Rodar 2x = mesmo resultado
5. **Rápido**: Mantenha < 2 segundos

---

## Skills — Estendendo Funcionalidades

### O que são Skills?

Skills são extensões que dão a Claude novas instruções ou comandos customizados reutilizáveis:

```
Skills = Instruções + Comandos + Lógica
```

**Diferença de Commands:**
- **Commands**: Workflow que Claude segue (.md)
- **Skills**: Lógica/funcionalidade que Claude executa (JavaScript/Python)

### Anatomia de uma Skill

```javascript
// .claude/skills/test-reporter.skill.js
// Fornece funcionalidade: "generate-test-report"

module.exports = {
  name: "test-reporter",
  version: "1.0.0",
  description: "Generate formatted test reports from jest output",

  commands: [
    {
      name: "generate-test-report",
      description: "Generate colored test report from jest JSON",
      parameters: {
        jsonFile: { type: "string", required: true },
        format: { type: "enum", values: ["html", "markdown", "terminal"] }
      }
    }
  ],

  async execute(command, params) {
    if (command === "generate-test-report") {
      const fs = require("fs");
      const json = JSON.parse(fs.readFileSync(params.jsonFile));

      return formatReport(json, params.format);
    }
  }
};

function formatReport(testData, format) {
  if (format === "markdown") {
    return `# Test Results\n\n✅ ${testData.numPassedTests}/${testData.numTotalTests}`;
  }
  // ... resto da lógica
}
```

### Usando Skills

```bash
# Arquivo .claude/CLAUDE.md menciona skills
skills:
  - test-reporter
  - deployment-helper

# Claude pode então usar:
claude "generate a test report from the latest jest output"
```

### Built-in Skills

Claude Code inclui várias skills:

- **code-search**: Buscar padrões no codebase
- **dependency-analyzer**: Analisar dependências
- **performance-profiler**: Profile de performance
- **security-scanner**: Análise de segurança

### Skill Best Practices

1. **Uma responsabilidade**: Uma skill = um domínio
2. **Reutilizável**: Funcione em múltiplos projetos
3. **Testes inclusos**: Inclua testes da skill
4. **Documentar**: README com exemplos
5. **Versionado**: Mantenha changelog

---

## Integração com IDEs

### VS Code (Recomendado)

Claude Code tem integração nativa com VS Code:

#### Instalação

```bash
# No VS Code:
Cmd+Shift+X (Mac) / Ctrl+Shift+X (Windows/Linux)
Buscar "Claude Code"
Clicar "Install"

# Ou via terminal:
code --install-extension anthropic.claude-code
```

#### Recursos

- **Diff Viewer**: Vê mudanças lado-a-lado
- **Tabs**: Múltiplas conversas em paralelo
- **Integrated Terminal**: CLI dentro do VS Code
- **File References**: @arquivo com linha específica
- **Git Integration**: Ver git status

#### Usar CLI Dentro de VS Code

```bash
# No terminal integrado do VS Code:
claude "refactor this component"
claude -c  # Resumir última conversa
/help      # Ver comandos disponíveis
```

### JetBrains IDEs

Suporte parcial para IntelliJ, PyCharm, Goland:

- CLI funciona normalmente
- Algumas features de IDE podem não estar disponíveis
- Use modo "headless" para melhor compatibilidade

### Neovim / Vim

Claude Code é CLI-native, funciona perfeitamente com Vim:

```vim
:! claude "explain this function"
:read ! claude "generate unit tests for this file"
```

### GitHub Codespaces

Claude Code funciona em Codespaces:

```bash
# No Codespace terminal:
npm install -g @anthropic-ai/claude-code
claude auth
claude "start developing"
```

---

## Boas Práticas e Patterns

### Pattern 1: Context Management

**Problema**: Contexto fica grande, Claude fica lento

**Solução**: Estrutura em camadas

```
├── Global CLAUDE.md          (está sempre)
├── .claude/CLAUDE.md         (projeto)
├── .claude/rules/            (carrega conforme necessário)
├── .claude/commands/         (executar explicitamente)
└── .claude/agents/           (ativar quando necessário)
```

**Implementar:**
1. Mova instruções genéricas para `~/.claude/CLAUDE.md`
2. Projeto-específico em `.claude/CLAUDE.md`
3. Domínio-específico em `.claude/rules/`
4. Limpe contexto com `/clear` entre tasks

### Pattern 2: Task Breakdown

**Problema**: "Implemente todo o sistema de auth" é vago demais

**Solução**: Quebra em 5-10 minutos tarefas

```
❌ Ruim:
[ ] Implementar autenticação

✅ Bom:
[ ] Criar schema de usuários (5 min)
    ├─ [ ] Escrever migrations (5 min)
    ├─ [ ] Criar tipos TypeScript (3 min)
    └─ [ ] Adicionar validações com Zod (5 min)
[ ] Implementar API endpoints (10 min)
    ├─ [ ] POST /auth/register (5 min)
    ├─ [ ] POST /auth/login (5 min)
    └─ [ ] POST /auth/refresh (5 min)
[ ] Testes automatizados (5 min)
[ ] Deploy (2 min)
```

### Pattern 3: Plan Before Code

**Sempre use Plan Mode primeiro:**

```bash
# 1. Modo Plan
claude "let's refactor the authentication system"
# Claude: "Aqui está meu plano: 1) ... 2) ... 3) ..."

# 2. Aprovar plano
"Looks good, execute it"

# 3. Implementação
# Claude: Executa o plano aprovado
```

### Pattern 4: Custom Commands para Workflows

**Se usa 2x, vira comando:**

```markdown
# .claude/commands/test-coverage.md

Workflow:
1. Run tests with coverage: npm run test:cov
2. Check coverage report
3. Identify uncovered lines
4. Suggest tests for gaps
```

### Pattern 5: Memory-Driven Development

**Use memory para aprender padrões:**

```bash
# Sessão 1: Cria novo padrão
claude "create a custom hook for form validation"
# Claude escreve notas na memory

# Sessão 2: Reutiliza padrão
claude "create another custom hook for checkbox handling"
# Claude lê memory, reutiliza padrão automaticamente
```

### Pattern 6: MCP for External Integrations

**Use MCP para conectar com ferramentas externas:**

```bash
# Ao invés de:
claude "create a GitHub issue manually"

# Use MCP:
claude "create a GitHub issue: Fix auth bug in prod"
# Claude usa GitHub MCP automáticamente
```

---

## Error Handling e Debugging

### Comum Issues e Soluções

#### 1. "Command not found: claude"

```bash
# Solução 1: Instalar globalmente
npm install -g @anthropic-ai/claude-code

# Solução 2: Verificar PATH
echo $PATH | grep npm

# Solução 3: Versão incompatível
npm uninstall -g @anthropic-ai/claude-code
npm install -g @anthropic-ai/claude-code@latest
```

#### 2. "Invalid API Key"

```bash
# Reautenticar
claude auth logout
claude auth

# Verificar token (não compartilhar!)
echo $CLAUDE_API_KEY | head -c 10
```

#### 3. "Permission Denied" (Arquivo não pode ser editado)

```bash
# Verificar permissões
/permissions  # Ver configuração

# Modo plan
Shift+Tab     # Ciclar para Plan Mode

# Verificar settings.json
cat .claude/settings.json | grep -A10 permissions
```

#### 4. Contexto Cheio (Claude fica lento)

```bash
# Limpar contexto
/clear

# Ou reiniciar sessão
exit
claude -c  # Resumir última conversa
```

#### 5. MCP Não Funciona

```bash
# Diagnosticar
claude mcp list

# Debugar MCP
claude --mcp-debug
```

### Debugging Strategy

**Sempre use plano:**

```bash
# Ao invés de:
claude "fix the bug"

# Use:
claude "I'm getting error X in file Y. Let's debug it step by step"

# Modo Plan para entender sem fazer mudanças:
Shift+Tab  # Ativar Plan Mode
claude "debug the authentication flow"
```

### Ferramentas de Diagnóstico

```bash
# Status completo
/status

# Ver toda configuração
cat ~/.claude/CLAUDE.md
cat .claude/CLAUDE.md
cat .claude/settings.json

# Ver memory
ls -la .claude/memory/

# Ver hooks
ls -la .claude/hooks/

# Ver agents
ls -la .claude/agents/

# Diagnóstico do sistema
claude doctor
```

### Logging para Debug

```bash
# Habilitar debug verbose
export CLAUDE_DEBUG=true
claude "seu comando"

# Ver logs
tail -f ~/.claude/logs/claude.log

# Logs de MCP
claude --mcp-debug --verbose
```

---

## Referências e Recursos

### Documentação Oficial

- **CLI Reference**: https://code.claude.com/docs/en/cli-reference
- **Settings**: https://code.claude.com/docs/en/settings
- **Memory**: https://code.claude.com/docs/en/memory
- **Subagents**: https://code.claude.com/docs/en/sub-agents
- **MCP Integration**: https://code.claude.com/docs/en/mcp
- **Keybindings**: https://code.claude.com/docs/en/keybindings
- **Permissions**: https://code.claude.com/docs/en/permissions
- **Hooks**: https://code.claude.com/docs/en/hooks-guide
- **Best Practices**: https://code.claude.com/docs/en/best-practices
- **Troubleshooting**: https://code.claude.com/docs/en/troubleshooting

### Comunidade e Recursos

- **GitHub Oficial**: https://github.com/anthropics/claude-code
- **GitHub Awesome Claude Code**: https://github.com/hesreallyhim/awesome-claude-code
- **Subagents Directory**: https://subagents.app/
- **MCP Marketplace**: https://mcpmarket.com/

### Guias Educacionais

- **Shipyard Cheatsheet**: https://shipyard.build/blog/claude-code-cheat-sheet/
- **Medium Articles**: Buscar por "Claude Code best practices"
- **ClaudeLog Docs**: https://claudelog.com/
- **SFEIR Institute**: Cursos sobre Claude Code

### Repositórios Úteis

- **Claude Code Hooks**: https://github.com/karanb192/claude-code-hooks
- **Claude Code Best Practices**: https://github.com/shanraisshan/claude-code-best-practice
- **Subagents Collection**: https://github.com/VoltAgent/awesome-claude-code-subagents

---

## Próximos Passos

### Início Rápido (Primeira Hora)

1. Instalar: `npm install -g @anthropic-ai/claude-code`
2. Autenticar: `claude auth`
3. Criar CLAUDE.md: `claude "help me set up my first CLAUDE.md"`
4. Explorar: `claude "explore my project structure"`

### Profundidade Intermediária (Primeira Semana)

1. Configurar MCP (GitHub, Slack)
2. Criar custom commands
3. Setup de rules para seu projeto
4. Entender memory system

### Avançado (Primeiras Semanas)

1. Criar agentes customizados
2. Setup de hooks para automação
3. Integrar com CI/CD (Vercel, GitHub Actions)
4. Implementar skills customizadas

---

## Resumo por Nível

### 🟢 Iniciante
- Conhece CLI básico: `claude "seu prompt"`
- Entende CLAUDE.md global
- Usa permission modes (Ask/Plan)
- Vê arquivo `.claude/` básico

### 🟡 Intermediário
- Cria CLAUDE.md customizado por projeto
- Configura MCP servers
- Cria custom commands
- Entende rules contextuais
- Usa memory efetivamente

### 🔴 Avançado
- Cria agentes customizados
- Setup hooks para automação
- Implementa skills
- Integra com CI/CD
- Otimiza context management

---

**Última Atualização:** Março 2026
**Versão Claude Code:** 2.2.x+
**Contribuidores:** Comunidade Anthropic
