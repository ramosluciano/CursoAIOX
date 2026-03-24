<!-- metadata
module: 0
lesson: 8
-->

# Aula 08 — MCP, Integração & Advanced

## 🎯 Objetivos desta Aula

- [ ] Entender Model Context Protocol (MCP)
- [ ] Adicionar MCP servers ao seu projeto
- [ ] Customizar keybindings
- [ ] Integrar Claude Code com sua IDE
- [ ] Troubleshooting de problemas comuns

## 🔌 Model Context Protocol (MCP)

### O que é MCP?

MCP é um **protocolo para conectar ferramentas externas** ao Claude Code.

```
Claude Code
    ↓
[MCP Manager]
    ↓
MCP Servers
├─ GitHub
├─ Slack
├─ Docker
├─ Notion
├─ Supabase
└─ Custom...
```

### Fluxo

```
Você: "Busque issues do GitHub"
        ↓
Claude: Usa MCP GitHub server
        ↓
GitHub: Retorna dados
        ↓
Claude: Mostra resultado
```

---

## 🛠️ Adicionando MCP Servers

### Configuração em ~/.claude.json

```json
{
  "mcpServers": {
    "github": {
      "command": "node",
      "args": ["~/.local/bin/mcp-github.js"]
    },
    "slack": {
      "command": "node",
      "args": ["~/.local/bin/mcp-slack.js"],
      "env": {
        "SLACK_BOT_TOKEN": "${SLACK_TOKEN}"
      }
    }
  }
}
```

### Servidores Populares

| Server | Função | Use Para |
|--------|--------|----------|
| **GitHub** | Gerenciar repos/PRs | Automação Git |
| **Slack** | Enviar mensagens | Notificações |
| **Docker** | Gerenciar containers | DevOps |
| **Supabase** | Acesso database | Queries |
| **Notion** | Gerenciar Notion | Documentação |

---

## 💻 Exercício 1: Adicionar MCP GitHub

### Passo 1: Instalar MCP GitHub

```bash
npm install -g @anthropic-ai/mcp-github
```

### Passo 2: Configurar ~/.claude.json

```json
{
  "mcpServers": {
    "github": {
      "command": "node",
      "args": ["~/.local/bin/mcp-github.js"],
      "env": {
        "GITHUB_TOKEN": "your-token-here"
      }
    }
  }
}
```

### Passo 3: Testar

No Claude Code:

```
> Lista issues abertas do repositório X
```

Claude usa MCP GitHub automaticamente!

---

## ⌨️ Keybindings Customizados

### O que são Keybindings?

Atalhos de teclado para comandos frequentes.

### Configuração em ~/.claude/keybindings.json

```json
{
  "keybindings": [
    {
      "key": "ctrl+k",
      "command": "/yolo",
      "description": "Toggle permission mode"
    },
    {
      "key": "ctrl+shift+l",
      "command": "*run-tests",
      "description": "Run tests"
    },
    {
      "key": "ctrl+g",
      "command": "*develop",
      "description": "Start developing story"
    }
  ]
}
```

### Exemplo: Criar Atalho para Testes

```json
{
  "key": "ctrl+t",
  "command": "*run-tests",
  "description": "Run all tests"
}
```

Agora: **Ctrl+T** = Roda testes

### Chords (Combinações)

```json
{
  "key": "ctrl+k ctrl+d",
  "command": "/yolo",
  "description": "Enter debug mode"
}
```

Pressione: **Ctrl+K**, solte, depois **Ctrl+D**

---

## 💻 Exercício 2: Criar Atalhos

### Passo 1: Criar keybindings.json

```bash
touch ~/.claude/keybindings.json
```

### Passo 2: Adicionar atalhos

```json
{
  "keybindings": [
    {
      "key": "ctrl+shift+t",
      "command": "*run-tests",
      "description": "Run tests"
    },
    {
      "key": "alt+d",
      "command": "*develop",
      "description": "Develop story"
    },
    {
      "key": "ctrl+shift+y",
      "command": "/yolo",
      "description": "YOLO mode"
    }
  ]
}
```

### Passo 3: Testar

Pressione **Ctrl+Shift+T** → Roda testes!

---

## 🔗 IDE Integration

### VS Code

1. Instalar extension "Claude Code"
2. Configurar em settings.json:

```json
{
  "claudeCode.apiKey": "your-key",
  "claudeCode.autoSave": true,
  "claudeCode.permissions": "auto"
}
```

3. Usar command palette: **Ctrl+Shift+P** → "Claude Code: Start Session"

