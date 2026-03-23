2:I[4817,["972","static/chunks/972-435ad046c10f8479.js","552","static/chunks/552-ca913c8f5aa11d94.js","460","static/chunks/app/mastery/%5Blesson%5D/page-19f8ee117e5859d3.js"],"LessonRenderer"]
4:I[4707,[],""]
6:I[6423,[],""]
7:I[872,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"ThemeProvider"]
8:I[3021,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Sidebar"]
9:I[8680,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Header"]
3:T218f,# Aula 14 — Ferramentas Interativas e Lab Provisioner

<!-- metadata
course: Mastery
module: 4
lesson: 14
title: "Ferramentas Interativas e Lab Provisioner"
duration: 5-6 horas
agents: "@dev, @devops, @zabbix-expert, @qa"
project: Plataforma Zabbix Learning
phase: Desenvolvimento Core
prerequisites: Aula 13 concluída (Quiz + Learning Path)
-->

---

> **Módulo 4** · Plataforma Zabbix: Desenvolvimento Core
> **Duração**: 5-6 horas
> **Agentes praticados**: `@dev`, `@devops`, `@zabbix-expert`, `@qa`
> **Projeto**: Plataforma Zabbix Learning

---

## 🏆 Vitória desta aula

Ferramentas interativas Zabbix funcionais (item creator, trigger creator, macro search) e Lab Provisioner provisionando instância Zabbix efêmera com configuração pré-definida acessível via iframe na tela da aula.

**Critério binário**: 3+ ferramentas interativas gerando configs válidas + lab provisionado com Zabbix acessível + Recovery System tratando falhas de containers.

---

## Conceito

### Tooling interativo: aprender fazendo, não lendo

Cada ferramenta interativa é uma mini-app que ensina um conceito Zabbix pela prática. Em vez de ler sobre trigger expressions, o aluno monta uma expressão visualmente, vê o resultado e exporta para usar no Zabbix real:

| Ferramenta | O que faz | Conceito que ensina |
|-----------|-----------|-------------------|
| Item Creator | Monta itens de monitoramento com preview | Items, keys, preprocessing |
| Trigger Creator | Monta expressões de trigger visualmente | Trigger expressions, severity |
| Macro Search | Pesquisa macros com exemplos de uso | Macros, context, templates |
| Script Generator | Gera scripts por prompt → IA → código | External checks, preprocessing |
| LLD Designer | Projeta discovery rules interativamente | Low-Level Discovery |

### Lab Provisioner: onde teoria vira prática de verdade

O design foi feito na Aula 10. A Aula 07 implementou o protótipo com Recovery System. Agora integramos com a plataforma: o aluno clica "Iniciar Lab" na tela de exercício e em 30-60 segundos tem uma instância Zabbix real, pré-configurada para aquele exercício, acessível na própria tela.

---

## Contexto

Esta é a última aula do Módulo 4. Após ela, os 6 subsistemas da Plataforma Zabbix estarão implementados: Auth (Aula 11), Content Engine (Aula 12), Quiz Engine + Learning Path (Aula 13), Ferramentas + Labs (esta aula). O Módulo 5 foca em refinamento avançado.

---

## Prática

### Passo 1 — Ferramentas interativas

```bash
cd ~/aiox-mastery/zabbix-platform
claude
```

```
@dev

Dex, implemente as ferramentas interativas Zabbix.
Consulte docs/prd/prd-tooling.md.

Para cada ferramenta:
1. Interface React com inputs relevantes ao conceito
2. @zabbix-expert no backend validando e sugerindo
3. Preview do resultado (como ficaria no Zabbix real)
4. Exportar configuração (copiar/download para usar)

Comece com 3 essenciais:

ITEM CREATOR:
- Selecionar tipo de item (Zabbix agent, SNMP, HTTP, etc.)
- Configurar key com parâmetros
- Definir preprocessing steps
- Preview: como o item apareceria no Zabbix
- @zabbix-expert sugere preprocessing baseado no tipo

TRIGGER CREATOR:
- Builder visual de expressões de trigger
- Drag-and-drop de funções (avg, last, diff, change)
- Definir severity, dependencies
- Preview: expressão completa + resultado esperado
- @zabbix-expert valida sintaxe

MACRO SEARCH:
- Busca por nome ou contexto
- Mostra: nome da macro, valor, onde é usada, exemplos
- Sugere macros para cenários comuns
- @zabbix-expert explica quando usar cada tipo 
  (global, host, template, LLD)
```

> **Checklist de ferramentas interativas**
> - [ ] Item Creator gera item válido com key correta?
> - [ ] Trigger Creator monta expressão sintaticamente correta?
> - [ ] Macro Search retorna macros reais com exemplos?
> - [ ] @zabbix-expert valida e sugere em tempo real?
> - [ ] Preview mostra como ficaria no Zabbix?
> - [ ] Export gera config utilizável?

Se as ferramentas gerarem configs inválidas:

```
Dex, o Trigger Creator gerou a expressão 
"last(host:key)" — essa é a sintaxe antiga (pré-6.0). 
A sintaxe atual é "last(/host/key)". O @zabbix-expert 
deve validar contra a versão do Zabbix que a plataforma 
cobre. Atualize.
```

> **🏆 Checkpoint 1**: 3 ferramentas interativas funcionais.

---

### Passo 2 — Lab Provisioner integrado

```
*exit

@devops

Dex-Ops, integre o Lab Provisioner (protótipo da Aula 07) 
com a plataforma completa.

Requisitos de integração:
1. Botão "Iniciar Lab" na tela de exercício da aula
2. Provisioning: subir container Zabbix pré-configurado
3. Exercise manifests: YAML que define a configuração 
   de cada lab (hosts, templates, triggers carregados)
4. Acesso via iframe na própria tela da aula
5. TTL: 30-60 minutos com countdown visível
6. Cleanup automático após expiração
7. Feature gating: free = sem labs, pro = 3/dia, 
   premium = ilimitado

Recovery System (da Aula 07):
- Retry com backoff se provisioning falhar
- Porta dinâmica se conflito
- Health check do Zabbix antes de marcar como ready
- Orphan cleanup periódico
```

**Teste completo**:

```bash
# Provisionar lab
curl -X POST http://localhost:3000/api/labs/provision \
  -H "Authorization: Bearer $TOKEN_PRO" \
  -d '{"exerciseId":"basic-monitoring","lessonId":3}' | jq

# Verificar status (deve passar por: provisioning → configuring → ready)
curl http://localhost:3000/api/labs/1/status | jq

# Acessar URL do Zabbix web
# A URL retornada deve abrir Zabbix com config pré-definida

# Verificar que lab expira após TTL
# Esperar 30 minutos (ou reduzir TTL para teste)
```

> **Checklist do Lab Provisioner**
> - [ ] Lab provisiona em < 60 segundos?
> - [ ] Zabbix web acessível via URL retornada?
> - [ ] Configuração pré-definida carregada (hosts, templates)?
> - [ ] Iframe funciona na tela da aula?
> - [ ] TTL com countdown visível?
> - [ ] Cleanup automático após expiração?
> - [ ] Feature gating funciona (free bloqueado)?
> - [ ] Recovery System trata falhas de provisioning?

> **🏆 Checkpoint 2**: Lab Provisioner integrado com a plataforma.

---

### Passo 3 — QA review dos 4 subsistemas

```
*exit

@qa

Quinn, review de integração dos 4 subsistemas do Módulo 4:
Auth + Content Engine + Quiz/Learning Path + Tooling/Labs.

Foco em integração cross-subsistema:
- Auth protege TODOS os endpoints dos 4 subsistemas?
- Feature gating funciona nos labs E no conteúdo?
- Content → Quiz → Path flui sem breaks?
- Labs respeitam isolamento de tenants?
- Ferramentas interativas são acessíveis conforme plano?
- Performance: tempo de geração de aula + quiz + lab 
  é aceitável para o aluno?

*review-build
```

Ciclo de correções.

> **🏆 Checkpoint 3 — VITÓRIA DA AULA E DO MÓDULO 4**: 6 subsistemas implementados e integrados.

---

### Passo 4 — Commit

```bash
*exit
git add .
git commit -m "feat: interactive tools + Lab Provisioner integrated with platform

- 3 interactive tools: Item Creator, Trigger Creator, Macro Search
- @zabbix-expert validation and suggestions in real-time
- Lab Provisioner: ephemeral Zabbix with exercise manifests
- Lab iframe embedded in lesson UI with countdown timer
- Recovery system for container failures
- Feature gating across all tools and labs
- QA cross-subsystem integration review approved"
```

---

## Reflexão

### O Módulo 4 completo: de planejamento a produto

Quatro aulas transformaram a Plataforma Zabbix de especificações em produto funcional:

```
Aula 11: Auth      → Fundação (quem é, o que pode, a quem pertence)
Aula 12: Content   → Valor (aulas geradas por IA com qualidade)
Aula 13: Quiz+Path → Engajamento (gamificação + adaptatividade)
Aula 14: Tools+Lab → Prática (ferramentas + ambiente real)
```

### O conceito-chave

> **Cada subsistema da Plataforma Zabbix foi implementado com o rigor do ADE (specs aprovadas, 13 steps, recovery, review) e validado pelo QA em integração. É um SaaS real com 6 subsistemas trabalhando juntos: auth protege, content ensina, quiz avalia, path adapta, tools praticam, labs experimentam. O Módulo 5 vai refinar e expandir essa base.**

### Conexão com o Módulo 5

O Módulo 5 (Aulas 15-17): hooks de lifecycle para automação, multi-IDE testando a plataforma em Claude Code + Gemini CLI + Codex CLI, e brownfield completo do LinkedIn Automation.

---

> **Anterior**: [Aula 13 — Quiz Engine + Learning Path](./aula-13-quiz-learning-path.md)
> **Próxima**: [Aula 15 — Hooks de Lifecycle + Automação](../modulo-05/aula-15-hooks.md) *(Módulo 5)*
5:["lesson","mastery-aula-14-tooling-labs","d"]
0:["0aCmzVh17xjX8k-qFi6hn",[[["",{"children":["mastery",{"children":[["lesson","mastery-aula-14-tooling-labs","d"],{"children":["__PAGE__?{\"lesson\":\"mastery-aula-14-tooling-labs\"}",{}]}]}]},"$undefined","$undefined",true],["",{"children":["mastery",{"children":[["lesson","mastery-aula-14-tooling-labs","d"],{"children":["__PAGE__",{},[["$L1",["$","$L2",null,{"content":"$3","lessonSlug":"mastery-aula-14-tooling-labs","module":"mastery","lessonIndex":13,"totalLessons":22,"nextLesson":"mastery-aula-15-hooks","prevLesson":"mastery-aula-13-quiz-learning-path"}],null],null],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","mastery","children","$5","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","mastery","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[[[["$","link","0",{"rel":"stylesheet","href":"/_next/static/css/71d217bb04404cb9.css","precedence":"next","crossOrigin":"$undefined"}]],["$","html",null,{"lang":"pt-BR","children":["$","body",null,{"className":"bg-white dark:bg-slate-900 text-gray-900 dark:text-gray-100 transition-colors","children":["$","$L7",null,{"children":["$","div",null,{"className":"flex h-screen overflow-hidden","children":[["$","$L8",null,{}],["$","div",null,{"className":"flex-1 flex flex-col overflow-hidden","children":[["$","$L9",null,{}],["$","main",null,{"className":"flex-1 overflow-y-auto bg-white dark:bg-slate-900 transition-colors","children":["$","div",null,{"className":"max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8","children":["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":[["$","title",null,{"children":"404: This page could not be found."}],["$","div",null,{"style":{"fontFamily":"system-ui,\"Segoe UI\",Roboto,Helvetica,Arial,sans-serif,\"Apple Color Emoji\",\"Segoe UI Emoji\"","height":"100vh","textAlign":"center","display":"flex","flexDirection":"column","alignItems":"center","justifyContent":"center"},"children":["$","div",null,{"children":[["$","style",null,{"dangerouslySetInnerHTML":{"__html":"body{color:#000;background:#fff;margin:0}.next-error-h1{border-right:1px solid rgba(0,0,0,.3)}@media (prefers-color-scheme:dark){body{color:#fff;background:#000}.next-error-h1{border-right:1px solid rgba(255,255,255,.3)}}"}}],["$","h1",null,{"className":"next-error-h1","style":{"display":"inline-block","margin":"0 20px 0 0","padding":"0 23px 0 0","fontSize":24,"fontWeight":500,"verticalAlign":"top","lineHeight":"49px"},"children":"404"}],["$","div",null,{"style":{"display":"inline-block"},"children":["$","h2",null,{"style":{"fontSize":14,"fontWeight":400,"lineHeight":"49px","margin":0},"children":"This page could not be found."}]}]]}]}]],"notFoundStyles":[]}]}]}]]}]]}]}]}]}]],null],null],["$La",null]]]]
a:[["$","meta","0",{"name":"viewport","content":"width=device-width, initial-scale=1"}],["$","meta","1",{"charSet":"utf-8"}],["$","title","2",{"children":"AIOX Course Platform | Professional Bootcamp & Mastery"}],["$","meta","3",{"name":"description","content":"Learn AIOX - AI-Orchestrated System for Full Stack Development. Complete bootcamp and mastery courses with hands-on projects."}],["$","meta","4",{"name":"keywords","content":"AIOX,AI Development,Full Stack,Course,Bootcamp,Learning"}]]
1:null
