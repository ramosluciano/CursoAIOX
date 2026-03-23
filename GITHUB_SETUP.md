# GitHub & Vercel Setup Guide

## 🎯 Overview

This guide walks you through pushing the AIOX Course Platform to GitHub and deploying it to Vercel with CI/CD automation.

**Timeline**: ~15-20 minutes for complete setup

---

## ✅ Prerequisites

Before starting, you need:

1. GitHub account (https://github.com)
2. Vercel account (https://vercel.com) - connect with GitHub
3. Vercel CLI installed (optional): `npm i -g vercel`
4. Git configured locally

---

## 📋 Step-by-Step Setup

### Step 1: Initialize Git & Create First Commit

```bash
cd /data/projects/CursoAIOX

# Initialize git repository
git init

# Configure git (if not already done)
git config user.name "Your Name"
git config user.email "your.email@example.com"

# Add all files
git add .

# Create initial commit
git commit -m "Initial commit: AIOX Course Platform v1.0

- Full-stack Next.js 14 course platform
- 40 lessons (18 Bootcamp + 22 Mastery)
- 6 projects showcase
- Progress tracking
- Responsive design
- Docker support"

# View commit log
git log --oneline
```

### Step 2: Create GitHub Repository

#### Option A: Using GitHub Web Interface

1. Go to https://github.com/new
2. **Repository name**: `aiox-course-platform`
3. **Description**: "Interactive learning platform for AIOX development courses"
4. **Visibility**: Public (or Private if preferred)
5. **Skip** "Initialize with README" (we have content already)
6. Click **"Create repository"**

#### Option B: Using GitHub CLI

```bash
# If you have gh CLI installed
gh repo create aiox-course-platform \
  --public \
  --source=. \
  --remote=origin \
  --push

# Skip the rest of steps 3-5
```

### Step 3: Connect Local to GitHub

```bash
# Add remote (replace YOUR_USERNAME)
git remote add origin https://github.com/YOUR_USERNAME/aiox-course-platform.git

# Verify remote
git remote -v

# Set main branch as default (if not already)
git branch -M main

# Push to GitHub
git push -u origin main

# Verify push succeeded
git log --oneline origin/main
```

**Expected output:**
```
✅ origin  https://github.com/YOUR_USERNAME/aiox-course-platform.git (fetch)
✅ origin  https://github.com/YOUR_USERNAME/aiox-course-platform.git (push)
```

### Step 4: Generate Vercel Token

1. Go to https://vercel.com/account/tokens
2. Click **"Create Token"**
3. **Token name**: `github-actions`
4. **Scope**: Select your account
5. Click **"Create"**
6. **Copy the token** (you won't see it again!)

### Step 5: Create GitHub Secrets

```bash
# Using GitHub CLI (recommended)
gh secret set VERCEL_TOKEN --body "paste_your_vercel_token_here"
gh secret set VERCEL_ORG_ID --body "your_vercel_org_id"
gh secret set VERCEL_PROJECT_ID --body "your_project_id"
gh secret set NEXT_PUBLIC_APP_URL --body "https://aiox-course.vercel.app"
```

**To find VERCEL_ORG_ID & VERCEL_PROJECT_ID:**

Option 1: After first Vercel deployment, check `.vercel/project.json`
```bash
cat .vercel/project.json
```

Option 2: Get from Vercel dashboard:
- Go to https://vercel.com/dashboard
- Select project
- Settings → General
- Copy "Project ID" and "Team ID"

### Step 6: Create Vercel Project

#### Option A: Automatic (Recommended)

1. Go to https://vercel.com/new
2. Search for your GitHub repository
3. Click **"Import"**
4. Vercel auto-detects Next.js
5. Click **"Deploy"**

Vercel creates the project automatically on first deployment!

#### Option B: Manual with Vercel CLI

```bash
# Make sure you're in the project directory
cd /data/projects/CursoAIOX

# Link to Vercel
vercel link --project aiox-course-platform

# Get the IDs
cat .vercel/project.json

# Deploy
vercel deploy --prod
```

### Step 7: Update GitHub Secrets (after Vercel setup)

Once Vercel project is created, get the IDs:

```bash
# From Vercel dashboard or .vercel/project.json
VERCEL_ORG_ID="your_org_id"
VERCEL_PROJECT_ID="your_project_id"

# Set secrets
gh secret set VERCEL_ORG_ID --body "$VERCEL_ORG_ID"
gh secret set VERCEL_PROJECT_ID --body "$VERCEL_PROJECT_ID"

# Verify secrets are set
gh secret list
```

---

## 🚀 Testing the Pipeline

### Manual Test

1. Make a small change to a file:
```bash
echo "# Updated" >> README.md
git add README.md
git commit -m "Update README"
git push origin main
```

2. Go to https://github.com/YOUR_USERNAME/aiox-course-platform/actions
3. Watch the workflow execute
4. Check Vercel deployment at https://vercel.com/dashboard

### Expected Workflow Steps

```
✅ Build and Test
   ├─ Checkout code
   ├─ Setup Node.js
   ├─ Install dependencies
   ├─ Linter check
   ├─ Type check
   └─ Build application

✅ Run Tests
   ├─ Checkout code
   ├─ Setup Node.js
   ├─ Install dependencies
   └─ Unit tests

✅ Deploy to Vercel
   ├─ Checkout code
   ├─ Setup Node.js
   └─ Deploy
```

---

## ✅ Verification Checklist

After setup, verify:

- [ ] Repository created on GitHub
- [ ] Local code pushed to main branch
- [ ] GitHub Actions workflow file exists (`.github/workflows/deploy.yml`)
- [ ] Secrets configured in GitHub repository settings
- [ ] Vercel project created
- [ ] First deployment successful
- [ ] App accessible at Vercel URL
- [ ] Automatic deployment triggered on push

---

## 📊 View Deployment Status

### GitHub Actions

```bash
# View workflow runs
gh run list

# View specific run
gh run view RUN_ID

# View logs
gh run view RUN_ID --log
```

### Vercel

1. Go to https://vercel.com/dashboard
2. Select "aiox-course-platform"
3. Click "Deployments"
4. View logs for each deployment

---

## 🔧 Troubleshooting

### Build fails in GitHub Actions

**Problem**: `npm: command not found`
```bash
# Solution: Check Node version in workflow
# Must match: node-version: "20"
```

**Problem**: `Module not found`
```bash
# Solution: Run npm ci instead of npm install
# Already configured in workflow
```

### Vercel deployment stuck

```bash
# Check deployment logs
vercel logs --follow

# Redeploy manually
vercel deploy --prod
```

### Secrets not found

```bash
# List secrets
gh secret list

# Update secret
gh secret set SECRET_NAME --body "new_value"

# Remove secret
gh secret delete SECRET_NAME
```

### Build timeout

In `vercel.json`, increase timeout:
```json
{
  "buildCommand": "npm run build",
  "maxDuration": 60
}
```

---

## 🎯 Next Steps (Post-Deployment)

Once deployed successfully:

1. **Enable Preview Deployments**
   - Settings → Git → Deploy on Push (auto-enabled)

2. **Setup Custom Domain** (optional)
   - Vercel Dashboard → Domains
   - Add custom domain

3. **Configure Environment Variables**
   - Vercel Dashboard → Settings → Environment Variables
   - Add production secrets if needed

4. **Monitor Performance**
   - Vercel Analytics
   - Web Vitals monitoring

5. **Setup Notifications** (optional)
   - GitHub → Actions settings
   - Slack integration

---

## 📝 Useful Commands

```bash
# View GitHub status
gh status

# View deployed URL
gh repo view --json url

# Create GitHub release
gh release create v1.0.0 --notes "Initial release"

# Check Vercel deployment
vercel ls

# View Vercel environment
vercel env ls
```

---

## 🔐 Security Best Practices

1. **Protect main branch**
   - GitHub → Settings → Branches
   - Add branch protection rule for `main`
   - Require PR reviews before merge

2. **Use environment secrets**
   - Keep prod secrets separate
   - Never commit `.env` files

3. **Rotate tokens periodically**
   - Vercel tokens every 3-6 months
   - GitHub tokens same as above

4. **Use team access**
   - GitHub → Settings → Collaborators
   - Add team members with appropriate permissions

---

## 📞 Support Resources

- **GitHub Actions Docs**: https://docs.github.com/en/actions
- **Vercel Docs**: https://vercel.com/docs
- **Next.js Deployment**: https://nextjs.org/docs/deployment
- **GitHub CLI**: https://cli.github.com/

---

**Status**: Ready for deployment! 🚀
**Last Updated**: 2026-03-23
**Estimated Time**: 15-20 minutes
