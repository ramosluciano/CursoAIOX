2:I[4817,["972","static/chunks/972-435ad046c10f8479.js","552","static/chunks/552-ca913c8f5aa11d94.js","460","static/chunks/app/mastery/%5Blesson%5D/page-19f8ee117e5859d3.js"],"LessonRenderer"]
4:I[4707,[],""]
6:I[6423,[],""]
7:I[872,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"ThemeProvider"]
8:I[3021,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Sidebar"]
9:I[8680,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Header"]
3:T1a26,# Aula 15 — Hooks de Lifecycle + Automação

<!-- metadata
course: Mastery
module: 5
lesson: 15
title: "Hooks de Lifecycle + Automação"
duration: 4 horas
agents: "@dev, @devops"
project: Plataforma Zabbix Learning + LinkedIn
phase: Hooks + Multi-IDE + Brownfield
prerequisites: Aula 14 concluída (6 subsistemas implementados)
-->

---

> **Módulo 5** · Hooks, Multi-IDE e Brownfield
> **Duração**: 4 horas
> **Agentes praticados**: `@dev`, `@devops`
> **Projeto**: Plataforma Zabbix Learning + LinkedIn Automation

---

## 🏆 Vitória desta aula

3+ hooks de lifecycle customizados criados e funcionando: auto-teste de conteúdo gerado, monitoramento de labs, e coleta de métricas de uso dos agentes.

**Critério binário**: 3 hooks ativos → eventos disparam → hooks executam ação → resultado verificável nos logs ou dashboard.

---

## Conceito

### Hooks: automação do processo de desenvolvimento

No Bootcamp, cada ação era explícita: você chamava agente, pedia ação, verificava. Hooks automatizam esse ciclo: quando um evento acontece no AIOX, um hook executa uma ação automaticamente sem intervenção.

| Tipo de hook | Quando dispara | Exemplo |
|-------------|---------------|---------|
| `pre-tool` | Antes de um agente executar | Validar input antes do @dev implementar |
| `post-tool` | Depois de um agente executar | Auto-testar código gerado pelo @dev |
| `session-start` | Quando sessão AIOX inicia | Carregar contexto do projeto |
| `session-end` | Quando sessão AIOX encerra | Salvar insights na Memory Layer |
| `monitor` | Periodicamente | Coletar métricas, verificar saúde |

A diferença é estrutural: hooks garantem que verificações acontecem **sempre**, não apenas quando você lembra. Se toda aula gerada pelo Content Engine deve passar pelo checklist de qualidade, um hook `post-tool` garante isso automaticamente.

---

## Contexto

A Plataforma Zabbix tem 6 subsistemas rodando. Agora automatizamos verificações e monitoramentos que antes eram manuais. Hooks são aplicados tanto na Plataforma Zabbix quanto no LinkedIn Automation — qualquer projeto AIOX se beneficia.

---

## Prática

### Passo 1 — Explorar sistema de hooks

```bash
cd ~/aiox-mastery/zabbix-platform
claude
```

```
Explore o sistema de hooks do AIOX:
- Onde hooks são definidos no .aiox-core/?
- Qual o formato de definição (YAML, MD, JS)?
- Quais eventos estão disponíveis?
- Como um hook acessa o output do agente que disparou?
- Como um hook reporta resultados?

Documente em docs/hooks-reference.md.
```

---

### Passo 2 — Hook 1: auto-teste de conteúdo

```
Crie um hook post-tool que dispara toda vez que o 
@zabbix-expert ou o Content Engine gerar uma aula:

Ação do hook:
1. Ler conteúdo gerado
2. Aplicar checklist zabbix-lesson-quality.md automaticamente
3. Verificar se conceitos mencionados existem na documentação 
   oficial (anti-hallucination check)
4. Calcular score de qualidade (0-100)
5. Se score < 70%: emitir warning no log + marcar conteúdo 
   como "needs-review"
6. Se score ≥ 70%: marcar como "auto-approved"

Salve em .aiox-core/hooks/post-content-generation.yaml
```

**Teste**: Gere uma aula e verifique que o hook disparou:

```bash
# Gerar aula via Content Engine
curl -X POST http://localhost:3000/api/content/generate \
  -d '{"topic":"Zabbix API","level":"advanced"}' | jq

# Verificar log do hook
cat logs/hooks/post-content-generation.log

# Verificar status do conteúdo
curl http://localhost:3000/api/content/lessons/latest | jq '.qualityScore, .status'
```

> **Checklist**
> - [ ] Hook dispara automaticamente após geração?
> - [ ] Score de qualidade é calculado?
> - [ ] Conteúdo com score < 70% é marcado "needs-review"?
> - [ ] Anti-hallucination check funciona?
> - [ ] Log registra resultado do hook?

> **🏆 Checkpoint 1**: Hook de auto-teste disparando.

---

### Passo 3 — Hook 2: monitoramento de labs

```
Crie um hook monitor que verifica o Lab Provisioner 
periodicamente (a cada 5 minutos):

Ação do hook:
1. Listar containers de lab ativos
2. Verificar health de cada um (Zabbix web respondendo?)
3. Se lab falhou (container crashed): notificar via log + webhook
4. Se lab está orphan (TTL expirado mas não destruído): 
   forçar cleanup
5. Registrar métricas: labs ativos, labs falhos, labs 
   limpos, recursos consumidos

Salve em .aiox-core/hooks/monitor-lab-health.yaml
```

**Teste**:

```bash
# Provisionar um lab
# Matar o container manualmente (simular falha)
docker stop [container-id]

# Esperar hook rodar (5 minutos ou trigger manual)
# Verificar que hook detectou e logou a falha
cat logs/hooks/monitor-lab-health.log
```

> **🏆 Checkpoint 2**: Hook de monitoramento de labs ativo.

---

### Passo 4 — Hook 3: métricas de uso de agentes

```
Crie um hook session-end que ao final de cada sessão AIOX:

1. Registrar quais agentes foram usados na sessão
2. Tempo de execução de cada agente
3. Quantas iterações foram necessárias (ciclos de correção)
4. Resultado final (sucesso/falha/parcial)
5. Salvar em banco para análise de produtividade

Aplicar na Plataforma Zabbix E no LinkedIn Automation.
```

> **Checklist**
> - [ ] Hook dispara ao final de cada sessão?
> - [ ] Métricas de agentes são registradas?
> - [ ] Dados são persistidos para consulta posterior?
> - [ ] Funciona em ambos os projetos?

> **🏆 Checkpoint 3 — VITÓRIA DA AULA**: 3 hooks customizados funcionando.

---

### Passo 5 — Commit

```bash
*exit
git add .
git commit -m "feat: 3 custom lifecycle hooks for content QA, lab monitoring, agent metrics

- post-tool hook: auto-validate generated content with quality scoring
- monitor hook: Lab Provisioner health + orphan cleanup every 5min
- session-end hook: agent usage metrics collection
- Applied to Zabbix Platform and LinkedIn projects
- hooks-reference.md documenting system"
```

---

## Reflexão

### O conceito-chave

> **Hooks transformam verificações manuais em garantias estruturais. O hook de auto-teste garante que NENHUMA aula vai para produção sem validação — mesmo que você esqueça de verificar. O hook de monitoramento garante que labs falhos são detectados em 5 minutos, não dias. A diferença entre "processo que depende de disciplina" e "processo estruturalmente garantido".**

### Conexão com a próxima aula

Na Aula 16, testamos a Plataforma Zabbix em 3 IDEs diferentes: Claude Code, Gemini CLI e Codex CLI. Mesma feature, 3 implementações, relatório de paridade.

---

> **Anterior**: [Aula 14 — Ferramentas Interativas e Lab Provisioner](../modulo-04/aula-14-tooling-labs.md)
> **Próxima**: [Aula 16 — Multi-IDE na Prática](./aula-16-multi-ide.md)
5:["lesson","mastery-aula-15-hooks","d"]
0:["0aCmzVh17xjX8k-qFi6hn",[[["",{"children":["mastery",{"children":[["lesson","mastery-aula-15-hooks","d"],{"children":["__PAGE__?{\"lesson\":\"mastery-aula-15-hooks\"}",{}]}]}]},"$undefined","$undefined",true],["",{"children":["mastery",{"children":[["lesson","mastery-aula-15-hooks","d"],{"children":["__PAGE__",{},[["$L1",["$","$L2",null,{"content":"$3","lessonSlug":"mastery-aula-15-hooks","module":"mastery","lessonIndex":14,"totalLessons":22,"nextLesson":"mastery-aula-16-multi-ide","prevLesson":"mastery-aula-14-tooling-labs"}],null],null],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","mastery","children","$5","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","mastery","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[[[["$","link","0",{"rel":"stylesheet","href":"/_next/static/css/71d217bb04404cb9.css","precedence":"next","crossOrigin":"$undefined"}]],["$","html",null,{"lang":"pt-BR","children":["$","body",null,{"className":"bg-white dark:bg-slate-900 text-gray-900 dark:text-gray-100 transition-colors","children":["$","$L7",null,{"children":["$","div",null,{"className":"flex h-screen overflow-hidden","children":[["$","$L8",null,{}],["$","div",null,{"className":"flex-1 flex flex-col overflow-hidden","children":[["$","$L9",null,{}],["$","main",null,{"className":"flex-1 overflow-y-auto bg-white dark:bg-slate-900 transition-colors","children":["$","div",null,{"className":"max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8","children":["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":[["$","title",null,{"children":"404: This page could not be found."}],["$","div",null,{"style":{"fontFamily":"system-ui,\"Segoe UI\",Roboto,Helvetica,Arial,sans-serif,\"Apple Color Emoji\",\"Segoe UI Emoji\"","height":"100vh","textAlign":"center","display":"flex","flexDirection":"column","alignItems":"center","justifyContent":"center"},"children":["$","div",null,{"children":[["$","style",null,{"dangerouslySetInnerHTML":{"__html":"body{color:#000;background:#fff;margin:0}.next-error-h1{border-right:1px solid rgba(0,0,0,.3)}@media (prefers-color-scheme:dark){body{color:#fff;background:#000}.next-error-h1{border-right:1px solid rgba(255,255,255,.3)}}"}}],["$","h1",null,{"className":"next-error-h1","style":{"display":"inline-block","margin":"0 20px 0 0","padding":"0 23px 0 0","fontSize":24,"fontWeight":500,"verticalAlign":"top","lineHeight":"49px"},"children":"404"}],["$","div",null,{"style":{"display":"inline-block"},"children":["$","h2",null,{"style":{"fontSize":14,"fontWeight":400,"lineHeight":"49px","margin":0},"children":"This page could not be found."}]}]]}]}]],"notFoundStyles":[]}]}]}]]}]]}]}]}]}]],null],null],["$La",null]]]]
a:[["$","meta","0",{"name":"viewport","content":"width=device-width, initial-scale=1"}],["$","meta","1",{"charSet":"utf-8"}],["$","title","2",{"children":"AIOX Course Platform | Professional Bootcamp & Mastery"}],["$","meta","3",{"name":"description","content":"Learn AIOX - AI-Orchestrated System for Full Stack Development. Complete bootcamp and mastery courses with hands-on projects."}],["$","meta","4",{"name":"keywords","content":"AIOX,AI Development,Full Stack,Course,Bootcamp,Learning"}]]
1:null
