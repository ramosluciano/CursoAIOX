# Claude Code — Quick Reference Guide

**Cheat sheet visual para consulta rápida**

---

## Command Quick Map

```
📝 Chat & Context
  claude "your prompt"           → Iniciar sessão
  claude -c                      → Resumir última conversa
  /clear                         → Limpar contexto
  /abort                         → Parar execução
  /undo                          → Desfazer mudanças

⚙️  Configuração
  /init                          → Gerar CLAUDE.md template
  /status                        → Ver estado config
  /permissions                   → Configurar permissões
  /keybindings                   → Editar atalhos
  /memory                        → Gerenciar memory

🔄 Git
  /git add/commit/push          → Git operations
  /git status                    → Ver mudanças
  /git diff                      → Ver diffs

🤖 Agentes & Tasks
  /agent plan                    → Ativar agent plan
  /task add "descrição"          → Criar task
  /task list                     → Listar tasks

🧠 MCP
  /mcp add                       → Adicionar MCP server
  /mcp list                      → Listar MCPs
  /mcp remove                    → Remover MCP

🔍 Debugging
  /doctor                        → Diagnosticar sistema
  --verbose                      → Ver logs detalhados
  --mcp-debug                    → Debug MCP
```

---

## Permission Modes Cheat Sheet

| Modo | Atalho | Behavior | Use Case |
|------|--------|----------|----------|
| **Ask** | Padrão | Pedir para cada ação | Desenvolvimento normal |
| **Auto-Accept** | Shift+Tab | Aceita edits, pede bash | Quando confia em código |
| **Plan** | Shift+Tab | Read-only, zero mudanças | Reviews/arquitetura |
| **Don't Ask** | Shift+Tab | Auto-nega tudo não permitido | CI/CD automatizado |
| **Auto** | Shift+Tab | Classifier revisa ações | Equilíbrio velocidade/segurança |

**Atalho universal:** Pressione `Shift+Tab` para ciclar

---

## File Structure Quick Reference

```
Seu Projeto/
├── .claude/                    ← Configuração LOCAL
│   ├── CLAUDE.md              ← Instruções específicas do projeto
│   ├── settings.json          ← Permissões & config do projeto
│   ├── keybindings.json       ← Atalhos do projeto
│   ├── rules/                 ← Regras contextuais
│   │   ├── backend.md
│   │   ├── frontend.md
│   │   └── database.md
│   ├── commands/              ← Slash commands customizados
│   │   ├── commit.md
│   │   ├── test.md
│   │   └── deploy.md
│   ├── agents/                ← Agentes customizados
│   │   ├── backend-specialist.md
│   │   └── frontend-expert.md
│   ├── hooks/                 ← Automação (scripts shell)
│   │   ├── post-file-edit.sh
│   │   └── pre-git-push.sh
│   └── memory/                ← Persistência entre sessões
│       ├── auto.md
│       └── sessions/
│
├── docs/
│   └── (seus arquivos de projeto)
│
└── src/
    └── (seu código)
```

**Global (Todos os Projetos):**
```
~/.claude/
├── CLAUDE.md              ← Instruções globais
├── settings.json          ← Permissões globais
├── keybindings.json       ← Atalhos globais
├── commands/              ← Comandos globais
├── agents/                ← Agentes globais
└── memory/                ← Memory global
```

---

## MCP Setup One-Liners

```bash
# GitHub
claude mcp add --transport http \
  --url "https://github.com/anthropics/mcp-github" \
  --auth-token "ghp_YOUR_TOKEN"

# Docker
claude mcp add --transport stdio \
  --command "/usr/local/bin/docker-mcp"

# Slack
claude mcp add --transport http \
  --url "https://slack-mcp.example.com" \
  --auth-token "xoxb-YOUR_TOKEN"

# Listar todos
claude mcp list

# Ver detalhes
claude mcp info github
```

---

## Agent Activation Patterns

```bash
# Explícito
/agent plan
/agent backend-specialist

# Via mention
@plan Descreve seu request
@backend-specialist Implementar API

# Automático (Claude choose)
"Explore the codebase"  ← Usa Explore agent automaticamente
"Let me plan this"      ← Usa Plan agent
```

---

## Task Dependency Patterns

```markdown
# Pattern 1: Linear Dependency
[ ] Task 1: Setup database
  └─ [ ] Task 2: Create migrations (blockedBy: Task 1)
     └─ [ ] Task 3: Seed data (blockedBy: Task 2)

# Pattern 2: Multiple Dependencies
[ ] Task 1: API design (priority: high)
[ ] Task 2: Frontend design (priority: high)
  └─ [ ] Task 3: Integration (blockedBy: Task 1, Task 2)

# Pattern 3: Parallel Tasks
[ ] Task 1: Write tests
[ ] Task 2: Write docs
[ ] Task 3: Fix bugs
  └─ [ ] Task 4: Code review (blockedBy: Task 1, 2, 3)
```

