# Aula 10 — Infraestrutura SaaS + Lab Provisioner Design

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
> - <input type="checkbox" class="checkbox-input" /> 6 serviços de desenvolvimento configurados?
> - <input type="checkbox" class="checkbox-input" /> Health checks em todos os serviços?
> - <input type="checkbox" class="checkbox-input" /> API espera dependências antes de aceitar requests?
> - <input type="checkbox" class="checkbox-input" /> Hot reload funciona para desenvolvimento?
> - <input type="checkbox" class="checkbox-input" /> Volumes persistem dados entre restarts?

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
> - <input type="checkbox" class="checkbox-input" /> 10+ serviços definidos e iniciando?
> - <input type="checkbox" class="checkbox-input" /> Multi-stage builds em todos os Dockerfiles custom?
> - <input type="checkbox" class="checkbox-input" /> Rede interna isolada?
> - <input type="checkbox" class="checkbox-input" /> Resource limits configurados?
> - <input type="checkbox" class="checkbox-input" /> Secrets não estão hardcoded?
> - <input type="checkbox" class="checkbox-input" /> Todos os health checks passam?

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
> - <input type="checkbox" class="checkbox-input" /> Lifecycle completo documentado (9 estados)?
> - <input type="checkbox" class="checkbox-input" /> Exercise manifest format definido?
> - <input type="checkbox" class="checkbox-input" /> Resource limits com números concretos?
> - <input type="checkbox" class="checkbox-input" /> Isolamento de rede entre labs?
> - <input type="checkbox" class="checkbox-input" /> Cleanup com TTL + orphan detection?
> - <input type="checkbox" class="checkbox-input" /> Diagrama de fluxo presente?

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

> **Anterior**: Aula 09 — PM + Architect: PRD e Arquitetura de SaaS
> **Próxima**: Aula 11 — Auth, Multi-Tenant e Billing *(Módulo 4)*
