<!-- metadata
module: 0
lesson: 6
-->

# Aula 06 — Rules System & Contexto Automático

## 🎯 Objetivos desta Aula

- [ ] Entender sistema de regras (.claude/rules/)
- [ ] Aprender frontmatter com `paths:` para carregamento automático
- [ ] Criar regra contextual customizada
- [ ] Debugar regras não carregadas
- [ ] Usar rules para enforçar padrões

## 📋 O que é o Rules System?

Rules são **instruções automáticas** que carregam quando você edita certos arquivos.

```
Você edita arquivo X
        ↓
Claude verifica .claude/rules/
        ↓
Encontra regra com paths: [X]
        ↓
Carrega regra automaticamente
        ↓
Claude segue regra durante sessão
```

### Exemplo Real

```
Você edita: src/components/Button.tsx
        ↓
Claude carrega: .claude/rules/react-components.md
        ↓
Regra diz: "Use TypeScript, PropTypes obrigatório"
        ↓
Claude segue este padrão para Button.tsx
```

---

## 🏗️ Estrutura de Rules

```
.claude/rules/
├── agent-authority.md         ← Quem pode fazer o quê
├── story-lifecycle.md          ← Status de stories
├── component-patterns.md       ← Padrões de componentes (CUSTOM)
├── api-patterns.md            ← Padrões de API (CUSTOM)
└── database-patterns.md        ← Padrões de DB (CUSTOM)
```

### Arquivo Exemplo: component-patterns.md

```markdown
---
paths: ['src/components/**/*.tsx', 'src/components/**/*.ts']
severity: high
---

# React Component Patterns

When editing React components, follow these rules:

## 1. TypeScript Required
- All props must be typed
- Use interface for Props

## 2. PropTypes or Validation
```typescript
interface Props {
  children: React.ReactNode;
  onClick: (id: string) => void;
  variant?: 'primary' | 'secondary';
}
```

## 3. Component Structure
```typescript
export const Component: React.FC<Props> = ({
  children,
  onClick,
  variant = 'primary'
}) => {
  return <div>...</div>;
};
```

## 4. No Default Exports
```typescript
// ❌ WRONG
export default Component;

// ✅ RIGHT
export const Component = (...) => ...;
```

## 5. Styling
- Use Tailwind CSS
- No inline styles
- No CSS-in-JS
```
```

### Frontmatter (Obrigatório)

```markdown
---
paths: ['src/components/**/*.tsx']  ← Trigger files
severity: high                      ← high/medium/low
---
```

**Paths suporta:**
- Glob patterns: `src/**/*.tsx`
- Wildcards: `*`, `**`
- Ranges: `[a-z]`
- Negação: `!src/test/`

---

## 🔄 Carregamento Automático

### Como Funciona

```
1. Você abre nova sessão
   ↓
2. Claude Code carrega todos os rules arquivos
   ↓
3. Você edita arquivo src/components/Button.tsx
   ↓
4. Claude verifica paths em cada rule
   ↓
5. Encontra rule com paths: ['src/components/**/*.tsx']
   ↓
6. Carrega esse rule automaticamente
   ↓
7. Segue padrões durante sessão
```

### Ordem de Carregamento

```
Global rules (sempre)
        ↓
Project rules (matched paths)
        ↓
CLI flags (/yolo, etc)

← Mais específico ganha
```

---

## 💻 Exercício 1: Criar Regra Customizada

### Passo 1: Criar arquivo

```bash
touch .claude/rules/custom-patterns.md
```

### Passo 2: Adicionar conteúdo

```markdown
---
paths: ['src/**/*.ts', 'src/**/*.js']
severity: medium
---

# Custom Project Patterns

## Variable Naming
- Use camelCase for variables
- Use UPPERCASE for constants
- Use snake_case for database columns

## Comments
- Add comment before complex logic
- Use JSDoc for functions

## Error Handling
- Always use try/catch
- Log errors with context
- Return consistent error format

## Database
- Use migrations for schema changes
- Always add indexes for foreign keys
```

### Passo 3: Testar

Edite arquivo em `src/`:

```bash
echo "// test" > src/test.js
```

No Claude Code:
```
> Leia meu arquivo src/test.js
```

Claude deve mencionar a regra carregada!

---

## 💻 Exercício 2: Debug - Regra Não Carregou

Se uma regra não carrega, debug assim:

### Passo 1: Verificar paths

Seu arquivo: `src/components/Button.tsx`
Sua rule: `paths: ['src/components/**/*.js']`

❌ **Problema:** Pattern `.js` não match `.tsx`!

### Passo 2: Corrigir

```markdown
---
paths: ['src/components/**/*.tsx', 'src/components/**/*.ts', 'src/components/**/*.js']
severity: high
---
```

### Passo 3: Testar novamente

Regra agora carrega!

---

## 🔗 Severidade de Regras

### severity: high

```
❌ BLOQUEADOR
Se você violar, Claude recusa fazer
```

Exemplo:
```markdown
---
paths: ['src/**/*']
severity: high
---

# NEVER do this
- Never use var (use let/const)
```

Resultado:
```
Claude: Você usou var aqui. Minha regra bloqueia isso.
Mude para let/const.
```

### severity: medium

```
⚠️ AVISO
Claude faz, mas avisa e documenta
```

### severity: low

```
ℹ️ SUGESTÃO
Claude sugere, mas não impõe
```

---

## 💻 Exercício 3: Test Severity

Crie regra com `severity: high`:

```markdown
---
paths: ['src/**/*.ts']
severity: high
---

# TypeScript Strictness

NEVER:
- Use `any` type
- Use `//` comments (use /* */ only)
```

No Claude Code:
```
> Criar variável com tipo any
```

Claude bloqueia! ❌

---

## 📋 Built-in Rules (Referência)

### agent-authority.md

Define quem pode fazer o quê:
- `@dev`: Pode fazer git add, commit
- `@dev`: Não pode fazer git push
- `@devops`: Pode fazer git push, PR create

### story-lifecycle.md

Define status de stories:
- Draft → Ready for Dev → InProgress → Ready for Review → Done

---

## 🔗 Recursos

- **[Rules System Docs](https://code.claude.com/docs/rules)** — Documentação oficial
- **[Paths Patterns](https://code.claude.com/docs/rules-paths)** — Glob pattern reference
- **[Rule Examples](https://code.claude.com/docs/rules-examples)** — Exemplos prontos

---

## ⚡ Checkpoint

Valide que você:

- [ ] Entendeu carregamento automático de rules
- [ ] Criou regra customizada com paths
- [ ] Testou regra com arquivo matching
- [ ] Debugou regra não carregada
- [ ] Entendeu diferença entre severities
- [ ] Sabe como rules enforçam padrões

---

## 📝 Resumo

- ✅ **Rules:** Instruções automáticas por arquivo
- ✅ **Paths:** Glob patterns disparam rules
- ✅ **Frontmatter:** Define `paths:` e `severity:`
- ✅ **Carregamento:** Automático quando edita arquivo
- ✅ **Severidade:** high (bloqueia), medium (avisa), low (sugere)

---

## 🚀 Próximos Passos

Na **Aula 07** você vai aprender sobre:
- Agent tool (spawnar subagentes)
- Task tool (criar listas)
- Execução paralela
- Orquestração de workflows

---

*Aula criada por @dev — Básico Claude Code v1.0*
