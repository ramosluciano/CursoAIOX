2:I[4817,["972","static/chunks/972-435ad046c10f8479.js","552","static/chunks/552-ca913c8f5aa11d94.js","460","static/chunks/app/mastery/%5Blesson%5D/page-19f8ee117e5859d3.js"],"LessonRenderer"]
4:I[4707,[],""]
6:I[6423,[],""]
7:I[872,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"ThemeProvider"]
8:I[3021,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Sidebar"]
9:I[8680,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Header"]
3:T15fa,# Aula 17 — Brownfield: LinkedIn Automation Protótipo → Produção

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
> - [ ] A/B testing gera 2 versões e compara métricas?
> - [ ] Scheduling usa dados do analytics para horários?
> - [ ] Dashboard mostra visão consolidada?
> - [ ] Sistema roda independente do Google AI Studio?
> - [ ] Templates migrados do protótipo enriqueceram o squad?

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

> **Anterior**: [Aula 16 — Multi-IDE na Prática](./aula-16-multi-ide.md)
> **Próxima**: [Aula 18 — Squad Zabbix Content](../modulo-06/aula-18-squad-zabbix-content.md) *(Módulo 6)*
5:["lesson","mastery-aula-17-brownfield-linkedin","d"]
0:["0aCmzVh17xjX8k-qFi6hn",[[["",{"children":["mastery",{"children":[["lesson","mastery-aula-17-brownfield-linkedin","d"],{"children":["__PAGE__?{\"lesson\":\"mastery-aula-17-brownfield-linkedin\"}",{}]}]}]},"$undefined","$undefined",true],["",{"children":["mastery",{"children":[["lesson","mastery-aula-17-brownfield-linkedin","d"],{"children":["__PAGE__",{},[["$L1",["$","$L2",null,{"content":"$3","lessonSlug":"mastery-aula-17-brownfield-linkedin","module":"mastery","lessonIndex":16,"totalLessons":22,"nextLesson":"mastery-aula-18-squad-zabbix-content","prevLesson":"mastery-aula-16-multi-ide"}],null],null],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","mastery","children","$5","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","mastery","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[[[["$","link","0",{"rel":"stylesheet","href":"/_next/static/css/71d217bb04404cb9.css","precedence":"next","crossOrigin":"$undefined"}]],["$","html",null,{"lang":"pt-BR","children":["$","body",null,{"className":"bg-white dark:bg-slate-900 text-gray-900 dark:text-gray-100 transition-colors","children":["$","$L7",null,{"children":["$","div",null,{"className":"flex h-screen overflow-hidden","children":[["$","$L8",null,{}],["$","div",null,{"className":"flex-1 flex flex-col overflow-hidden","children":[["$","$L9",null,{}],["$","main",null,{"className":"flex-1 overflow-y-auto bg-white dark:bg-slate-900 transition-colors","children":["$","div",null,{"className":"max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8","children":["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":[["$","title",null,{"children":"404: This page could not be found."}],["$","div",null,{"style":{"fontFamily":"system-ui,\"Segoe UI\",Roboto,Helvetica,Arial,sans-serif,\"Apple Color Emoji\",\"Segoe UI Emoji\"","height":"100vh","textAlign":"center","display":"flex","flexDirection":"column","alignItems":"center","justifyContent":"center"},"children":["$","div",null,{"children":[["$","style",null,{"dangerouslySetInnerHTML":{"__html":"body{color:#000;background:#fff;margin:0}.next-error-h1{border-right:1px solid rgba(0,0,0,.3)}@media (prefers-color-scheme:dark){body{color:#fff;background:#000}.next-error-h1{border-right:1px solid rgba(255,255,255,.3)}}"}}],["$","h1",null,{"className":"next-error-h1","style":{"display":"inline-block","margin":"0 20px 0 0","padding":"0 23px 0 0","fontSize":24,"fontWeight":500,"verticalAlign":"top","lineHeight":"49px"},"children":"404"}],["$","div",null,{"style":{"display":"inline-block"},"children":["$","h2",null,{"style":{"fontSize":14,"fontWeight":400,"lineHeight":"49px","margin":0},"children":"This page could not be found."}]}]]}]}]],"notFoundStyles":[]}]}]}]]}]]}]}]}]}]],null],null],["$La",null]]]]
a:[["$","meta","0",{"name":"viewport","content":"width=device-width, initial-scale=1"}],["$","meta","1",{"charSet":"utf-8"}],["$","title","2",{"children":"AIOX Course Platform | Professional Bootcamp & Mastery"}],["$","meta","3",{"name":"description","content":"Learn AIOX - AI-Orchestrated System for Full Stack Development. Complete bootcamp and mastery courses with hands-on projects."}],["$","meta","4",{"name":"keywords","content":"AIOX,AI Development,Full Stack,Course,Bootcamp,Learning"}]]
1:null
