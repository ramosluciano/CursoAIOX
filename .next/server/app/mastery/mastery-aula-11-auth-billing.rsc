2:I[4817,["972","static/chunks/972-435ad046c10f8479.js","552","static/chunks/552-ca913c8f5aa11d94.js","460","static/chunks/app/mastery/%5Blesson%5D/page-19f8ee117e5859d3.js"],"LessonRenderer"]
4:I[4707,[],""]
6:I[6423,[],""]
7:I[872,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"ThemeProvider"]
8:I[3021,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Sidebar"]
9:I[8680,["972","static/chunks/972-435ad046c10f8479.js","185","static/chunks/app/layout-54d86b5a841a3f04.js"],"Header"]
3:T2203,# Aula 11 — Auth, Multi-Tenant e Billing

<!-- metadata
course: Mastery
module: 4
lesson: 11
title: "Auth, Multi-Tenant e Billing"
duration: 4-5 horas
agents: "@dev, @qa"
project: Plataforma Zabbix Learning
phase: Desenvolvimento Core
prerequisites: Aula 10 concluída (infra SaaS configurada)
-->

---

> **Módulo 4** · Plataforma Zabbix: Desenvolvimento Core
> **Duração**: 4-5 horas
> **Agentes praticados**: `@dev`, `@qa`
> **Projeto**: Plataforma Zabbix Learning

---

## 🏆 Vitória desta aula

Auth completo com OAuth providers, multi-tenancy com isolamento de dados, RBAC (admin/instructor/student), e 3 planos de acesso com feature gating funcionando.

**Critério binário**: Login funciona → usuário tem role e plano → features são gatadas por plano → dados isolados por tenant.

---

## Conceito

### Auth + Multi-tenancy: a fundação de um SaaS

Auth e multi-tenancy são a fundação sobre a qual todo o resto se constrói. Se o isolamento de dados falhar, um aluno vê dados de outro. Se o feature gating falhar, acesso free tem features premium. Se o RBAC falhar, aluno pode alterar conteúdo.

No Bootcamp, nenhum projeto tinha auth real. Aqui, auth é o primeiro subsistema implementado porque todos os outros dependem dele: Content Engine precisa saber o plano do aluno (free vs premium), Quiz Engine precisa do perfil do aluno, Lab Provisioner precisa limitar labs por plano.

A complexidade não está no login em si — está nas **implicações downstream**:

| Decisão de auth | Impacto nos subsistemas |
|-----------------|------------------------|
| Plano do aluno | Content Engine: quais aulas acessíveis. Lab Provisioner: quantos labs/dia |
| Role do usuário | Admin: gerencia tudo. Instructor: cria conteúdo. Student: consome |
| Tenant isolation | Cada organização vê apenas seus dados em TODAS as queries |
| Session management | JWT precisa ser válido em todos os microsserviços |

---

## Contexto

A infraestrutura SaaS está pronta (Aula 10): Docker Compose com 10+ serviços, DevContainer funcional, CI/CD planejado. Agora o @dev implementa o primeiro subsistema real. Auth é a fundação — Aulas 12-14 dependem dele para feature gating, isolamento e personalização.

---

## Prática

### Passo 1 — Auth com NextAuth.js

```bash
cd ~/aiox-mastery/zabbix-platform
claude
```

```
@dev

Dex, leia docs/prd/prd-auth-billing.md e docs/architecture.md.

Implemente o sistema de autenticação usando os 13 steps do ADE.

Requisitos:
1. NextAuth.js com 3 providers:
   - Credentials (email + password)
   - GitHub OAuth
   - Google OAuth
2. JWT sessions com refresh token rotation
3. Middleware de proteção de rotas
4. Tabela de usuários com: email, name, role, plan, 
   tenant_id, created_at, last_login

Comece pelos steps 1-3: analise a spec, decomponha 
em subtasks e me mostre o plano.
```

**Como verificar**:

```bash
# Testar registro
curl -X POST http://localhost:3000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"SecurePass123","name":"Test User"}' | jq

# Testar login
curl -X POST http://localhost:3000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"SecurePass123"}' | jq

# Usar token para rota protegida
TOKEN=$(curl -s -X POST http://localhost:3000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"SecurePass123"}' | jq -r '.token')

curl -H "Authorization: Bearer $TOKEN" http://localhost:3000/api/me | jq
```

> **Checklist de avaliação do auth**
> - [ ] Registro cria usuário no banco?
> - [ ] Login retorna JWT válido?
> - [ ] JWT contém role e plan do usuário?
> - [ ] Rotas protegidas bloqueiam acesso sem token?
> - [ ] Token expirado é rejeitado?
> - [ ] OAuth providers estão configurados?

> **🏆 Checkpoint 1**: Auth funcional com 3 providers.

---

### Passo 2 — RBAC: roles e permissões

```
Dex, implemente RBAC com 3 roles:

1. ADMIN: gerencia tenants, conteúdo, planos, analytics
2. INSTRUCTOR: cria/edita conteúdo, vê analytics próprio
3. STUDENT: acessa conteúdo conforme plano, faz quizzes, usa labs

Middleware que verifica role em cada rota:
- /api/admin/* → requer ADMIN
- /api/instructor/* → requer ADMIN ou INSTRUCTOR
- /api/content/* → requer autenticação (qualquer role)
- /api/public/* → sem autenticação

CRÍTICO: RBAC deve ser enforced no BACKEND, não 
apenas na UI. Esconder um botão no frontend não é 
segurança — qualquer pessoa com curl acessa o endpoint.
```

> **Checklist de avaliação do RBAC**
> - [ ] Middleware verifica role antes de executar handler?
> - [ ] Student não acessa /api/admin/* (retorna 403)?
> - [ ] Admin acessa tudo?
> - [ ] Verificação é no backend (não só UI)?

Se o RBAC estiver só no frontend:

```
Dex, o RBAC está apenas escondendo elementos na UI. 
Testei com curl e o endpoint /api/admin/users retorna 
dados mesmo com token de student. O middleware de 
verificação de role deve bloquear no backend ANTES 
de executar qualquer lógica.
```

> **🏆 Checkpoint 2**: RBAC enforced no backend.

---

### Passo 3 — Multi-tenancy e isolamento

```
Dex, implemente multi-tenancy com isolamento de dados.

Modelo: row-level isolation (conforme Architecture Doc)
- Cada entidade no banco tem tenant_id
- Toda query filtra por tenant_id automaticamente
- Middleware injeta tenant_id no request context 
  baseado no usuário logado
- Hook no ORM que adiciona WHERE tenant_id = X em 
  toda query automaticamente

CRÍTICO: É IMPOSSÍVEL para um request de tenant A 
retornar dados de tenant B. Mesmo que um bug no 
código esqueça o filtro, o ORM middleware garante.
```

**Teste de isolamento**:

```bash
# Criar 2 tenants, login em cada, criar recurso em A, 
# verificar que B não vê
# [comandos de teste com curl como na versão anterior]
```

> **Checklist de isolamento**
> - [ ] Tenant A não vê dados de Tenant B?
> - [ ] ORM middleware aplica filtro automaticamente?
> - [ ] Constraint NOT NULL impede entidades sem tenant?

> **🏆 Checkpoint 3**: Isolamento verificado entre tenants.

---

### Passo 4 — Planos e feature gating

```
Dex, implemente os 3 planos de acesso com feature gating:

FREE: conteúdo básico, quiz limitado (5/dia), sem labs
PRO: todo conteúdo, quiz ilimitado, 3 labs/dia
PREMIUM: tudo + labs ilimitados + certificação

Implementação:
1. Tabela plans com features e limites
2. Middleware que verifica plano antes de features
3. Resposta clara quando limite atingido 
   ("Upgrade para Pro para acessar labs")
```

> **Checklist de feature gating**
> - [ ] Free não acessa labs?
> - [ ] Pro acessa labs com limite (3/dia)?
> - [ ] Premium acessa tudo sem limite?
> - [ ] Mensagem de upgrade é clara?
> - [ ] Gating é no backend (não só UI)?

> **🏆 Checkpoint 4**: Feature gating funcional por plano.

---

### Passo 5 — QA review de segurança

```
*exit

@qa

Quinn, review de auth, RBAC, multi-tenancy e billing.
Este review é CRÍTICO — falhas aqui são vulnerabilidades.

Foco:
- É possível acessar dados de outro tenant (IDOR)?
- JWT pode ser forjado? Secret está seguro?
- Password hasheado com bcrypt/argon2 (não MD5/SHA)?
- Rate limiting em login (brute force protection)?
- RBAC enforced no backend?
- Feature gating no backend?
- Refresh token rotation funciona?

*review-build
```

Ciclo de correções até QA aprovar.

> **🏆 Checkpoint 5 — VITÓRIA DA AULA**: Auth completo + QA segurança aprovado.

---

### Passo 6 — Commit

```bash
*exit
git add .
git commit -m "feat: auth, RBAC, multi-tenancy, and billing with 3 plans

- NextAuth.js with credentials + GitHub + Google OAuth
- JWT sessions with refresh token rotation
- RBAC enforced at backend level (admin/instructor/student)
- Multi-tenant row-level isolation with ORM middleware
- 3 plans (Free/Pro/Premium) with feature gating
- QA security review approved"
```

---

## Reflexão

### O conceito-chave

> **Auth e multi-tenancy são a fundação invisível de um SaaS. Implementar primeiro — antes de qualquer feature — garante que cada subsistema nascido depois já tem isolamento, controle de acesso e consciência de planos. É a decisão arquitetural que previne refatoração massiva no futuro.**

### Conexão com a próxima aula

Na Aula 12, o Content Engine usa auth de duas formas: o plano do aluno determina quais conteúdos são acessíveis (feature gating), e o tenant_id isola conteúdo entre organizações.

---

> **Anterior**: [Aula 10 — Infraestrutura SaaS](../modulo-03/aula-10-infra-saas.md)
> **Próxima**: [Aula 12 — Content Engine com RAG](./aula-12-content-engine.md)
5:["lesson","mastery-aula-11-auth-billing","d"]
0:["0aCmzVh17xjX8k-qFi6hn",[[["",{"children":["mastery",{"children":[["lesson","mastery-aula-11-auth-billing","d"],{"children":["__PAGE__?{\"lesson\":\"mastery-aula-11-auth-billing\"}",{}]}]}]},"$undefined","$undefined",true],["",{"children":["mastery",{"children":[["lesson","mastery-aula-11-auth-billing","d"],{"children":["__PAGE__",{},[["$L1",["$","$L2",null,{"content":"$3","lessonSlug":"mastery-aula-11-auth-billing","module":"mastery","lessonIndex":10,"totalLessons":22,"nextLesson":"mastery-aula-12-content-engine","prevLesson":"mastery-aula-10-infra-saas"}],null],null],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","mastery","children","$5","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[null,["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children","mastery","children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":"$undefined","notFoundStyles":"$undefined"}]],null]},[[[["$","link","0",{"rel":"stylesheet","href":"/_next/static/css/71d217bb04404cb9.css","precedence":"next","crossOrigin":"$undefined"}]],["$","html",null,{"lang":"pt-BR","children":["$","body",null,{"className":"bg-white dark:bg-slate-900 text-gray-900 dark:text-gray-100 transition-colors","children":["$","$L7",null,{"children":["$","div",null,{"className":"flex h-screen overflow-hidden","children":[["$","$L8",null,{}],["$","div",null,{"className":"flex-1 flex flex-col overflow-hidden","children":[["$","$L9",null,{}],["$","main",null,{"className":"flex-1 overflow-y-auto bg-white dark:bg-slate-900 transition-colors","children":["$","div",null,{"className":"max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8","children":["$","$L4",null,{"parallelRouterKey":"children","segmentPath":["children"],"error":"$undefined","errorStyles":"$undefined","errorScripts":"$undefined","template":["$","$L6",null,{}],"templateStyles":"$undefined","templateScripts":"$undefined","notFound":[["$","title",null,{"children":"404: This page could not be found."}],["$","div",null,{"style":{"fontFamily":"system-ui,\"Segoe UI\",Roboto,Helvetica,Arial,sans-serif,\"Apple Color Emoji\",\"Segoe UI Emoji\"","height":"100vh","textAlign":"center","display":"flex","flexDirection":"column","alignItems":"center","justifyContent":"center"},"children":["$","div",null,{"children":[["$","style",null,{"dangerouslySetInnerHTML":{"__html":"body{color:#000;background:#fff;margin:0}.next-error-h1{border-right:1px solid rgba(0,0,0,.3)}@media (prefers-color-scheme:dark){body{color:#fff;background:#000}.next-error-h1{border-right:1px solid rgba(255,255,255,.3)}}"}}],["$","h1",null,{"className":"next-error-h1","style":{"display":"inline-block","margin":"0 20px 0 0","padding":"0 23px 0 0","fontSize":24,"fontWeight":500,"verticalAlign":"top","lineHeight":"49px"},"children":"404"}],["$","div",null,{"style":{"display":"inline-block"},"children":["$","h2",null,{"style":{"fontSize":14,"fontWeight":400,"lineHeight":"49px","margin":0},"children":"This page could not be found."}]}]]}]}]],"notFoundStyles":[]}]}]}]]}]]}]}]}]}]],null],null],["$La",null]]]]
a:[["$","meta","0",{"name":"viewport","content":"width=device-width, initial-scale=1"}],["$","meta","1",{"charSet":"utf-8"}],["$","title","2",{"children":"AIOX Course Platform | Professional Bootcamp & Mastery"}],["$","meta","3",{"name":"description","content":"Learn AIOX - AI-Orchestrated System for Full Stack Development. Complete bootcamp and mastery courses with hands-on projects."}],["$","meta","4",{"name":"keywords","content":"AIOX,AI Development,Full Stack,Course,Bootcamp,Learning"}]]
1:null
