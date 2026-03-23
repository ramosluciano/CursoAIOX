2:I[4817,["972","static/chunks/972-435ad046c10f8479.js","552","static/chunks/552-ca913c8f5aa11d94.js","460","static/chunks/app/mastery/%5Blesson%5D/page-19f8ee117e5859d3.js"],"LessonRenderer"]
4:I[4707,[],""]
6:I[6423,[],""]
7:I[872,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"ThemeProvider"]
8:I[3021,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Sidebar"]
9:I[8680,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Header"]
3:Tfa5,# Aula 20 — MCP Integration e Squad Testing

<!-- metadata
course: Mastery
module: 6
lesson: 20
title: "MCP Integration e Squad Testing"
duration: 4-5 horas
agents: "squad N8N, squad LinkedIn"
project: Squad N8N + LinkedIn
phase: Squads Avançados
prerequisites: Aula 19 concluída (Squad N8N funcional)
-->

---

> **Módulo 6** · Squads Avançados
> **Duração**: 4-5 horas
> **Agentes praticados**: Squad N8N, Squad LinkedIn
> **Projeto**: Squad N8N Automation + LinkedIn Automation

---

## 🏆 Vitória desta aula

MCP integration conectando agentes a sistemas externos (n8n, LinkedIn), e framework de testing formal para squads com 5 níveis de validação aprovados.

**Critério binário**: MCP server conectado → agente deploya via MCP (não HTTP direto) → squad testing 5 níveis passando para N8N e LinkedIn.

---

## Conceito

### MCP: protocolo padronizado para interações externas

MCP (Model Context Protocol) abstrai como agentes se comunicam com sistemas externos. Em vez de HTTP hardcoded no código do agente, MCP padroniza a conexão — trocar o backend (n8n por Temporal, por exemplo) é mudar o MCP server, não reescrever o agente.

### Squad Testing: squads são software, e software tem testes

| Nível | O que testa |
|-------|------------|
| 1. Config | config.yaml é válido contra schema AIOX |
| 2. Agent | Cada agente responde a seus comandos |
| 3. Workflow | Cada workflow executa end-to-end |
| 4. Integration | Squad funciona como unidade coesa |
| 5. Quality | Output atende checklists de domínio |

---

## Prática

### Passo 1 — MCP para Squad N8N

```bash
cd ~/aiox-mastery/n8n-squad
claude
```

```
Configure MCP integration para o Squad N8N:

1. MCP server para n8n:
   - Conectar agente Deployer ao n8n via MCP
   - Conectar agente Monitor para observar execuções
2. Testar: Deployer deploya workflow via MCP
3. MCP server para LinkedIn (squad LinkedIn):
   - Conectar Publisher para publicação
   - Conectar metrics collector para engagement
```

> **Checklist MCP**
> - [ ] MCP server do n8n configurado e conectado?
> - [ ] Deployer usa MCP (não HTTP direto)?
> - [ ] Monitor lê execuções via MCP?
> - [ ] MCP do LinkedIn conectado?

> **🏆 Checkpoint 1**: MCP integration funcional.

---

### Passo 2 — Squad Testing Framework

```
Implemente testing formal para squads N8N e LinkedIn.

5 níveis de teste:
1. CONFIG: config.yaml válido contra schema
2. AGENT: cada agente responde a *help e 1+ comando
3. WORKFLOW: workflow completo executa (happy + error path)
4. INTEGRATION: squad como unidade produz output correto
5. QUALITY: output atende checklist de domínio

Scripts:
- npm run test:squad -- --squad=n8n
- npm run test:squad -- --squad=linkedin
```

> **Checklist de testing**
> - [ ] 5 níveis implementados?
> - [ ] Squad N8N passa em todos?
> - [ ] Squad LinkedIn passa em todos?
> - [ ] Error paths testados?
> - [ ] Scripts automatizáveis?

> **🏆 Checkpoint 2 — VITÓRIA DA AULA**: MCP + testing formal aprovado.

---

### Passo 3 — Commit

```bash
*exit
git add .
git commit -m "feat: MCP integration + 5-level squad testing framework

- MCP server for n8n (deploy + monitor)
- MCP server for LinkedIn (publish + metrics)
- 5-level testing: config, agent, workflow, integration, quality
- Both squads passing all test levels"
```

---

## Reflexão

### O conceito-chave

> **MCP padroniza integrações externas — sem MCP, cada integração é HTTP customizado. Com MCP, trocar backend é mudar o server, não o agente. Squad testing garante confiabilidade: squads são software que precisa funcionar toda vez, verificável por testes automatizados, não por execução manual e esperança.**

### Conexão com a próxima aula

Na Aula 21, squads se conectam entre si: composição cross-squad com @aiox-orchestrator.

---

> **Anterior**: [Aula 19 — @squad-creator + Squad N8N](./aula-19-squad-creator-n8n.md)
> **Próxima**: [Aula 21 — Squad Composition e Ecossistema](./aula-21-composition.md)
5:["lesson","mastery-aula-20-mcp-testing","d"]
0:["0aCmzVh17xjX8k-qFi6hn",[[["",{"children":["mastery",{"children":[["lesson","mastery-aula-20-mcp-testing","d"],{"children":["__PAGE__?{\"lesson\":\"mastery-aula-20-mcp-testing\"}",{}]}]}]},"$undefined","$undefined",true],["",{"children":["mastery",{"children":[["lesson","mastery-aula-20-mcp-testing","d"],{"children":["__PAGE__",{},[["$L1",["$","$L2",null,{"content":"$3","lessonSlug":"mastery-aula-20-mcp-testing","module":"mastery","lessonIndex":19,"totalLessons":22,"nextLesson":"mastery-aula-21-composition","prevLesson":"mastery-aula-19-squad-creator-n8n"}],null],null],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","mastery","children","$5","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","mastery","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[[[["$","link","0",{"rel":"stylesheet","href":"/_next/static/css/71d217bb04404cb9.css","precedence":"next","crossOrigin":"$undefined"}]],["$","html",null,{"lang":"pt-BR","children":["$","body",null,{"className":"bg-white dark:bg-slate-900 text-gray-900 dark:text-gray-100 transition-colors","children":["$","$L7",null,{"children":["$","div",null,{"className":"flex h-screen overflow-hidden","children":[["$","$L8",null,{}],["$","div",null,{"className":"flex-1 flex flex-col overflow-hidden","children":[["$","$L9",null,{}],["$","main",null,{"className":"flex-1 overflow-y-auto bg-white dark:bg-slate-900 transition-colors","children":["$","div",null,{"className":"max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8","children":["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":[["$","title",null,{"children":"404: This page could not be found."}],["$","div",null,{"style":{"fontFamily":"system-ui,\"Segoe UI\",Roboto,Helvetica,Arial,sans-serif,\"Apple Color Emoji\",\"Segoe UI Emoji\"","height":"100vh","textAlign":"center","display":"flex","flexDirection":"column","alignItems":"center","justifyContent":"center"},"children":["$","div",null,{"children":[["$","style",null,{"dangerouslySetInnerHTML":{"__html":"body{color:#000;background:#fff;margin:0}.next-error-h1{border-right:1px solid rgba(0,0,0,.3)}@media (prefers-color-scheme:dark){body{color:#fff;background:#000}.next-error-h1{border-right:1px solid rgba(255,255,255,.3)}}"}}],["$","h1",null,{"className":"next-error-h1","style":{"display":"inline-block","margin":"0 20px 0 0","padding":"0 23px 0 0","fontSize":24,"fontWeight":500,"verticalAlign":"top","lineHeight":"49px"},"children":"404"}],["$","div",null,{"style":{"display":"inline-block"},"children":["$","h2",null,{"style":{"fontSize":14,"fontWeight":400,"lineHeight":"49px","margin":0},"children":"This page could not be found."}]}]]}]}]],"notFoundStyles":[]}]}]}]]}]]}]}]}]}]],null],null],["$La",null]]]]
a:[["$","meta","0",{"name":"viewport","content":"width=device-width, initial-scale=1"}],["$","meta","1",{"charSet":"utf-8"}],["$","title","2",{"children":"AIOX Course Platform | Professional Bootcamp & Mastery"}],["$","meta","3",{"name":"description","content":"Learn AIOX - AI-Orchestrated System for Full Stack Development. Complete bootcamp and mastery courses with hands-on projects."}],["$","meta","4",{"name":"keywords","content":"AIOX,AI Development,Full Stack,Course,Bootcamp,Learning"}]]
1:null
