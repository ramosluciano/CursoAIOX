2:I[4817,["972","static/chunks/972-435ad046c10f8479.js","552","static/chunks/552-ca913c8f5aa11d94.js","460","static/chunks/app/mastery/%5Blesson%5D/page-19f8ee117e5859d3.js"],"LessonRenderer"]
4:I[4707,[],""]
6:I[6423,[],""]
7:I[872,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"ThemeProvider"]
8:I[3021,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Sidebar"]
9:I[8680,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Header"]
3:T1ce2,# Aula 10 — Infraestrutura SaaS + Lab Provisioner Design

<!-- metadata
course: Mastery
module: 3
lesson: 10
title: "Infraestrutura SaaS + Lab Provisioner Design"
duration: 4-5 horas
agents: "@devops, @architect"
project: Plataforma Zabbix Learning
phase: Planejamento
prerequisites: Aula 09 concluída (PRD sharded + Architecture Doc)
-->

---

> **Módulo 3** · Plataforma Zabbix: Planejamento e Arquitetura
> **Duração**: 4-5 horas
> **Agentes praticados**: `@devops`, `@architect`
> **Projeto**: Plataforma Zabbix Learning

---

## 🏆 Vitória desta aula

Infraestrutura SaaS completa configurada: Docker Compose com 10+ serviços, DevContainer para desenvolvimento, design detalhado do Lab Provisioner com a opção escolhida, e CI/CD pipeline para build matrix.

**Critério binário**: `docker compose up -d` sobe 10+ serviços saudáveis + design do Lab Provisioner documentado com diagramas + CI/CD definido.

---

## Conceito

### Infraestrutura de SaaS: orquestração de 10+ serviços

No Bootcamp, Docker Compose tinha 5 serviços (RockQuiz) ou 4 (AuctionHunter). A Plataforma Zabbix tem **10+**, com dependências entre si, health checks cruzados e ordem de inicialização. O Docker Compose vira um documento de orquestração — não apenas uma lista de containers.

### Lab Provisioner Design: a decisão mais técnica do programa

A Aula 09 avaliou 3 opções. Agora o DevOps implementa a escolhida com design detalhado: como provisionar, como configurar, como limitar recursos, como fazer cleanup, como escalar. Este design vai ser implementado de verdade no Módulo 4.

---

## Prática

### Passo 1 — DevContainer para desenvolvimento

```bash
cd ~/aiox-mastery/zabbix-platform
claude
```

```
@devops

Dex-Ops, configure o ambiente de desenvolvimento da 
Plataforma Zabbix.

DevContainer com os serviços essenciais para dev:
- API (hot reload)
- PostgreSQL (banco principal)
- Redis (cache + queues)
- Vector store (para RAG do Content Engine)
- MinIO (assets)
- Mailhog ou similar (emails de teste)

Não precisa incluir Prometheus/Grafana no DevContainer — 
só no Compose de produção.

Cada serviço precisa de health check. A API só deve 
aceitar requests quando banco e Redis estiverem ready.
```

> **Checklist do DevContainer**
> - [ ] 6 serviços de desenvolvimento configurados?
> - [ ] Health checks em todos os serviços?
> - [ ] API espera dependências antes de aceitar requests?
> - [ ] Hot reload funciona para desenvolvimento?
> - [ ] Volumes persistem dados entre restarts?

> **🏆 Checkpoint 1**: DevContainer funcional.

---

### Passo 2 — Docker Compose produção (10+ serviços)

```
Dex-Ops, agora configure o Docker Compose de produção 
completo. Consulte o Architecture Doc (docs/architecture.md).

Serviços:
1. web — Next.js frontend
2. api — Backend principal
3. content-worker — RAG processing (pode ser pesado)
4. lab-provisioner — Gestão de labs efêmeros
5. quiz-engine — Lógica de quiz (se separado da API)
6. postgres — Banco principal
7. redis — Cache + sessions + task queues
8. minio — Object storage (assets, PDFs)
9. vector-db — Vector store para embeddings RAG
10. prometheus — Métricas
11. grafana — Dashboards

Requisitos:
- Multi-stage builds para imagens leves
- Rede interna isolada (serviços não expostos ao público 
  exceto web e api)
- Resource limits em produção (CPU, RAM por serviço)
- Secrets management (não hardcoded)
- Logging centralizado
```

**Como verificar**:

```bash
docker compose -f docker-compose.prod.yml config  # validar
docker compose -f docker-compose.prod.yml up -d
docker compose -f docker-compose.prod.yml ps       # 10+ running
```

> **Checklist do Compose produção**
> - [ ] 10+ serviços definidos e iniciando?
> - [ ] Multi-stage builds em todos os Dockerfiles custom?
> - [ ] Rede interna isolada?
> - [ ] Resource limits configurados?
> - [ ] Secrets não estão hardcoded?
> - [ ] Todos os health checks passam?

> **🏆 Checkpoint 2**: 10+ serviços rodando em produção.

---

### Passo 3 — Design detalhado do Lab Provisioner

```
Dex-Ops, baseado na decisão do Architecture Doc, faça 
o design detalhado do Lab Provisioner.

Documente em docs/lab-provisioner-design.md:

1. LIFECYCLE de um lab:
   - Request → Validate → Provision → Configure → 
     Health Check → Ready → In Use → Expiring → 
     Cleanup → Destroyed

2. CONFIGURAÇÃO POR EXERCÍCIO:
   - Como definir: quais hosts, templates, triggers 
     pré-configurar em cada lab?
   - Formato do "exercise manifest" (YAML/JSON)
   - Como carregar configuração após Zabbix iniciar

3. RESOURCE MANAGEMENT:
   - Limites por lab (CPU, RAM, disco)
   - Máximo de labs simultâneos
   - Queue de espera quando no limite
   - Preemption (destruir labs inativos se necessário?)

4. NETWORKING:
   - Isolamento entre labs
   - Exposição da porta web (dynamic port allocation)
   - Acesso via iframe na plataforma

5. CLEANUP:
   - TTL enforcement
   - Grace period antes de destruição
   - Force cleanup de orphans
   - Dados destruídos (sem persistência entre labs)

6. DIAGRAMA:
   - Fluxo completo do lifecycle
   - Diagrama de rede (isolamento)
```

> **Checklist do design**
> - [ ] Lifecycle completo documentado (9 estados)?
> - [ ] Exercise manifest format definido?
> - [ ] Resource limits com números concretos?
> - [ ] Isolamento de rede entre labs?
> - [ ] Cleanup com TTL + orphan detection?
> - [ ] Diagrama de fluxo presente?

> **🏆 Checkpoint 3**: Design do Lab Provisioner detalhado.

---

### Passo 4 — CI/CD para SaaS

```
Dex-Ops, configure o CI/CD para a Plataforma Zabbix.

Build matrix: 10+ serviços significam que o CI precisa 
ser inteligente — não rebuildar tudo a cada push.

Requisitos:
- Build apenas dos serviços alterados (change detection)
- Testes por serviço (não monolítico)
- Build de imagens Docker no CI
- Staging environment para preview
- Deploy com zero-downtime (rolling update)

Documente em docs/devops/ci-cd-strategy.md
```

> **🏆 Checkpoint 4 — VITÓRIA DA AULA**: Infra completa + Lab design + CI/CD strategy.

---

### Passo 5 — Commit

```bash
*exit
git add .
git commit -m "infra: SaaS infrastructure, Lab Provisioner design, CI/CD strategy

- DevContainer with 6 dev services
- Production Docker Compose with 10+ services
- Lab Provisioner detailed design (lifecycle, networking, cleanup)
- Exercise manifest format defined
- CI/CD strategy with build matrix and change detection"
```

---

## Reflexão

### O conceito-chave

> **Infraestrutura de SaaS com 10+ serviços exige orquestração, não apenas configuração. Cada serviço tem lifecycle, dependências e resource requirements próprios. O Lab Provisioner é um serviço que gerencia outros containers — meta-infraestrutura que exige design dedicado. CI/CD inteligente (change detection, build matrix) é obrigatório quando rebuildar tudo a cada push levaria 30+ minutos.**

### Conexão com o Módulo 4

O Módulo 3 planejou. O Módulo 4 (Aulas 11-14) implementa: Auth + multi-tenant, Content Engine com RAG, Quiz Engine gamificado, e Ferramentas Interativas + Lab Provisioner real.

---

> **Anterior**: [Aula 09 — PM + Architect: PRD e Arquitetura de SaaS](./aula-09-prd-architecture.md)
> **Próxima**: [Aula 11 — Auth, Multi-Tenant e Billing](../modulo-04/aula-11-auth-billing.md) *(Módulo 4)*
5:["lesson","mastery-aula-10-infra-saas","d"]
0:["0aCmzVh17xjX8k-qFi6hn",[[["",{"children":["mastery",{"children":[["lesson","mastery-aula-10-infra-saas","d"],{"children":["__PAGE__?{\"lesson\":\"mastery-aula-10-infra-saas\"}",{}]}]}]},"$undefined","$undefined",true],["",{"children":["mastery",{"children":[["lesson","mastery-aula-10-infra-saas","d"],{"children":["__PAGE__",{},[["$L1",["$","$L2",null,{"content":"$3","lessonSlug":"mastery-aula-10-infra-saas","module":"mastery","lessonIndex":9,"totalLessons":22,"nextLesson":"mastery-aula-11-auth-billing","prevLesson":"mastery-aula-09-prd-architecture"}],null],null],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","mastery","children","$5","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","mastery","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[[[["$","link","0",{"rel":"stylesheet","href":"/_next/static/css/71d217bb04404cb9.css","precedence":"next","crossOrigin":"$undefined"}]],["$","html",null,{"lang":"pt-BR","children":["$","body",null,{"className":"bg-white dark:bg-slate-900 text-gray-900 dark:text-gray-100 transition-colors","children":["$","$L7",null,{"children":["$","div",null,{"className":"flex h-screen overflow-hidden","children":[["$","$L8",null,{}],["$","div",null,{"className":"flex-1 flex flex-col overflow-hidden","children":[["$","$L9",null,{}],["$","main",null,{"className":"flex-1 overflow-y-auto bg-white dark:bg-slate-900 transition-colors","children":["$","div",null,{"className":"max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8","children":["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":[["$","title",null,{"children":"404: This page could not be found."}],["$","div",null,{"style":{"fontFamily":"system-ui,\"Segoe UI\",Roboto,Helvetica,Arial,sans-serif,\"Apple Color Emoji\",\"Segoe UI Emoji\"","height":"100vh","textAlign":"center","display":"flex","flexDirection":"column","alignItems":"center","justifyContent":"center"},"children":["$","div",null,{"children":[["$","style",null,{"dangerouslySetInnerHTML":{"__html":"body{color:#000;background:#fff;margin:0}.next-error-h1{border-right:1px solid rgba(0,0,0,.3)}@media (prefers-color-scheme:dark){body{color:#fff;background:#000}.next-error-h1{border-right:1px solid rgba(255,255,255,.3)}}"}}],["$","h1",null,{"className":"next-error-h1","style":{"display":"inline-block","margin":"0 20px 0 0","padding":"0 23px 0 0","fontSize":24,"fontWeight":500,"verticalAlign":"top","lineHeight":"49px"},"children":"404"}],["$","div",null,{"style":{"display":"inline-block"},"children":["$","h2",null,{"style":{"fontSize":14,"fontWeight":400,"lineHeight":"49px","margin":0},"children":"This page could not be found."}]}]]}]}]],"notFoundStyles":[]}]}]}]]}]]}]}]}]}]],null],null],["$La",null]]]]
a:[["$","meta","0",{"name":"viewport","content":"width=device-width, initial-scale=1"}],["$","meta","1",{"charSet":"utf-8"}],["$","title","2",{"children":"AIOX Course Platform | Professional Bootcamp & Mastery"}],["$","meta","3",{"name":"description","content":"Learn AIOX - AI-Orchestrated System for Full Stack Development. Complete bootcamp and mastery courses with hands-on projects."}],["$","meta","4",{"name":"keywords","content":"AIOX,AI Development,Full Stack,Course,Bootcamp,Learning"}]]
1:null
