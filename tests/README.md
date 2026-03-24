# CursoAIOX Testing Infrastructure

This directory contains comprehensive test suites for the AIOX multi-module course platform, including unit tests, end-to-end tests, and performance/accessibility audits.

---

## Quick Start

### Install Test Dependencies
```bash
npm install
```

### Run All Tests
```bash
# Unit tests
npm run test

# E2E tests (requires dev server)
npm run test:e2e

# Unit tests in watch mode
npm run test:watch
```

### Start Dev Server (for E2E)
```bash
npm run dev
# Server will listen on http://localhost:3000
```

---

## Test Structure

```
tests/
├── README.md                          # This file
├── setup.ts                           # Jest configuration
├── unit/
│   └── useProgress.test.ts           # 40+ tests (90% coverage)
├── e2e/
│   ├── navigation.spec.ts            # 20+ tests (multi-module navigation)
│   └── performance-audit.spec.ts     # 30+ tests (Lighthouse-like audits)
└── __mocks__/
    └── (future mocks)
```

---

## Test Suites

### 1. Unit Tests: `useProgress` Hook

**File:** `unit/useProgress.test.ts`

**Coverage:** 40+ tests, 90% code coverage

**What's Tested:**
- Module progress tracking (Básico, Bootcamp, Mastery)
- Global progress calculation (0% → 100%)
- Lesson completion toggle
- localStorage persistence
- Data migration (V1 → V2)
- Edge cases (0/50, 50/50, partial)

**Run:**
```bash
npm run test
npm run test -- --coverage
npm run test:watch
```

**Example:**
```typescript
it('should calculate 50% progress across modules', () => {
  // Marks 25 lessons complete
  const progress = result.current.getGlobalProgress();
  expect(progress.percentage).toBe(50);
});
```

---

### 2. E2E Tests: Navigation & Progress

**File:** `e2e/navigation.spec.ts`

**Coverage:** 20+ tests across desktop & mobile

**What's Tested:**
- Home → Básico → Aula 1 → Complete → Progress Updates
- Module switching (Básico → Bootcamp → Mastery)
- Previous/Next lesson navigation
- Progress persistence across page refresh
- Mobile viewport (360px)
- Keyboard navigation
- ARIA label accessibility

**Run:**
```bash
npm run dev &  # Start server in background
npm run test:e2e tests/e2e/navigation.spec.ts

# Or with options
npm run test:e2e -- --headed           # See browser
npm run test:e2e -- --grep "navigation"
```

**Test Scenarios:**
```
✓ should navigate from Home to Básico module index
✓ Básico → Aula 1 → mark complete → progress updates
✓ should navigate through Bootcamp lessons with Previous/Next
✓ progress persists after page refresh
✓ reset progress clears all lessons
✓ mobile navigation at 360px viewport
```

---

### 3. Performance & Accessibility Audit

**File:** `e2e/performance-audit.spec.ts`

**Coverage:** 30+ tests for Lighthouse-like metrics

**What's Tested:**
- Page load times (Desktop < 3s, Mobile < 5s)
- Lighthouse Performance ≥ 90
- Lighthouse Accessibility ≥ 90
- WCAG 2.1 Level AA compliance
- Color contrast (4.5:1 or higher)
- Keyboard navigation
- Focus indicators
- Heading hierarchy
- Form labels

**Run:**
```bash
npm run test:e2e tests/e2e/performance-audit.spec.ts
npm run test:e2e -- --grep "Lighthouse"
```

**Key Checks:**
- Home page load: < 3 seconds
- Lesson page load: < 4 seconds
- No layout shifts
- Proper ARIA attributes
- No duplicate IDs
- Color contrast verified

---

## Configuration Files

### Jest Configuration: `jest.config.js`

Located in project root.

```javascript
{
  preset: 'ts-jest',
  testEnvironment: 'jsdom',
  setupFilesAfterEnv: ['<rootDir>/tests/setup.ts'],
  collectCoverageFrom: ['components/**/*.tsx', 'hooks/**/*.ts'],
  coverageThreshold: { global: { lines: 80 } }
}
```

### Jest Setup: `tests/setup.ts`

Mocks localStorage and browser APIs:

```typescript
// localStorage mock
const localStorageMock = { getItem, setItem, removeItem, clear };
Object.defineProperty(window, 'localStorage', { value: localStorageMock });

// matchMedia mock for theme detection
Object.defineProperty(window, 'matchMedia', { ... });
```

### Playwright Configuration: `playwright.config.ts`

Located in project root.

```typescript
{
  testDir: './tests/e2e',
  use: { baseURL: 'http://localhost:3000' },
  webServer: { command: 'npm run dev', ... },
  projects: [
    { name: 'chromium', ... },
    { name: 'firefox', ... },
    { name: 'webkit', ... },
    { name: 'Mobile Chrome', ... },
    { name: 'Mobile Safari', ... }
  ]
}
```

