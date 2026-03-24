<!-- metadata
module: 0
lesson: 4
-->

# Aula 04 — Sistema de Permissões

## 🎯 Objetivos desta Aula

- [ ] Entender 3 permission modes: Ask, Auto, Explore
- [ ] Aprender quando usar cada mode
- [ ] Compreender trade-offs de segurança
- [ ] Alternar entre modes com /yolo
- [ ] Configurar deny rules para máxima segurança

## 🔐 3 Permission Modes

Claude Code oferece 3 níveis de permissão:

### Mode 1: Ask (Default - Seguro)

```
┌─────────────────────────────┐
│  Ask Mode (Padrão)          │
├─────────────────────────────┤
│ Cada ação pede confirmação  │
│                             │
│ ⚠️ [Ask] Allow this? (y/n) │
└─────────────────────────────┘
```

**Fluxo:**
1. Claude quer executar ação (ler arquivo, bash, etc)
2. Sistema mostra o que vai fazer
3. Você aprova (y) ou nega (n)
4. Ação executa (ou não)

**Exemplo:**

```
Claude: Vou ler o arquivo src/main.ts

[⚠️ Ask] Allow? (y/n)
y
← Arquivo lido

Claude: Agora vou rodar npm test

[⚠️ Ask] Allow? (y/n)
n
← Comando bloqueado
```

**Vantagens:**
- ✅ Total controle
- ✅ Máxima segurança
- ✅ Impede acidentes

**Desvantagens:**
- ❌ Lento (muitas confirmações)
- ❌ Repetitivo para ações comuns

**Melhor para:** Desenvolvimento inicial, scripts novos, operações perigosas

---

### Mode 2: Auto (Intermediário - Balanceado)

```
┌─────────────────────────────┐
│  Auto Mode                  │
├─────────────────────────────┤
│ Ferramentas permitidas      │
│ executam sem pedir          │
│                             │
│ ✅ Lê e executa direto      │
└─────────────────────────────┘
```

**Fluxo:**
1. Claude quer executar ação
2. Se estiver na "allow list" → executa direto
3. Se estiver na "deny list" → bloqueia
4. Se for novo → pede confirmação

**Exemplo (com allow: npm, git, read):**

```
Claude: Vou rodar npm test
← Executa direto (permitido)

Claude: Vou fazer git add .
← Executa direto (permitido)

Claude: Vou fazer docker run
← Pede confirmação (não está em allow)
```

**Vantagens:**
- ✅ Mais rápido
- ✅ Menos confirmações
- ✅ Automação funciona

**Desvantagens:**
- ❌ Menos controle
- ❌ Pode executar sem querer

**Melhor para:** Workflows conhecidos, desenvolvimento rápido

---

### Mode 3: Explore (Sem Limites - Rápido)

```
┌─────────────────────────────┐
│  Explore Mode               │
├─────────────────────────────┤
│ Acesso total                │
│ Nenhuma confirmação         │
│                             │
│ 🚀 Executa tudo direto      │
└─────────────────────────────┘
```

**Fluxo:**
1. Claude quer executar qualquer coisa
2. Executa direto, sem pedir nada
3. Nenhuma proteção

**Exemplo:**

```
Claude: Vou fazer git push
← Executa direto

Claude: Vou deletar node_modules/
← Executa direto

Claude: Vou fazer rm -rf /
← Executa direto (PERIGO!)
```

**Vantagens:**
- ✅ Muito rápido
- ✅ Zero confirmações
- ✅ Perfeito para CI/CD automático

**Desvantagens:**
- ❌ Nenhuma proteção
- ❌ Pode causar danos
- ❌ Nunca use em produção

**Melhor para:** Automation scripts, CI/CD confiáveis (com deny rules)

---

## 🔄 Alternar Entre Modes

### Comando /yolo

Use `/yolo` para ciclar entre modes:

```
Ask Mode → /yolo → Auto Mode → /yolo → Explore Mode → /yolo → Ask Mode
```

**Exemplo prático:**

