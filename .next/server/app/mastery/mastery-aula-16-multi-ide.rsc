2:I[4817,["972","static/chunks/972-435ad046c10f8479.js","552","static/chunks/552-ca913c8f5aa11d94.js","460","static/chunks/app/mastery/%5Blesson%5D/page-19f8ee117e5859d3.js"],"LessonRenderer"]
4:I[4707,[],""]
6:I[6423,[],""]
7:I[872,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"ThemeProvider"]
8:I[3021,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Sidebar"]
9:I[8680,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Header"]
3:T1075,# Aula 16 — Multi-IDE na Prática

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
> - [ ] Feature implementada nas 3 IDEs?
> - [ ] Testes passam nas 3 branches?
> - [ ] .aiox-core/ reconhecido em todas?
> - [ ] Relatório com comparação e recomendações?

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

> **Anterior**: [Aula 15 — Hooks de Lifecycle](./aula-15-hooks.md)
> **Próxima**: [Aula 17 — Brownfield: LinkedIn Automation](./aula-17-brownfield-linkedin.md)
5:["lesson","mastery-aula-16-multi-ide","d"]
0:["0aCmzVh17xjX8k-qFi6hn",[[["",{"children":["mastery",{"children":[["lesson","mastery-aula-16-multi-ide","d"],{"children":["__PAGE__?{\"lesson\":\"mastery-aula-16-multi-ide\"}",{}]}]}]},"$undefined","$undefined",true],["",{"children":["mastery",{"children":[["lesson","mastery-aula-16-multi-ide","d"],{"children":["__PAGE__",{},[["$L1",["$","$L2",null,{"content":"$3","lessonSlug":"mastery-aula-16-multi-ide","module":"mastery","lessonIndex":15,"totalLessons":22,"nextLesson":"mastery-aula-17-brownfield-linkedin","prevLesson":"mastery-aula-15-hooks"}],null],null],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","mastery","children","$5","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","mastery","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[[[["$","link","0",{"rel":"stylesheet","href":"/_next/static/css/71d217bb04404cb9.css","precedence":"next","crossOrigin":"$undefined"}]],["$","html",null,{"lang":"pt-BR","children":["$","body",null,{"className":"bg-white dark:bg-slate-900 text-gray-900 dark:text-gray-100 transition-colors","children":["$","$L7",null,{"children":["$","div",null,{"className":"flex h-screen overflow-hidden","children":[["$","$L8",null,{}],["$","div",null,{"className":"flex-1 flex flex-col overflow-hidden","children":[["$","$L9",null,{}],["$","main",null,{"className":"flex-1 overflow-y-auto bg-white dark:bg-slate-900 transition-colors","children":["$","div",null,{"className":"max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8","children":["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":[["$","title",null,{"children":"404: This page could not be found."}],["$","div",null,{"style":{"fontFamily":"system-ui,\"Segoe UI\",Roboto,Helvetica,Arial,sans-serif,\"Apple Color Emoji\",\"Segoe UI Emoji\"","height":"100vh","textAlign":"center","display":"flex","flexDirection":"column","alignItems":"center","justifyContent":"center"},"children":["$","div",null,{"children":[["$","style",null,{"dangerouslySetInnerHTML":{"__html":"body{color:#000;background:#fff;margin:0}.next-error-h1{border-right:1px solid rgba(0,0,0,.3)}@media (prefers-color-scheme:dark){body{color:#fff;background:#000}.next-error-h1{border-right:1px solid rgba(255,255,255,.3)}}"}}],["$","h1",null,{"className":"next-error-h1","style":{"display":"inline-block","margin":"0 20px 0 0","padding":"0 23px 0 0","fontSize":24,"fontWeight":500,"verticalAlign":"top","lineHeight":"49px"},"children":"404"}],["$","div",null,{"style":{"display":"inline-block"},"children":["$","h2",null,{"style":{"fontSize":14,"fontWeight":400,"lineHeight":"49px","margin":0},"children":"This page could not be found."}]}]]}]}]],"notFoundStyles":[]}]}]}]]}]]}]}]}]}]],null],null],["$La",null]]]]
a:[["$","meta","0",{"name":"viewport","content":"width=device-width, initial-scale=1"}],["$","meta","1",{"charSet":"utf-8"}],["$","title","2",{"children":"AIOX Course Platform | Professional Bootcamp & Mastery"}],["$","meta","3",{"name":"description","content":"Learn AIOX - AI-Orchestrated System for Full Stack Development. Complete bootcamp and mastery courses with hands-on projects."}],["$","meta","4",{"name":"keywords","content":"AIOX,AI Development,Full Stack,Course,Bootcamp,Learning"}]]
1:null
