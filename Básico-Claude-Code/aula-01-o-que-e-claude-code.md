<!-- metadata
module: 0
lesson: 1
-->

# Aula 01 — O que é Claude Code?

## 🎯 Objetivos desta Aula

- [ ] Entender a diferença entre Claude Code (CLI), Claude API e Claude Web
- [ ] Identificar quando usar Claude Code vs outras opções
- [ ] Conhecer arquitetura e capacidades principais
- [ ] Compreender limitações e casos de uso ideais

## 📖 O que é Claude Code?

Claude Code é uma ferramenta CLI (Command Line Interface) desenvolvida pela Anthropic que permite interagir com Claude diretamente do seu terminal. Diferente da interface web ou da API, o Claude Code é **projetado para desenvolvedores que trabalham localmente** em seus projetos.

### Arquitetura Básica

```
┌─────────────────────────────────────┐
│   Seu Projeto (Local)               │
│   └─ Arquivos, código, contexto     │
└─────────────────┬───────────────────┘
                  │
                  ▼
        ┌─────────────────┐
        │  Claude Code    │
        │  (CLI Tool)     │
        └────────┬────────┘
                 │
                 ▼
        ┌─────────────────┐
        │  Claude API     │
        │  (Anthropic)    │
        └────────┬────────┘
                 │
                 ▼
        ┌─────────────────┐
        │   Claude Model  │
        │   (IA)          │
        └─────────────────┘
```

Claude Code funciona assim:

1. **Local Context** — Lê seus arquivos, projeto, histórico
2. **Local Memory** — Persiste conhecimento entre sessões
3. **Tool Execution** — Executa ferramentas localmente (read, write, run bash, git)
4. **Session Management** — Mantém estado da conversa no seu computador

### Comparação: Claude Code vs Claude API vs Claude Web

| Aspecto | Claude Code | Claude API | Claude Web |
|---------|------------|-----------|-----------|
| **Interface** | CLI (terminal) | HTTP requests | Browser web |
| **Acesso a Arquivos** | ✅ Sim (local) | ❌ Não direto | ❌ Upload apenas |
| **Execução de Tools** | ✅ Sim (read, write, bash, git) | ✅ Sim (via SDK) | ❌ Não |
| **Memória Persistente** | ✅ Sim (.claude/memory/) | ❌ Não | ⚠️ Session only |
| **Controle Local** | ✅ 100% | ❌ Remoto | ⚠️ Parcial |
| **Perfeito Para** | Dev individual, scripts | Aplicações, APIs | Uso geral, chat |
| **Custo** | Pago por tokens | Pago por tokens | Pago por plan |
| **Setup** | 5 min | Variável | Nenhum |

**Claude Code é escolha ideal para:**
- Desenvolvimento local (um dev, um projeto)
- Scripts automatizados pessoais
- Prototipagem rápida
- Trabalho com contexto grande (arquivo local)
- Necessidade de tools (git, bash, file operations)

## Capacidades Principais

### ✅ O Que Claude Code Pode Fazer

1. **Ler Arquivos** — Acesso completo ao seu projeto local
2. **Escrever & Editar** — Criar, modificar, deletar arquivos
3. **Executar Bash** — Rodar comandos (npm, git, python, etc.)
4. **Git Integration** — Status, log, diff, branches (read-only)
5. **Executar Tools** — Acesso a ferramentas configuradas (Grep, Glob, etc.)
6. **Memória Local** — Persistência entre sessões (.claude/memory/)
7. **Configuração** — CLAUDE.md, rules, permissões
8. **MCP Servers** — Integração com Model Context Protocol

### ❌ Limitações