```bash
$ claude

You: Preciso rodar 5 comandos diferentes

Claude: Vou executar. Pronto para Ask mode?

You: /yolo
# Mudou para Auto mode

Claude: Executando... ✅
You: /yolo
# Mudou para Explore mode

Claude: Executando rápido... ✅
You: /yolo
# Voltou para Ask mode
```

### Verificar Mode Atual

```bash
claude
# Mostra na saudação:
# Permission Mode: [⚠️ Ask] ou [🟢 Auto] ou [🔍 Explore]
```

## 🛡️ Estratégia de Segurança

### Recomendação

| Situação | Mode | Motivo |
|----------|------|--------|
| Novo projeto | Ask | Entender que fazer |
| Workflow repetido | Auto | Eficiência |
| Script confiável | Explore | Velocidade |
| Produção | Ask + Deny | Máxima segurança |
| CI/CD | Explore + Deny | Automação segura |

### Deny Rules (Sempre Use)

Independente do mode, sempre defina deny rules:

```markdown
# CLAUDE.md

## Deny Rules

- Deny: `git push` (use @github-devops)
- Deny: `rm -rf` (too destructive)
- Deny: `sudo` (ask for help)
- Deny: `.env` files (sensitive)
- Deny: `docker run` (use docker-compose)
```

Deny rules funcionam em **qualquer mode** — são absolutas.

## 💻 Exercício 1: Testar Ask Mode

1. Inicie Claude Code:
   ```bash
   claude
   ```

2. Peça para fazer algo:
   ```
   > Leia meu package.json
   ```

3. Você verá:
   ```
   [⚠️ Ask] Allow? (y/n)
   ```

4. Responda `y` e veja confirmação

**Resultado:** Cada ação pede permissão

## 💻 Exercício 2: Alternar para Auto Mode

1. No Claude Code, execute:
   ```
   /yolo
   ```

2. Veja resposta:
   ```
   Mudando para Auto Mode...
   ```

3. Peça para fazer algo:
   ```
   > Leia meu package.json
   > Leia meu README.md
   ```

4. Nenhuma confirmação!

**Resultado:** Auto mode é mais rápido

## 💻 Exercício 3: Test Deny Rules

1. Adicione deny rule ao CLAUDE.md:
   ```markdown
   ## Deny Rules
   - Deny: rm -rf
   ```

2. Volte para Ask mode:
   ```
   /yolo
   /yolo
   ```

3. Peça:
   ```
   > Delete node_modules usando rm -rf
   ```

4. Claude recusa!

**Resultado:** Deny rules bloqueiam mesmo em Auto/Explore

## 🔗 Recursos

- **[Permission Modes](https://code.claude.com/docs/permissions)** — Documentação oficial
- **[Security Best Practices](https://code.claude.com/docs/security)** — Guia de segurança
- **[Deny Rules Reference](https://code.claude.com/docs/deny-rules)** — Lista completa

## ⚡ Checkpoint

Valide que você:

- [ ] Entendeu 3 modes: Ask, Auto, Explore
- [ ] Testou Ask mode (confirmações)
- [ ] Testou Auto mode (menos confirmações)
- [ ] Alternoul entre modes com /yolo
- [ ] Entendeu trade-offs segurança vs velocidade
- [ ] Configurou deny rules pessoais
- [ ] Sabe quando usar cada mode

## 📝 Resumo

- ✅ **Ask:** Máxima segurança, lentas confirmações
- ✅ **Auto:** Balanço entre segurança e velocidade
- ✅ **Explore:** Máxima velocidade, sem proteção
- ✅ **/yolo:** Alterna entre modes
- ✅ **Deny rules:** Funcionam em qualquer mode

## 🚀 Próximos Passos

Na **Aula 05** você vai aprender sobre:
- `.claude/memory/` (memória persistente)
- MEMORY.md (armazenar conhecimento)
- Entre-session context
- Como usar memory no seu projeto

---

*Aula criada por @dev — Básico Claude Code v1.0*
