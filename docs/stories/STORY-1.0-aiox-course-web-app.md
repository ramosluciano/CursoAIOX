# Story: AIOX Course Web Application [Story 1.0]

**Status:** `[ ] Pending`
**Created:** 2026-03-23
**Author:** @sm
**Epic:** Multi-Module Course Platform

---

## Summary

Build a responsive, performant web application to deliver the **AIOX Professional Bootcamp** (18 aulas + 3 projetos) and **AIOX Mastery** (22 aulas + 3 squads/projetos) courses with dynamic Markdown content rendering, per-user progress tracking via localStorage, and a projects showcase page.

The application reads the existing `.md` lesson files from `Bootcamp/` and `Mastery/` (40 lessons total) and the project descriptions from `docs/projetos-descritivo-completo.md`, serving them through a clean, fast, accessible UI.

---

## Context

### Existing Content Structure

```
/
├── Bootcamp/                          # 18 lesson files
│   ├── aula-01-setup-anatomia.md
│   ├── aula-02-conceitos-fluxo.md
│   ├── aula-03-analyst-pm.md
│   ├── aula-04-architect-stories.md
│   ├── aula-05-devops-infra.md
│   ├── aula-06-dev-backend.md
│   ├── aula-07-dev-qa-frontend.md
│   ├── aula-08-devops-cicd-deploy.md
│   ├── aula-09-auction-analyst.md
│   ├── aula-10-pm-architect-spec.md
│   ├── aula-11-dev-scrapers.md
│   ├── aula-12-dev-normalization-api.md
│   ├── aula-13-devops-deploy-retro.md
│   ├── aula-14-squad-architecture.md
│   ├── aula-15-voice-content.md
│   ├── aula-16-backend-persistence.md
│   ├── aula-17-analytics-patterns.md
│   └── aula-18-automation-brownfield-retro.md
│
├── Mastery/                           # 22 lesson files (+ 3 bundle files)
│   ├── mastery-aula-01-internals.md
│   ├── mastery-aula-02-elicitation-agents.md
│   ├── mastery-aula-03-tasks-workflows.md
│   ├── mastery-aula-04-worktrees-migration.md
│   ├── mastery-aula-05-spec-pipeline.md
│   ├── mastery-aula-06-execution-engine.md
│   ├── mastery-aula-07-recovery-qa-memory.md
│   ├── mastery-aula-08-analyst-domain.md
│   ├── mastery-aula-09-prd-architecture.md
│   ├── mastery-aula-10-infra-saas.md
│   ├── mastery-aula-11-auth-billing.md
│   ├── mastery-aula-12-content-engine.md
│   ├── mastery-aula-13-quiz-learning-path.md
│   ├── mastery-aula-14-tooling-labs.md
│   ├── mastery-aula-15-hooks.md
│   ├── mastery-aula-16-multi-ide.md
│   ├── mastery-aula-17-brownfield-linkedin.md
│   ├── mastery-aula-18-squad-zabbix-content.md
│   ├── mastery-aula-19-squad-creator-n8n.md
│   ├── mastery-aula-20-mcp-testing.md
│   ├── mastery-aula-21-composition.md
│   └── mastery-aula-22-marketplace-consolidation.md
│
└── docs/
    ├── projetos-descritivo-completo.md  # 6 project full descriptions
    ├── roadmap-reformulado-projetos-reais.md
    ├── analise-reestruturacao-cursos.md
    └── contexto-continuacao-cursos.md
```

### Lesson Metadata Format

Each lesson file contains a front-matter comment block with module and lesson metadata:

```markdown
<!-- metadata
module: 1
lesson: 1
-->
# Aula 01 — Setup e Anatomia do AIOX
```

### Project Catalogue (6 projects)

From `docs/projetos-descritivo-completo.md`:

