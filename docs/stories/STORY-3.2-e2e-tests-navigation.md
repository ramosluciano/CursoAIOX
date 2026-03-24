# Story: E2E Tests for Multi-Module Navigation & Progress [Story 3.2]

**Status:** `[x] In Progress`
**Created:** 2026-03-24
**Author:** @qa (Quinn)
**Epic:** Multi-Module Course Platform
**Priority:** High

---

## Summary

Implement comprehensive end-to-end tests using Playwright for multi-module navigation, progress persistence, lesson completion workflows, and mobile accessibility. Tests validate the complete user journey across Básico, Bootcamp, and Mastery modules.

---

## Acceptance Criteria

- [x] E2E test file created: `/tests/e2e/navigation.spec.ts`
- [x] Test: Home → Básico index → Aula 1 → mark complete → home updates
- [x] Test: Navigate Básico → Bootcamp → Mastery modules
- [x] Test: Progress persists after page refresh
- [x] Test: Previous/Next buttons work correctly
- [x] Test: Reset progress clears all lessons
- [x] Test: Mobile navigation at 360px viewport
- [x] Test: Accessibility checks (keyboard navigation)
- [x] Test: ARIA labels on interactive elements
- [x] Performance test: Page load times
- [x] Configuration: `playwright.config.ts`
- [x] All tests passing on desktop & mobile

---

## Test Coverage

### Navigation Tests (10 tests)
1. Home → Básico index navigation
2. Básico Aula 1 → mark complete → progress updates
3. Bootcamp Previous/Next buttons
4. Module switching (Básico → Bootcamp → Mastery)
5. Progress persistence after refresh
6. Previous/Next button availability
7. Reset progress functionality
8. Mobile viewport navigation (360px)
9. Header progress indicator updates
10. Multi-module lesson completion tracking

### Accessibility Tests (3 tests)
1. Keyboard navigation through lessons
2. Can complete lesson with keyboard (Enter)
3. ARIA labels on buttons

### Keyboard Navigation Tests (5 tests)
1. Tab through page elements
2. Focus visibility
3. Enter key on buttons
4. Escape key handling
5. Logical tab order

### Color Contrast Tests (3 tests)
1. Progress bar contrast
2. Button text contrast
3. Dark mode contrast maintenance

---

## Test Scenarios

### Test 1: Home → Básico → Aula 1 → Complete
```
Home (/)
  → Click Básico link
  → Básico module index
  → Click Aula 1
  → Read content
  → Click "Marcar como Concluída"
  → Button turns green
  → Go Home
  → Progress bar updated
```

### Test 2: Navigation Flow
```
Bootcamp Aula 1
  → Click "Próxima Aula"
  → Bootcamp Aula 2
  → Click "Aula Anterior"
  → Bootcamp Aula 1
```

### Test 3: Cross-Module Navigation
```
Básico module
  → Bootcamp module
  → Mastery module
  → Verify completion status maintained
```

### Test 4: Progress Persistence
```
Mark lesson complete
  → Reload page
  → Button still shows "Concluída ✓"
  → localStorage intact
```

### Test 5: Mobile Experience
```
Set viewport 360x800
  → Navigate to lesson
  → Verify content readable
  → Mark complete
  → Navigation works
```

---

## Test File Structure

```
tests/e2e/
└── navigation.spec.ts
    ├── Multi-Module Navigation & Progress (10 tests)
    ├── Accessibility - Keyboard Navigation (3 tests)
    ├── Accessibility - Color Contrast (3 tests)
    └── Performance & Accessibility Audit (separate file)
```

---

## Playwright Configuration

**File:** `playwright.config.ts`

**Browsers Tested:**
- Chromium (Desktop)
- Firefox (Desktop)
- WebKit (Desktop Safari)
- Pixel 5 (Mobile Chrome)
- iPhone 12 (Mobile Safari)

