<!-- metadata
module: 0
lesson: 2
-->

# Aula 02 — Setup & Primeira Sessão

## 🎯 Objetivos desta Aula

- [ ] Instalar Claude Code corretamente no seu computador
- [ ] Completar autenticação com Anthropic
- [ ] Executar seu primeiro comando com sucesso
- [ ] Entender o fluxo de permissões (Ask mode)

## 📥 Instalação

### Opção 1: NPM (Recomendado)

Se você tem Node.js 18+ instalado:

```bash
npm install -g claude-code
```

Verificar instalação:

```bash
claude --version
# Deve retornar algo como: claude-code 1.5.0
```

### Opção 2: Curl Script

Se não tem Node.js ou prefere instalação manual:

```bash
curl -fsSL https://code.claude.com/install.sh | bash
```

Depois adicionar ao PATH:

```bash
export PATH="$HOME/.local/bin:$PATH"
# Adicione esta linha ao seu ~/.bashrc, ~/.zshrc ou similar
```

### Verificação Pós-Instalação

```bash
which claude
# Deve mostrar o caminho da instalação

claude --help
# Deve listar comandos disponíveis
```

## 🔐 Autenticação

### Passo 1: Iniciar Login

```bash
claude auth login
```

Você será redirecionado para o navegador.

### Passo 2: Autorizar

1. Clique em **"Authorize Claude Code"**
2. Faça login na sua conta Anthropic (ou crie uma)
3. Confirme permissões

### Passo 3: Token Salvo

O token é armazenado em:
- **Linux/Mac:** `~/.claude/auth-token`
- **Windows:** `%APPDATA%\.claude\auth-token`

**⚠️ Segurança:** Nunca commit este arquivo no git. Adicione ao `.gitignore`:

```bash
echo ".claude/auth-token" >> .gitignore
```

### Verificar Autenticação

```bash
claude auth status
# Deve retornar: "Authenticated as [seu-email]"
```

## 🚀 Primeira Sessão

### Passo 1: Criar Projeto (Opcional)

```bash
mkdir meu-projeto
cd meu-projeto
```

### Passo 2: Inicializar Claude Code

```bash
claude init
```

Isso cria estrutura inicial `.claude/`.

### Passo 3: Primeiro Comando

Vamos começar simples — listar arquivos:

```bash
ls
# Você verá:
# You're about to run the following:
# $ ls
#
# [⚠️  Ask]  Allow this?  (y/n)
```

Digite **`y`** e pressione Enter.

### Entender a Saída

```
Claude Code — Session started

Current context:
├─ 🗂️ Files loaded: 23
├─ 📝 Memory enabled
├─ 🔐 Permissions: Ask mode
└─ 📍 Working directory: /Users/you/meu-projeto

What would you like help with?
```

Isso significa:
- ✅ Conectado com sucesso
- ✅ Sua pasta foi escaneada
- ✅ Memória está ativada
- ✅ Pronto para receber comandos

### Passo 4: Segundo Comando — Ler um Arquivo

Crie um arquivo simples:

```bash
echo "# Meu Projeto" > README.md
```

Agora peça para Claude ler:

```
claude
> Qual é o conteúdo do README.md?
```

Claude vai:
1. Pedir permissão para ler arquivo
2. Ler o conteúdo
3. Responder sua pergunta

## 💡 Sistema de Permissões (Ask Mode)

### Como Funciona

No **Ask Mode** (padrão), Claude pede permissão antes de cada ação:

```
Claude: Vou ler o arquivo src/main.ts

[⚠️ Ask] Allow this? (y/n)
```

Opções:
- **`y`** — Permitir esta ação
- **`n`** — Bloquear esta ação
- **`a`** — Permitir tudo para a sessão (use com cuidado!)

### Por Que Isso?

Segurança! Você controla exatamente o que Claude faz no seu computador.

### Mudar de Modo

Você pode alterar para `Auto` mode (menos confirmações):

```bash
/yolo
# Alterna: Ask → Auto → Explore → Ask
```

⚠️ **Cuidado:** Em Auto/Explore mode, Claude executa sem pedir confirmação.

## 💻 Exercícios Práticos

### Exercício 1: Ler Arquivo Existente

1. Crie arquivo `test.txt`:
   ```bash
   echo "Hello Claude Code" > test.txt
   ```

2. Abra Claude Code:
   ```bash
   claude
   ```

3. Peça para ler:
   ```
   > Qual é o conteúdo de test.txt?
   ```

4. Responda `y` quando perguntado

**Resultado esperado:** Claude mostra "Hello Claude Code"

### Exercício 2: Criar um Arquivo

1. No Claude Code:
   ```
   > Crie um arquivo chamado hello.js com um console.log("Hello World")
   ```

2. Responda `y` quando perguntado

3. Verifique arquivo foi criado:
   ```bash
   cat hello.js
   ```

**Resultado esperado:** Arquivo existe com código correto

### Exercício 3: Executar JavaScript

1. No Claude Code:
   ```
   > Execute o arquivo hello.js
   ```

2. Responda `y` quando perguntado

**Resultado esperado:** Output mostra "Hello World"

## 🔗 Recursos

- **[Claude Code Installation](https://code.claude.com/docs/getting-started)** — Guia oficial
- **[Troubleshooting](https://code.claude.com/docs/troubleshooting)** — Problemas comuns
- **[Permission Modes](https://code.claude.com/docs/permissions)** — Sistema de permissões detalhado

## ⚡ Checkpoint

Valide que você conseguiu:

- [ ] Instalar Claude Code com `claude --version` mostrando versão
- [ ] Fazer login com `claude auth status` retornando seu email
- [ ] Executar primeiro comando (`ls`) com sucesso
- [ ] Ler um arquivo com sucesso
- [ ] Criar um novo arquivo com sucesso
- [ ] Compreender Ask/Auto/Explore modes

## 📝 Resumo

- ✅ Claude Code instalado via NPM ou curl
- ✅ Autenticado com sua conta Anthropic
- ✅ Token armazenado em `~/.claude/auth-token`
- ✅ Primeiro comando executado em Ask mode
- ✅ Sistema de permissões entendido

## 🚀 Próximos Passos

Na **Aula 03** você vai aprender sobre:
- Arquivo `CLAUDE.md` (configuração global)
- Allow/deny rules (controlar ferramentas)
- Hooks (executar scripts antes/depois)
- Variáveis de ambiente

---

*Aula criada por @dev — Básico Claude Code v1.0*