| # | Name | Course | Type |
|---|------|--------|------|
| 1 | RockQuiz | Bootcamp | Greenfield app |
| 2 | Squad LinkedIn Autopilot | Bootcamp | Squad (automation) |
| 3 | SentinelAI | Mastery | Greenfield SaaS |
| 4 | SentinelAI Brownfield | Mastery | Brownfield integration |
| 5 | Squad DevOps Intelligent Ops | Mastery | Squad (DevOps) |
| 6 | Squad AI Course Factory | Mastery | Squad (meta/content) |

---

## Epic: Multi-Module Course Platform

### User Stories

**US-01 — Module Navigation**
> As a student, I want to see both course modules (Bootcamp and Mastery) with their full lesson indices so I can understand what I will learn and navigate directly to any lesson.

**US-02 — Lesson Rendering**
> As a student, I want each lesson's Markdown content rendered with proper typography, code syntax highlighting, and heading anchors so the material is readable and navigable.

**US-03 — Progress Tracking**
> As a student, I want the platform to remember which lessons I have completed and show me my progress percentage per module so I stay motivated and know where I left off.

**US-04 — Projects Showcase**
> As a prospective student or graduate, I want a dedicated page showcasing all 6 projects with full descriptions, tech stack, and AIOX resources exercised so I understand what I will build.

**US-05 — Responsive Experience**
> As a student on any device, I want the platform to work correctly on mobile (360px+), tablet (768px+), and desktop (1280px+) so I can learn anywhere.

---

## Acceptance Criteria

```
AC-01  [ ] Module navigation
       Given: user visits home page
       When: page loads
       Then: two module cards are visible — "AIOX Professional Bootcamp" and "AIOX Mastery"
       And: each card shows total lesson count and current progress percentage

AC-02  [ ] Lesson index
       Given: user navigates to /bootcamp or /mastery
       When: page renders
       Then: all lessons are listed in order with their number, title, and completion status (checkmark or open circle)
       And: completed lessons are visually distinguished from pending ones

AC-03  [ ] Lesson rendering
       Given: user navigates to /bootcamp/[lesson] or /mastery/[lesson]
       When: page loads
       Then: the full Markdown content is rendered as HTML
       And: code blocks have syntax highlighting (highlight.js or Prism)
       And: headings are anchor-linked
       And: tables are styled and scrollable on mobile
       And: a "Mark as complete / Mark as incomplete" toggle is visible

AC-04  [ ] Lesson navigation
       Given: user is viewing any lesson
       When: they reach the bottom of the page or use navigation buttons
       Then: Previous Lesson and Next Lesson buttons are present
       And: Previous is hidden on the first lesson, Next is hidden on the last lesson

AC-05  [ ] Progress tracking — localStorage
       Given: user marks a lesson as complete
       When: they revisit the lesson index or home page
       Then: that lesson shows as completed
       And: the module progress percentage is recalculated
       And: progress persists across browser sessions (localStorage)
       And: a "Reset progress" option is available in settings

AC-06  [ ] Projects showcase
       Given: user navigates to /projects
       When: page renders
       Then: all 6 project cards are visible with name, description summary, tech stack tags, and source module badge
       And: clicking a card expands or navigates to full project detail (full description from docs/projetos-descritivo-completo.md)

AC-07  [ ] Responsive design
       Given: user accesses the platform on mobile (360px wide)
       When: they view any page
       Then: sidebar collapses to a hamburger/drawer menu
       And: content is readable without horizontal scroll
       And: touch targets are >= 44px

AC-08  [ ] Performance
       Given: user visits any page for the first time
       When: the page finishes loading
       Then: Time to First Contentful Paint < 1.5s on a 4G connection
       And: Lighthouse Performance score >= 90
       And: lesson content is loaded on demand (not bundled at build time for all 40 lessons)

AC-09  [ ] Accessibility
       Given: user navigates the platform using keyboard only
       When: they tab through interactive elements
       Then: focus indicators are visible
       And: all images have alt text
       And: ARIA labels are present on icon-only buttons
       And: color contrast meets WCAG 2.1 AA (4.5:1 for body text, 3:1 for large text)
```