---

## Keybindings Template

```json
{
  "$schema": "https://www.schemastore.org/claude-code-keybindings.json",
  "bindings": [
    {
      "context": "Chat",
      "bindings": {
        "ctrl+e": "chat:externalEditor",
        "ctrl+k": "chat:clear",
        "ctrl+s": "chat:submit",
        "ctrl+shift+c": "/commit",
        "ctrl+shift+t": "/test",
        "ctrl+shift+l": "/lint",
        "shift+tab": "modeSwitch:cycle"
      }
    }
  ]
}
```

---

## Permission Rules Patterns

```json
{
  "permissions": {
    "defaultMode": "ask",

    "allow": [
      "read",                      // Ler qualquer arquivo
      "editFile:src/**/*.ts",     // Editar TypeScript
      "editFile:src/**/*.tsx",    // Editar React
      "bash:npm"                   // Rodar npm
    ],

    "ask": [
      "bash:*",                    // Pedir antes de bash
      "gitPush",                   // Pedir antes de push
      "gitPushForce",              // Confirmar force push
      "deleteFile"                 // Confirmar deleção
    ],

    "deny": [
      "bash:rm -rf",              // Nunca rm -rf
      "editFile:.env*",           // Nunca editar .env
      "editFile:package.json",    // Nunca editar package.json
      "gitPushForce"              // Nunca força push
    ]
  }
}
```

---

## CLAUDE.md Sections Template

```markdown
# Project Context

## Tech Stack
- React 18 + TypeScript
- Node.js 18+
- PostgreSQL + Prisma

## Code Standards
- TypeScript strict mode
- Prettier formatting
- ESLint rules

## File Organization
/pages       → Next.js routes
/components  → React components
/lib        → Utilities
/api        → Backend

## Common Commands
\`\`\`bash
npm run dev   # Start dev server
npm test      # Run tests
npm run lint  # Lint & format
npm run build # Production build
\`\`\`

## Testing
- Jest for unit tests
- React Testing Library for components
- Minimum 80% coverage

## Git Conventions
- conventional commits (feat:, fix:, docs:, etc)
- Reference story IDs: [Story 2.1]
```

---

## Hook Examples

### Pre-Push Validation
```bash
#!/bin/bash
# .claude/hooks/pre-git-push.sh

if git diff --cached --name-only | grep -E '\.ts?$' > /dev/null; then
  echo "🔍 Linting TypeScript files..."
  npx eslint --fix src/**/*.ts
  git add src/
fi

if git diff --cached --name-only | grep -E '\.test\.ts?$' > /dev/null; then
  echo "🧪 Running tests..."
  npm test -- --passWithNoTests
fi
```

### Post-File-Edit
```bash
#!/bin/bash
# .claude/hooks/post-file-edit.sh

if [[ "$EDITED_FILE" == *.tsx ]]; then
  echo "✨ Formatting React component..."
  npx prettier "$EDITED_FILE" --write
fi

if [[ "$EDITED_FILE" == *.ts ]]; then
  echo "✨ Formatting TypeScript..."
  npx prettier "$EDITED_FILE" --write
fi
```

---

## Rule Frontmatter Patterns

```yaml
# Rule: activates when editing React files
---
paths:
  - "src/components/**/*.tsx"
severity: high
tags: ["react", "frontend"]
contexts: ["always"]
---

# Rule: activates for database files
---
paths:
  - "db/migrations/*.sql"
  - "src/db/**/*.ts"
severity: high
tags: ["database", "safety"]
contexts: ["on-edit"]
---

# Rule: activates for tests
---
paths:
  - "**/*.test.ts"
  - "**/*.spec.ts"
severity: normal
tags: ["testing"]
contexts: ["always"]
---
```

---

## Common Workflows

### Workflow 1: New Feature Development
```bash
1. claude "explore the codebase for the feature area"
2. /agent plan
3. "Create a plan for implementing [feature]"
4. [ ] Review plan → if approved:
5. "Implement according to plan"
6. /test
7. /commit "feat: implement [feature]"
```

### Workflow 2: Bug Fix
```bash
1. Shift+Tab → Plan mode
2. claude "Debug: [error message] in [file]"
3. Claude: Analysis without changes
4. Shift+Tab → Normal mode
5. claude "Fix the issue"
6. /test
7. /commit "fix: [issue]"
```

