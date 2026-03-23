# Aula 21 — Squad Composition e Ecossistema

<!-- metadata
course: Mastery
module: 6
lesson: 21
title: "Squad Composition e Ecossistema"
duration: 4-5 horas
agents: "todos os squads + @aiox-orchestrator"
project: Todos os projetos
phase: Squads Avançados
prerequisites: Aula 20 concluída (MCP + testing)
-->

---

> **Módulo 6** · Squads Avançados
> **Duração**: 4-5 horas
> **Agentes praticados**: Todos os squads + `@aiox-orchestrator`
> **Projeto**: Ecossistema completo

---

## 🏆 Vitória desta aula

Composição cross-squad funcionando: Squad N8N orquestrando Squad LinkedIn, e Squad Zabbix Content triggerando Squad N8N. Versionamento semântico por squad.

**Critério binário**: Composição N8N → LinkedIn funciona end-to-end + composição Zabbix Content → N8N funciona + versão semântica de cada squad.

---

## Conceito

### Squad Composition: squads que orquestram squads

Squads individuais são poderosos. Squads compostos são **ecossistemas**:

```
Composição 1: Squad N8N + Squad LinkedIn
  N8N cria workflow → workflow aciona LinkedIn → 
  LinkedIn gera posts → workflow publica → coleta métricas

Composição 2: Squad Zabbix Content + Squad N8N
  Zabbix Content gera módulo → trigger workflow n8n →
  n8n provisiona labs + notifica alunos
```

O `@aiox-orchestrator` coordena comunicação entre squads: roteia outputs para inputs e gerencia dependências.

### Versionamento semântico para squads

Squads evoluem — quando agentes mudam ou workflows são adicionados, a versão do squad muda. MAJOR.MINOR.PATCH permite rastrear compatibilidade entre composições.

---

## Prática

### Passo 1 — Composição N8N + LinkedIn

```bash
cd ~/aiox-mastery
claude
```

```
Configure composição entre Squad N8N e Squad LinkedIn:

Fluxo: Squad N8N cria workflow semanal que:
1. Chama Squad LinkedIn para gerar conteúdo (4 vertentes)
2. Squad LinkedIn gera posts com Voice Profile
3. Workflow n8n agenda publicação nos horários ideais
4. Workflow coleta métricas D+1, D+3, D+7
5. Resultado alimenta analytics do LinkedIn

Use @aiox-orchestrator para coordenar.
Teste: execute composição end-to-end.
```

> **Checklist**
> - <input type="checkbox" class="checkbox-input" /> Squad N8N gera workflow que aciona Squad LinkedIn?
> - <input type="checkbox" class="checkbox-input" /> Squad LinkedIn gera conteúdo dentro do workflow n8n?
> - <input type="checkbox" class="checkbox-input" /> Scheduling usa dados do analytics?
> - <input type="checkbox" class="checkbox-input" /> Métricas são coletadas automaticamente?
> - <input type="checkbox" class="checkbox-input" /> Orquestração funciona sem intervenção manual?

> **🏆 Checkpoint 1**: Composição N8N + LinkedIn funcional.

---

### Passo 2 — Composição Zabbix Content + N8N

```
Configure composição entre Squad Zabbix Content e Squad N8N:

Fluxo: quando Squad Zabbix Content gera módulo novo:
1. Trigger para Squad N8N
2. N8N cria workflow de provisioning de labs para o módulo
3. N8N cria workflow de notificação para alunos

Teste com módulo gerado na Aula 18.
```

> **🏆 Checkpoint 2**: Composição Zabbix Content + N8N funcional.

---

### Passo 3 — Versionamento semântico

```
Configure versionamento para cada squad:

- Squad LinkedIn: v2.0.0 (V3 + brownfield + A/B testing)
- Squad Zabbix Content: v1.0.0 (primeira versão estável)
- Squad N8N: v1.0.0 (primeira versão estável)

Para cada squad: changelog, regras de breaking changes (MAJOR), 
features (MINOR), fixes (PATCH).
```

> **🏆 Checkpoint 3 — VITÓRIA DA AULA**: 2 composições + versionamento semântico.

---

### Passo 4 — Commit

```bash
*exit
git add .
git commit -m "feat: squad composition + semantic versioning

- Composition: N8N → LinkedIn (automated weekly content pipeline)
- Composition: Zabbix Content → N8N (lab provisioning + notification)
- @aiox-orchestrator coordinating cross-squad communication
- Semantic versioning for all 3 squads with changelogs"
```

---

## Reflexão

### O conceito-chave

> **Squad composition é a expressão máxima do AIOX: não apenas agentes dentro de um squad, mas squads inteiros orquestrando outros squads. O ecossistema LinkedIn (N8N gera workflow → LinkedIn gera posts → publica → coleta métricas) é uma cadeia impossível de gerenciar manualmente — e que funciona porque cada squad é testado, versionado e composto formalmente.**

### Conexão com a próxima aula

Na Aula 22 — a última do programa — publicação no marketplace, contribuição ao AIOX core, e a retrospectiva final.

---

> **Anterior**: Aula 20 — MCP Integration e Squad Testing
> **Próxima**: Aula 22 — Marketplace, Contribuição e Consolidação Final