---

## Tech Stack

| Layer | Technology | Rationale |
|-------|-----------|-----------|
| Framework | Next.js 14 (App Router) | Server Components for lesson rendering, file-system routing matches content structure, Vercel-native deployment |
| Language | TypeScript 5 | Type safety for lesson metadata, progress state, and project catalogue |
| Styling | Tailwind CSS 3 + shadcn/ui | Utility-first, shadcn components for sidebar, cards, progress bars, badges |
| Markdown | remark + rehype pipeline | `remark-gfm` for tables/strikethrough, `rehype-highlight` for syntax, `rehype-slug` + `rehype-autolink-headings` for anchor links |
| Progress storage | localStorage | No backend needed; zero friction for students; exportable JSON for future sync |
| Deployment | Vercel (primary) or Docker + Nginx | Vercel for zero-config Next.js; Docker Compose for self-hosted option |
| Testing | Playwright (E2E) + Vitest (unit) | Playwright covers navigation and progress flows; Vitest for progress logic and markdown parsing utilities |
| Linting | ESLint + Prettier | Consistent code style across the project |

### Optional Future Layers

- **Auth + cloud sync:** Supabase or Firebase for multi-device progress sync
- **API backend:** Fastify (mirrors RockQuiz architecture taught in Bootcamp)
- **Analytics:** Posthog or custom event tracking for lesson engagement

---

## Subtasks

### Phase 1 — Foundation

```
1. [  ] ST-01  Bootstrap Next.js 14 project
               - npx create-next-app@latest with TypeScript, Tailwind, App Router
               - Install shadcn/ui, remark/rehype pipeline, and highlight.js
               - Configure tsconfig paths, ESLint, Prettier
               - Set up Vitest and Playwright

2. [  ] ST-02  Content layer — lesson loader utility
               - Read .md files from Bootcamp/ and Mastery/ at build/request time
               - Parse <!-- metadata --> front-matter comment (module, lesson, course)
               - Return typed LessonMeta object: { slug, title, module, lessonNumber, course, content }
               - Unit tests: loader returns correct metadata for all 40 lessons

3. [  ] ST-03  Content layer — project catalogue loader
               - Parse docs/projetos-descritivo-completo.md into 6 typed Project objects
               - Fields: id, name, summary, fullDescription, techStack[], course, type, agentsExercised[]
               - Unit tests: all 6 projects parsed correctly
```

### Phase 2 — Layout and Navigation

```
4. [  ] ST-04  App shell layout
               - Root layout.tsx: Header (logo + nav links) + Sidebar + Main
               - Header: logo "AIOX", nav links (Home, Bootcamp, Mastery, Projects)
               - Sidebar (desktop): collapsible module lesson index with progress per module
               - Sidebar (mobile): drawer triggered by hamburger button
               - Footer: minimal (version, links)

5. [  ] ST-05  Home page (/)
               - Two module cards: Bootcamp (18 aulas, 3 projetos) and Mastery (22 aulas, 3 squads)
               - Each card: module name, description, lesson count, project count, progress ring
               - CTA buttons: "Continuar" (goes to last incomplete lesson) or "Começar"
               - Projects teaser: 3-card preview linking to /projects
```

### Phase 3 — Module and Lesson Pages

