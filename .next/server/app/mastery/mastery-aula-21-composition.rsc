2:I[4817,["972","static/chunks/972-435ad046c10f8479.js","552","static/chunks/552-ca913c8f5aa11d94.js","460","static/chunks/app/mastery/%5Blesson%5D/page-19f8ee117e5859d3.js"],"LessonRenderer"]
4:I[4707,[],""]
6:I[6423,[],""]
7:I[872,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"ThemeProvider"]
8:I[3021,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Sidebar"]
9:I[8680,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Header"]
3:T11de,# Aula 21 — Squad Composition e Ecossistema

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
> - [ ] Squad N8N gera workflow que aciona Squad LinkedIn?
> - [ ] Squad LinkedIn gera conteúdo dentro do workflow n8n?
> - [ ] Scheduling usa dados do analytics?
> - [ ] Métricas são coletadas automaticamente?
> - [ ] Orquestração funciona sem intervenção manual?

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

> **Anterior**: [Aula 20 — MCP Integration e Squad Testing](./aula-20-mcp-testing.md)
> **Próxima**: [Aula 22 — Marketplace, Contribuição e Consolidação Final](./aula-22-marketplace-consolidation.md)
5:["lesson","mastery-aula-21-composition","d"]
0:["0aCmzVh17xjX8k-qFi6hn",[[["",{"children":["mastery",{"children":[["lesson","mastery-aula-21-composition","d"],{"children":["__PAGE__?{\"lesson\":\"mastery-aula-21-composition\"}",{}]}]}]},"$undefined","$undefined",true],["",{"children":["mastery",{"children":[["lesson","mastery-aula-21-composition","d"],{"children":["__PAGE__",{},[["$L1",["$","$L2",null,{"content":"$3","lessonSlug":"mastery-aula-21-composition","module":"mastery","lessonIndex":20,"totalLessons":22,"nextLesson":"mastery-aula-22-marketplace-consolidation","prevLesson":"mastery-aula-20-mcp-testing"}],null],null],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","mastery","children","$5","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","mastery","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[[[["$","link","0",{"rel":"stylesheet","href":"/_next/static/css/71d217bb04404cb9.css","precedence":"next","crossOrigin":"$undefined"}]],["$","html",null,{"lang":"pt-BR","children":["$","body",null,{"className":"bg-white dark:bg-slate-900 text-gray-900 dark:text-gray-100 transition-colors","children":["$","$L7",null,{"children":["$","div",null,{"className":"flex h-screen overflow-hidden","children":[["$","$L8",null,{}],["$","div",null,{"className":"flex-1 flex flex-col overflow-hidden","children":[["$","$L9",null,{}],["$","main",null,{"className":"flex-1 overflow-y-auto bg-white dark:bg-slate-900 transition-colors","children":["$","div",null,{"className":"max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8","children":["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":[["$","title",null,{"children":"404: This page could not be found."}],["$","div",null,{"style":{"fontFamily":"system-ui,\"Segoe UI\",Roboto,Helvetica,Arial,sans-serif,\"Apple Color Emoji\",\"Segoe UI Emoji\"","height":"100vh","textAlign":"center","display":"flex","flexDirection":"column","alignItems":"center","justifyContent":"center"},"children":["$","div",null,{"children":[["$","style",null,{"dangerouslySetInnerHTML":{"__html":"body{color:#000;background:#fff;margin:0}.next-error-h1{border-right:1px solid rgba(0,0,0,.3)}@media (prefers-color-scheme:dark){body{color:#fff;background:#000}.next-error-h1{border-right:1px solid rgba(255,255,255,.3)}}"}}],["$","h1",null,{"className":"next-error-h1","style":{"display":"inline-block","margin":"0 20px 0 0","padding":"0 23px 0 0","fontSize":24,"fontWeight":500,"verticalAlign":"top","lineHeight":"49px"},"children":"404"}],["$","div",null,{"style":{"display":"inline-block"},"children":["$","h2",null,{"style":{"fontSize":14,"fontWeight":400,"lineHeight":"49px","margin":0},"children":"This page could not be found."}]}]]}]}]],"notFoundStyles":[]}]}]}]]}]]}]}]}]}]],null],null],["$La",null]]]]
a:[["$","meta","0",{"name":"viewport","content":"width=device-width, initial-scale=1"}],["$","meta","1",{"charSet":"utf-8"}],["$","title","2",{"children":"AIOX Course Platform | Professional Bootcamp & Mastery"}],["$","meta","3",{"name":"description","content":"Learn AIOX - AI-Orchestrated System for Full Stack Development. Complete bootcamp and mastery courses with hands-on projects."}],["$","meta","4",{"name":"keywords","content":"AIOX,AI Development,Full Stack,Course,Bootcamp,Learning"}]]
1:null
