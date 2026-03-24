# Módulo: Básico Claude Code

> Fundamentos essenciais para usar Claude Code e preparação para o framework AIOX.

---

## 📚 Resumo

Este módulo cobre **8 aulas** (4 horas de teoria + 3 horas de prática) introduzindo você a Claude Code — a ferramenta CLI da Anthropic para desenvolvimento local.

**Objetivo:** Você será capaz de usar Claude Code com confiança, entender segurança, e estar preparado para o Bootcamp AIOX.

---

## 🎯 Learning Path

Recomendamos seguir as aulas **sequencialmente**, dedicando 1-2 semanas:

```
Semana 1:
└─ Aula 01-02 (O que é + Setup)
   Aula 03-04 (Configuração + Permissões)
   Aula 05-06 (Memória + Rules)

Semana 2:
└─ Aula 07-08 (Agentes + MCP)
   Exercícios práticos
   Revisão
```

---

## 📖 Aulas

| # | Aula | Duração | Foco |
|---|------|---------|------|
| **1** | O que é Claude Code? | 20min | Conceitos |
| **2** | Setup & Primeira Sessão | 30min | Hands-on |
| **3** | Anatomia do CLAUDE.md | 35min | Configuração |
| **4** | Sistema de Permissões | 25min | Segurança |
| **5** | Memória Persistente | 30min | Persistência |
| **6** | Rules System & Contexto | 30min | Automação |
| **7** | Agentes & Tasks | 35min | Orquestração |
| **8** | MCP, Integração & Advanced | 40min | Avançado |

**TOTAL:** ~3.5 horas teoria + ~2.5 horas prática = 6 horas

---

## 🎓 Pré-requisitos