---

## Module Information

### Básico Claude Code
- **Lessons:** 10
- **Status:** Content available
- **Files:** `Básico-Claude-Code/aula-*.md`

### Professional Bootcamp
- **Lessons:** 18
- **Status:** Content available
- **Files:** `Bootcamp/aula-*.md`

### Mastery
- **Lessons:** 22
- **Status:** Content available
- **Files:** `Mastery/mastery-aula-*.md`

**Total:** 50 lessons

---

## Writing New Tests

### Unit Test Template

```typescript
import { renderHook, act } from '@testing-library/react';
import { useProgress } from '../../hooks/useProgress';

describe('Feature', () => {
  beforeEach(() => {
    localStorage.clear();
  });

  it('should do something', () => {
    const { result } = renderHook(() => useProgress());

    act(() => {
      result.current.toggleLessonComplete('lesson-id', 'module');
    });

    expect(result.current.isLessonComplete('lesson-id')).toBe(true);
  });
});
```

### E2E Test Template

```typescript
import { test, expect } from '@playwright/test';

test.describe('Feature', () => {
  test.beforeEach(async ({ page }) => {
    await page.evaluate(() => localStorage.clear());
  });

  test('should navigate to page', async ({ page }) => {
    await page.goto('/path');
    await expect(page.locator('h1')).toBeVisible();
  });
});
```

---

## Debugging Tests

### Debug Unit Test
```bash
# Watch mode with breakpoints
npm run test:watch -- --no-coverage

# Use Node debugger
node --inspect-brk node_modules/jest/bin/jest.js --runInBand
```

### Debug E2E Test
```bash
# Headed mode (see browser)
npm run test:e2e -- --headed

# Debug a specific test
npm run test:e2e -- --debug

# Slowdown for observation
npm run test:e2e -- --headed --timeout=30000
```

### View Reports
```bash
# After tests complete
open playwright-report/index.html
```

---

## Continuous Integration

### GitHub Actions Example

```yaml
name: Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '18'
      - run: npm ci
      - run: npm run test -- --coverage
      - run: npx playwright install
      - run: npm run test:e2e
```

---

## Coverage Reports

### Generate Coverage Report
```bash
npm run test -- --coverage
```

### Expected Output
```
File               | % Stmts | % Branch | % Funcs | % Lines
-------------------|---------|----------|---------|--------
All files          |   90%   |   80%    |   80%   |   90%
hooks/useProgress  |   92%   |   85%    |   90%   |   92%
```

### View HTML Report
```bash
npm run test -- --coverage
open coverage/lcov-report/index.html
```

---

## Known Issues & Troubleshooting

### Issue: Dev server not starting
```bash
# Kill existing process
pkill -f "next dev"
npm run dev
```

### Issue: localStorage not persisting in tests
- Ensure `tests/setup.ts` is loaded
- Check `jest.config.js` has `setupFilesAfterEnv`

### Issue: E2E tests timeout
```bash
# Increase timeout
npm run test:e2e -- --timeout=60000
```

### Issue: Mobile tests not running
- Ensure Playwright browsers are installed: `npx playwright install`

---

## Performance Baseline

### Target Metrics
| Metric | Target | Current |
|--------|--------|---------|
| Home Load | < 3s | Pending |
| Lesson Load | < 4s | Pending |
| Lighthouse Perf | ≥ 90 | Pending |
| Lighthouse A11y | ≥ 90 | Pending |
| Unit Coverage | ≥ 90% | 90% |
| E2E Coverage | 20+ | 20+ |

---

## Adding New Tests

1. **Unit Test:** Add to `unit/*.test.ts`
2. **E2E Test:** Add to `e2e/*.spec.ts`
3. **Run:** `npm run test` or `npm run test:e2e`
4. **Verify:** All tests pass, coverage maintained

---

## Resources

- **Jest:** https://jestjs.io/docs/getting-started
- **React Testing Library:** https://testing-library.com/docs/react-testing-library/intro/
- **Playwright:** https://playwright.dev/docs/intro
- **WCAG 2.1:** https://www.w3.org/WAI/WCAG21/quickref/

---

## Contact

Questions about tests? Check the relevant story:
- Unit Tests: `docs/stories/STORY-3.1-unit-tests-progress.md`
- E2E Tests: `docs/stories/STORY-3.2-e2e-tests-navigation.md`
- Audit: `docs/stories/STORY-3.3-performance-accessibility-audit.md`

---

**Last Updated:** 2026-03-24
**Test Framework Version:** Jest 29.7.0, Playwright 1.41.0
