# Claude Code — Exemplos Práticos e Casos de Uso

Guia com implementações reais que você pode copiar e customizar.

---

## Tabela de Conteúdos

1. [Setup Inicial de Projeto](#setup-inicial-de-projeto)
2. [Exemplos de CLAUDE.md](#exemplos-de-claudemd)
3. [Exemplos de Rules](#exemplos-de-rules)
4. [Exemplos de Commands](#exemplos-de-commands)
5. [Exemplos de Agentes](#exemplos-de-agentes)
6. [Exemplos de Hooks](#exemplos-de-hooks)
7. [Exemplos de Workflows](#exemplos-de-workflows)
8. [Exemplos de Tasks](#exemplos-de-tasks)

---

## Setup Inicial de Projeto

### Passo 1: Estrutura de Diretórios

```bash
# No seu projeto novo/existente:
mkdir -p .claude/{rules,commands,agents,hooks,memory}

# Inicializar Claude Code
claude /init

# Ele criará .claude/CLAUDE.md
```

### Passo 2: settings.json Básico

Crie `.claude/settings.json`:

```json
{
  "permissions": {
    "defaultMode": "ask",
    "allow": [
      "read",
      "editFile:src/**/*",
      "editFile:tests/**/*",
      "bash:npm",
      "bash:npx"
    ],
    "ask": [
      "bash:*",
      "gitPush",
      "deleteFile"
    ],
    "deny": [
      "bash:rm -rf",
      "editFile:.env*",
      "editFile:package.json"
    ]
  },

  "preferredModels": {
    "default": "claude-3-5-sonnet",
    "fast": "claude-3-5-haiku",
    "thoughtful": "claude-3-opus"
  }
}
```

### Passo 3: CLAUDE.md Projeto

Crie `.claude/CLAUDE.md`:

```markdown
# [Seu Projeto] — Claude Code Setup

## Contexto do Projeto
- **Nome**: My Awesome App
- **Stack**: React 18 + TypeScript + Node.js
- **Database**: PostgreSQL com Prisma
- **Deploy**: Vercel + GitHub Actions

## Estrutura do Projeto
\`\`\`
src/
├── app/          → Next.js pages/routes
├── components/   → React components
├── lib/          → Utilities
├── db/           → Database schemas
└── tests/        → Test files
\`\`\`

## Convenções de Código

### TypeScript
- Use \`strict: true\` em tsconfig
- Sempre type variáveis: \`const x: string = "..."\`
- Use \`interface\` para objects, \`type\` para unions
- Never use \`any\` — use \`unknown\` if necessary

### React Components
- PascalCase para component names
- Props inline na function signature
- Export both named e default
- Use functional components + hooks only

\`\`\`typescript
// ✓ Good
interface CardProps {
  title: string;
  onClick: () => void;
}

export const Card: React.FC<CardProps> = ({ title, onClick }) => (
  <div onClick={onClick}>{title}</div>
);

export default Card;
\`\`\`

### File Organization
- One component per file
- Tests alongside components: \`Component.tsx\` + \`Component.test.tsx\`
- Utilities in \`lib/\` by domain

### Git Conventions
- Commit format: \`type: description [Story ID]\`
- Types: feat, fix, docs, refactor, test, chore
- Reference stories: \`[Story 2.1]\`

Example:
\`\`\`bash
feat: add user profile page [Story 1.5]
fix: handle null values in form submission [Story 1.3]
test: add tests for payment processor [Story 2.1]
\`\`\`

## Common Tasks

### Start Development
\`\`\`bash
npm run dev      # Starts on localhost:3000
\`\`\`

### Testing
\`\`\`bash
npm test         # Run all tests
npm test --cov   # With coverage
npm test -- -u   # Update snapshots
\`\`\`

### Linting & Formatting
\`\`\`bash
npm run lint     # ESLint check
npm run format   # Prettier format
\`\`\`

### Database
\`\`\`bash
npx prisma migrate dev --name <name>  # Create migration
npx prisma db push                    # Push to DB
npx prisma studio                     # GUI for database
\`\`\`

### Building
\`\`\`bash
npm run build    # Production build
npm start        # Run production build
\`\`\`

## Debugging Tips

If something breaks:
1. Check error message in terminal
2. Look at relevant files (use @filename.ts)
3. Check git diff to see what changed
4. Run tests: npm test
5. Use Plan mode first (Shift+Tab) for exploration

## Performance Notes

- Components > 300 lines should be split
- Use React.memo for expensive renders
- Lazy load pages with React.lazy
- Optimize images with next/image
- Use CDN for static assets

## Security Notes

- Never commit \`.env\` files
- Validate all user inputs
- Use parameterized queries with Prisma
- Add rate limiting to APIs
- Sanitize HTML if user-generated

## Deployment Checklist

- [ ] Tests passing: npm test
- [ ] Lint passing: npm run lint
- [ ] Build successful: npm run build
- [ ] No console errors
- [ ] Environment variables set
- [ ] Database migrated
- [ ] Cache invalidated
```

---

## Exemplos de CLAUDE.md

### Exemplo 1: Next.js E-commerce

```markdown
# E-commerce Platform — Claude Code Setup

## Tech Stack
- **Frontend**: Next.js 14 + React 18 + TypeScript
- **Styling**: Tailwind CSS + shadcn/ui
- **Backend**: Next.js API routes
- **Database**: PostgreSQL + Prisma ORM
- **Authentication**: NextAuth.js
- **Payments**: Stripe
- **Deploy**: Vercel

## Code Style

### TypeScript
- Strict mode enabled
- No implicit any
- Zod for validation

### React
- Functional components with hooks
- Server components when possible
- Client components for interactivity
- Props drilling limited to 2 levels

### API Routes
- Endpoint format: GET /api/v1/resource
- Use middleware for auth
- Return consistent response format:
  \`\`\`json
  { "success": true, "data": {...} }
  { "success": false, "error": "message" }
  \`\`\`

### Database
- Prisma models in schema.prisma
- Migrations tracked in git
- Seeds in prisma/seed.ts
- Tests use separate database

### File Organization
```
src/
├── app/                          # Next.js app directory
│   ├── layout.tsx               # Root layout
│   ├── page.tsx                 # Home page
│   ├── (marketing)/             # Route group
│   ├── (dashboard)/             # Protected routes
│   ├── api/                     # API endpoints
│   └── not-found.tsx
├── components/
│   ├── ui/                      # shadcn/ui components
│   ├── common/                  # Reusable components
│   └── features/                # Feature-specific
├── lib/
│   ├── api.ts                   # API client
│   ├── auth.ts                  # Auth helpers
│   ├── db.ts                    # Database client
│   └── utils.ts                 # Utilities
├── hooks/
│   ├── useAuth.ts
│   ├── useCart.ts
│   └── usePagination.ts
├── types/
│   ├── index.ts                 # Shared types
│   └── api.ts                   # API types
└── tests/
    ├── unit/
    └── integration/
```

## Common Commands

\`\`\`bash
# Development
npm run dev                       # Start dev server

# Database
npx prisma migrate dev --name <name>
npx prisma db seed              # Seed database
npx prisma studio               # Open GUI

# Testing
npm test                         # Run tests
npm run test:watch              # Watch mode
npm run test:cov                # With coverage

# Build & Deploy
npm run build                    # Production build
vercel deploy                    # Deploy to Vercel

# Code Quality
npm run lint                     # ESLint
npm run format                   # Prettier
npm run type-check               # TypeScript check
\`\`\`

## Security Checklist

- [ ] Rate limiting on APIs
- [ ] CSRF protection enabled
- [ ] Input validation with Zod
- [ ] SQL injection prevention (use Prisma)
- [ ] XSS protection (React sanitizes by default)
- [ ] CORS configured
- [ ] Sensitive data in .env
- [ ] API authentication required
- [ ] Payment info never logged
```

### Exemplo 2: Node.js Backend API

```markdown
# Backend API — Claude Code Setup

## Tech Stack
- **Runtime**: Node.js 18+
- **Framework**: Express.js
- **Language**: TypeScript
- **Database**: PostgreSQL + Prisma
- **Authentication**: JWT
- **Validation**: Zod
- **Testing**: Jest + Supertest
- **API Documentation**: Swagger/OpenAPI

## File Organization

```
src/
├── index.ts                      # Entry point
├── middleware/                   # Express middleware
│   ├── auth.ts
│   ├── errorHandler.ts
│   └── logger.ts
├── routes/                       # API routes
│   ├── users.ts
│   ├── posts.ts
│   └── comments.ts
├── controllers/                  # Route handlers
│   ├── userController.ts
│   ├── postController.ts
│   └── commentController.ts
├── services/                     # Business logic
│   ├── userService.ts
│   ├── postService.ts
│   └── emailService.ts
├── db/
│   └── prisma.ts                # Database client
├── types/
│   ├── index.ts
│   └── api.ts
├── utils/
│   ├── jwt.ts
│   ├── validators.ts
│   └── errors.ts
└── tests/
    ├── unit/
    └── integration/
```

## API Endpoint Pattern

\`\`\`typescript
// POST /api/users
// Create a new user
interface CreateUserRequest {
  email: string;
  name: string;
  password: string;
}

interface UserResponse {
  id: string;
  email: string;
  name: string;
  createdAt: string;
}

// Response: 201 Created
{
  "success": true,
  "data": {
    "id": "user_123",
    "email": "user@example.com",
    "name": "John Doe",
    "createdAt": "2024-01-01T00:00:00Z"
  }
}
\`\`\`

## Error Handling

\`\`\`typescript
// Consistent error response
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid email format",
    "details": [
      { "field": "email", "message": "Must be valid email" }
    ]
  }
}
\`\`\`

## Testing

\`\`\`typescript
// Example: test/users.test.ts
describe("POST /api/users", () => {
  it("should create user with valid data", async () => {
    const res = await request(app)
      .post("/api/users")
      .send({
        email: "test@example.com",
        name: "Test User",
        password: "Password123!"
      });

    expect(res.status).toBe(201);
    expect(res.body.data.email).toBe("test@example.com");
  });
});
\`\`\`
```

---

## Exemplos de Rules

### Exemplo 1: React Components Rule

Crie `.claude/rules/react-components.md`:

```markdown
---
paths:
  - "src/components/**/*.tsx"
severity: high
tags: ["react", "frontend"]
---

# React Component Standards

## File Structure

Each component gets its own file with this structure:

\`\`\`typescript
import React from 'react';

// 1. Type definitions (if not imported)
interface Props {
  title: string;
  onClose: () => void;
}

// 2. Component definition
export const MyComponent: React.FC<Props> = ({
  title,
  onClose
}) => {
  return (
    <div>
      <h1>{title}</h1>
      <button onClick={onClose}>Close</button>
    </div>
  );
};

// 3. Default export
export default MyComponent;
\`\`\`

## Naming Conventions

- Components: PascalCase (\`UserCard.tsx\`)
- Props interfaces: Component name + "Props" (\`UserCardProps\`)
- Hooks: camelCase (\`useUserData.ts\`)
- Files: Match component name exactly

## Accessibility (a11y)

- Use semantic HTML: \`<button>\` not \`<div onClick>\`
- Add \`aria-label\` to icon buttons
- Keyboard navigation support
- Test with screen reader

## Performance

- Memoize with \`React.memo\` if re-renders expensive
- Use \`useCallback\` for stable function refs
- Use \`useMemo\` for expensive computations
- Lazy load heavy components

Example:
\`\`\`typescript
export const UserCard = React.memo(function UserCard({
  userId
}: { userId: string }) {
  const user = useUserData(userId);

  return (
    <div role="article">
      <h2>{user.name}</h2>
      <p>{user.email}</p>
    </div>
  );
});
\`\`\`

## Testing

Every component must have a test file:

\`\`\`typescript
// UserCard.test.tsx
import { render, screen } from '@testing-library/react';
import UserCard from './UserCard';

describe('UserCard', () => {
  it('renders user name', () => {
    render(<UserCard userId="123" />);
    expect(screen.getByText('John Doe')).toBeInTheDocument();
  });

  it('handles close button', () => {
    const onClose = jest.fn();
    render(<UserCard userId="123" onClose={onClose} />);
    screen.getByRole('button', { name: /close/i }).click();
    expect(onClose).toHaveBeenCalled();
  });
});
\`\`\`
```

### Exemplo 2: Database Migrations Rule

Crie `.claude/rules/database-safety.md`:

```markdown
---
paths:
  - "db/migrations/*.sql"
  - "prisma/migrations/**/*"
severity: high
tags: ["database", "migrations", "safety"]
---

# Database Migration Safety Guidelines

## Before Creating Migration

1. **Always have backup**
   - Production data backed up before release
   - Test migration on staging first

2. **Never use DROP without planning**
   - Always create rollback
   - Announce deprecation first
   - Give users time to migrate

3. **Check dependent data**
   - Find all references to column/table
   - Update application code first
   - Then remove from database

## Migration Structure

\`\`\`sql
-- Migration: 2024_01_01_add_user_email_verified.sql

-- Up (forward)
BEGIN TRANSACTION;

ALTER TABLE users ADD COLUMN email_verified BOOLEAN DEFAULT FALSE;
CREATE INDEX idx_users_email_verified ON users(email_verified);

-- Seed existing users (optional)
UPDATE users SET email_verified = true WHERE created_at < NOW() - INTERVAL 7 DAY;

COMMIT;

-- Down (rollback)
BEGIN TRANSACTION;

DROP INDEX idx_users_email_verified;
ALTER TABLE users DROP COLUMN email_verified;

COMMIT;
\`\`\`

## Prisma Migration Pattern

\`\`\`prisma
// prisma/schema.prisma

model User {
  id                 String    @id @default(cuid())
  email              String    @unique
  emailVerified      DateTime?
  name               String?
  createdAt          DateTime  @default(now())
  updatedAt          DateTime  @updatedAt

  @@index([emailVerified])
}
\`\`\`

## Safe Migration Checklist

- [ ] Backup created
- [ ] Tested on staging
- [ ] Rollback verified
- [ ] Application code updated
- [ ] Index performance checked
- [ ] Zero-downtime compatible
- [ ] Notification sent to team
- [ ] Monitoring enabled
```

---

## Exemplos de Commands

### Exemplo 1: Test Coverage Command

Crie `.claude/commands/test-coverage.md`:

```markdown
---
name: "test-coverage"
description: "Run tests with coverage report and highlight gaps"
shortcut: "ctrl+shift+t"
---

# Test Coverage Analysis

Follow these steps to generate and analyze test coverage:

## Step 1: Run Tests with Coverage
\`\`\`bash
npm run test:cov
\`\`\`

## Step 2: Analyze Report
Open \`coverage/lcov-report/index.html\` and look for:
- Files with < 80% coverage (red)
- Uncovered branches (yellow lines)
- Critical paths missing tests

## Step 3: Identify Gaps
For each uncovered section:
1. Understand the logic
2. Identify test scenarios
3. Write missing tests

Example test additions:
- Happy path ✓
- Error cases ✗
- Edge cases (null, empty, boundary values)
- Integration between modules

## Step 4: Add Tests
Create/update \`.test.ts\` files for gaps.

## Step 5: Verify
\`\`\`bash
npm run test:cov
\`\`\`

Repeat until > 80% coverage.
```

### Exemplo 2: Database Seed Command

Crie `.claude/commands/db-reset.md`:

```markdown
---
name: "db-reset"
description: "Reset database: drop all tables, run migrations, seed data"
---

# Database Reset

⚠️  This command clears ALL data. Use only in development!

## Steps

1. **Drop existing database**
   \`\`\`bash
   npx prisma migrate reset --force
   \`\`\`

2. **Run all migrations**
   \`\`\`bash
   npx prisma migrate deploy
   \`\`\`

3. **Seed with test data**
   \`\`\`bash
   npx prisma db seed
   \`\`\`

4. **Verify setup**
   \`\`\`bash
   npx prisma studio
   \`\`\`
   Check that all tables exist with sample data

## Result
Clean database with fresh schema and test data, ready for development.
```

---

## Exemplos de Agentes

### Exemplo 1: React Specialist Agent

Crie `.claude/agents/react-specialist.md`:

```markdown
---
name: "React Specialist"
description: "Expert in React, TypeScript, performance optimization, and testing"
model: "claude-3-5-sonnet"
toolAccess:
  allow:
    - read
    - editFile
    - bash
  deny:
    - gitPush
    - networkRequest
permissionMode: "auto-accept-edits"
tags: ["frontend", "react", "typescript"]
---

# React Specialist Agent

## Expertise

You are a React expert specializing in:

- **Architecture**: Component composition, hooks patterns, state management
- **Performance**: Memoization, code splitting, lazy loading
- **Accessibility**: WCAG compliance, semantic HTML, ARIA attributes
- **Testing**: Unit tests, integration tests, snapshot tests
- **TypeScript**: Strict typing, generics, type safety
- **Styling**: Tailwind CSS, CSS Modules, styled-components

## Your Guidelines

### Component Design
1. Write functional components with hooks
2. Keep components focused and testable
3. Use TypeScript interfaces for props
4. Prefer composition over inheritance

### Performance First
- Profile before optimizing
- Use \`React.memo\` for expensive renders
- Memoize callbacks with \`useCallback\`
- Use \`useMemo\` for expensive calculations
- Code-split with \`React.lazy\`

### Accessibility Always
- Test with keyboard navigation
- Add ARIA labels to interactive elements
- Use semantic HTML
- Provide alt text for images

### Testing Coverage
- Minimum 80% code coverage
- Test user behavior, not implementation
- Use React Testing Library (not Enzyme)
- Test edge cases and error states

### Code Style
- ESLint enforced
- Prettier formatted
- TypeScript strict mode
- No console logs in production

## When Claude Calls You

Claude will invoke you for tasks like:
- "Refactor this component for performance"
- "Add tests to this component"
- "Make this component accessible"
- "Optimize this heavy component"

Execute the task following your guidelines, explain changes, and ensure tests pass.
```

### Exemplo 2: Backend Architect Agent

Crie `.claude/agents/backend-architect.md`:

```markdown
---
name: "Backend Architect"
description: "Specialist in API design, database architecture, and scalability"
model: "claude-3-5-sonnet"
toolAccess:
  allow:
    - read
    - editFile
  deny:
    - bash
    - gitPush
    - networkRequest
permissionMode: "plan"
tags: ["backend", "architecture", "database"]
---

# Backend Architect Agent

## Expertise

- **API Design**: RESTful principles, versioning, error handling
- **Database**: Schema design, normalization, indexing, performance
- **Security**: Authentication, authorization, data protection
- **Scalability**: Caching, horizontal scaling, microservices
- **DevOps**: Containerization, monitoring, deployment

## Your Approach

1. **Analyze existing structure**
   - Understand current architecture
   - Identify pain points
   - Map data flows

2. **Design improvements**
   - Consider trade-offs
   - Plan migrations
   - Document decisions

3. **Create implementation plan**
   - Break into phases
   - Prioritize by impact
   - Estimate effort

4. **Code review**
   - Check implementation follows design
   - Verify performance characteristics
   - Ensure security practices
```

---

## Exemplos de Hooks

### Exemplo 1: Auto-format TypeScript Files

Crie `.claude/hooks/post-file-edit.sh`:

```bash
#!/bin/bash
# Auto-format edited files based on type

set -e

# Color output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

FILE="$EDITED_FILE"

# TypeScript files
if [[ "$FILE" == *.ts ]] || [[ "$FILE" == *.tsx ]]; then
  echo -e "${YELLOW}✨ Formatting TypeScript: $FILE${NC}"
  npx prettier "$FILE" --write --quiet 2>/dev/null || true

  # ESLint fix
  npx eslint "$FILE" --fix --quiet 2>/dev/null || true

  echo -e "${GREEN}✓ Done${NC}"
fi

# Markdown files
if [[ "$FILE" == *.md ]]; then
  echo -e "${YELLOW}✨ Formatting Markdown: $FILE${NC}"
  npx prettier "$FILE" --write --quiet 2>/dev/null || true
fi

# JSON files (config, tsconfig, etc)
if [[ "$FILE" == *.json ]]; then
  echo -e "${YELLOW}✨ Formatting JSON: $FILE${NC}"
  npx prettier "$FILE" --write --quiet 2>/dev/null || true
fi
```

### Exemplo 2: Pre-commit Test Hook

Crie `.claude/hooks/pre-git-commit.sh`:

```bash
#!/bin/bash
# Run tests before committing

set -e

YELLOW='\033[1;33m'
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# Get changed files
CHANGED_FILES=$(git diff --cached --name-only)

# Check if any test files changed
if echo "$CHANGED_FILES" | grep -E "\.test\.(ts|tsx|js)$" > /dev/null; then
  echo -e "${YELLOW}🧪 Tests changed, running full test suite...${NC}"

  if npm test -- --bail; then
    echo -e "${GREEN}✓ Tests passed${NC}"
  else
    echo -e "${RED}✗ Tests failed! Fix and try again.${NC}"
    exit 1
  fi
else
  echo -e "${YELLOW}🧪 Running quick test check...${NC}"
  npm test -- --testPathPattern="(unit|integration)" --bail 2>/dev/null || true
fi
```

---

## Exemplos de Workflows

### Workflow 1: Feature Development Completo

```bash
# Session 1: Planning
1. claude "explore the codebase for user authentication"
2. /agent plan
3. claude "create a plan for adding two-factor authentication"
   # Claude produces step-by-step plan

# Session 2: Implementation
1. /clear  # Start fresh
2. claude "implement the 2FA system according to the plan"
   # Claude executes implementation
3. /test
4. /commit "feat: add two-factor authentication"

# Session 3: Testing & Review
1. /agent react-specialist
2. claude "review and optimize the 2FA components"
3. /test
4. /commit "refactor: optimize 2FA components"

# Session 4: Documentation
1. claude "generate API documentation for 2FA endpoints"
2. /commit "docs: add 2FA API documentation"
```

### Workflow 2: Bug Fix Metodológico

```bash
# Step 1: Understand (Plan Mode)
1. Shift+Tab  # Enter Plan Mode (read-only)
2. claude "I'm getting 'Cannot read property email of undefined'
           in UserCard component when user data is loading.
           Let's debug this step by step."
   # Claude analyzes without making changes

# Step 2: Review Code
3. @src/components/UserCard.tsx
4. @src/hooks/useUserData.ts
5. "Show me all places where user data is accessed"
   # Claude traces the issue

# Step 3: Implement Fix (Normal Mode)
6. Shift+Tab  # Back to normal mode
7. claude "Fix the null reference error in UserCard"
8. /test  # Verify tests pass
9. /commit "fix: handle undefined user data in UserCard"
```

### Workflow 3: Code Review

```bash
# Análise Completa
1. Shift+Tab  # Plan Mode
2. /agent backend-architect  # Backend specialist
3. claude "Review the API endpoints in src/api/users.ts
           Check for security, performance, and design issues"
   # Architect reviews without modifying

# Resultados
- Security concerns identified
- Performance suggestions
- Design pattern improvements
- Database optimization ideas

# Discuss with team
- Decide which recommendations to implement
- Plan follow-up tasks
```

---

## Exemplos de Tasks

### Task List para Feature Development

```markdown
# User Authentication System — Tasks

## Epic: JWT-based Authentication

### Phase 1: Backend Setup
- [ ] T1: Create user schema and migrations (2h)
  - Database table with email, password hash, tokens
  - Migrations tracked in git

- [ ] T2: Implement password hashing (1h)
  - Use bcrypt, never store plain passwords
  - Blockedby: T1

- [ ] T3: Create JWT utilities (1h)
  - Generate, verify, refresh tokens
  - Blockedby: T1

### Phase 2: API Endpoints
- [ ] T4: Implement POST /auth/register (1h)
  - Validate input with Zod
  - Hash password, create user
  - Return JWT tokens
  - Blockedby: T2, T3

- [ ] T5: Implement POST /auth/login (1h)
  - Verify credentials
  - Return JWT tokens
  - Blockedby: T2, T3

- [ ] T6: Implement POST /auth/refresh (30m)
  - Exchange old token for new
  - Blockedby: T3

### Phase 3: Frontend
- [ ] T7: Create LoginForm component (1.5h)
  - Form validation
  - Error handling
  - Blockedby: T4

- [ ] T8: Create RegisterForm component (1.5h)
  - Password validation
  - Terms acceptance
  - Blockedby: T4

- [ ] T9: Create ProtectedRoute wrapper (1h)
  - Check token validity
  - Redirect if expired
  - Blockedby: T6

### Phase 4: Testing & Polish
- [ ] T10: Write API tests (2h)
  - Happy path tests
  - Error case tests
  - Blockedby: T4, T5, T6

- [ ] T11: Write component tests (2h)
  - Form validation tests
  - Error handling tests
  - Blockedby: T7, T8

- [ ] T12: Security review (1h)
  - Check OWASP guidelines
  - Verify token handling
  - Blockedby: T4, T5

### Phase 5: Deployment
- [ ] T13: Deploy to production (30m)
  - Blockedby: T10, T11, T12

**Total Estimated**: 16.5 hours
**Start Date**: [DATE]
**Target Completion**: [DATE + 2 days]
```

### Task List com Parallelização

```markdown
# Platform Refactoring — Parallel Tasks

## Backend Tasks (Parallel)
- [ ] T1: Refactor authentication module
  - Duration: 4h
  - Owner: @backend-specialist

- [ ] T2: Optimize database queries
  - Duration: 3h
  - Owner: @data-engineer
  - (Can run in parallel with T1)

- [ ] T3: Update API documentation
  - Duration: 2h
  - Owner: @pm

## Frontend Tasks (Parallel)
- [ ] T4: Update React components
  - Duration: 4h
  - Owner: @react-specialist
  - (Can run in parallel with T1-T3)

- [ ] T5: Improve styling with Tailwind
  - Duration: 2h
  - Owner: @frontend-specialist
  - (Can run in parallel with T4)

## Integration & Testing
- [ ] T6: Integration testing
  - Duration: 2h
  - Owner: @qa
  - Blockedby: T1, T4

- [ ] T7: Performance testing
  - Duration: 1h
  - Owner: @qa
  - Blockedby: T2

- [ ] T8: Deploy to staging
  - Duration: 30m
  - Owner: @devops
  - Blockedby: T6, T7

**Timeline**:
- T1-T5: Run in parallel (4h wall time)
- T6-T7: Run after parallel tasks (2h wall time)
- T8: Final deployment (30m)
- **Total**: ~6.5 hours wall time instead of 18.5 hours sequential
```

---

## Dicas Práticas Finais

### ✓ Use essa estrutura em NOVO projeto:

```bash
./                              # Raiz do projeto
├── .claude/                    # Criar agora!
│   ├── CLAUDE.md
│   ├── settings.json
│   ├── rules/
│   ├── commands/
│   ├── agents/
│   ├── hooks/
│   └── memory/
├── docs/
├── src/
└── tests/
```

### ✓ Em projeto EXISTENTE:

```bash
# 1. Criar estrutura
mkdir -p .claude/{rules,commands,agents,hooks,memory}

# 2. Gerar CLAUDE.md template
claude /init

# 3. Customizar para seu projeto
# (copiar template de cima)

# 4. Add ao git
git add .claude/
git commit -m "chore: add Claude Code configuration"
```

### ✓ Checklist antes de "Vou usar Claude Code":

- [ ] .claude/CLAUDE.md completo
- [ ] .claude/settings.json com permissões corretas
- [ ] .claude/rules/ com 2-3 rules principais
- [ ] .claude/commands/ com 2-3 commands úteis
- [ ] Testou um workflow simples
- [ ] Documentou no README do projeto

---

**Próxima leitura:** `CLAUDE_CODE_COMPREHENSIVE_GUIDE.md` para referência completa.

Última Atualização: Março 2026
