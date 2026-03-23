# Aula 17 — Brownfield: LinkedIn Automation Protótipo → Produção

<!-- metadata
course: Mastery
module: 5
lesson: 17
title: "Brownfield: LinkedIn Automation Protótipo → Produção"
duration: 5-6 horas
agents: "@architect, @analyst, @po, @sm, @dev"
project: LinkedIn Automation (brownfield completo)
phase: Hooks + Multi-IDE + Brownfield
prerequisites: Aula 16 concluída (multi-IDE testado)
-->

---

> **Módulo 5** · Hooks, Multi-IDE e Brownfield
> **Duração**: 5-6 horas
> **Agentes praticados**: `@architect`, `@analyst`, `@po`, `@sm`, `@dev`
> **Projeto**: LinkedIn Automation (brownfield completo)

---

## 🏆 Vitória desta aula

LinkedIn Automation migrado do protótipo Google AI Studio para arquitetura independente com features avançadas: A/B testing de conteúdo, scheduling inteligente baseado em analytics, e performance tuning do sistema combinado.

**Critério binário**: Protótipo mapeado + patterns migrados + A/B testing funcional + scheduling inteligente + sistema rodando independente do Google AI Studio.

---

## Conceito

### Brownfield completo: 5 etapas do AIOX

A Aula 18 do Bootcamp fez brownfield parcial. Aqui é o **completo**, usando todas as ferramentas:

| Etapa | Agente | Ação |
|-------|--------|------|
| 1. Map | @architect `*map-codebase` | Mapear protótipo existente |
| 2. Extract | @analyst `*extract-patterns` | Extrair o que funciona |
| 3. Plan | @po sharding + @sm stories | Planejar evolução |
| 4. Implement | @dev | Implementar migração + features novas |
| 5. Tune | @dev | Performance tuning do sistema combinado |

### O que o sistema LinkedIn agora combina

- Squad V3 (migrado na Aula 04 do Mastery)
- Backend de persistência + publicação (Aula 16 Bootcamp)
- Analytics com feedback loop (Aula 17 Bootcamp)
- Automação end-to-end (Aula 18 Bootcamp)
- Hooks de lifecycle (Aula 15 Mastery)
- Agora: A/B testing + scheduling inteligente

---

## Prática

### Passo 1 — Map codebase completo

```bash
cd ~/aiox-bootcamp/linkedin-squad
claude
```

```
@architect

Aria, mapeie o sistema LinkedIn Automation completo:

*map-codebase

Mapeie: squad (6 agentes V3), backend (API, banco, métricas), 
analytics (patterns, feedback loop), automação (scheduling), 
protótipo legado (Google AI Studio).

Identifique: o que está pronto, parcial e faltando para produção.
```

```
@analyst

*extract-patterns

Extraia do protótipo Google AI Studio: prompts calibrados, 
regras de formatação, padrões de voz que ainda não foram 
migrados, lógica de decisão (quando gerar quiz vs artigo).
```

> **🏆 Checkpoint 1**: Mapeamento + patterns extraídos.

---

### Passo 2 — Migrar e evoluir

```
*exit

@sm

Sam, crie stories de evolução:
1. Migrar features restantes do protótipo
2. A/B testing de conteúdo (2 versões, medir performance)
3. Scheduling inteligente (publicar no melhor horário baseado em dados)
4. Dashboard consolidado
5. Performance tuning
```

```
*exit

@dev

Dex, implemente as stories priorizadas:

A/B TESTING:
- Gerar 2 versões do mesmo post (hook diferente, formato diferente)
- Publicar ambas em horários similares em dias diferentes
- Comparar métricas D+7 de cada versão
- Declarar vencedora e alimentar feedback loop

SCHEDULING INTELIGENTE:
- Analytics identifica melhores horários por vertente
- Scheduler publica automaticamente no horário ideal
- Se não houver dados suficientes, usar horários default
- Aprender e ajustar com cada publicação

DASHBOARD CONSOLIDADO:
- Tudo sobre LinkedIn em uma tela
- Posts recentes com métricas
- A/B tests ativos com resultado parcial
- Padrões identificados pelo analytics
- Próximas publicações agendadas
```

> **Checklist**
> - <input type="checkbox" class="checkbox-input" /> A/B testing gera 2 versões e compara métricas?
> - <input type="checkbox" class="checkbox-input" /> Scheduling usa dados do analytics para horários?
> - <input type="checkbox" class="checkbox-input" /> Dashboard mostra visão consolidada?
> - <input type="checkbox" class="checkbox-input" /> Sistema roda independente do Google AI Studio?
> - <input type="checkbox" class="checkbox-input" /> Templates migrados do protótipo enriqueceram o squad?

> **🏆 Checkpoint 2**: Features avançadas implementadas.

---

### Passo 3 — Performance tuning

```
Dex, faça performance tuning do sistema combinado:
- Tempo de geração de 4 posts (1 por vertente)
- Tempo de response dos endpoints de analytics
- Overhead da automação semanal
- Uso de memória do sistema completo

Identifique top 3 bottlenecks e otimize.
```

> **🏆 Checkpoint 3 — VITÓRIA DA AULA**: LinkedIn Automation production-ready.

---

### Passo 4 — Commit

```bash
*exit
git add .
git commit -m "feat: LinkedIn Automation brownfield complete - production-ready

- Full codebase mapping and pattern extraction
- A/B content testing with metric comparison
- Intelligent scheduling based on analytics
- Consolidated dashboard
- Performance tuning: top 3 bottlenecks resolved
- System independent of Google AI Studio"
```

---

## Reflexão

### O conceito-chave

> **Brownfield completo é mais que migração — é evolução. O protótipo do Google AI Studio foi o MVP. O Bootcamp construiu a infraestrutura. O Mastery evoluiu para produção: A/B testing, scheduling inteligente, performance tuning. O AIOX estruturou cada etapa com ferramentas específicas (*map-codebase, *extract-patterns, stories de evolução).**

### Conexão com o Módulo 6

O Módulo 6 (Aulas 18-22) é o grand finale: squads avançados com @squad-creator, MCP integration, composition cross-squad, marketplace e contribuição ao AIOX core.

---

> **Anterior**: Aula 16 — Multi-IDE na Prática
> **Próxima**: Aula 18 — Squad Zabbix Content *(Módulo 6)*
