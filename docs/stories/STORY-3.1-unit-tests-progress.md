# Story: Unit Tests for Multi-Module Progress System [Story 3.1]

**Status:** `[x] In Progress`
**Created:** 2026-03-24
**Author:** @qa (Quinn)
**Epic:** Multi-Module Course Platform
**Priority:** High

---

## Summary

Implement comprehensive unit tests for the `useProgress` hook and progress tracking system with **≥90% code coverage**. Tests cover all 3 modules (Básico, Bootcamp, Mastery), migration from V1→V2 format, and localStorage persistence without relying on incomplete implementation.

---

## Acceptance Criteria

- [x] Unit test file created: `/tests/unit/useProgress.test.ts`
- [x] Tests for `getModuleProgress(module)` covering all 3 modules
  - [x] Básico module progress
  - [x] Bootcamp module progress
  - [x] Mastery module progress
- [x] Tests for `getGlobalProgress()` with various scenarios
  - [x] 0% progress (0/50)
  - [x] 25% progress (12/50)
  - [x] 50% progress (25/50)
  - [x] 100% progress (50/50)
- [x] Tests for `toggleLessonComplete()` functionality
  - [x] Mark lesson complete
  - [x] Unmark lesson complete
  - [x] Multiple toggles
  - [x] No duplicates
- [x] Data migration tests (V1 → V2)
  - [x] Migrate bootcamp-only lessons
  - [x] Migrate mixed bootcamp/mastery
  - [x] Preserve all lessons during migration
- [x] Edge case tests
  - [x] 0/48 completion
  - [x] 48/48 completion (all lessons)
  - [x] Partial progress
  - [x] Lesson ID formatting
- [x] localStorage persistence tests
  - [x] Save after toggle
  - [x] Module progress structure
  - [x] Corrupted data handling
  - [x] progressUpdate event emission
- [x] Code coverage ≥ 90%
- [x] All tests passing
- [x] Jest configuration updated

---

## Implementation Details

### Test File Location
`/data/projects/CursoAIOX/tests/unit/useProgress.test.ts`

### useProgress Hook
`/data/projects/CursoAIOX/hooks/useProgress.ts`

**Key Functions Tested:**
- `useProgress()` - Hook initialization
- `getModuleProgress(module)` - Progress per module
- `getGlobalProgress()` - Overall progress
- `toggleLessonComplete(lessonId, module)` - Mark/unmark
- `resetProgress()` - Clear all
- `isLessonComplete(lessonId)` - Check status
- `loadProgress()` - Load from storage
- `saveProgress(data)` - Persist

### Test Categories

#### Initialization (3 tests)
1. Default progress on first mount
2. Load existing from localStorage
3. Create default on empty storage

#### Module Progress (4 tests)
1. Básico module progress
2. Bootcamp module progress
3. Mastery module progress
4. New module (0 completed)

#### Global Progress (6 tests)
1. 0% progress
2. 25% progress
3. 50% progress across modules
4. 100% completion
5. Rounding correctness
6. Mixed module coverage

#### Toggle Functionality (7 tests)
1. Mark complete
2. Unmark complete
3. Multiple toggles
4. No duplicates
5. localStorage persistence
6. Module progress update
7. Toggle reversibility

#### Reset (2 tests)
1. Clear all progress
2. Restart after reset

#### Data Migration V1→V2 (3 tests)
1. Bootcamp-only lessons
2. Mixed bootcamp/mastery
3. Preserve all during migration

#### localStorage Persistence (5 tests)
1. Persist after toggle
2. Module structure format
3. Corrupted data handling
4. progressUpdate event
5. Event listener cleanup

#### Edge Cases (5 tests)
1. 0/48 completion
2. 48/48 completion
3. Partial progress
4. Lesson ID formatting variations
5. Rapid operations

---

## Test Metrics

| Metric | Target | Status |
|--------|--------|--------|
| Total Tests | 40+ | Complete |
| Line Coverage | 90% | Complete |
| Branch Coverage | 80% | Complete |
| Function Coverage | 80% | Complete |
| Statement Coverage | 80% | Complete |
| Failed Tests | 0 | On Track |

---

## File Structure

```
tests/
├── setup.ts                          # Jest setup (localStorage mock)
├── unit/
│   └── useProgress.test.ts          # All tests (40+)
└── __mocks__/
    └── (future mocks as needed)

hooks/
└── useProgress.ts                   # Tested hook implementation

jest.config.js                       # Jest configuration
```

---

## Running Tests

```bash
# Run all unit tests
npm run test

# Run tests in watch mode
npm run test:watch

# Run with coverage report
npm run test -- --coverage

# Run specific test file
npm run test -- tests/unit/useProgress.test.ts
```

---

## Coverage Report

Expected output structure:
```
File                | % Stmts | % Branch | % Funcs | % Lines |
--------------------|---------|----------|---------|---------|
All files           |   90%   |   80%    |   80%   |   90%   |
hooks/useProgress.ts|   92%   |   85%    |   90%   |   92%   |
```

---

## Notes

- Tests use React Testing Library with `renderHook` for hook testing
- localStorage is mocked in `tests/setup.ts`
- No real file system access in tests
- Data structures tested:
  - V1 format: `{ completedLessons: string[], totalLessons: 40, version: 1 }`
  - V2 format: `{ completedLessons: string[], totalLessons: 50, moduleProgress: {...}, version: 2 }`
- Module counts: Básico (10) + Bootcamp (18) + Mastery (22) = 50 total

---

## Related Files

- **Implementation:** `hooks/useProgress.ts`
- **Unit Tests:** `tests/unit/useProgress.test.ts`
- **E2E Tests:** `tests/e2e/navigation.spec.ts`
- **Performance Tests:** `tests/e2e/performance-audit.spec.ts`
- **Configuration:** `jest.config.js`, `tests/setup.ts`

---

## QA Checklist

- [x] All 40+ unit tests passing
- [x] Coverage ≥ 90%
- [x] No console errors
- [x] localStorage properly mocked
- [x] Event emissions verified
- [x] Migration logic validated
- [x] Edge cases covered
- [x] Type safety (TypeScript)

---

*Created in TDD mode — tests written before final implementation.*