```
6. [  ] ST-06  Module index pages (/bootcamp and /mastery)
               - List all lessons in order with: lesson number, title, completion status icon
               - Group by sub-module (Módulo 1, Módulo 2, etc.) using module metadata
               - Module-level progress bar showing X of N lessons completed
               - Clicking any lesson navigates to the lesson detail page

7. [  ] ST-07  Lesson detail pages (/bootcamp/[lesson] and /mastery/[lesson])
               - Render Markdown via remark/rehype pipeline (GFM, syntax highlight, slug anchors)
               - Table of contents sidebar (desktop) built from headings
               - "Mark as complete" / "Mark as incomplete" button (updates localStorage)
               - Previous / Next lesson navigation buttons at top and bottom
               - Lesson metadata badge: module number, lesson number, estimated reading time
               - Breadcrumb: Home > Bootcamp > Aula 06

8. [  ] ST-08  Progress store (localStorage)
               - Key: aiox_progress (JSON object)
               - Shape: { bootcamp: { "aula-01": true, "aula-06": true, ... }, mastery: { ... } }
               - Custom hook: useProgress() — returns { isComplete, toggle, percentage, reset }
               - Hydration-safe: avoid SSR/client mismatch with useEffect initialization
               - Unit tests: toggle, percentage calculation, reset
```

### Phase 4 — Projects Showcase

```
9. [  ] ST-09  Projects list page (/projects)
               - Grid of 6 project cards (3-col desktop, 2-col tablet, 1-col mobile)
               - Card: project name, one-line summary, course badge (Bootcamp / Mastery),
                 type badge (Greenfield / Brownfield / Squad), tech stack tags (top 4)
               - Click navigates to /projects/[project]

10. [  ] ST-10  Project detail page (/projects/[project])
                - Full description rendered from docs/projetos-descritivo-completo.md
                - Tech stack table (where available)
                - Agent roster (agentes AIOX exercitados)
                - Features list
                - "Back to Projects" breadcrumb
```

### Phase 5 — Quality and Deployment

```
11. [  ] ST-11  Responsive polish pass
                - Test all pages at 360px, 768px, 1280px, 1440px
                - Sidebar drawer works on mobile (focus trap, close on backdrop click)
                - Tables inside lessons scroll horizontally on small screens
                - Touch targets >= 44px for all interactive elements

12. [  ] ST-12  Performance optimization
                - Verify Next.js dynamic imports are used for heavy remark plugins
                - Check no lesson content is bundled in the JS payload at build time
                - Optimize any images (next/image with appropriate sizes)
                - Verify Lighthouse score >= 90 on desktop and >= 80 on mobile

13. [  ] ST-13  Accessibility audit
                - Run axe-core via Playwright on all route types (home, module, lesson, projects)
                - Fix all critical (P1) and serious (P2) violations
                - Verify keyboard navigation flow (tab order, focus visible, skip link)
                - Verify ARIA roles on sidebar, drawer, progress indicators

14. [  ] ST-14  E2E tests (Playwright)
                - Test: landing page shows two module cards with correct lesson counts
                - Test: navigate to Bootcamp > Aula 01 > content renders > mark complete > progress updates
                - Test: navigate to Projects > click RockQuiz card > full description visible
                - Test: mobile menu opens, navigates, closes correctly
                - Test: progress persists after page refresh (localStorage)
                - Test: Reset progress clears all completion state

15. [  ] ST-15  Deployment
                - Vercel: connect repo, set NEXT_PUBLIC_ env vars, verify preview deploy on PR
                - Optional Docker: Dockerfile (multi-stage) + docker-compose.yml for self-hosting
                - README with local dev instructions (npm install, npm run dev)
```

---

## File List

