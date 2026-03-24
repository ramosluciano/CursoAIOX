<!-- metadata
module: 0
lesson: 7
-->

# Aula 07 — Agentes & Tasks - Orquestração

## 🎯 Objetivos desta Aula

- [ ] Entender Agent tool (spawnar subagentes)
- [ ] Aprender Task tool (criar listas de tarefas)
- [ ] Executar múltiplos agentes em paralelo
- [ ] Entender dependências entre tasks
- [ ] Quando delegar vs executar

## 🤖 Agent Tool — Spawnar Subagentes

### O que é um Agente?

Um **agente** é uma IA especializada que opera com contexto próprio.

```
Você (Claude Code)
        ↓
Precisa pesquisar? → Spawna @analyst (pesquisador)
Precisa de testes? → Spawna @qa (testador)
Precisa de design? → Spawna @architect (arquiteto)
        ↓
Cada agente trabalha independentemente
        ↓
Retorna resultado ao contexto principal
```

### Agent Tool Syntax

```bash
Agent (description, task)
```

### Tipos de Agentes

| Agente | Especialidade | Quando Usar |
|--------|---------------|------------|
| **general-purpose** | Tudo | Pesquisa genérica |
| **Explore** | Explorar código | Entender codebase |
| **Plan** | Planejar | Design de solução |
| **@dev** | Implementação | Código |
| **@qa** | Testes | QA e validação |
| **@architect** | Design | Arquitetura |
| **@analyst** | Pesquisa | Análise mercado |

### Exemplo: Pesquisar com Agente

```
Você: Preciso pesquisar sobre arquitetura de microserviços

Claude: Vou spawnar @analyst para pesquisa profunda

[Agent: @analyst]
Pesquisando microserviços...
✓ Coletou 5 artigos
✓ Analisou padrões
✓ Criou resumo

Claude: Aqui está o resultado:
[Resultado da pesquisa]
```

---

## 📋 Task Tool — Gerenciar Tarefas

### O que é uma Task?

Uma **task** é uma unidade de trabalho rastreável com:

```
├─ subject (o quê)
├─ description (detalhes)
├─ status (pending, in_progress, completed)
├─ blockedBy (dependências)
└─ blocks (aguarda por mim)
```

### Task Lifecycle

```
Criar → Assign → In Progress → Completed → Archive

[pending] → [in_progress] → [completed]
```

### Criar Task

```
Task (subject, description)

Exemplo:
Task ("Implementar login",
      "Criar página de login com validação")
```

### Task Status

```
[pending]      = Aguardando começo
[in_progress]  = Sendo feito agora
[completed]    = Pronto ✓
```

---

## 🔗 Dependências Entre Tasks

### BlockedBy

```
Task 2: Implementar logout
BlockedBy: Task 1 (Implementar login)

Significa: Task 2 só começa depois que Task 1 terminar
```

### Blocks

```
Task 1: Database setup
Blocks: Task 2, Task 3

Significa: Task 2 e 3 aguardam Task 1 terminar
```

### Exemplo Cadeia

```
Task 1: Setup banco de dados
   ↓ (Task 2 bloqueado)
Task 2: Create migrations
   ↓ (Task 3 e 4 bloqueados)
Task 3: Implement API
Task 4: Write tests
```

---

## ⚡ Execução Paralela

Claude pode executar **múltiplas tasks em paralelo** se não houver dependências:

```
Task 1: Fetch data
Task 2: Process data     ← Espera Task 1
Task 3: Write tests      ← Paralelo com Task 1!
Task 4: Setup DB         ← Paralelo com Task 1!

Execução:
Task 1 ────────────
Task 3 ────────────
Task 4 ────────────
Task 2           ────────────

Total time: 4 unidades (não 4)
```

---

## 💻 Exercício 1: Criar Task List

### Passo 1: Criar tarefas

No Claude Code:

```
> Crie uma task para "Refatorar main.ts"

Task criada: [1] Refatorar main.ts [pending]
```

```
> Crie outra task: "Escrever testes para main.ts"
  Esta task depende da primeira

Task criada: [2] Testar main.ts [pending] [blockedBy: 1]
```

### Passo 2: Ver status

```
> Listar tasks

[1] Refatorar main.ts         [pending]
[2] Testar main.ts            [pending] (blockedBy: 1)
```

### Passo 3: Marcar completa

```
> Marcar task 1 como completa
Task 1 agora [completed]
Task 2 desbloqueada → [pending]
```

---

## 💻 Exercício 2: Spaw Agent para Pesquisa

### Passo 1: Spawnar agente

```
> Use o agente Explore para entender meu projeto

[Agent: Explore - Explorando codebase...]
```

Claude spawna agent que:
- Lê estrutura do projeto
- Identifica padrões
- Retorna análise

### Passo 2: Usar resultado

```
Claude: Aqui está a análise:
├─ Projeto: React + Express
├─ Padrões: Custom hooks
└─ Structure: src/components, src/pages, src/api
```

---

## 💻 Exercício 3: Parallelizar Tasks

### Passo 1: Criar 3 tasks independentes

```
> Crie 3 tasks:
  1. Implement feature X
  2. Fix bug Y
  3. Update documentation

  Tasks 2 e 3 não dependem de 1
```

### Passo 2: Ver paralelização

```
> Mostrar diagrama de execução

Task 1 ──────────────
Task 2 ──────────────  (paralelo)
Task 3 ──────────────  (paralelo)

Tempo total: 1x
(não 3x se fossem sequenciais)
```

---

## 🎯 Quando Delegar vs Executar

### ✅ Delegue (Use Agent)

| Situação | Agente | Porquê |
|----------|--------|--------|
| Pesquisar tema novo | @analyst | Especialista |
| Planejar arquitetura | @architect | Visão sistêmica |
| Implementar recurso | @dev | Especialista code |
| Testar código | @qa | Especialista testes |
| Explorar codebase | Explore | Especialista |

### ❌ NÃO Delegue

| Situação | Faça | Porquê |
|----------|------|--------|
| Comando simples | Direto | Rápido, sem overhead |
| Decisão imediata | Você | Você sabe contexto |
| Mudança trivial | Direto | Não precisa agente |

---

## 🔗 Recursos

- **[Agent Tool Docs](https://code.claude.com/docs/agents)** — Documentação oficial
- **[Task Tool Docs](https://code.claude.com/docs/tasks)** — Task management
- **[Agent Types](https://code.claude.com/docs/agent-types)** — Tipos disponíveis
- **[Parallelization](https://code.claude.com/docs/parallelization)** — Otimização paralela

---

## ⚡ Checkpoint

Valide que você:

- [ ] Entendeu Agent tool e spawning
- [ ] Criou tasks com status
- [ ] Configurou dependências (blockedBy)
- [ ] Executou tasks em paralelo
- [ ] Spawnnou agente Explore
- [ ] Sabe quando delegar vs executar
- [ ] Compreende workflow orquestração

---

## 📝 Resumo

- ✅ **Agent:** Subagentes especializados
- ✅ **Task:** Unidades de trabalho rastreáveis
- ✅ **BlockedBy:** Dependências entre tasks
- ✅ **Parallelização:** Tasks independentes rodamjuntas
- ✅ **Delegação:** Use agentes para especialidades

---

## 🚀 Próximos Passos

Na **Aula 08** você vai aprender sobre:
- MCP (Model Context Protocol)
- Adicionando servidores MCP
- Keybindings customizados
- IDE integrations
- Troubleshooting

---

*Aula criada por @dev — Básico Claude Code v1.0*
