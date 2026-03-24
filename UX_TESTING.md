# UX Testing Guide - Lesson Completion Features

This guide helps you verify that all UX improvements have been correctly implemented across all three course modules (Básico Claude Code, Bootcamp, and Mastery).

## ✅ Test Checklist

### 1. Dashboard Completion Markers

**For each module (Básico, Bootcamp, Mastery):**

1. Open the module dashboard (e.g., http://localhost:3000/basico-claude-code)
2. Look at the lesson cards
3. **Verify:**
   - ✅ Cards for non-completed lessons have white/neutral background
   - ✅ Cards for completed lessons have colored background:
     - Básico: green-50 (light green)
     - Bootcamp: aiox-50 (light blue)
     - Mastery: purple-50 (light purple)
   - ✅ Lesson titles show strikethrough for completed lessons
   - ✅ Checkmark icon appears next to completed lessons
   - ✅ Number badge shows correct color based on completion status

### 2. Sidebar Menu Strikethrough

**Test across all modules:**

1. Expand a module in the left sidebar
2. Scroll to a lesson marked as completed
3. **Verify:**
   - ✅ Text is struck through (line-through style)
   - ✅ Text color is gray (text-gray-500)
   - ✅ Background is subtle (bg-gray-200 or dark:bg-slate-700)
   - ✅ Checkmark icon appears next to completed lesson name

### 3. Mark as Completed Button (Lesson Page)

**For each module, on any lesson page:**

1. Navigate to a lesson (e.g., http://localhost:3000/basico-claude-code/aula-01-o-que-e-claude-code)
2. Scroll to the navigation section at the bottom
3. **Verify:**
   - ✅ Button shows "Marcar como Concluída" text
   - ✅ Button is clickable
   - ✅ Upon click, text changes to "Concluída ✓"
   - ✅ Button background changes to green

### 4. Checkbox Interactivity

**For each module, on any lesson page with checklists:**

1. Look for task lists in the lesson content
2. **Verify:**
   - ✅ Checkboxes are clickable (not disabled)
   - ✅ Checkboxes can be checked/unchecked
   - ✅ Checkbox state persists on page reload (optional - uses browser's default behavior)

### 5. Cross-Component Synchronization

**Test real-time updates:**

1. Open two browser windows/tabs:
   - Tab 1: Lesson page (http://localhost:3000/basico-claude-code/aula-01-...)
   - Tab 2: Module dashboard (http://localhost:3000/basico-claude-code)

2. In Tab 1, click "Marcar como Concluída"

3. **Verify:**
   - ✅ Tab 1 button shows "Concluída ✓" immediately
   - ✅ Tab 2 dashboard updates automatically to show completion markers
   - ✅ Tab 2 sidebar (if visible) updates to show strikethrough

### 6. No Duplicate H1 Titles

**For each lesson page:**

1. Open any lesson (e.g., http://localhost:3000/basico-claude-code/aula-01-...)
2. Look at the page heading
3. **Verify:**
   - ✅ Title appears once at the top (in the header section)
   - ✅ Title does NOT appear again in the lesson content area
   - ✅ No duplicate title visible anywhere on the page

### 7. Module-Specific Colors

**Verify color schemes per module:**

| Element | Básico | Bootcamp | Mastery |
|---------|--------|----------|---------|
| Dashboard header | text-green-700 | text-aiox-700 | text-aiox-600 |
| Card background (completed) | bg-green-50 | bg-aiox-50 | bg-purple-50 |
| Sidebar module button | text-green-700 | text-aiox-700 | text-aiox-600 |
| "Mark as Completed" button (completed) | bg-green-500 | bg-aiox-purple | varies |

## 🔧 Testing Different Scenarios

### Scenario 1: Fresh User
1. Clear browser cache/localStorage
2. Open http://localhost:3000/basico-claude-code
3. Verify: No lessons show as completed (all white cards)
4. Go to first lesson and mark as completed
5. Return to dashboard
6. Verify: First lesson card now shows completion markers

### Scenario 2: Multiple Completions
1. Mark 3-4 different lessons as completed across the module
2. Refresh the page
3. Verify: All marked lessons still show completion (localStorage persists)
4. Verify: Sidebar also shows all marked lessons with strikethrough

### Scenario 3: Cross-Module Navigation
1. Mark lessons as complete in Basico
2. Switch to Bootcamp and mark some lessons complete
3. Return to Basico
4. Verify: Basico lessons still show your completions (each module tracks separately)

## 📊 Component Architecture

The implementation uses a shared hook for consistency:

```typescript
// All dashboard pages use this hook
const { completedLessons, isMounted } = useLessonCompletion();

// Storage key format (consistent across all components):
// ${module}/${lessonSlug}
// Example: basico-claude-code/aula-01-o-que-e-claude-code
```

## ⚠️ Known Limitations

- Checkbox state in lesson content uses browser's default behavior (not persisted)
- Progress is stored in browser localStorage (not synced to server)
- Clearing browser cache will reset all progress

## 🐛 Troubleshooting

### Completion not persisting
1. Check browser console for errors
2. Verify localStorage is enabled in browser
3. Try clearing cache and refreshing

### Sidebar not updating
1. Make sure you see the module expanded in the sidebar
2. Try refreshing the page
3. Check that the lesson slug in sidebar matches the stored key format

### Checkboxes not interactive
1. Open browser DevTools (F12)
2. Search for `<input type="checkbox"`
3. Verify it does NOT have a `disabled` attribute
4. If it does, the markdown processing regex is not working correctly

## ✅ All Tests Pass When

- [x] Dashboard cards show correct colors for completed lessons
- [x] Sidebar lessons show strikethrough text when completed
- [x] Mark as Completed button works on lesson pages
- [x] Checkboxes in lesson content are clickable
- [x] Updates sync across tabs/windows in real-time
- [x] No duplicate H1 titles appear on lesson pages
- [x] Progress persists after page reload
