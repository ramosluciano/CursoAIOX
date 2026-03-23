# AIOX Course Platform - Deployment Guide

## ✅ Local Validation Complete

The application has been successfully built and tested locally using Docker.

### Test Results

```
✅ Home Page (/)              - 200 OK
✅ Bootcamp Module            - 200 OK
✅ Mastery Module             - 200 OK
✅ Projects Page              - 200 OK
✅ Bootcamp Lesson (Aula 01)  - 200 OK
✅ Mastery Lesson (Aula 01)   - 200 OK

Performance: ~2-3ms per request
Container Status: Healthy
```

---

## 🐳 Running Locally with Docker

### Quick Start

```bash
# Build Docker image (one-time)
docker build -t aiox-course-app:latest .

# Start container
docker compose up -d

# View logs
docker compose logs -f app

# Stop container
docker compose down
```

### Using the Helper Script

```bash
# Build
./docker-build.sh build

# Start
./docker-build.sh up

# View logs
./docker-build.sh logs

# Stop
./docker-build.sh down

# Clean up
./docker-build.sh clean
```

### Access the Application

- 🌐 **Home**: http://localhost:3000
- 📚 **Bootcamp**: http://localhost:3000/bootcamp
- 🎓 **Mastery**: http://localhost:3000/mastery
- 🚀 **Projects**: http://localhost:3000/projects

---

## 🚀 Next Steps: GitHub + Vercel

### Phase 1: GitHub Setup

#### 1. Initialize Git Repository

```bash
git init
git add .
git commit -m "Initial commit: AIOX Course Platform v1.0"
```

#### 2. Create GitHub Repository

```bash
# Create a new repository on https://github.com/new
# Then:
git remote add origin https://github.com/YOUR_USERNAME/aiox-course-platform.git
git branch -M main
git push -u origin main
```

#### 3. Add GitHub Secrets (for Vercel)

```bash
gh secret set VERCEL_TOKEN --body "your_vercel_token"
```

### Phase 2: GitHub Actions CI/CD

#### 4. Create GitHub Actions Workflow

File: `.github/workflows/deploy.yml`

```yaml
name: Build and Deploy to Vercel

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v3

    - name: Use Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '20'
        cache: 'npm'

    - name: Install dependencies
      run: npm ci

    - name: Run linter
      run: npm run lint

    - name: Type check
      run: npm run type-check

    - name: Build
      run: npm run build

    - name: Deploy to Vercel
      uses: vercel/action@v4
      with:
        vercel-token: ${{ secrets.VERCEL_TOKEN }}
        vercel-org-id: ${{ secrets.VERCEL_ORG_ID }}
        vercel-project-id: ${{ secrets.VERCEL_PROJECT_ID }}
        scope: ${{ secrets.VERCEL_ORG_ID }}
```

### Phase 3: Vercel Deployment

#### 5. Vercel Setup

**Option A: Automatic (Recommended)**

1. Go to https://vercel.com
2. Sign in with GitHub
3. Click "New Project"
4. Import your repository
5. Vercel auto-detects Next.js settings
6. Deploy (automatic on push to main)

**Option B: Manual with Vercel CLI**

```bash
# Install Vercel CLI
npm i -g vercel

# Deploy
vercel deploy --prod
```

#### 6. Configure Environment Variables

In Vercel Dashboard:
- Settings → Environment Variables
- Add any production env vars (if needed)

### Phase 4: GitHub Workflows for Testing (Optional)

Add automated tests:

```yaml
- name: Run unit tests
  run: npm test -- --coverage

- name: Run E2E tests
  run: npm run test:e2e
```

---

## 📊 Architecture & Features

### Tech Stack
- **Framework**: Next.js 14 (App Router)
- **Styling**: Tailwind CSS
- **Content**: Markdown (40 lessons)
- **Deployment**: Docker → Vercel
- **CI/CD**: GitHub Actions

### Features Implemented
✅ Module-based navigation (Bootcamp + Mastery)
✅ Dynamic markdown lesson rendering
✅ Progress tracking (localStorage)
✅ Project showcase (6 projects)
✅ Responsive design
✅ Static pre-generation (47 pages)
✅ Health checks
✅ Performance optimized

---

## 🔧 Troubleshooting

### Container won't start
```bash
docker compose logs app
docker compose down -v
docker compose up -d
```

### Port 3000 already in use
```bash
# Change port in docker-compose.yml
ports:
  - "3001:3000"

# Then access at http://localhost:3001
```

### Build failing on GitHub Actions
- Check Node.js version matches (20.x)
- Verify all dependencies installed
- Check for hard-coded paths

### Vercel deployment timeout
- Increase timeout in vercel.json
- Optimize build (remove unused deps)
- Check memory limits

---

## 📝 Project Structure

```
/data/projects/CursoAIOX/
├── app/                    # Next.js app directory
│   ├── layout.tsx
│   ├── page.tsx
│   ├── bootcamp/
│   ├── mastery/
│   └── projects/
├── components/             # React components
├── Bootcamp/              # Lesson content (18 .md files)
├── Mastery/               # Lesson content (22 .md files)
├── docs/                  # Documentation
├── Dockerfile             # Docker image definition
├── docker-compose.yml     # Docker orchestration
├── package.json           # Dependencies
├── tsconfig.json          # TypeScript config
├── tailwind.config.js     # Tailwind config
└── next.config.js         # Next.js config
```

---

## 🎯 Next Actions

1. ✅ Validate locally (DONE)
2. ⏳ Initialize Git repository
3. ⏳ Push to GitHub
4. ⏳ Setup Vercel
5. ⏳ Configure CI/CD
6. ⏳ Test deployment pipeline
7. ⏳ Go live!

---

## 📞 Support

For issues or questions:
- Check Docker logs: `docker compose logs -f`
- Review Next.js docs: https://nextjs.org
- Check Vercel docs: https://vercel.com/docs

---

**Status**: ✅ Ready for GitHub → Vercel deployment
**Last Updated**: 2026-03-23
**Version**: 1.0.0