1. **Sem acesso remoto** — Não pode clonar repos remotos, só gerenciar local
2. **Sem push automático** — Não faz `git push` (you'll learn why soon!)
3. **Sem acesso web real** — Não navega websites (só ferramentas configuradas)
4. **Sem persistência remota** — Progress é local, não sincroniza automaticamente
5. **Sem colaboração real-time** — Um usuário por sessão

## 🏗️ Arquitetura & Fluxo

```
┌──────────────────────────────────────────────────────────────┐
│                        Claude Code Session                   │
├──────────────────────────────────────────────────────────────┤
│                                                               │
│  1. Local Context Loading                                    │
│     ├─ .claude/CLAUDE.md (configuração global)              │
│     ├─ .claude/memory/ (memória persistente)                │
│     ├─ .claude/rules/ (regras contextuais)                  │
│     └─ Story files (docs/stories/)                          │
│                                                               │
│  2. Permission System                                        │
│     ├─ Ask Mode (default: pedir permissão)                  │
│     ├─ Auto Mode (ferramentas permitidas executam)          │
│     └─ Explore Mode (acesso total)                          │
│                                                               │
│  3. Tool Execution                                           │
│     ├─ File operations (Read, Write, Edit)                  │
│     ├─ Bash commands (npm, git, python)                     │
│     ├─ Search tools (Glob, Grep)                            │
│     └─ External APIs (via MCP)                              │
│                                                               │
│  4. Conversation Loop                                        │
│     ├─ User input → Claude processes                        │
│     ├─ Claude requests permissions                          │
│     ├─ User approves/denies                                 │
│     ├─ Tools execute                                        │
│     └─ Loop continua...                                      │
│                                                               │
└──────────────────────────────────────────────────────────────┘
```

## 💡 Casos de Uso Reais

### ✅ Quando Usar Claude Code

**1. Desenvolvimento Solo**
```
"Estou fazendo um projeto pessoal. Preciso de um AI assistant
que lê meu código, entende estrutura, e me ajuda a implementar."
→ Use Claude Code
```

**2. Scripts & Automação**
```
"Preciso de um script que processa 1000 arquivos de forma inteligente."
→ Claude Code pode ler, processar, executar em loop
```

**3. Prototipagem Rápida**
```
"Quero testar uma ideia rapidamente sem setup de API."
→ Claude Code já tem tudo que precisa (local context, tools)
```

**4. Contexto Grande**
```
"Meu projeto tem 500 arquivos. Preciso que Claude entenda tudo."
→ Claude Code lê tudo localmente (offline, rápido)
```

### ❌ Quando NÃO Usar Claude Code

**1. Aplicação Web (multi-user)**
```
"Preciso de um backend que atenda 1000 usuários."
→ Use Claude API + servidor remoto (não Claude Code)
```

**2. Integração em Produção**
```
"Preciso chamar Claude de um Slack bot em produção."
→ Use Claude API com SDK (não Claude Code)
```

**3. Colaboração Remota**
```
"Meu time tem 5 devs que precisam colaborar."
→ Use sistema de chat tradicional ou API (não Claude Code)
```

**4. Sem Contexto Local**
```
"Preciso pesquisar na internet sobre um tópico."
→ Use Claude Web ou API (Claude Code não navega)
```

## 🔗 Recursos Externos

- **[Claude Code Official Docs](https://code.claude.com/)** — Documentação oficial
- **[GitHub Repository](https://github.com/anthropics/claude-code)** — Source code
- **[Anthropic Blog](https://www.anthropic.com/blog)** — Anúncios e updates
- **[MCP Documentation](https://modelcontextprotocol.io/)** — Model Context Protocol specs

## ⚡ Checkpoint

Responda as perguntas abaixo para validar compreensão:

1. **Qual é a principal diferença entre Claude Code e Claude API?**
   - A) Preço diferente
   - B) Claude Code é CLI local, API é remota via HTTP
   - C) Claude Code é mais poderoso
   - D) Não há diferença significativa

2. **Claude Code pode fazer `git push` automaticamente?**
   - A) Sim, é uma capacidade padrão
   - B) Não, é bloqueado intencionalmente
   - C) Só se você permitir em CLAUDE.md
   - D) Depende da versão

3. **Qual caso de uso é ideal para Claude Code?**
   - A) Backend multi-user em produção
   - B) Chatbot para website público
   - C) Desenvolvimento solo com contexto local
   - D) Integração com Slack enterprise

**Respostas esperadas:** 1-B, 2-B, 3-C

## 📝 Resumo

- **Claude Code** é um CLI para desenvolvedores que trabalham localmente
- Pode **ler/escrever arquivos, executar bash, gerenciar git** localmente
- Ideal para **desenvolvimento solo, scripts, prototipagem rápida**
- **Não é adequado** para aplicações web multi-user ou produção
- Próximo passo: Instalação e primeira sessão

## 🚀 Próximos Passos

Na **Aula 02** você vai:
- ✅ Instalar Claude Code no seu computador
- ✅ Fazer autenticação com sua conta Anthropic
- ✅ Executar seu primeiro comando
- ✅ Entender o sistema de permissões

**Tempo estimado:** 30 minutos de hands-on

---

*Aula criada por @dev — Básico Claude Code v1.0*