### Workflow 3: Code Review
```bash
1. Shift+Tab → Plan mode (read-only)
2. claude "Review the changes in [file/PR]"
3. Claude: Suggestions without modifying
4. Note areas to discuss with team
```

### Workflow 4: Refactoring
```bash
1. /agent plan
2. "Refactor [module] for [reason]"
3. Review plan → approve
4. "Execute the refactoring"
5. /test (ensure tests pass)
6. /commit "refactor: [module]"
```

---

## Debugging Checklist

```
❌ Claude não executa?
  [ ] Verificar: claude --version
  [ ] Verificar: claude auth status
  [ ] Limpar: /clear
  [ ] Reiniciar: exit + claude -c

❌ Permissões bloqueando?
  [ ] Ver: /permissions
  [ ] Modo: Shift+Tab para mudar modo
  [ ] Plan: Mode → Shift+Tab

❌ Memory não funcionando?
  [ ] Ver: /memory view
  [ ] Check: ls -la .claude/memory/
  [ ] Limpar: rm -rf .claude/memory/

❌ MCP não conectando?
  [ ] List: claude mcp list
  [ ] Debug: claude --mcp-debug
  [ ] Status: /status

❌ Contexto cheio (lento)?
  [ ] Limpar: /clear
  [ ] Novo: exit + claude -c
  [ ] Rules: Verificar .claude/rules/

❌ Hooks não executando?
  [ ] Ver: ls -la .claude/hooks/
  [ ] Permissão: chmod +x .claude/hooks/*.sh
  [ ] Test: bash .claude/hooks/nome.sh
```

---

## Performance Tips

| Dica | Impacto | Esforço |
|------|---------|---------|
| Dividir tasks em 5-10 min | Alto | Baixo |
| Usar Plan Mode primeiro | Alto | Baixo |
| CLAUDE.md bem estruturado | Alto | Médio |
| Usar rules (não tudo em CLAUDE.md) | Alto | Médio |
| Limpar contexto regular | Médio | Baixo |
| Criar custom commands | Médio | Médio |
| Setup MCP correto | Médio | Médio |
| Usar agentes especializados | Médio | Alto |

---

## Cost Optimization (por modelo)

```
Haiku ($0.25/$1.25 por M tokens)  → Busca, leitura, formatação
  ✓ Usar em: Exploração, processamento dados

Sonnet ($3/$15)                   → Default, criação, código
  ✓ Usar em: Implementação normal

Opus ($15/$75)                    → Decisões críticas
  ✓ Usar em: Arquitetura, refactoring massivo
```

---

## Integration Checklist

```
✓ Checklist: Setup Completo de Claude Code

Nível 1 — Básico (1 hora)
  [ ] Instalar & autenticar
  [ ] Criar CLAUDE.md básico
  [ ] Entender permission modes
  [ ] Explorar projeto

Nível 2 — Intermediário (1 dia)
  [ ] Configurar MCP (GitHub, Slack)
  [ ] Criar custom commands (2-3)
  [ ] Setup regras (.claude/rules/)
  [ ] Configurar keybindings

Nível 3 — Avançado (1 semana)
  [ ] Criar agentes customizados
  [ ] Setup hooks para CI/CD
  [ ] Integrar com vercel/github actions
  [ ] Otimizar memory system
```

---

## Troubleshooting Decision Tree

```
Problem: Claude faz algo inesperado

├─ Comportamento errado?
│  ├─ Sim → Verificar CLAUDE.md (seção relevante)
│  └─ Não → Próximo
│
├─ Não encontra arquivo?
│  ├─ Sim → Usar @ para referenciar: @path/to/file.ts
│  └─ Não → Próximo
│
├─ Bloqueado por permissões?
│  ├─ Sim → /permissions or Shift+Tab para modo
│  └─ Não → Próximo
│
├─ Contexto confuso?
│  ├─ Sim → /clear e recomeçar
│  └─ Não → Próximo
│
└─ Erro genuíno? → /doctor and check logs
```

---

## Recursos Rápidos

**Documentação:**
- Oficial: https://code.claude.com/docs
- Troubleshooting: https://code.claude.com/docs/en/troubleshooting
- Best Practices: https://code.claude.com/docs/en/best-practices

**Comunidade:**
- GitHub: https://github.com/anthropics/claude-code
- Awesome List: https://github.com/hesreallyhim/awesome-claude-code
- MCP Market: https://mcpmarket.com/

**Exemplos:**
- Hooks: https://github.com/karanb192/claude-code-hooks
- Subagents: https://subagents.app/
- Best Practices: https://github.com/shanraisshan/claude-code-best-practice

---

**Última Atualização:** Março 2026
**Versão Claude Code:** 2.2.x+
