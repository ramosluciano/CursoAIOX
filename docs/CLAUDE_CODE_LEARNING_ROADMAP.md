# Claude Code — Learning Roadmap

Roteiro estruturado para dominar Claude Code da Anthropic.

---

## 📚 Estrutura de Conhecimento

Claude Code organiza-se em 3 camadas de complexidade:

```
┌─────────────────────────────────────────────────────────────┐
│ CAMADA 3: AVANÇADO                                          │
│ • Agentes customizados                                      │
│ • Hooks & automação                                         │
│ • Skills e extensões                                        │
│ • Integração CI/CD                                          │
│ • Otimização de contexto                                    │
│ ⏱️ 4-6 semanas de prática                                    │
└─────────────────────────────────────────────────────────────┘
             ↑ Depende de...
┌─────────────────────────────────────────────────────────────┐
│ CAMADA 2: INTERMEDIÁRIO                                     │
│ • MCP servers                                               │
│ • Custom commands                                           │
│ • Rules contextuais                                         │
│ • Memory management                                         │
│ • Task dependencies                                         │
│ ⏱️ 2-3 semanas de prática                                    │
└─────────────────────────────────────────────────────────────┘
             ↑ Depende de...
┌─────────────────────────────────────────────────────────────┐
│ CAMADA 1: INICIANTE                                         │
│ • CLI básico                                                │
│ • CLAUDE.md global                                          │
│ • Permission modes                                          │
│ • Slash commands built-in                                   │
│ ⏱️ 1-2 dias práticos                                        │
└─────────────────────────────────────────────────────────────┘
```

---

## 🟢 NÍVEL 1: INICIANTE (1-2 dias)

### Objetivo
Usar Claude Code para tarefas básicas de desenvolvimento com confiança.

### Tópicos

#### 1.1 Instalação & Setup (30 min)
- [ ] Instalar via npm
- [ ] Autenticar com Anthropic
- [ ] Entender estrutura de diretórios
- [ ] Verificar que funciona: `claude "hello"`

**Atividade:**
```bash
npm install -g @anthropic-ai/claude-code
claude auth
claude "what's in the current directory?"
```

#### 1.2 CLAUDE.md Básico (1 hora)
- [ ] Entender propósito (instruções persistentes)
- [ ] Gerar template com `/init`
- [ ] Adicionar contexto do projeto
- [ ] Documentar tech stack

**Atividade:**
- Executar `/init`
- Editar `.claude/CLAUDE.md`
- Adicionar: stack, convenções de código, comandos comuns
- Testar: `claude "what's our tech stack?"`

