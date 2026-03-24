<!-- metadata
module: 0
lesson: 5
-->

# Aula 05 — Memória Persistente

## 🎯 Objetivos desta Aula

- [ ] Entender diferença entre session memory e persistent memory
- [ ] Usar `.claude/memory/` para armazenar conhecimento
- [ ] Criar e atualizar MEMORY.md
- [ ] Aplicar memory em múltiplas sessões
- [ ] Organizar memory semanticamente

## 🧠 Memory Layer

Claude Code tem **dois tipos de memória**:

### Session Memory (Temporária)
```
Sessão 1: Chat com Claude
├─ Contexto carregado
├─ Conversa acontece
└─ Sessão fecha → Tudo esquecido
```

**Persiste:** Apenas durante a sessão atual

### Persistent Memory (Permanente)
```
Session 1: Claude aprende padrão X
           Salva em MEMORY.md
             ↓
Session 2: Carrega MEMORY.md
           Lembra padrão X
           Usa conhecimento anterior
```

**Persiste:** Entre sessões (até você deletar)

---

## 📁 Estrutura de Memory

```
.claude/memory/
├── MEMORY.md          ← Arquivo principal (sempre carregado)
├── architecture.md    ← Tópico: Arquitetura
├── patterns.md        ← Tópico: Padrões encontrados
├── debugging.md       ← Tópico: Debug insights
├── performance.md     ← Tópico: Performance tips
└── team-prefs.md      ← Tópico: Preferências do time
```

### Quando Carregar

- **MEMORY.md:** SEMPRE (linha 1 do contexto)
- **Outros arquivos:** Quando referenciados em MEMORY.md

### Limite

- **MEMORY.md:** Máx 200 linhas (resumido, não verbose)
- **Arquivos específicos:** Sem limite

---

## 📝 Criando MEMORY.md

### Template Inicial

```markdown
# Project Memory

> Conhecimento persistente sobre este projeto.

---

## Quick Context

- **Project:** Meu app React
- **Tech Stack:** React 18 + Next.js + Tailwind
- **Team:** Solo dev
- **Status:** Em desenvolvimento ativo

---

## Architecture Decisions

- Use Next.js App Router (não Pages Router)
- Tailwind para styling (não CSS-in-JS)
- Supabase para backend (não MongoDB)

---

## Padrões Encontrados

- **Custom hooks:** useAuth, useFetch, useLocalStorage
- **API route pattern:** /api/[resource]/[action].ts
- **Component structure:** src/components/{feature}/{Component}.tsx

---

## Preferências do Time

- Prettier config: 2 spaces
- No semicolons
- ESLint + TypeScript strict mode

---

## Known Gotchas

- [Link para debugging.md] - Performance issue com re-renders
- [Link para architecture.md] - Decisão de mudar para Supabase

---

## Próximas Investigações

- [ ] Investigar build time lento
- [ ] Otimizar bundle size
- [ ] Setup CI/CD com GitHub Actions

---

*Última atualização: 2026-03-24*
*Por: @dev*
```

---

## 💾 O que Salvar (e Quando)

### ✅ SEMPRE Salve

1. **Decisões arquiteturais** — "Por que escolhemos Next.js?"
2. **Padrões identificados** — "Onde estão os custom hooks?"
3. **Preferências do time** — "Como formatamos código?"
4. **Known gotchas** — "Cuidado com re-renders aqui"
5. **Convenções do projeto** — "Naming, estrutura, patterns"

### ❌ NUNCA Salve

1. **Informação temporária** — "Task da sprint"
2. **Estado temporário** — "Estamos debuggando X"
3. **Informação incompleta** — "Preciso investigar mais"
4. **Credentials** — "API keys, senhas"
5. **Duplicatas** — "Já existe em CLAUDE.md"

---

## 🔄 Ciclo de Vida de Memory

### Session 1: Descobrir Padrão

```
Claude: Analisando seu projeto...

Descoberto: Todos os custom hooks estão em src/hooks/useX.ts

Adicionar ao MEMORY.md?
```

Você responde `y`.

### Session 2: Usar Conhecimento

```
Claude carrega MEMORY.md...

Lê: "Custom hooks: src/hooks/useX.ts"

Claude: Encontrei pattern! Vou criar novo hook lá.
```

Claude já sabe onde colocar!

---

## 💻 Exercício 1: Criar MEMORY.md

### Passo 1: Criar arquivo

```bash
touch .claude/memory/MEMORY.md
```

### Passo 2: Adicionar conteúdo

```markdown
# Memory

## My Project
- Stack: Node.js + Express
- Setup time: 5 min
- Main goal: Learn Claude Code

## Architecture
- Routes in src/routes/
- Models in src/models/
- Utils in src/utils/

## Padrões
- RESTful endpoints
- Snake case for databases
- Camel case for JavaScript

---
*Updated: 2026-03-24*
```

### Passo 3: Testar

No Claude Code:
```
> Qual é a arquitetura do meu projeto?
```

Claude lê MEMORY.md e responde com base no arquivo!

---

## 💻 Exercício 2: Atualizar Memory

### Passo 1: Adicionar novo padrão

No Claude Code:
```
> Qual padrão você vê para tratamento de erros?
```

Claude analisa, descobre padrão.

### Passo 2: Salvar no MEMORY.md

```markdown
## Error Handling
- Try/catch em todas as routes
- Return { error: string, code: string }
- Log em console.error
```

### Passo 3: Próxima sessão verifica

Abra novo Claude Code:
```
> Como tratamos erros aqui?
```

Claude lê MEMORY.md e lembra!

---

## 📋 Organização Semântica

### Boa Estrutura

```
MEMORY.md
├── Quick Context (projeto, stack, team)
├── Architecture Decisions (why choices)
├── Padrões (where things are)
├── Preferências (code style)
├── Known Gotchas (cuidados)
└── Próximas Investigações (TODO)

Arquivos temáticos:
├── architecture.md (deep dive)
├── patterns.md (all patterns)
├── debugging.md (insights)
└── performance.md (tips)
```

### Ruim

```
MEMORY.md
├── Random notes from session 1
├── Stuff I learned
├── Some idea I had
├── TODO (misturado com gotchas)
└── (Sem organização)
```

---

## 🔗 Recursos

- **[Memory Layer Docs](https://code.claude.com/docs/memory)** — Documentação oficial
- **[Best Practices](https://code.claude.com/docs/memory-best-practices)** — Como usar bem
- **[Memory Examples](https://code.claude.com/docs/memory-examples)** — Exemplos reais

---

## ⚡ Checkpoint

Valide que você:

- [ ] Entendeu diferença entre session e persistent memory
- [ ] Criou `.claude/memory/MEMORY.md`
- [ ] Adicionou contexto do projeto
- [ ] Salvou pelo menos 1 padrão
- [ ] Testou memory em nova sessão
- [ ] Entendeorganização semântica
- [ ] Sabe o que salvar e quando

---

## 📝 Resumo

- ✅ **Session Memory:** Temporária (sessão)
- ✅ **Persistent Memory:** Permanente (entre sessões)
- ✅ **MEMORY.md:** Carregado automaticamente
- ✅ **Organização:** Semântica, não cronológica
- ✅ **Updates:** Incremental, conforme aprende

---

## 🚀 Próximos Passos

Na **Aula 06** você vai aprender sobre:
- `.claude/rules/` (regras contextuais)
- Frontmatter com `paths:`
- Carregamento automático
- Debugging de rules

---

*Aula criada por @dev — Básico Claude Code v1.0*
