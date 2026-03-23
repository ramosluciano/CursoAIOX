# 🚀 CI/CD Pipeline - AIOX Course Platform

## Visão Geral

Este projeto utiliza **GitHub Actions** para automação de CI/CD e **Vercel** para deploy automático.

---

## 📋 Fluxo de CI/CD

```
Developer Push
     ↓
┌────────────────┐
│  Lint & Format │ (ESLint, Prettier check)
└────────────────┘
     ↓
┌────────────────┐
│ Build & Test   │ (npm run build)
└────────────────┘
     ↓
┌────────────────┐
│ Docker Build   │ (Multi-stage build)
└────────────────┘
     ↓
┌────────────────────────┐
│ Deploy to Vercel       │ (Only on main branch)
│ (Production)           │
└────────────────────────┘
     ↓
┌────────────────────────┐
│ Health Check           │ (HTTP 200 verification)
│ Slack Notification     │
└────────────────────────┘
```

---

## 🔑 Variáveis de Ambiente Necessárias

Configure estas secrets no GitHub Actions:

### 1. **VERCEL_TOKEN**
- O token de autenticação do Vercel
- Crie em: https://vercel.com/account/tokens
- Permissões: Full Access

### 2. **VERCEL_ORG_ID**
- ID da organização no Vercel
- Encontre em: https://vercel.com/dashboard/settings/[your-org]/general

### 3. **VERCEL_PROJECT_ID**
- ID do projeto no Vercel
- Encontre em: https://vercel.com/dashboard/[project-name]/settings/general

### 4. **SLACK_WEBHOOK** (Opcional)
- Webhook URL do Slack para notificações
- Crie em: https://api.slack.com/messaging/webhooks

### 5. **NEXT_PUBLIC_APP_URL**
- URL pública da aplicação
- Padrão: `https://curso-aiox.vercel.app`

---

## 📐 Configurar Secrets no GitHub

1. Vá para: `Settings → Secrets and variables → Actions`
2. Clique em "New repository secret"
3. Adicione cada variável acima

---

## 🌿 Branches e Fluxo de Trabalho

### **Main Branch** (`main`)
- ✅ Produção
- ✅ Deploy automático no Vercel
- 🔒 Protegida: Requer Pull Request + CI passing

### **Dev Branch** (`dev`)
- 🛠️ Desenvolvimento
- 🧪 CI/CD roda (sem deploy)
- 📝 Base para features

### **Feature Branches** (`feature/xyz`)
- 📋 Branches temporárias
- ✂️ Deletadas após merge
- Nomenclatura: `feature/`, `fix/`, `hotfix/`

---

## 💻 Workflow Local

### 1. Clonar o repositório
```bash
git clone https://github.com/monitoragindo/CursoAIOX.git
cd CursoAIOX
```

### 2. Criar feature branch
```bash
git checkout -b feature/nova-feature
```

### 3. Fazer alterações
```bash
npm install
npm run dev
```

### 4. Commit e Push
```bash
git add .
git commit -m "feat: descrição da feature"
git push -u origin feature/nova-feature
```

### 5. Abrir Pull Request
- Vá para GitHub
- Clique em "Compare & pull request"
- Merge quando CI passar ✅

---

## ✅ GitHub Actions Jobs

### 1️⃣ **Lint & Format Check**
- Roda ESLint
- Valida formatação de código

### 2️⃣ **Build & Test**
- Instala dependências
- Executa `npm run build`
- Verifica se `.next` foi gerado

### 3️⃣ **Docker Build**
- Constrói imagem Docker multi-stage
- Cache via GitHub Actions

### 4️⃣ **Deploy to Vercel**
- Só roda no branch `main`
- Deploy automático em produção
- Comenta URL na PR

### 5️⃣ **Test Deployment**
- Verifica health check (HTTP 200)
- Tenta 5 vezes com 10s de intervalo

### 6️⃣ **Slack Notification**
- Notifica status do deploy
- Links para GitHub Actions e aplicação

---

## 🔒 Proteções de Branch

### Main Branch Rules
```
- Require pull request reviews before merging
- Require status checks to pass before merging
  - lint (must pass)
  - build (must pass)
  - docker (must pass)
- Require branches to be up to date before merging
- Include administrators
```

---

## 📊 Status Badge

Adicione ao README.md:

```markdown
[![CI/CD Pipeline](https://github.com/monitoragindo/CursoAIOX/actions/workflows/ci-cd.yml/badge.svg)](https://github.com/monitoragindo/CursoAIOX/actions)
```

---

## 🐛 Troubleshooting

### Build falha localmente
```bash
npm cache clean --force
rm -rf node_modules package-lock.json
npm install
npm run build
```

### Secrets não funcionam no GitHub Actions
1. Verifique se o secret está criado corretamente
2. Redeploy: Menu `Actions → All workflows → CI/CD Pipeline → Run workflow`

### Deploy no Vercel falha
1. Verifique `VERCEL_TOKEN` e `VERCEL_PROJECT_ID`
2. Logs: https://vercel.com/dashboard/[project]/logs

---

## 📚 Documentação

- [GitHub Actions](https://docs.github.com/en/actions)
- [Vercel Deployment](https://vercel.com/docs)
- [Next.js Build](https://nextjs.org/docs/deployment/vercel)

---

**Mantido por**: Monitoragindo Soluções Inteligentes
**Última atualização**: 2026-03-23