#### 1.3 Permission Modes (45 min)
- [ ] Entender 5 modos (ask/auto/plan/don't-ask/auto)
- [ ] Praticar ciclar com `Shift+Tab`
- [ ] Usar Plan mode para exploração
- [ ] Usar Auto mode para velocidade

**Atividade:**
```bash
# Explore sem fazer mudanças
Shift+Tab  # Ativar Plan Mode
claude "analyze this component"

# Voltar para normal
Shift+Tab  # Ativar Ask Mode
```

#### 1.4 CLI Básico (45 min)
- [ ] Comandos essenciais: claude, -c, /clear, /help
- [ ] Referência de arquivo: @filename.ts
- [ ] Referência de linha: @filename.ts:10-20
- [ ] Entender contexto (token window)

**Atividade:**
```bash
claude "what's in src/App.tsx?"
claude "@src/App.tsx:1-50 explain this"
claude "@src/utils/helpers.ts analyze these functions"
```

#### 1.5 Slash Commands (1 hora)
- [ ] /help → listar comandos
- [ ] /status → ver configuração
- [ ] /clear → limpar contexto
- [ ] /undo → desfazer mudanças
- [ ] /permissions → ver regras
- [ ] /keybindings → ver atalhos

**Atividade:**
```bash
/help                  # Ver tudo disponível
/status                # Ver CLAUDE.md carregados
/clear                 # Limpar contexto
/undo                  # Desfazer última mudança
```

### Checkpoint Nível 1 ✅

```bash
# Verificar se sabe:
1. [ ] Instalou e autenticou com sucesso
2. [ ] CLAUDE.md criado e customizado
3. [ ] Consegue ciclar entre modos (Shift+Tab)
4. [ ] Conhece comandos básicos: /help, /clear, /status
5. [ ] Consegue referenciar arquivos: @filename
6. [ ] Entende que contexto é limitado (não cabe tudo)
```

**Parabéns! Agora você pode usar Claude Code para desenvolvimento básico.**

---

## 🟡 NÍVEL 2: INTERMEDIÁRIO (2-3 semanas)

### Objetivo
Otimizar workflow, criar automações, conectar ferramentas externas.

### Tópicos

#### 2.1 Memory System (3-4 horas)

**O que é:**
- Auto memory: Claude escreve notas para si mesmo
- Session memory: Sistema automático de persistência
- CLAUDE.md: Instruções que você escreve

**Aprender:**

1. **Auto Memory**
   - [ ] Entender que Claude toma notas
   - [ ] Fornecer feedback durante sessão
   - [ ] Notas aparecem na próxima sessão
   - [ ] Verificar: `ls -la .claude/memory/`

2. **Session Memory**
   - [ ] Funciona automaticamente
   - [ ] Extrai insights importantes
   - [ ] Compacta após ~10k tokens

3. **CLAUDE.md Optimizado**
   - [ ] Seções por tópico
   - [ ] Atualizar com `#` durante sessão
   - [ ] Rever entre projetos

**Atividade Prática:**

Sessão 1:
```bash
claude "create a React hook for form validation"
# Claude cria hook
# Você valida o resultado
# Adiciona feedback: "Great pattern! Use this for all forms"
```

Sessão 2:
```bash
claude "create another validation hook for checkbox"
# Claude lê memory
# Reutiliza padrão automaticamente
```

#### 2.2 Rules System (4-5 horas)

**O que é:**
Instruções contextuais que carregam quando você edita certos arquivos.

**Aprender:**

1. **Conceito**
   - [ ] Rules carregam sob demanda (não ocupam contexto sempre)
   - [ ] Globos em frontmatter (paths:)
   - [ ] Severidade (high/normal/low)

2. **Criar 3 Rules**
   - [ ] React components rule (.claude/rules/react.md)
   - [ ] Database rule (.claude/rules/database.md)
   - [ ] API rule (.claude/rules/api.md)

3. **Usar Rules**
   - [ ] Editar um arquivo React → rule carrega
   - [ ] Editar migration SQL → database rule carrega
   - [ ] Criar endpoint → API rule carrega

**Atividade Prática:**

1. Criar `.claude/rules/react-components.md`:
```markdown
---
paths:
  - "src/components/**/*.tsx"
severity: high
---

# React Standards
- Use PascalCase
- Functional components
- Add tests alongside
```

2. Criar `.claude/rules/database.md`:
```markdown
---
paths:
  - "db/migrations/*.sql"
  - "prisma/schema.prisma"
severity: high
---

# Database Safety
- Always have rollback
- Test on staging first
- Check for dependencies
```

3. Testar:
```bash
# Editar componente React
claude "refactor this component"
# React rule carrega automaticamente

# Editar migration
claude "add email_verified to users"
# Database rule carrega automaticamente
```

#### 2.3 Custom Commands (4-5 horas)

**O que é:**
Workflows reutilizáveis que você digita como `/commit`, `/test`, etc.

**Aprender:**

1. **Conceito**
   - [ ] Commands são markdown files em .claude/commands/
   - [ ] Executar com / prefix
   - [ ] Reutilizáveis no projeto

2. **Criar 3 Commands**
   - [ ] /commit → workflow de commit convencional
   - [ ] /test → rodar testes com análise
   - [ ] /deploy → checklist de deploy

**Atividade Prática:**

1. Criar `.claude/commands/commit.md`:
```markdown
---
name: "commit"
shortcut: "ctrl+shift+c"
---

# Commit Workflow

1. git diff --stat
2. Review changes
3. Write message: type: description [Story ID]
4. git commit -m "message"
```

2. Criar `.claude/commands/test.md`:
```markdown
---
name: "test"
shortcut: "ctrl+shift+t"
---

# Test & Coverage

1. npm test
2. Analyze coverage report
3. Identify gaps
4. Add missing tests
```

3. Usar:
```bash
/commit
/test
```

#### 2.4 MCP Integration (6-8 horas)

**O que é:**
Conectar ferramentas externas (GitHub, Slack, Docker, etc).

**Aprender:**

1. **Conceito MCP**
   - [ ] Protocol aberto para integrações
   - [ ] MCPs com transport HTTP ou stdio
   - [ ] Acesso a ferramentas externas

2. **Configurar 2 MCPs**
   - [ ] GitHub MCP (criar issues, gerenciar PRs)
   - [ ] Slack MCP (enviar notificações)

3. **Usar MCPs**
   - [ ] Referenciar com @ mention
   - [ ] Deixar Claude usar automaticamente

**Atividade Prática:**

1. Setup GitHub MCP:
```bash
claude mcp add \
  --transport http \
  --url "https://github.com/anthropics/mcp-github" \
  --auth-token "ghp_YOUR_TOKEN"
```

2. Usar:
```bash
claude "create a GitHub issue: Fix auth bug"
# Claude usa GitHub MCP automaticamente

# Ou explicitamente:
claude "@github:repo:main/src Create issue"
```

3. Setup Slack MCP:
```bash
claude mcp add \
  --transport http \
  --url "https://slack-mcp.your-domain.com" \
  --auth-token "xoxb_TOKEN"
```

4. Usar:
```bash
claude "send a message to #dev: deployment complete"
```

#### 2.5 Task System (4-5 horas)

**O que é:**
Gerenciamento de tarefas com dependências, para multi-sessão.

**Aprender:**

1. **Conceito**
   - [ ] Tasks com status: pending → in_progress → completed
   - [ ] Dependências: Task A bloqueia Task B
   - [ ] Multi-sessão: múltiplas instâncias apontam para mesma task

2. **Criar Task List**
   - [ ] Quebrar feature em subtasks
   - [ ] Definir dependências
   - [ ] Estimar duração

3. **Usar Tasks**
   - [ ] Criar com /task add "..."
   - [ ] Marcar in_progress
   - [ ] Marcar completed quando pronto

**Atividade Prática:**

1. Criar lista de tasks para feature:
```markdown
[ ] T1: Design schema (2h)
    ├─ T2: Create migrations (1h) - blockedBy: T1
    └─ T3: Seed data (30m) - blockedBy: T1
[ ] T4: Implement API (3h) - blockedBy: T3
[ ] T5: Create frontend (3h)
```

2. Usar:
```bash
/task add "Design database schema"
# Claude vê task
# Trabalha em T1
# Marca completed: /task mark-done T1
# Sistema automáticamente desbloqueia T2, T3
```

#### 2.6 Keybindings (2 horas)

**Aprender:**

1. **Criar atalhos personalizados**
   - [ ] /keybindings para abrir arquivo
   - [ ] Mapear commands a keys: Ctrl+Shift+C → /commit

2. **Customizar**
   - [ ] Ctrl+Shift+T → /test
   - [ ] Ctrl+Shift+D → /deploy
   - [ ] Shift+Tab (já existe) → cycle modes

**Atividade:**
```json
{
  "bindings": [
    {
      "context": "Chat",
      "bindings": {
        "ctrl+shift+c": "/commit",
        "ctrl+shift+t": "/test",
        "ctrl+shift+d": "/deploy"
      }
    }
  ]
}
```

### Checkpoint Nível 2 ✅

```bash
1. [ ] Memory system funcionando
2. [ ] 3 Rules criadas e em uso
3. [ ] 3 Custom commands criados
4. [ ] 2 MCPs integrados
5. [ ] Task list com dependências
6. [ ] Keybindings customizados
```

**Parabéns! Você consegue automação e integrações.**

---

## 🔴 NÍVEL 3: AVANÇADO (4-6 semanas)

### Objetivo
Arquitetar workflows complexos, criar agentes especializados, otimizar performance.

### Tópicos

#### 3.1 Custom Agents (8-10 horas)

**O que é:**
Personas especializadas com contexto próprio e restrições.

**Aprender:**

1. **Conceito de Agents**
   - [ ] Agent = persona + instruções + ferramentas + permissions
   - [ ] Cada agent roda em contexto isolado
   - [ ] Ativa com /agent ou @mention

2. **Criar 2 Agentes**
   - [ ] React Specialist (frontend)
   - [ ] Backend Architect (infraestrutura)

3. **Customizar**
   - [ ] Model preferido (haiku para tarefas leves)
   - [ ] Tool access (deny ferramentas desnecessárias)
   - [ ] Permission mode

**Atividade:**

1. Criar `.claude/agents/react-specialist.md`:
```markdown
---
name: "React Specialist"
model: "claude-3-5-sonnet"
toolAccess:
  allow: [read, editFile, bash]
  deny: [gitPush, networkRequest]
permissionMode: "auto-accept-edits"
---

# React Expert
You specialize in React, TypeScript, performance.
...
```

2. Usar:
```bash
/agent react-specialist
"Optimize this component for re-renders"
```

#### 3.2 Hooks & Automation (10-12 horas)

**O que é:**
Shell scripts que executam em pontos específicos do lifecycle.

**Aprender:**

1. **Hooks disponíveis**
   - [ ] PreToolUse (antes da ferramenta)
   - [ ] PostToolUse (depois da ferramenta)
   - [ ] PreGitPush (antes de git push)
   - [ ] SessionStart (início da sessão)

2. **Criar 3 Hooks**
   - [ ] Post-file-edit (auto-format)
   - [ ] Pre-git-push (testes)
   - [ ] Post-commit (notificação)

**Atividade:**

1. Criar `.claude/hooks/post-file-edit.sh`:
```bash
#!/bin/bash
# Auto-format TypeScript files

if [[ "$EDITED_FILE" == *.ts ]] || [[ "$EDITED_FILE" == *.tsx ]]; then
  npx prettier "$EDITED_FILE" --write
  npx eslint "$EDITED_FILE" --fix
fi
```

2. Criar `.claude/hooks/pre-git-push.sh`:
```bash
#!/bin/bash
# Run tests before push

npm test -- --bail
if [ $? -ne 0 ]; then
  echo "❌ Tests failed! Fix and retry."
  exit 1
fi
```

#### 3.3 Skills & Extensões (10-12 horas)

**O que é:**
Lógica customizada em JavaScript/Python que Claude executa.

**Aprender:**

1. **Conceito**
   - [ ] Skills adicionam comandos executáveis
   - [ ] Implementação em JS/Python
   - [ ] Acesso a APIs externas

2. **Criar 1 Skill**
   - [ ] Test coverage analyzer
   - [ ] Performance profiler
   - [ ] Security scanner

**Atividade:**

1. Criar `.claude/skills/test-reporter.js`:
```javascript
module.exports = {
  name: "test-reporter",
  commands: [{
    name: "generate-test-report",
    description: "Generate test report from jest output"
  }],
  async execute(command, params) {
    if (command === "generate-test-report") {
      const fs = require("fs");
      const json = JSON.parse(
        fs.readFileSync(params.jsonFile)
      );
      return formatReport(json);
    }
  }
};
```

#### 3.4 CI/CD Integration (12-15 horas)

**O que é:**
Integrar Claude Code em pipelines de CI/CD.

**Aprender:**

1. **GitHub Actions**
   - [ ] Trigger Claude Code em PR
   - [ ] Code review automático
   - [ ] Deploy automático

2. **Vercel Deployment**
   - [ ] Connect Claude Code
   - [ ] Auto-generate PRs
   - [ ] Deploy automation

3. **Docker Integration**
   - [ ] Claude Code em container
   - [ ] Usar com docker-mcp
   - [ ] Automatizar tasks

**Atividade:**

1. GitHub Action para PR review:
```yaml
name: Claude Code Review
on:
  pull_request:
    types: [opened, synchronize]

jobs:
  review:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - run: |
          npm install -g @anthropic-ai/claude-code
          claude "Review this PR: ${{ github.event.pull_request.body }}"
```

#### 3.5 Context Optimization (8-10 horas)

**O que é:**
Estratégias para manter contexto limpo e eficiente.

**Aprender:**

1. **Token Management**
   - [ ] Entender limite de contexto
   - [ ] Compactação automática
   - [ ] Quando usar /clear

2. **Memory Best Practices**
   - [ ] O que goes em CLAUDE.md
   - [ ] O que goes em rules
   - [ ] O que goes em memory

3. **Performance Profiling**
   - [ ] Medir tempo de resposta
   - [ ] Identificar bottlenecks
   - [ ] Otimizar instruções

**Atividade:**

1. Estrutura de contexto ideal:
```
CLAUDE.md (global)       5-10 KB
CLAUDE.md (projeto)      10-15 KB
Rules (carregadas)       3-5 KB
Memory (auto)            5-10 KB
Chat (últimas N msgs)    20-30 KB
───────────────────────────────
Total: ~50-80 KB (vs. 200+ KB sem otimização)
```

#### 3.6 Architecture & Strategy (12-15 horas)

**O que é:**
Usar Claude Code para decisões arquiteturais complexas.

**Aprender:**

1. **Arquitetura de Sistemas**
   - [ ] Usar Opus para decisões críticas
   - [ ] Documentar trade-offs
   - [ ] Validar com team

2. **Patterns Avançados**
   - [ ] Multi-agent coordination
   - [ ] Parallel task execution
   - [ ] Fallback strategies

3. **Scaling & Growth**
   - [ ] Adaptar Claude Code para projetos maiores
   - [ ] Equipes coordenadas
   - [ ] Conhecimento compartilhado

**Atividade:**

1. Arquitetar refactoring de sistema:
```bash
/agent backend-architect
/agent plan

claude "We're growing from 10k to 100k users.
        Design a scalable architecture for our system."

# Resultado: Plano estratégico documentado
```

### Checkpoint Nível 3 ✅

```bash
1. [ ] 2+ agentes customizados funcionando
2. [ ] 3+ hooks implementados
3. [ ] 1+ skill criada
4. [ ] CI/CD pipeline com Claude Code
5. [ ] Context < 100 KB (otimizado)
6. [ ] Documentação de arquitectura

# Bonus:
7. [ ] Equipe usando Claude Code coordenado
8. [ ] Métricas de produtividade medidas
9. [ ] Workflow repetível documentado
```

**Parabéns! Você é um Claude Code Power User! 🚀**

---

## 📈 Progressão por Stack

### Stack: React + TypeScript (Frontend)

```
NÍVEL 1  → Usar Claude Code para explorar componentes
         → Usar Plan Mode para análise

NÍVEL 2  → React rule (.claude/rules/react.md)
         → React-specific commands (/test-coverage)
         → MCP para GitHub (PR review)

NÍVEL 3  → React Specialist agent
         → Performance profiling skill
         → Auto-format hooks
         → CI/CD: Automated tests on PR
```

### Stack: Node.js + PostgreSQL (Backend)

```
NÍVEL 1  → Usar Claude Code para explorar APIs
         → Database schema review

NÍVEL 2  → Database rule (.claude/rules/database.md)
         → API rule (.claude/rules/api.md)
         → Migration commands (/db-reset, /db-migrate)

NÍVEL 3  → Backend Architect agent
         → Database optimization skill
         → Pre-push test hooks
         → CI/CD: Automated migrations
```

### Stack: Full Stack (React + Node + PostgreSQL)

```
NÍVEL 1  → Exploração geral do codebase

NÍVEL 2  → Regras separadas por domínio
         → Commands por workflow
         → MCP para GitHub

NÍVEL 3  → Frontend + Backend agents
         → Multi-agent coordination
         → Full pipeline CI/CD
         → Performance + security scanning
```

---

## ⏱️ Timeline Sugerida

### Semana 1-2: NÍVEL 1 (Iniciante)

```
Dia 1-2:   Setup & instalação
Dia 3-4:   CLAUDE.md customizado
Dia 5-6:   Permission modes dominados
Dia 7-10:  Slash commands praticados
Dia 11-14: Referência de arquivos confortável
```

**Resultado:** Usa Claude Code confortavelmente para dev diário

### Semana 3-5: NÍVEL 2 (Intermediário)

```
Semana 3:  Memory system + Rules (3 regras)
Semana 4:  Custom commands (3 comandos)
Semana 5:  MCP + Tasks + Keybindings
```

**Resultado:** Automação e integrações funcionando

### Semana 6-11: NÍVEL 3 (Avançado)

```
Semana 6-7:   Custom agents (2 agentes)
Semana 8-9:   Hooks & automation (3+ hooks)
Semana 10:    Skills ou CI/CD
Semana 11:    Context optimization & strategy
```

**Resultado:** Power user com workflows avançados

---

## 📊 Checklist de Proficiência

### ✅ NÍVEL 1 (Iniciante)
- [ ] Pode iniciar sessão e fazer prompts
- [ ] Entende CLAUDE.md global
- [ ] Consegue referenciar arquivos com @
- [ ] Conhece /clear, /help, /status
- [ ] Consegue ciclar permission modes
- [ ] Sabe quando usar Plan Mode

### ✅ NÍVEL 2 (Intermediário)
- [ ] CLAUDE.md otimizado por projeto
- [ ] 3+ Rules criadas e em uso
- [ ] 3+ Commands customizados
- [ ] 1-2 MCPs integrados
- [ ] Task lists com dependências
- [ ] Memory funcionando entre sessões
- [ ] Keybindings personalizados

### ✅ NÍVEL 3 (Avançado)
- [ ] 2+ Agentes customizados
- [ ] 3+ Hooks implementados
- [ ] 1+ Skill criada
- [ ] Contexto < 100 KB
- [ ] CI/CD pipeline automatizado
- [ ] Equipe coordenada usando Claude Code
- [ ] Métricas de produtividade medidas
- [ ] Troubleshooting profundo

---

## 🎓 Recursos por Nível

### NÍVEL 1
**Documentação:**
- https://code.claude.com/docs/en/cli-reference
- https://code.claude.com/docs/en/settings

**Guias:**
- CLAUDE_CODE_COMPREHENSIVE_GUIDE.md (seções 1-3)

### NÍVEL 2
**Documentação:**
- https://code.claude.com/docs/en/memory
- https://code.claude.com/docs/en/mcp
- https://code.claude.com/docs/en/hooks-guide

**Guias:**
- CLAUDE_CODE_COMPREHENSIVE_GUIDE.md (seções 4-8)
- CLAUDE_CODE_PRACTICAL_EXAMPLES.md

### NÍVEL 3
**Documentação:**
- https://code.claude.com/docs/en/sub-agents
- https://code.claude.com/docs/en/best-practices

**Guias:**
- CLAUDE_CODE_PRACTICAL_EXAMPLES.md (exemplos avançados)
- Repositórios: awesome-claude-code, subagents.app

---

## 🚀 Próximos Passos

### Escolha seu caminho:

**Desenvolvimento Rápido?**
```
1. Setup nível 1 hoje
2. 3 regras + 3 commands nesta semana
3. MCP GitHub/Slack próxima semana
→ 70% de produtividade em 2 semanas
```

**Excelência de Longo Prazo?**
```
1. Setup nível 1 (1 semana)
2. Nível 2 completo (2 semanas)
3. Nível 3 (4 semanas)
→ Power user em 7 semanas
```

**Abordagem Mínima?**
```
1. Instalação + CLAUDE.md (hoje)
2. Usar como chat inteligente (semana 1)
3. Adicionar rules/commands conforme necessário
→ Ganhar valor imediatamente
```

---

## 💡 Dicas de Sucesso

1. **Practice over Theory**
   - Não leia tudo antes — faça enquanto aprende
   - Cada tópico: 5 min leitura, 20 min prática

2. **Start Small**
   - 1 rule, 1 command, depois 3
   - Não tente tudo no primeiro dia

3. **Document Your Setup**
   - Seu CLAUDE.md é sua base de conhecimento
   - Atualize conforme aprende

4. **Use com Projeto Real**
   - Aprender em projeto "toy" ≠ aprender em produção
   - Use seu projeto atual

5. **Comunidade**
   - GitHub Issues no anthropics/claude-code
   - Awesome Claude Code repo (exemplos)
   - Pergunte em comunidades Dev

---

## 📋 Seu Checklist de Início

```
Hoje (30 min):
  [ ] Instalar Claude Code
  [ ] Autenticar
  [ ] Testar: claude "hello"

Esta semana (2 horas):
  [ ] Criar CLAUDE.md
  [ ] Entender permission modes
  [ ] Explorar 3 arquivos com @mentions

Próxima semana (5 horas):
  [ ] 1 rule criada
  [ ] 2 commands criados
  [ ] Memory ativa

Em 2 semanas:
  [ ] Nível 1 completo
  [ ] Começar Nível 2
```

---

**Boa sorte! 🎯**

Próximas leituras em ordem:
1. CLAUDE_CODE_QUICK_REFERENCE.md (referência rápida)
2. CLAUDE_CODE_COMPREHENSIVE_GUIDE.md (aprofundamento)
3. CLAUDE_CODE_PRACTICAL_EXAMPLES.md (implementação)

Última Atualização: Março 2026
