# Quick Test Guide — Verify Everything Works ✅

**Time:** 5 minutes
**Status:** Application running on http://localhost:3000

---

## Step-by-Step Testing

### Test 1: Basico Module Button (The Main Fix) ⭐

1. **Open browser:** http://localhost:3000/basico-claude-code/aula-01-o-que-e-claude-code
2. **Scroll down** to find the button "Marcar como Concluída"
3. **Click the button** → should turn green and show "Concluída ✓"
4. **Check DevTools** (F12 → Application → Storage → Local Storage)
   - Should see `courseProgress` with key `basico-claude-code/aula-01-o-que-e-claude-code`
5. **Go back to dashboard:** http://localhost:3000/basico-claude-code
   - First lesson should have GREEN background (green-50)
   - Title should be strikethrough
   - CheckCircle icon should appear
6. **Open sidebar** → expand "Básico" section
   - First lesson should have strikethrough text
   - Should appear grayed out

✅ **All working?** → PASS

---

### Test 2: Bootcamp Module (Verify Still Works)

1. **Open:** http://localhost:3000/bootcamp/aula-01-setup-anatomia
2. **Click "Marcar como Concluída"** → button turns green ✓
3. **Dashboard:** http://localhost:3000/bootcamp
   - First lesson should have AIOX-BLUE background
4. **Sidebar** → expand "Bootcamp"
   - First lesson should be strikethrough

✅ **All working?** → PASS

---

### Test 3: Mastery Module (Verify Still Works)

1. **Open:** http://localhost:3000/mastery/mastery-aula-01-internals
2. **Click "Marcar como Concluída"** → button turns green ✓
3. **Dashboard:** http://localhost:3000/mastery
   - First lesson should have PURPLE background
4. **Sidebar** → expand "Mastery"
   - First lesson should be strikethrough

✅ **All working?** → PASS

---

### Test 4: Checkboxes (Interactive)

1. **Open any lesson** with checkboxes (e.g., Basico aula 01)
2. **Look for checklist items** in the lesson content
3. **Click a checkbox** → should toggle on/off
4. **Try clicking again** → should toggle back
5. No error messages in console? ✓

✅ **Checkboxes interactive?** → PASS

---

### Test 5: No Duplicate Titles

1. **Open any lesson page** (e.g., http://localhost:3000/basico-claude-code/aula-01-o-que-e-claude-code)
2. **Look at page heading** → Should see ONE title at top
3. **Scroll through content** → Title should NOT appear again in the content area
4. **Check page source** (Ctrl+U or F12) → Only 1 `<h1>` tag

✅ **No duplicates?** → PASS

---

## Cross-Tab Synchronization Test (Advanced)

1. **Open two browser windows/tabs:**
   - Tab 1: Lesson page (http://localhost:3000/basico-claude-code/aula-02-setup-primeira-sessao)
   - Tab 2: Dashboard (http://localhost:3000/basico-claude-code)

2. **In Tab 1:** Click "Marcar como Concluída"
   - Button turns green immediately ✓

3. **In Tab 2:** Lesson card should update automatically
   - Should show green background
   - Should show strikethrough title
   - **Without refresh** ✓

✅ **Real-time sync working?** → PASS

---

## What Each Color Means

| Module | Color | Location |
|--------|-------|----------|
| **Basico** | 🟢 Green (green-50) | Completed lesson cards on dashboard |
| **Bootcamp** | 🔵 Blue (aiox-50) | Completed lesson cards on dashboard |
| **Mastery** | 🟣 Purple (purple-50) | Completed lesson cards on dashboard |

---

## Common Issues & Solutions

### Issue: Button doesn't show as clicked
**Solution:** Hard refresh browser (Ctrl+Shift+R) to clear cache

### Issue: Dashboard doesn't update
**Solution:**
- Check if you actually clicked the button (should turn green)
- Refresh dashboard page (F5)
- Check localStorage in DevTools

### Issue: Checkboxes won't click
**Solution:**
- Make sure you're clicking inside the checkbox
- Check DevTools console for errors
- Clear cache and reload

### Issue: Title appears twice
**Solution:**
- This is fixed and should not happen
- If it does, hard refresh browser (Ctrl+Shift+R)

---

## Success Criteria ✅

All tests pass when:

| Test | Expected Result | Status |
|------|-----------------|--------|
| Basico button works | Turns green, shows "Concluída ✓" | ✅ |
| Dashboard updates | Card turns green with checkmark | ✅ |
| Sidebar updates | Text strikethrough appears | ✅ |
| Checkboxes interactive | Can click and toggle | ✅ |
| No H1 duplicate | Only 1 title on page | ✅ |
| Real-time sync | Updates without refresh | ✅ |
| Bootcamp still works | All features intact | ✅ |
| Mastery still works | All features intact | ✅ |

---

## Quick Commands

```bash
# Check button renders in all modules
curl http://localhost:3000/basico-claude-code/aula-01-o-que-e-claude-code | grep "Marcar como"

# Verify checkboxes are interactive (no disabled attribute)
curl http://localhost:3000/basico-claude-code/aula-01-o-que-e-claude-code | grep -c 'disabled.*checkbox'
# Should return: 0

# Verify no H1 duplication
curl http://localhost:3000/basico-claude-code/aula-01-o-que-e-claude-code | grep -o '<h1' | wc -l
# Should return: 1
```

---

## Summary

If all tests in this guide PASS, then:
✅ **All UX improvements are working**
✅ **Basico module is fully functional**
✅ **All 3 modules are standardized**
✅ **Ready for production**

**Time estimate:** 5 minutes to complete all tests

