# Aula 11 — Auth, Multi-Tenant e Billing

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
> - <input type="checkbox" class="checkbox-input" /> Registro cria usuário no banco?
> - <input type="checkbox" class="checkbox-input" /> Login retorna JWT válido?
> - <input type="checkbox" class="checkbox-input" /> JWT contém role e plan do usuário?
> - <input type="checkbox" class="checkbox-input" /> Rotas protegidas bloqueiam acesso sem token?
> - <input type="checkbox" class="checkbox-input" /> Token expirado é rejeitado?
> - <input type="checkbox" class="checkbox-input" /> OAuth providers estão configurados?

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
> - <input type="checkbox" class="checkbox-input" /> Middleware verifica role antes de executar handler?
> - <input type="checkbox" class="checkbox-input" /> Student não acessa /api/admin/* (retorna 403)?
> - <input type="checkbox" class="checkbox-input" /> Admin acessa tudo?
> - <input type="checkbox" class="checkbox-input" /> Verificação é no backend (não só UI)?

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
> - <input type="checkbox" class="checkbox-input" /> Tenant A não vê dados de Tenant B?
> - <input type="checkbox" class="checkbox-input" /> ORM middleware aplica filtro automaticamente?
> - <input type="checkbox" class="checkbox-input" /> Constraint NOT NULL impede entidades sem tenant?

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
> - <input type="checkbox" class="checkbox-input" /> Free não acessa labs?
> - <input type="checkbox" class="checkbox-input" /> Pro acessa labs com limite (3/dia)?
> - <input type="checkbox" class="checkbox-input" /> Premium acessa tudo sem limite?
> - <input type="checkbox" class="checkbox-input" /> Mensagem de upgrade é clara?
> - <input type="checkbox" class="checkbox-input" /> Gating é no backend (não só UI)?

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

> **Anterior**: Aula 10 — Infraestrutura SaaS
> **Próxima**: Aula 12 — Content Engine com RAG