- Computador com terminal (Mac, Linux, Windows com WSL)
- Node.js 18+ instalado
- Conta Anthropic (gratuita em https://anthropic.com)
- Conforto com linha de comando

**Tempo de Setup:** ~10 minutos

---

## 💡 O que Você Aprenderá

### Aula 01: Contexto
- ✅ Claude Code vs Claude API vs Claude Web
- ✅ Casos de uso ideais
- ✅ Arquitetura básica

### Aula 02: Hands-On
- ✅ Instalar Claude Code (NPM ou curl)
- ✅ Autenticação com Anthropic
- ✅ Executar primeiro comando
- ✅ Entender Ask mode

### Aula 03: Configuração
- ✅ Arquivo CLAUDE.md (obrigatório)
- ✅ Allow/deny rules (segurança)
- ✅ Variáveis de ambiente
- ✅ Hooks (automação)

### Aula 04: Segurança
- ✅ Ask mode (máximo controle)
- ✅ Auto mode (balanceado)
- ✅ Explore mode (rápido)
- ✅ Quando usar cada um

### Aula 05: Persistência
- ✅ Session vs persistent memory
- ✅ .claude/memory/ (compartilhado)
- ✅ MEMORY.md (conhecimento)
- ✅ Entre-session context

### Aula 06: Automação
- ✅ .claude/rules/ (instruções)
- ✅ Frontmatter `paths:` (trigger)
- ✅ Severidade (high/medium/low)
- ✅ Debug de rules

### Aula 07: Orquestração
- ✅ Agent tool (subagentes)
- ✅ Task tool (tarefas)
- ✅ Dependências (blockedBy)
- ✅ Parallelização

### Aula 08: Advanced
- ✅ MCP (protocolo de integração)
- ✅ Keybindings (atalhos)
- ✅ IDE integration (VS Code, etc)
- ✅ Troubleshooting

---

## 📋 Estrutura de Cada Aula

Cada aula markdown segue este padrão:

```markdown
<!-- metadata
module: 0           ← Módulo Básico
lesson: N           ← Número da aula
-->

# Aula NN — Título

## 🎯 Objetivos (3-4 items)
- [ ] Objetivo 1
- [ ] Objetivo 2

## 📖 Conteúdo Teórico
[Explicações, exemplos, tabelas]

## 💻 Exercícios Práticos
1. Exercício 1 com instruções passo-a-passo
2. Exercício 2 com código/template
3. Exercício 3 com validação

## 🔗 Recursos Externos
- Link 1
- Link 2

## ⚡ Checkpoint
[Quiz para validar aprendizado]

## 📝 Resumo
[3-5 pontos-chave]

## 🚀 Próximos Passos
[Preview da próxima aula]
```

---

## 💻 Exercícios Práticos

Cada aula inclui **2-3 exercícios práticos** (hands-on).

**Tempo por exercício:** 15-20 minutos

**Validação:** Checkpoint no final de cada aula

### Exemplo de Exercício

```
Exercício 1: Criar CLAUDE.md Pessoal

Passo 1: Criar arquivo
$ touch .claude/CLAUDE.md

Passo 2: Adicionar conteúdo
[Template]

Passo 3: Testar
> Leia meu CLAUDE.md

Resultado esperado:
Claude lista suas regras corretamente
```

---

## ✅ Como Usar Este Módulo

### Opção 1: Auto-paced (Recomendado)

1. Leia cada aula completa
2. Execute todos os exercícios
3. Valide no checkpoint
4. Passe para próxima aula

**Duração:** 1-2 semanas (6-10h)

### Opção 2: Focused (Rápido)

1. Leia apenas seções teóricas
2. Pule exercícios avançados
3. Vá direto para Aula 07-08 (importante!)

**Duração:** 3-4 dias (3-4h)

### Opção 3: Hands-Only (Prático)

1. Pule teoria, vá direto aos exercícios
2. Entenda conceitos fazendo
3. Volta para teoria se tiver dúvida

**Duração:** 2-3 semanas (exploração)

---

## 📊 Checkpoint Progress

Você pode rastrear seu progresso:

```
Aula 01: [✓] Completa
Aula 02: [✓] Completa
Aula 03: [ ] Em andamento
Aula 04: [ ] Pendente
...
```

Marque na web app enquanto progride!

---

## 🚀 Próximo Módulo

Depois de completar este módulo, você estará pronto para:

→ **Bootcamp AIOX** (Módulo 2)

No Bootcamp você vai:
- Trabalhar com framework AIOX em projeto real
- Usar Claude Code em contexto de equipe
- Implementar features completas com agents
- Aprender padrões e best practices

---

## 📞 Dúvidas & Support

- **Erro durante instalação?** → Veja Aula 02 "Troubleshooting"
- **CLAUDE.md confuso?** → Veja Aula 03 "Template Inicial"
- **Permissões?** → Veja Aula 04 "3 Permission Modes"
- **Problema MCP?** → Veja Aula 08 "Troubleshooting"

---

## 📚 Recursos Complementares

### Oficial
- [Claude Code Docs](https://code.claude.com/)
- [GitHub Repository](https://github.com/anthropics/claude-code)
- [Anthropic Blog](https://www.anthropic.com/blog)

### Community
- [Awesome Claude Code](https://github.com/awesome-claude-code)
- [Subagents Directory](https://subagents.app/)
- [MCP Marketplace](https://mcpmarket.com/)

### Related
- [AIOX Framework Docs](../../../docs/)
- [Bootcamp Module](../Bootcamp/)
- [Mastery Module](../Mastery/)

---

## 📈 Estatísticas

| Métrica | Valor |
|---------|-------|
| **Aulas** | 8 |
| **Duração Total** | 3.5h teoria + 2.5h prática |
| **Exercícios** | 20+ práticos |
| **Checkpoints** | 8 (um por aula) |
| **Recursos Externos** | 30+ links |
| **Linhas de Conteúdo** | ~6,000 |

---

## 🎓 Sobre Este Módulo

**Criado por:** @dev (Dex)
**Data:** 2026-03-24
**Versão:** 1.0
**Status:** ✅ Completo e pronto para uso

---

## 🙏 Dicas Finais

1. **Não pule aulas** — Cada uma é importante
2. **Faça todos os exercícios** — Prática > teoria
3. **Anote suas dúvidas** — Pergunte após cada aula
4. **Tire screenshots** — Documente seu progresso
5. **Compartilhe** — Ajude outros no seu journey

---

**Bem-vindo ao Claude Code! Vamos começar? 🚀**

---

*Módulo: Básico Claude Code v1.0 | CursoAIOX*