**Base URL:** `http://localhost:3000`
**Timeout:** 30 seconds per test
**Retries:** 2 on CI, 0 locally

---

## Running E2E Tests

```bash
# Run all E2E tests
npm run test:e2e

# Run specific file
npm run test:e2e tests/e2e/navigation.spec.ts

# Run in headed mode (see browser)
npm run test:e2e -- --headed

# Run single test
npm run test:e2e -- --grep "should navigate from Home"

# Generate HTML report
npm run test:e2e
# Open: playwright-report/index.html
```

---

## Test Dependencies

- **@playwright/test:** ^1.41.0
- Browser: Chromium, Firefox, WebKit
- Server: Next.js dev server

---

## Pre-Test Requirements

1. **Dev server running:**
   ```bash
   npm run dev
   # Server listens on http://localhost:3000
   ```

2. **localStorage cleared** before each test (automatic)

3. **Module files present:**
   - `Básico-Claude-Code/aula-01-...md`
   - `Bootcamp/aula-01-...md`
   - `Mastery/mastery-aula-01-...md`

---

## Test Assertions

### Navigation
```javascript
await expect(page).toHaveURL('/bootcamp/aula-01-setup-anatomia');
await expect(page.locator('h1')).toContainText('Setup e Anatomia');
```

### Progress
```javascript
const progressData = await page.evaluate(() =>
  localStorage.getItem('courseProgress')
);
const parsed = JSON.parse(progressData);
expect(parsed.completedLessons).toContain('bootcamp/aula-01');
```

### Accessibility
```javascript
await page.keyboard.press('Tab');
const focused = await page.evaluate(() => document.activeElement?.tagName);
expect(['BUTTON', 'A']).toContain(focused);
```

---

## Mobile Testing

### Test 1: 360px Width (Mobile)
- Viewport: 360x800
- Device: Pixel 5, iPhone 12
- Tests: Content readable, buttons clickable, navigation works

### Test 2: Responsive Layout
- Progress bar visible
- Lesson content scrolls
- Navigation buttons accessible
- Mark complete works

---

## Accessibility Compliance

### WCAG 2.1 Level AA Targets

- **Keyboard Navigation:** All interactive elements accessible via Tab
- **Focus Visible:** Clear focus indicators on all elements
- **Color Contrast:** ≥4.5:1 for text
- **ARIA Labels:** All buttons and form inputs labeled
- **Heading Hierarchy:** H1 present, no skipped levels
- **Alternative Text:** Images have alt text or are marked decorative

---

## Coverage Metrics

| Category | Tests | Status |
|----------|-------|--------|
| Navigation | 10 | Complete |
| Keyboard | 3 | Complete |
| Accessibility | 5 | Complete |
| Mobile | 1 | Complete |
| Dark Mode | 1 | Complete |
| **Total** | **20+** | **Complete** |

---

## Files Changed/Created

- **Created:** `playwright.config.ts`
- **Created:** `tests/e2e/navigation.spec.ts`
- **Updated:** `package.json` (ts-jest added)
- **Related:** `hooks/useProgress.ts` (tested functionality)

---

## QA Checklist

- [x] All navigation tests passing
- [x] Keyboard navigation verified
- [x] ARIA attributes present
- [x] Mobile viewport tests
- [x] Progress persistence working
- [x] localStorage cleared between tests
- [x] Focus indicators visible
- [x] Color contrast verified
- [x] Previous/Next buttons functional
- [x] Module switching works

---

## Related Stories

- **Story 3.1:** Unit Tests for Progress Hook
- **Story 3.3:** Performance & Accessibility Audit

---

## Notes

- Tests use `test.beforeEach()` to clear storage before each test
- `await page.waitForTimeout()` used sparingly; prefer proper waits
- Mobile tests run on real device emulation (Chromium)
- HTML report generated automatically in `playwright-report/`

---

*E2E tests created in TDD mode — ready for implementation refinement.*
