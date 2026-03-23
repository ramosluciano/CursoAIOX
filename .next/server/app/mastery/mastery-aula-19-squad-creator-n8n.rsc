2:I[4817,["972","static/chunks/972-435ad046c10f8479.js","552","static/chunks/552-ca913c8f5aa11d94.js","460","static/chunks/app/mastery/%5Blesson%5D/page-19f8ee117e5859d3.js"],"LessonRenderer"]
4:I[4707,[],""]
6:I[6423,[],""]
7:I[872,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"ThemeProvider"]
8:I[3021,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Sidebar"]
9:I[8680,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Header"]
3:T1442,# Aula 19 — @squad-creator + Squad N8N Automation

<!-- metadata
course: Mastery
module: 6
lesson: 19
title: "@squad-creator + Squad N8N Automation"
duration: 4-5 horas
agents: "@squad-creator, squad N8N (6 agentes)"
project: Squad N8N Automation
phase: Squads Avançados
prerequisites: Aula 18 concluída (Squad Zabbix Content)
-->

---

> **Módulo 6** · Squads Avançados
> **Duração**: 4-5 horas
> **Agentes praticados**: `@squad-creator`, Squad N8N (6 agentes)
> **Projeto**: Squad N8N Automation

---

## 🏆 Vitória desta aula

Squad N8N Automation criado via @squad-creator, comparado com design manual, refinado, e funcional: agentes que projetam, criam, deployam e testam workflows n8n.

**Critério binário**: @squad-creator gera squad → comparação com design esperado → refinamento → squad funcional que deploya workflow n8n real.

---

## Conceito

### @squad-creator: meta-automação com refinamento humano

O @squad-creator automatiza a criação de squads: você descreve o objetivo e ele gera agentes, workflows e config.yaml. Mas output automatizado raramente é perfeito na primeira versão — assim como specs precisam de iteração (Aula 05), squads gerados precisam de refinamento.

O fluxo é: @squad-creator gera → você compara com design manual esperado → refina o que falta ou está errado → testa.

### Squad N8N: automação que cria automação

O projeto mais recursivo do programa: agentes AIOX que projetam, criam, deployam e monitoram workflows n8n. É IA criando automações — meta em dois níveis.

---

## Prática

### Passo 1 — @squad-creator gera o squad

```bash
mkdir -p ~/aiox-mastery/n8n-squad
cd ~/aiox-mastery/n8n-squad
git init
claude
```

```
@squad-creator

Gere um squad para automação de workflows n8n.

O squad deve:
- Entender necessidades de automação de um usuário
- Projetar o workflow n8n (nodes, connections, logic)
- Gerar o JSON do workflow
- Deployar via API do n8n
- Testar a execução
- Monitorar execuções e detectar erros

Contexto: n8n roda em Docker com Redis workers.
API disponível em http://n8n:5678/api/v1/.
Workflows são JSON com nodes e connections.
```

---

### Passo 2 — Comparar com design manual esperado

```
Compare o output do @squad-creator com o que eu esperaria:

Agentes esperados:
1. Automation Analyst: entende necessidade de automação
2. Workflow Designer: projeta workflow (nodes, connections, logic)
3. Workflow Builder: gera JSON do workflow
4. Deployer: deploya via API n8n
5. Tester: executa workflow e valida resultado
6. Monitor: observa execuções e detecta erros

O @squad-creator gerou esses? Faltou algum? Algum está 
duplicado ou desnecessário? Os workflows fazem sentido?

Documente diferenças em docs/squad-creator-comparison.md.
Faça os ajustes necessários no config.yaml e agentes.
```

> **Checklist**
> - [ ] @squad-creator gerou output válido?
> - [ ] 6 agentes presentes (ou equivalentes)?
> - [ ] Workflows cobrem ciclo completo (design → deploy → test → monitor)?
> - [ ] Diferenças com design esperado documentadas?
> - [ ] Refinamento aplicado e documentado?

> **🏆 Checkpoint 1**: Squad gerado + refinado.

---

### Passo 3 — Testar com workflow real

```
Execute o Squad N8N para criar um workflow real:

"Preciso de um workflow n8n que toda segunda às 8h:
1. Busque os 5 posts mais recentes do meu LinkedIn
2. Calcule engagement rate de cada um
3. Envie relatório por email com ranking dos posts"

O squad deve: analisar → projetar → gerar JSON → 
deployar → testar.
```

> **Checklist**
> - [ ] Workflow JSON gerado é válido (importável no n8n)?
> - [ ] Nodes fazem sentido para a automação pedida?
> - [ ] Deploy via API funcionou?
> - [ ] Teste de execução passou (ou simulou corretamente)?

Se o JSON for inválido:

```
O JSON gerado pelo Workflow Builder não importa no n8n — 
falta o campo "connections" entre nodes. O Builder precisa 
gerar JSON completo que o n8n aceita via POST /api/v1/workflows.
Valide contra o schema da API do n8n.
```

> **🏆 Checkpoint 2 — VITÓRIA DA AULA**: Squad N8N funcional com workflow deployado.

---

### Passo 4 — Commit

```bash
*exit
git add .
git commit -m "feat: N8N Automation Squad via @squad-creator + refinement

- @squad-creator generated initial squad definition
- Comparison with manual design: docs/squad-creator-comparison.md
- Manual refinement: 6 agents aligned with n8n lifecycle
- Tested with real workflow: LinkedIn engagement report
- Deploy via n8n API verified"
```

---

## Reflexão

### O conceito-chave

> **O @squad-creator acelera criação mas não elimina design humano. Output automatizado é draft — bom ponto de partida que precisa de refinamento baseado em domínio. A comparação "gerado vs esperado" ensina a avaliar e melhorar outputs do @squad-creator para qualquer domínio futuro.**

### Conexão com a próxima aula

Na Aula 20, MCP integration conecta agentes ao n8n e testing formal valida os squads como software.

---

> **Anterior**: [Aula 18 — Squad Zabbix Content](./aula-18-squad-zabbix-content.md)
> **Próxima**: [Aula 20 — MCP Integration e Squad Testing](./aula-20-mcp-testing.md)
5:["lesson","mastery-aula-19-squad-creator-n8n","d"]
0:["0aCmzVh17xjX8k-qFi6hn",[[["",{"children":["mastery",{"children":[["lesson","mastery-aula-19-squad-creator-n8n","d"],{"children":["__PAGE__?{\"lesson\":\"mastery-aula-19-squad-creator-n8n\"}",{}]}]}]},"$undefined","$undefined",true],["",{"children":["mastery",{"children":[["lesson","mastery-aula-19-squad-creator-n8n","d"],{"children":["__PAGE__",{},[["$L1",["$","$L2",null,{"content":"$3","lessonSlug":"mastery-aula-19-squad-creator-n8n","module":"mastery","lessonIndex":18,"totalLessons":22,"nextLesson":"mastery-aula-20-mcp-testing","prevLesson":"mastery-aula-18-squad-zabbix-content"}],null],null],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","mastery","children","$5","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","mastery","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[[[["$","link","0",{"rel":"stylesheet","href":"/_next/static/css/71d217bb04404cb9.css","precedence":"next","crossOrigin":"$undefined"}]],["$","html",null,{"lang":"pt-BR","children":["$","body",null,{"className":"bg-white dark:bg-slate-900 text-gray-900 dark:text-gray-100 transition-colors","children":["$","$L7",null,{"children":["$","div",null,{"className":"flex h-screen overflow-hidden","children":[["$","$L8",null,{}],["$","div",null,{"className":"flex-1 flex flex-col overflow-hidden","children":[["$","$L9",null,{}],["$","main",null,{"className":"flex-1 overflow-y-auto bg-white dark:bg-slate-900 transition-colors","children":["$","div",null,{"className":"max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8","children":["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":[["$","title",null,{"children":"404: This page could not be found."}],["$","div",null,{"style":{"fontFamily":"system-ui,\"Segoe UI\",Roboto,Helvetica,Arial,sans-serif,\"Apple Color Emoji\",\"Segoe UI Emoji\"","height":"100vh","textAlign":"center","display":"flex","flexDirection":"column","alignItems":"center","justifyContent":"center"},"children":["$","div",null,{"children":[["$","style",null,{"dangerouslySetInnerHTML":{"__html":"body{color:#000;background:#fff;margin:0}.next-error-h1{border-right:1px solid rgba(0,0,0,.3)}@media (prefers-color-scheme:dark){body{color:#fff;background:#000}.next-error-h1{border-right:1px solid rgba(255,255,255,.3)}}"}}],["$","h1",null,{"className":"next-error-h1","style":{"display":"inline-block","margin":"0 20px 0 0","padding":"0 23px 0 0","fontSize":24,"fontWeight":500,"verticalAlign":"top","lineHeight":"49px"},"children":"404"}],["$","div",null,{"style":{"display":"inline-block"},"children":["$","h2",null,{"style":{"fontSize":14,"fontWeight":400,"lineHeight":"49px","margin":0},"children":"This page could not be found."}]}]]}]}]],"notFoundStyles":[]}]}]}]]}]]}]}]}]}]],null],null],["$La",null]]]]
a:[["$","meta","0",{"name":"viewport","content":"width=device-width, initial-scale=1"}],["$","meta","1",{"charSet":"utf-8"}],["$","title","2",{"children":"AIOX Course Platform | Professional Bootcamp & Mastery"}],["$","meta","3",{"name":"description","content":"Learn AIOX - AI-Orchestrated System for Full Stack Development. Complete bootcamp and mastery courses with hands-on projects."}],["$","meta","4",{"name":"keywords","content":"AIOX,AI Development,Full Stack,Course,Bootcamp,Learning"}]]
1:null
