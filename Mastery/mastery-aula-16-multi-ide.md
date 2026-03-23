# Aula 16 — Multi-IDE na Prática

<!-- metadata
course: Mastery
module: 5
lesson: 16
title: "Multi-IDE na Prática"
duration: 4-5 horas
agents: "todos (em 3 IDEs)"
project: Plataforma Zabbix Learning
phase: Hooks + Multi-IDE + Brownfield
prerequisites: Aula 15 concluída (hooks funcionando)
-->

---

> **Módulo 5** · Hooks, Multi-IDE e Brownfield
> **Duração**: 4-5 horas
> **Agentes praticados**: Todos — testados em 3 IDEs diferentes
> **Projeto**: Plataforma Zabbix Learning

---

## 🏆 Vitória desta aula

Plataforma Zabbix configurada e testada em Claude Code, Gemini CLI e Codex CLI. Mesma feature implementada em 3 IDEs com relatório de paridade.

**Critério binário**: Feature implementada em 3 IDEs + todos os `validate:*` commands passando + `docs/multi-ide-report.md` com comparação.

---

## Conceito

### Multi-IDE: liberdade sem lock-in

O AIOX é IDE-agnostic — o `.aiox-core/` é o contrato que funciona em qualquer IDE que suporte agentes. Cada IDE tem strengths diferentes:

| IDE | Forte em | Fraco em |
|-----|---------|---------|
| Claude Code | Contexto longo, raciocínio complexo | Pode ser lento em tasks simples |
| Gemini CLI | Velocidade, integração Google | Pode perder contexto em projetos grandes |
| Codex CLI | Execução local, privacidade | Menos fluido em tasks conversacionais |

Paridade não significa experiência idêntica — significa que o **resultado** é equivalente: mesmo código, mesmos testes passando, mesma arquitetura respeitada.

---

## Prática

### Passo 1 — Configurar em 3 IDEs

```bash
cd ~/aiox-mastery/zabbix-platform

# IDE 1: Claude Code (já configurado)
# IDE 2: Gemini CLI (instalar e configurar)
# IDE 3: Codex CLI (instalar e configurar)

# Validar em cada IDE:
npx aiox-core doctor  # Todos os checks devem passar
```

---

### Passo 2 — Mesma feature em 3 IDEs

Escolha feature representativa (ex: badge "Maratonista" — 5 quizzes/dia):

```bash
# Branch por IDE
git checkout -b feature/badge-claude
git checkout -b feature/badge-gemini
git checkout -b feature/badge-codex
```

Em cada IDE, mesma instrução:

```
@dev
Adicione badge "Maratonista" que o aluno ganha ao 
completar 5 quizzes no mesmo dia. Implemente lógica 
de detecção, concessão automática, notificação visual 
e exibição no perfil. Adicione testes.
```

Documentar por IDE: tempo, iterações, qualidade, friction points.

---

### Passo 3 — Validar paridade

```bash
# Rodar testes em cada branch
git checkout feature/badge-claude && npm test
git checkout feature/badge-gemini && npm test
git checkout feature/badge-codex && npm test
```

---

### Passo 4 — Relatório de paridade

Crie `docs/multi-ide-report.md`:

| Aspecto | Claude Code | Gemini CLI | Codex CLI |
|---------|------------|-----------|----------|
| Tempo total | | | |
| Iterações | | | |
| Qualidade | | | |
| Contexto mantido | | | |
| Friction points | | | |

Inclua recomendações: qual IDE usar para qual tipo de task.

> **Checklist**
> - <input type="checkbox" class="checkbox-input" /> Feature implementada nas 3 IDEs?
> - <input type="checkbox" class="checkbox-input" /> Testes passam nas 3 branches?
> - <input type="checkbox" class="checkbox-input" /> .aiox-core/ reconhecido em todas?
> - <input type="checkbox" class="checkbox-input" /> Relatório com comparação e recomendações?

> **🏆 VITÓRIA DA AULA**: Feature em 3 IDEs + relatório de paridade.

---

### Passo 5 — Commit

```bash
git checkout main
git add docs/multi-ide-report.md
git commit -m "docs: multi-IDE parity report - Claude Code, Gemini CLI, Codex CLI

- Same feature implemented in 3 IDEs
- Parity validation: tests passing in all branches
- Detailed comparison with recommendations per task type"
```

---

## Reflexão

### O conceito-chave

> **Multi-IDE garante que o projeto não é refém de uma ferramenta. O `.aiox-core/` é o contrato portável — as diferenças entre IDEs estão na experiência, não na capacidade. Saber qual IDE usar para cada tipo de task otimiza produtividade sem criar dependência.**

### Conexão com a próxima aula

Na Aula 17, brownfield completo do LinkedIn Automation: protótipo → produção com A/B testing e scheduling inteligente.

---

> **Anterior**: Aula 15 — Hooks de Lifecycle
> **Próxima**: Aula 17 — Brownfield: LinkedIn Automation
