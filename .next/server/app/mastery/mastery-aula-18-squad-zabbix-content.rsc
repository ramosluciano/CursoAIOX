2:I[4817,["972","static/chunks/972-435ad046c10f8479.js","552","static/chunks/552-ca913c8f5aa11d94.js","460","static/chunks/app/mastery/%5Blesson%5D/page-19f8ee117e5859d3.js"],"LessonRenderer"]
4:I[4707,[],""]
6:I[6423,[],""]
7:I[872,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"ThemeProvider"]
8:I[3021,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Sidebar"]
9:I[8680,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Header"]
3:T14ee,# Aula 18 — Squad Zabbix Content (para a Plataforma)

<!-- metadata
course: Mastery
module: 6
lesson: 18
title: "Squad Zabbix Content"
duration: 4-5 horas
agents: "squad Zabbix Content (5 agentes)"
project: Plataforma Zabbix Learning
phase: Squads Avançados
prerequisites: Aula 17 concluída (brownfield LinkedIn completo)
-->

---

> **Módulo 6** · Squads Avançados
> **Duração**: 4-5 horas
> **Agentes praticados**: Squad Zabbix Content (5 agentes)
> **Projeto**: Plataforma Zabbix Learning

---

## 🏆 Vitória desta aula

Squad de conteúdo educacional Zabbix funcional com 5 agentes especializados, workflow de geração em lote, e integração com o Content Engine da plataforma. Módulo inteiro gerado de uma vez.

**Critério binário**: Squad definido com 5 agentes + workflow de lote testado + módulo completo gerado (3+ aulas com quiz e lab cada).

---

## Conceito

### Squad de conteúdo: escala que 1 agente não atinge

O @zabbix-expert gera aulas individuais. Mas a Plataforma precisa de centenas — organizadas em módulos, com progressão lógica, quizzes alinhados e labs configurados. Um squad de 5 agentes especializados, cada um responsável por uma dimensão, mantém coerência em escala:

| Agente | Responsabilidade |
|--------|-----------------|
| Curriculum Planner | Planeja módulo: aulas, ordem, pré-requisitos, duração |
| Lesson Writer | Escreve conteúdo de cada aula (RAG + @zabbix-expert) |
| Quiz Generator | Gera perguntas por tema/dificuldade com alternativas |
| Lab Designer | Projeta exercícios práticos com exercise manifests |
| Reviewer | Revisa precisão técnica, completude e pedagogia |

O workflow de lote orquestra os 5: input (tema + nível) → output (módulo completo com aulas, quizzes, labs).

---

## Prática

### Passo 1 — Definir o squad

```bash
cd ~/aiox-mastery/zabbix-platform
claude
```

```
Crie o Squad Zabbix Content com 5 agentes no formato V3.

Cada agente deve:
- Ter role e comandos claros
- Referenciar knowledge base (documentação Zabbix)
- Referenciar checklists de qualidade (Aula 03)
- Interagir com outros agentes do squad

Crie o workflow de geração em lote:
1. Curriculum Planner recebe tema + nível
2. Define estrutura do módulo (3-5 aulas com progressão)
3. Lesson Writer gera cada aula via RAG
4. Quiz Generator gera quiz por aula (5 perguntas)
5. Lab Designer projeta lab por aula (exercise manifest)
6. Reviewer valida tudo (loop de correção se necessário)

config.yaml + workflows em .aiox-core/squads/zabbix-content/
```

> **Checklist do squad**
> - [ ] 5 agentes no formato V3?
> - [ ] Workflows de geração em lote definidos?
> - [ ] Checklists de qualidade referenciados?
> - [ ] config.yaml válido?

> **🏆 Checkpoint 1**: Squad definido.

---

### Passo 2 — Testar geração em lote

```
Execute o workflow de lote para gerar o módulo 
"Zabbix Triggers" (nível intermediário).

Espero:
- Aula 1: Conceitos de triggers (expressões básicas)
- Aula 2: Trigger dependencies e correlação
- Aula 3: Trigger actions e escalation
- Cada aula com: conteúdo + quiz (5 perguntas) + lab manifest
```

> **Checklist de geração em lote**
> - [ ] Curriculum Planner definiu estrutura coerente?
> - [ ] 3 aulas geradas com conteúdo substantivo?
> - [ ] Quizzes tecnicamente corretos?
> - [ ] Labs com exercise manifests funcionais?
> - [ ] Reviewer encontrou e corrigiu issues?
> - [ ] Progressão entre aulas é lógica?

Se o Reviewer não encontrar nada:

```
Reviewer, releia a Aula 2 sobre trigger dependencies. 
A explicação está correta mas falta um exemplo prático 
de dependency entre trigger de servidor e trigger de 
serviço. Sem exemplo, o aluno não consegue aplicar.
```

> **🏆 Checkpoint 2**: Módulo completo gerado em lote.

---

### Passo 3 — Integrar com Content Engine

```
Integre o output do squad com a plataforma:
- Aulas geradas → ingestão no Content Engine
- Quizzes → Quiz Engine
- Labs → exercise manifests para Lab Provisioner
- Tudo vinculado ao Learning Path

Após integração, o módulo deve aparecer na plataforma 
como qualquer conteúdo — navegável, jogável, com labs.
```

> **🏆 Checkpoint 3 — VITÓRIA DA AULA**: Squad gerando módulos integrados com a plataforma.

---

### Passo 4 — Commit

```bash
*exit
git add .
git commit -m "feat: Zabbix Content Squad - batch generation of educational modules

- 5-agent squad: Curriculum Planner, Lesson Writer, Quiz Generator, Lab Designer, Reviewer
- Batch workflow: module from topic + level (3+ lessons with quizzes and labs)
- Tested with Zabbix Triggers module
- Full integration with Content Engine, Quiz Engine, Lab Provisioner"
```

---

## Reflexão

### O conceito-chave

> **Squads de conteúdo escalam produção de "1 aula por vez" para "1 módulo por vez" com qualidade consistente. O Reviewer como agente dedicado garante autocorreção. O workflow de lote é a linha de produção que a Plataforma precisa para ter centenas de aulas — impossível gerar manualmente, viável com squad.**

### Conexão com a próxima aula

Na Aula 19, o @squad-creator gera o Squad N8N automaticamente e comparamos com design manual.

---

> **Anterior**: [Aula 17 — Brownfield LinkedIn](../modulo-05/aula-17-brownfield-linkedin.md)
> **Próxima**: [Aula 19 — @squad-creator + Squad N8N](./aula-19-squad-creator-n8n.md)
5:["lesson","mastery-aula-18-squad-zabbix-content","d"]
0:["0aCmzVh17xjX8k-qFi6hn",[[["",{"children":["mastery",{"children":[["lesson","mastery-aula-18-squad-zabbix-content","d"],{"children":["__PAGE__?{\"lesson\":\"mastery-aula-18-squad-zabbix-content\"}",{}]}]}]},"$undefined","$undefined",true],["",{"children":["mastery",{"children":[["lesson","mastery-aula-18-squad-zabbix-content","d"],{"children":["__PAGE__",{},[["$L1",["$","$L2",null,{"content":"$3","lessonSlug":"mastery-aula-18-squad-zabbix-content","module":"mastery","lessonIndex":17,"totalLessons":22,"nextLesson":"mastery-aula-19-squad-creator-n8n","prevLesson":"mastery-aula-17-brownfield-linkedin"}],null],null],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","mastery","children","$5","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","mastery","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[[[["$","link","0",{"rel":"stylesheet","href":"/_next/static/css/71d217bb04404cb9.css","precedence":"next","crossOrigin":"$undefined"}]],["$","html",null,{"lang":"pt-BR","children":["$","body",null,{"className":"bg-white dark:bg-slate-900 text-gray-900 dark:text-gray-100 transition-colors","children":["$","$L7",null,{"children":["$","div",null,{"className":"flex h-screen overflow-hidden","children":[["$","$L8",null,{}],["$","div",null,{"className":"flex-1 flex flex-col overflow-hidden","children":[["$","$L9",null,{}],["$","main",null,{"className":"flex-1 overflow-y-auto bg-white dark:bg-slate-900 transition-colors","children":["$","div",null,{"className":"max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8","children":["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":[["$","title",null,{"children":"404: This page could not be found."}],["$","div",null,{"style":{"fontFamily":"system-ui,\"Segoe UI\",Roboto,Helvetica,Arial,sans-serif,\"Apple Color Emoji\",\"Segoe UI Emoji\"","height":"100vh","textAlign":"center","display":"flex","flexDirection":"column","alignItems":"center","justifyContent":"center"},"children":["$","div",null,{"children":[["$","style",null,{"dangerouslySetInnerHTML":{"__html":"body{color:#000;background:#fff;margin:0}.next-error-h1{border-right:1px solid rgba(0,0,0,.3)}@media (prefers-color-scheme:dark){body{color:#fff;background:#000}.next-error-h1{border-right:1px solid rgba(255,255,255,.3)}}"}}],["$","h1",null,{"className":"next-error-h1","style":{"display":"inline-block","margin":"0 20px 0 0","padding":"0 23px 0 0","fontSize":24,"fontWeight":500,"verticalAlign":"top","lineHeight":"49px"},"children":"404"}],["$","div",null,{"style":{"display":"inline-block"},"children":["$","h2",null,{"style":{"fontSize":14,"fontWeight":400,"lineHeight":"49px","margin":0},"children":"This page could not be found."}]}]]}]}]],"notFoundStyles":[]}]}]}]]}]]}]}]}]}]],null],null],["$La",null]]]]
a:[["$","meta","0",{"name":"viewport","content":"width=device-width, initial-scale=1"}],["$","meta","1",{"charSet":"utf-8"}],["$","title","2",{"children":"AIOX Course Platform | Professional Bootcamp & Mastery"}],["$","meta","3",{"name":"description","content":"Learn AIOX - AI-Orchestrated System for Full Stack Development. Complete bootcamp and mastery courses with hands-on projects."}],["$","meta","4",{"name":"keywords","content":"AIOX,AI Development,Full Stack,Course,Bootcamp,Learning"}]]
1:null