```
app/
  layout.tsx                          # Root shell: Header + Sidebar + Main
  page.tsx                            # Home — two module cards + projects teaser
  globals.css                         # Tailwind base + custom prose styles
  bootcamp/
    page.tsx                          # Bootcamp lesson index
    [lesson]/
      page.tsx                        # Individual lesson detail
  mastery/
    page.tsx                          # Mastery lesson index
    [lesson]/
      page.tsx                        # Individual lesson detail
  projects/
    page.tsx                          # Projects grid
    [project]/
      page.tsx                        # Project detail

components/
  layout/
    Header.tsx                        # Logo + nav links
    Sidebar.tsx                       # Lesson index (desktop persistent, mobile drawer)
    MobileMenu.tsx                    # Hamburger + drawer wrapper
    Breadcrumb.tsx                    # Breadcrumb component
  lesson/
    LessonContent.tsx                 # Renders rehype output HTML
    LessonNav.tsx                     # Previous / Next lesson buttons
    MarkCompleteButton.tsx            # Toggle complete/incomplete
    TableOfContents.tsx               # Auto-built from headings
    LessonMeta.tsx                    # Module badge, lesson number, reading time
  module/
    ModuleCard.tsx                    # Home page module card with progress ring
    LessonList.tsx                    # Ordered lesson index with status icons
    ProgressBar.tsx                   # Module-level progress bar
  projects/
    ProjectCard.tsx                   # Project summary card (grid item)
    TechStackBadge.tsx                # Colored tech tag
    CourseBadge.tsx                   # Bootcamp / Mastery badge

lib/
  lessons.ts                          # Lesson loader: reads .md files, parses metadata
  projects.ts                         # Project catalogue loader from docs/
  markdown.ts                         # remark/rehype pipeline configuration
  slugify.ts                          # Filename → URL slug utilities

hooks/
  useProgress.ts                      # localStorage progress store hook
  useMobileMenu.ts                    # Drawer open/close state

types/
  lesson.ts                           # LessonMeta, LessonContent types
  project.ts                          # Project, TechStackItem types
  progress.ts                         # ProgressState, ModuleProgress types

tests/
  unit/
    lessons.test.ts                   # Loader returns correct metadata for all 40 lessons
    projects.test.ts                  # Parser extracts all 6 projects correctly
    useProgress.test.ts               # Toggle, percentage, reset logic
  e2e/
    navigation.spec.ts                # Home → Module → Lesson → mark complete
    projects.spec.ts                  # Projects list → detail page
    progress.spec.ts                  # Progress persists, reset works
    mobile.spec.ts                    # Mobile menu open/close/navigate
    accessibility.spec.ts             # axe-core on all route types

public/
  logo.svg                            # AIOX logo
  og-image.png                        # Open Graph image (1200x630)

next.config.js                        # Next.js config: MDX off, static file handling
tailwind.config.ts                    # Tailwind config: prose plugin, custom colors
tsconfig.json
.env.local.example                    # Template for any future env vars
```

---

## Data Contracts

### LessonMeta (TypeScript)

```typescript
interface LessonMeta {
  slug: string;           // e.g. "aula-06-dev-backend"
  title: string;          // e.g. "Aula 06 — Dev: Backend do RockQuiz"
  course: 'bootcamp' | 'mastery';
  module: number;         // Sub-module number from metadata comment
  lessonNumber: number;   // Sequential lesson number within the course
  filePath: string;       // Absolute path to .md file
  readingTimeMin: number; // Estimated from word count (~200 wpm)
}

interface LessonContent extends LessonMeta {
  htmlContent: string;    // Rendered HTML from remark/rehype pipeline
  headings: Heading[];    // For table of contents
}

interface Heading {
  depth: number;          // 1–6
  text: string;
  anchor: string;         // href-safe slug
}
```

### Project (TypeScript)

```typescript
interface Project {
  id: string;             // e.g. "rockquiz", "sentinelai", "squad-linkedin-autopilot"
  name: string;           // e.g. "RockQuiz"
  summary: string;        // One-paragraph description
  fullDescription: string; // Full Markdown section from projetos-descritivo-completo.md
  course: 'bootcamp' | 'mastery';
  type: 'greenfield' | 'brownfield' | 'squad';
  techStack: TechStackItem[];
  agents: string[];       // e.g. ["@analyst", "@pm", "@architect", "@dev"]
  features: string[];     // Top-level capabilities
}

interface TechStackItem {
  layer: string;   // e.g. "Frontend"
  technology: string; // e.g. "Next.js 14 + Tailwind CSS"
}
```

### Progress State (localStorage)

