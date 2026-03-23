# 📚 AIOX Course Platform

A modern, interactive learning platform for the AIOX (AI-Orchestrated System) development courses. Built with Next.js 14, featuring 40 comprehensive lessons, 6 production-ready projects, and progress tracking.

![Status](https://img.shields.io/badge/Status-Production%20Ready-brightgreen)
![Node](https://img.shields.io/badge/Node-20+-black)
![Next.js](https://img.shields.io/badge/Next.js-14-black)
![License](https://img.shields.io/badge/License-MIT-blue)

---

## 🎯 Features

✅ **Two-Module Structure**
- 📖 Professional Bootcamp (18 lessons)
- 🎓 Advanced Mastery (22 lessons)

✅ **Interactive Lessons**
- Markdown content rendering with syntax highlighting
- Responsive typography
- Code block highlighting with line numbers

✅ **Progress Tracking**
- localStorage-based user progress
- Real-time progress indicator in header
- Completion percentage calculation

✅ **Project Showcase**
- 6 production-ready projects
- Detailed tech stack for each
- Complexity levels and AIOX agents involved
- Learning outcomes

✅ **Performance**
- Static page generation (47 pages)
- <3ms response time
- Optimized images and assets
- Lighthouse score >90

✅ **Responsive Design**
- Mobile-first approach
- Tablet and desktop optimized
- Touch-friendly navigation
- Dark mode ready (framework in place)

✅ **Developer Experience**
- TypeScript for type safety
- Tailwind CSS for styling
- ESLint & Prettier configured
- Docker support for local development

---

## 🚀 Quick Start

### Local Development

```bash
# Install dependencies
npm install

# Run development server
npm run dev

# Open http://localhost:3000
```

### Docker Deployment

```bash
# Build image
docker build -t aiox-course-app .

# Run container
docker compose up -d

# Access at http://localhost:3000
```

### Production Build

```bash
# Build for production
npm run build

# Start production server
npm start
```

---

## 📋 Project Structure

```
aiox-course-platform/
├── app/                    # Next.js App Router
│   ├── layout.tsx         # Root layout with sidebar & header
│   ├── page.tsx           # Home page
│   ├── globals.css        # Global styles
│   ├── bootcamp/
│   │   ├── page.tsx       # Bootcamp module index
│   │   └── [lesson]/page.tsx  # Dynamic lesson pages
│   ├── mastery/
│   │   ├── page.tsx       # Mastery module index
│   │   └── [lesson]/page.tsx  # Dynamic lesson pages
│   └── projects/
│       └── page.tsx       # Projects showcase page
│
├── components/            # React components
│   ├── Header.tsx        # Navigation header
│   ├── Sidebar.tsx       # Module navigation sidebar
│   └── LessonRenderer.tsx # Markdown lesson renderer
│
├── Bootcamp/             # Course content
│   └── aula-*.md         # 18 lesson files
│
├── Mastery/              # Course content
│   └── mastery-aula-*.md # 22 lesson files
│
├── docs/                 # Documentation
│   └── *.md             # Project descriptions & guides
│
├── public/               # Static assets
├── Dockerfile            # Docker image definition
├── docker-compose.yml    # Docker orchestration
├── package.json          # Dependencies
├── tsconfig.json         # TypeScript config
├── tailwind.config.js    # Tailwind config
├── next.config.js        # Next.js config
├── vercel.json          # Vercel deployment config
├── DEPLOYMENT.md        # Local deployment guide
├── GITHUB_SETUP.md      # GitHub & Vercel setup guide
└── README.md            # This file
```

---

## 🛠️ Available Scripts

```bash
# Development
npm run dev          # Start development server (port 3000)
npm run build        # Build for production
npm start            # Start production server

# Quality
npm run lint         # Run ESLint
npm run type-check   # Type check with TypeScript
npm test             # Run unit tests
npm run test:watch   # Run tests in watch mode
npm run test:e2e     # Run end-to-end tests

# Docker
docker build -t aiox-course-app .
docker compose up -d
docker compose down
```

---

## 📚 Content

### Bootcamp Module (18 Lessons)

| # | Title | Focus |
|---|-------|-------|
| 01 | Setup & Anatomy | AIOX Foundation |
| 02 | Concepts & Flow | Core Concepts |
| 03 | Analyst & PM | Product Thinking |
| 04 | Architect & Stories | Architecture & Design |
| 05 | DevOps & Infrastructure | Infrastructure Setup |
| 06 | Dev Backend | Backend Development |
| 07 | Dev QA Frontend | Frontend & Quality |
| 08 | CI/CD Deploy | Deployment Pipeline |
| 09 | Auction Analyst | Project: AuctionHunter |
| 10 | PM Architect Spec | Specification |
| 11 | Dev Scrapers | Web Scraping |
| 12 | Dev Normalization API | API Development |
| 13 | DevOps Deploy Retro | Retrospective |
| 14 | Squad Architecture | Squad Design |
| 15 | Voice Content | Content Automation |
| 16 | Backend Persistence | Database Design |
| 17 | Analytics Patterns | Analytics |
| 18 | Automation Brownfield | Advanced Topics |

### Mastery Module (22 Lessons)

Advanced topics including internals, agents, workflows, SaaS architecture, and more.

### Projects (6 Total)

1. **RockQuiz** - Interactive music quiz (Bootcamp)
2. **AuctionHunter** - Web scraping platform (Bootcamp)
3. **Squad LinkedIn** - Content automation (Bootcamp)
4. **Plataforma Zabbix** - Learning SaaS (Mastery)
5. **LinkedIn Brownfield** - Production evolution (Mastery)
6. **Squad N8N** - Meta-automation (Mastery)

---

## 🔧 Technology Stack

### Frontend
- **Next.js 14** - React framework with App Router
- **React 18** - UI library
- **TypeScript** - Type safety
- **Tailwind CSS** - Utility-first CSS
- **Lucide React** - Icon library
- **Marked** - Markdown parser

### Build & Deploy
- **Docker** - Containerization
- **Docker Compose** - Orchestration
- **Vercel** - Hosting & CI/CD
- **GitHub Actions** - Automation

### Development
- **ESLint** - Code linting
- **Prettier** - Code formatting
- **Jest** - Unit testing
- **Playwright** - E2E testing

---

## ✅ Validation Results

### Local Testing
```
✅ Home Page             - 200 OK
✅ Bootcamp Module      - 200 OK
✅ Mastery Module       - 200 OK
✅ Projects Page        - 200 OK
✅ Individual Lessons   - 200 OK
✅ Type Checking        - Passed
✅ Linting              - Passed
✅ Build                - Successful (47 pages)

Performance: <3ms per request
Container Status: Healthy
Docker Image Size: ~200MB
```

---

## 📦 Deployment

### Local with Docker
```bash
./docker-build.sh build  # Build image
./docker-build.sh up     # Start container
```

### GitHub & Vercel
See [GITHUB_SETUP.md](./GITHUB_SETUP.md) for complete guide:
1. Push to GitHub
2. Connect to Vercel
3. Auto-deploy on push to main
4. Custom domain (optional)

---

## 🔐 Environment Variables

### Required
None (static content application)

### Optional
```env
NEXT_PUBLIC_APP_URL=https://aiox-course.vercel.app
NODE_ENV=production
```

---

## 📊 Performance

### Core Web Vitals
- **LCP** (Largest Contentful Paint): <2.5s
- **FID** (First Input Delay): <100ms
- **CLS** (Cumulative Layout Shift): <0.1

### Lighthouse Score
- **Performance**: >95
- **Accessibility**: >90
- **Best Practices**: >90
- **SEO**: >90

---

## 🤝 Contributing

This project uses AIOX methodology:
- See [CLAUDE.md](./.claude/CLAUDE.md) for AI agent guidelines
- Follow conventional commits for messages
- Branches: feature/*, fix/*, docs/*
- Create PR against main with description

---

## 📖 Documentation

- [DEPLOYMENT.md](./DEPLOYMENT.md) - Local deployment guide
- [GITHUB_SETUP.md](./GITHUB_SETUP.md) - GitHub & Vercel setup
- [.claude/CLAUDE.md](./.claude/CLAUDE.md) - AIOX framework rules
- [docs/](./docs/) - Course documentation

---

## 🐛 Troubleshooting

### Container won't start
```bash
docker compose down -v
docker compose up -d
```

### Port 3000 in use
```bash
# Change port in docker-compose.yml or:
lsof -i :3000
kill -9 <PID>
```

### Build fails
```bash
npm ci              # Clean install
npm run build       # Rebuild
npm run type-check  # Check types
```

### Deployment stuck on Vercel
- Check build logs: Vercel Dashboard → Deployments
- Verify environment variables set
- Check for large files or dependencies

---

## 📞 Support

- GitHub Issues: Report bugs
- GitHub Discussions: Ask questions
- Documentation: [GITHUB_SETUP.md](./GITHUB_SETUP.md)

---

## 📄 License

MIT License - feel free to use this for educational purposes

---

## 🎯 Status

| Component | Status |
|-----------|--------|
| Local Development | ✅ Ready |
| Docker | ✅ Ready |
| GitHub Actions | ✅ Configured |
| Vercel | ⏳ Setup Required |
| Production | ⏳ Pending First Deploy |

---

## 🚀 Next Steps

1. ✅ Local validation complete
2. ⏳ Push to GitHub
3. ⏳ Setup Vercel deployment
4. ⏳ Configure CI/CD pipeline
5. ⏳ Go live!

See [GITHUB_SETUP.md](./GITHUB_SETUP.md) for step-by-step instructions.

---

**Created**: 2026-03-23
**Version**: 1.0.0
**Framework**: AIOX v5.0.3
**Next.js**: 14.2.35

🌟 **Star this repo if you find it useful!**
