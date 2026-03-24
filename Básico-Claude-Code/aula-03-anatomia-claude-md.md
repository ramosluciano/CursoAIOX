<!-- metadata
module: 0
lesson: 3
-->

# Aula 03 — Anatomia do CLAUDE.md

## 🎯 Objetivos desta Aula

- [ ] Entender propósito e estrutura do arquivo CLAUDE.md
- [ ] Aprender a criar regras de permissões (allow/deny)
- [ ] Configurar variáveis de ambiente
- [ ] Entender precedência de configurações
- [ ] Usar hooks para automação

## 📋 O que é CLAUDE.md?

`CLAUDE.md` é um arquivo de **configuração global do seu projeto** que instrui Claude Code sobre:

- ✅ Como se comportar no seu projeto
- ✅ Quais ferramentas são permitidas/bloqueadas
- ✅ Quais variáveis de ambiente usar
- ✅ Scripts a executar automaticamente
- ✅ Padrões de código que você quer manter

### Localização

```
.claude/
├── CLAUDE.md              ← Este arquivo (obrigatório)
├── memory/
│   └── MEMORY.md          ← Memória persistente
├── rules/
│   ├── agent-authority.md
│   └── story-lifecycle.md
└── auth-token            ← Seu token (gitignore!)
```

### Precedência de Configurações

```
Global (.claude/CLAUDE.md)
        ↓
Project (.claude/CLAUDE.md)
        ↓
Environment Variables (.env)
        ↓
CLI Flags (/yolo, etc)

← Mais específico ganha
```

## 🏗️ Estrutura Básica

### Template Inicial

```markdown
# Project Guidelines

> Instruções obrigatórias aplicadas a este projeto.

---

## 📋 Code Standards

- Use TypeScript quando possível
- Prettier para formatação
- 2 espaços de indentação
- Camel case para variáveis

## 🔐 Permissions

Ferramentas permitidas:
- Allow: npm, git (read-only)
- Allow: Read, Write, Edit, Bash

Ferramentas bloqueadas:
- Deny: docker run
- Deny: sudo
- Deny: rm -rf (perigoso!)

## 🌍 Environment Variables

```bash
NODE_ENV=development
API_URL=http://localhost:3000
LOG_LEVEL=debug
```

## 🔧 Hooks

### Pre-commit
```bash
npm run lint
npm run test
```

### Pre-push
```bash
npm run build
```

---
```

## 🔑 Seções Principais

### 1. Code Standards

Defina padrões de codificação:

```markdown
## 📋 Code Standards

- Language: TypeScript 5+
- Linter: ESLint + Prettier
- Formatter: Prettier (2 spaces)
- Testing: Vitest + Playwright
- Package manager: npm
- Node version: 18+
- Git hooks: husky + lint-staged

### Database
- Use Supabase for production data
- Local SQLite for dev/testing
- Always use migrations

### API
- Use REST endpoints
- Return JSON responses
- Status codes: 200, 201, 400, 404, 500
- Error format: { error: string, code: string }
```

### 2. Permissions (Allow/Deny Rules)

**Allow específicas:**

```markdown
## 🔐 Permissions

### Allowed Tools
- npm install, npm test, npm run
- git add, git commit, git status (NO git push)
- read files (all)
- write files (src/, tests/)
- edit files (src/, tests/)

### Denied Tools
- docker run (use Docker Compose only)
- sudo (request help for admin tasks)
- git push (ask @github-devops)
- rm -rf (use with caution)
```

**Deny específicas:**

```markdown
### Deny Rules

**Block tools:**
- Deny: `docker run` — Use docker-compose.yml instead
- Deny: `sudo` — Ask for help if admin task needed
- Deny: `git push` — Only @github-devops can push
- Deny: `rm -rf` — Too destructive without confirmation

**Block file patterns:**
- Deny: .env* files (sensitive data)
- Deny: node_modules/ (generated)
- Deny: .git/ (repository meta)
```

### 3. Environment Variables

```markdown
## 🌍 Environment Variables

Create `.env.local` (not committed):

```bash
# API Configuration
CLAUDE_API_KEY=your-key-here
API_URL=http://localhost:3000
API_TIMEOUT=30000

# Database
DATABASE_URL=postgresql://localhost/mydb

# Logging
LOG_LEVEL=info
DEBUG=false

# Feature Flags
FEATURE_X_ENABLED=true
```

⚠️ **NEVER commit `.env` to git!**
```

### 4. Hooks (Pre-commit, Pre-push)

```markdown
## 🔧 Hooks

### Pre-commit
Executado antes de cada commit:

```bash
npm run lint
npm run test
npm run typecheck
```

### Pre-push
Executado antes de `git push`:

```bash
npm run build
npm run test:e2e
```

### On Save (optional)
Executado ao salvar arquivo:

```bash
prettier --write .
```
```

## 💻 Exercício 1: Criar CLAUDE.md Pessoal

### Passo 1: Criar arquivo

```bash
touch .claude/CLAUDE.md
```

### Passo 2: Adicionar conteúdo básico

```markdown
# My Project Guidelines

## Code Standards
- Language: JavaScript/TypeScript
- Formatter: Prettier
- Linter: ESLint

## Permissions
Allow: npm, git (read), Read, Write
Deny: docker run, sudo, git push

## Environment
NODE_ENV=development
API_URL=http://localhost:3000
```

### Passo 3: Testar

No Claude Code:
```
> Leia meu CLAUDE.md e resume regras
```

Claude deve listar suas regras corretamente.

## 💻 Exercício 2: Adicionar Deny Rule

Adicione ao CLAUDE.md:

```markdown
## Restricted Operations

- Deny: rm -rf (too destructive)
- Deny: .env files (sensitive)
```

Agora tente:
```
> Delete a file usando rm -rf
```

Claude deve recusar por causa da deny rule!

## 💻 Exercício 3: Configurar Hooks

Adicione ao CLAUDE.md:

```markdown
## Hooks

### Pre-commit
```bash
npm run lint
npm run test
```
```

Commita um arquivo:
```bash
echo "test" > test.txt
git add test.txt
git commit -m "test"
```

Hooks devem executar automaticamente (se configurados no seu sistema).

## 🔗 Recursos

- **[CLAUDE.md Reference](https://code.claude.com/docs/claude-md)** — Documentação completa
- **[Permission Rules](https://code.claude.com/docs/permissions)** — Allow/Deny detalhado
- **[Hooks Guide](https://code.claude.com/docs/hooks)** — Setup de pre-commit/pre-push
- **[Best Practices](https://code.claude.com/docs/best-practices)** — Padrões recomendados

## ⚡ Checkpoint

Valide que você:

- [ ] Criou arquivo `.claude/CLAUDE.md`
- [ ] Adicionou seção de Code Standards
- [ ] Adicionou Allow rules
- [ ] Adicionou Deny rules
- [ ] Configurou variáveis de ambiente
- [ ] Entendeu precedência de configs
- [ ] Claude lê e respeita suas regras

## 📝 Resumo

- ✅ CLAUDE.md é configuração global do projeto
- ✅ Define padrões, permissões, variáveis
- ✅ Allow/Deny rules controlam ferramentas
- ✅ Hooks executam antes de ações
- ✅ Precedência: CLI > Env > Project > Global

## 🚀 Próximos Passos

Na **Aula 04** você vai aprender sobre:
- Ask/Auto/Explore modes
- Segurança de permissões
- Como alternar entre modes
- Trade-offs de cada mode

---

*Aula criada por @dev — Básico Claude Code v1.0*