```typescript
interface ProgressState {
  version: 1;
  bootcamp: Record<string, boolean>; // slug → completed
  mastery:  Record<string, boolean>; // slug → completed
  lastVisited: {
    bootcamp?: string; // slug of last viewed lesson
    mastery?:  string;
  };
  updatedAt: string; // ISO timestamp
}
```

---

## Lesson Metadata Reference

### Bootcamp Modules

| Module | Aulas | Theme |
|--------|-------|-------|
| 1 | 1–2 | AIOX Fundamentals — Setup and Concepts |
| 2 | 3–8 | RockQuiz — Full Pipeline (Analyst → DevOps + CI/CD) |
| 3 | 9–13 | AuctionHunter — Structured Restart (Brownfield / Scraping) |
| 4 | 14–18 | Squad LinkedIn Monitoragindo — Content Squad |

### Mastery Modules

| Module | Aulas | Theme |
|--------|-------|-------|
| 1 | 1–3 | AIOX Internals (deep dive into .aiox-core/) |
| 2 | 4–7 | ADE Deep Dive (Spec Pipeline, 13 Steps, Recovery, Memory Layer) |
| 3 | 8–10 | Plataforma Zabbix — Planning and Architecture (SaaS) |
| 4 | 11–14 | Plataforma Zabbix — Core Development (Auth, Content Engine, Quiz, Labs) |
| 5 | 15–17 | Hooks, Multi-IDE, Brownfield LinkedIn Migration |
| 6 | 18–22 | Advanced Squads (@squad-creator, MCP, Composition, Marketplace) |

---

## Definition of Done

```
[  ] All 9 acceptance criteria (AC-01 through AC-09) pass
[  ] All 40 lessons render correctly with no broken layouts
[  ] All 6 projects render with full descriptions
[  ] Progress tracking persists across page refresh and new browser session
[  ] No browser console errors on any page
[  ] Lighthouse scores: Performance >= 90 (desktop), Accessibility >= 90, Best Practices >= 90
[  ] All Playwright E2E tests pass (green)
[  ] Vitest unit test coverage >= 80% for lib/ and hooks/
[  ] Responsive: manually tested at 360px, 768px, 1280px
[  ] Deployed: live URL accessible (Vercel preview or production)
[  ] axe-core: zero critical or serious violations on all route types
```

---

## Notes and Decisions

### Why Next.js App Router (not Pages Router)

Server Components allow rendering lesson Markdown on the server with zero client JS for the content HTML, which directly supports the <3s initial load and >90 Lighthouse target. The App Router's file-system routing also maps cleanly to the `bootcamp/[lesson]` and `mastery/[lesson]` URL structure.

### Why not MDX

The existing `.md` files use a custom `<!-- metadata -->` comment block (not YAML front-matter). Processing them with a plain remark pipeline is simpler and avoids MDX's JSX-in-Markdown overhead. The content is teaching material, not interactive components — plain HTML output is sufficient.

### Lesson file naming vs. URL slugs

The file names (e.g., `aula-06-dev-backend.md`) are already URL-safe. The slug is derived by stripping the `.md` extension. The URL `/bootcamp/aula-06-dev-backend` is human-readable and matches the filesystem, keeping the loader simple.

### localStorage over a database

No authentication is required for the MVP. localStorage gives instant, zero-friction progress tracking. A migration path to Supabase or Firebase is straightforward: replace the `useProgress` hook implementation while keeping the same interface, and import the user's existing localStorage data on first sign-in.

### Mastery folder: bundle files

The `Mastery/` directory contains three bundle files (`mastery-aulas-11-14-dev-core.md`, `mastery-aulas-15-17-hooks-multiide-brownfield.md`, `mastery-aulas-18-22-squads-avancados.md`) in addition to the 22 individual lesson files. The loader should treat individual lesson files (`mastery-aula-NN-*.md`) as the canonical source and ignore bundle files, which are editorial summaries.

---

*Story generated by @sm — AIOX Course Web Application v1.0*
