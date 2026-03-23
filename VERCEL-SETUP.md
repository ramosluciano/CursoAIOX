# 🚀 Configuração do Vercel + GitHub Actions

Guia passo a passo para configurar deploy automático no Vercel.

---

## 📋 Pré-requisitos

- ✅ Conta Vercel criada: https://vercel.com
- ✅ Projeto importado no Vercel
- ✅ Repositório GitHub: https://github.com/monitoragindo/CursoAIOX

---

## 🔧 Passo 1: Criar Projeto no Vercel

### 1.1 Importar repositório
1. Vá para: https://vercel.com/new
2. Clique em "Import Git Repository"
3. Selecione `monitoragindo/CursoAIOX`
4. Clique em "Import"

### 1.2 Configurar projeto
- **Project Name**: `CursoAIOX` (ou `curso-aiox`)
- **Framework**: Next.js (detectado automaticamente)
- **Root Directory**: `.` (raiz do projeto)
- **Build Command**: `npm run build`
- **Output Directory**: `.next`

### 1.3 Variáveis de Ambiente
Deixe em branco por enquanto (configuraremos via GitHub Actions)

---

## 🔑 Passo 2: Gerar Tokens do Vercel

### 2.1 Access Token
1. Vá para: https://vercel.com/account/tokens
2. Clique em "Create Token"
3. **Name**: `GitHub-Actions-AIOX`
4. **Scope**: Select "Full Access"
5. **Expiration**: Nunca (deixe em branco)
6. **Copy** o token gerado

### 2.2 Organization ID
1. Vá para: https://vercel.com/dashboard/settings
2. Procure por "Your Team ID" ou "Organization ID"
3. **Copy** o ID (ex: `team_abc123xyz...`)

### 2.3 Project ID
1. Vá para: https://vercel.com/dashboard
2. Selecione o projeto `CursoAIOX`
3. Vá para "Settings → General"
4. Procure por "Project ID"
5. **Copy** o ID (ex: `prj_abc123xyz...`)

---

## 🔐 Passo 3: Adicionar Secrets no GitHub

### 3.1 Abrir Settings
1. Vá para: https://github.com/monitoragindo/CursoAIOX
2. Clique em **Settings** → **Secrets and variables** → **Actions**

### 3.2 Criar Secrets

Clique em **"New repository secret"** e adicione:

#### a) VERCEL_TOKEN
- **Name**: `VERCEL_TOKEN`
- **Value**: `dnp_...` (token gerado no passo 2.1)
- Clique em **"Add secret"**

#### b) VERCEL_ORG_ID
- **Name**: `VERCEL_ORG_ID`
- **Value**: Seu Organization ID (passo 2.2)
- Clique em **"Add secret"**

#### c) VERCEL_PROJECT_ID
- **Name**: `VERCEL_PROJECT_ID`
- **Value**: Seu Project ID (passo 2.3)
- Clique em **"Add secret"**

#### d) SLACK_WEBHOOK (Opcional)
- **Name**: `SLACK_WEBHOOK`
- **Value**: URL do webhook do Slack (se quiser notificações)
- Clique em **"Add secret"**

---

## ✅ Passo 4: Verificar Configuração

### 4.1 Testar Pipeline
1. Vá para: https://github.com/monitoragindo/CursoAIOX/actions
2. Clique em "CI/CD Pipeline" no menu esquerdo
3. Clique em "Run workflow" (botão à direita)
4. Selecione branch `dev` e clique em "Run workflow"

### 4.2 Monitorar Execução
- Veja o job rodar em tempo real
- Procure por "Deploy to Vercel" (vai ser skipped no dev)

### 4.3 Testar Deploy para Main
1. Crie um Pull Request: `dev` → `main`
2. Veja CI/CD rodar automaticamente
3. Merge quando todos os checks passarem
4. Deploy automático vai para Vercel!

---

## 📍 URL da Aplicação

Após o primeiro deploy:

```
https://curso-aiox.vercel.app
```

Ou verifique em: https://vercel.com/dashboard/CursoAIOX

---

## 🔒 Branch Protection Rules

Para garantir que CI/CD sempre roda antes de merge:

1. Vá para: **Settings → Branches**
2. Clique em **"Add rule"** sob "Branch protection rules"
3. **Branch name pattern**: `main`
4. Ative:
   - ✅ Require a pull request before merging
   - ✅ Require status checks to pass before merging
   - ✅ Require branches to be up to date before merging
   - ✅ Include administrators

---

## 🚨 Troubleshooting

### Deploy falha com "Unauthorized"
**Causa**: Token do Vercel inválido ou expirado
**Solução**:
1. Vá para https://vercel.com/account/tokens
2. Crie um novo token
3. Atualize `VERCEL_TOKEN` no GitHub

### Deploy falha com "Project not found"
**Causa**: `VERCEL_PROJECT_ID` está incorreto
**Solução**:
1. Verifique o Project ID em https://vercel.com/dashboard/CursoAIOX/settings/general
2. Atualize no GitHub Secrets

### Build falha localmente mas passa no CI
**Causa**: Diferença de versão de Node.js
**Solução**:
```bash
node --version  # Verificar versão local
nvm use 20     # Usar Node 20.x
npm run build
```

### Health check falha após deploy
**Causa**: Vercel ainda não finalizou deployment
**Solução**: CI vai tentar 5 vezes com 10s de intervalo
- Verifique logs em https://vercel.com/dashboard/CursoAIOX/logs

---

## 📊 Status do Deploy

Visualize status em tempo real:

### GitHub Actions
https://github.com/monitoragindo/CursoAIOX/actions

### Vercel Deployments
https://vercel.com/dashboard/CursoAIOX/deployments

### Aplicação em Produção
https://curso-aiox.vercel.app

---

## 🔄 Fluxo de Desenvolvimento

1. **Criar feature branch**
   ```bash
   git checkout -b feature/minha-feature
   ```

2. **Fazer mudanças**
   ```bash
   npm run dev
   # ... fazer alterações ...
   ```

3. **Commit e Push**
   ```bash
   git add .
   git commit -m "feat: descrição"
   git push -u origin feature/minha-feature
   ```

4. **Abrir Pull Request**
   - GitHub detecta mudanças
   - CI/CD roda automaticamente

5. **Review e Merge**
   - CI deve estar ✅ PASSING
   - Merge para `dev` (staging)
   - Merge para `main` (produção)
   - Deploy automático! 🚀

---

## 📞 Suporte

Dúvidas?
- Docs Vercel: https://vercel.com/docs
- GitHub Actions: https://docs.github.com/en/actions
- Contato: suporte@monitoragindo.com

---

**Mantido por**: Monitoragindo Soluções Inteligentes
**Última atualização**: 2026-03-23