### JetBrains (IntelliJ, PyCharm, etc)

1. Ir em: **Settings** → **Plugins**
2. Buscar e instalar "Claude Code"
3. Restart IDE
4. Use: **Right-click** → "Claude Code: Chat"

### Vim/Neovim

1. Instalar plugin:
```bash
git clone https://github.com/claude-code/vim-plugin ~/.vim/plugins/
```

2. Usar comando: `:ClaudeCode`

---

## 🐛 Troubleshooting

### Problema 1: "Claude Code not found"

**Solução:**
```bash
which claude
# Se não encontrar:
npm install -g claude-code

# Adicionar ao PATH:
export PATH="$PATH:~/.local/bin"
```

### Problema 2: "Permission denied"

**Solução:**
```bash
chmod +x ~/.local/bin/claude
```

### Problema 3: "Authentication failed"

**Solução:**
```bash
claude auth login
# Ou verifique token:
cat ~/.claude/auth-token
```

### Problema 4: MCP Server não carrega

**Solução:**
```bash
# Verificar ~/.claude.json sintaxe:
cat ~/.claude.json | jq .

# Reiniciar Claude Code:
claude auth logout
claude auth login
```

### Problema 5: Keybinding não funciona

**Solução:**
```bash
# Verificar sintaxe JSON:
cat ~/.claude/keybindings.json | jq .

# Testar comando manualmente:
/yolo
```

---

## 🎓 Advanced: Context Optimization

### Problema: Context Window Cheio

Quando seu projeto é grande, o contexto fica cheio.

### Solução: Pruning

Adicione ao CLAUDE.md:

```markdown
## Context Optimization

### Ignore patterns
- node_modules/
- .git/
- dist/
- build/
- .next/

### Auto-prune
Remove files > 1MB
Remove node_modules files
Keep essential files only
```

Claude automaticamente pruna contexto!

---

## 🎓 Advanced: Custom Tools

Você pode criar **tools customizadas** em JavaScript:

```javascript
// ~/.local/bin/my-tool.js
module.exports = {
  name: 'my-tool',
  description: 'Does something special',

  execute: async (args) => {
    // Sua lógica aqui
    return result;
  }
};
```

Depois registre em CLAUDE.md:

```markdown
## Custom Tools
- my-tool (custom)
```

---

## 🔗 Recursos

- **[MCP Documentation](https://modelcontextprotocol.io/)** — Spec oficial
- **[Available MCPs](https://mcpmarket.com/)** — Marketplace
- **[IDE Integrations](https://code.claude.com/docs/ide-integration)** — Setup guias
- **[Keybindings Guide](https://code.claude.com/docs/keybindings)** — Referência completa
- **[Troubleshooting](https://code.claude.com/docs/troubleshooting)** — FAQ oficial

---

## ⚡ Checkpoint

Valide que você:

- [ ] Entendeu Model Context Protocol (MCP)
- [ ] Adicionou pelo menos 1 MCP server
- [ ] Criou keybindings customizados
- [ ] Integrou com sua IDE (VS Code, etc)
- [ ] Debugou problemas comuns
- [ ] Entende context optimization
- [ ] Conhece troubleshooting básico

---

## 📝 Resumo

- ✅ **MCP:** Protocolo para integrar ferramentas
- ✅ **Servers:** GitHub, Slack, Docker, Supabase, etc
- ✅ **Keybindings:** Atalhos customizados
- ✅ **IDE Integration:** VS Code, JetBrains, Vim
- ✅ **Troubleshooting:** Soluções para problemas comuns

---

## 🎓 Conclusão do Módulo

Parabéns! Você completou o módulo **Básico Claude Code**! 🎉

### Você aprendeu:

1. ✅ O que é Claude Code e como funciona
2. ✅ Instalar, autenticar e primeira sessão
3. ✅ Configurar CLAUDE.md com regras
4. ✅ Sistema de permissões (Ask/Auto/Explore)
5. ✅ Memória persistente entre sessões
6. ✅ Rules system com carregamento automático
7. ✅ Agentes e Tasks para orquestração
8. ✅ MCP, keybindings, IDE integration

### Próximos Passos:

→ Você está pronto para o **módulo Bootcamp AIOX**!

No Bootcamp você vai:
- Usar Claude Code em projeto real
- Trabalhar com framework AIOX
- Implementar features completas
- Colaborar com múltiplos agentes

**Boa sorte! 🚀**

---

*Aula criada por @dev — Básico Claude Code v1.0*
