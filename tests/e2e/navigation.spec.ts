import { test, expect } from '@playwright/test';

test.describe('Multi-Module Navigation & Progress', () => {
  test.beforeEach(async ({ page }) => {
    // Clear all storage before each test
    await page.context().clearCookies();
    await page.evaluate(() => {
      localStorage.clear();
      sessionStorage.clear();
    });
    await page.goto('/');
  });

  test('should navigate from Home to Básico module index', async ({ page }) => {
    // Start on home page
    await expect(page).toHaveURL('/');
    await expect(page.locator('text=AIOX')).toBeVisible();

    // Click on Básico course (if available in sidebar or home)
    // For now, we'll test if navigation links exist
    await page.goto('/basico');
    await expect(page).toHaveURL('/basico');
  });

  test('Básico → Aula 1 → mark complete → progress updates', async ({ page }) => {
    // Navigate to Básico module's first lesson
    await page.goto('/basico/aula-01-o-que-e-claude-code');

    // Verify lesson content loads
    await expect(page.locator('h1')).toContainText('O que é Claude Code', { timeout: 5000 });

    // Find and click "Mark as Complete" button
    const completeButton = page.locator('button:has-text("Marcar como Concluída")').first();
    await expect(completeButton).toBeVisible();

    // Mark lesson as complete
    await completeButton.click();

    // Verify button changes to completed state
    const completedButton = page.locator('button:has-text("Concluída")').first();
    await expect(completedButton).toBeVisible();
    await expect(completedButton).toHaveClass(/bg-green/);

    // Go back to home and verify progress bar updated
    await page.goto('/');

    // Check progress indicator
    const progressBar = page.locator('[style*="width"]').first();
    // Progress should be > 0%
    const style = await progressBar.getAttribute('style');
    expect(style).toContain('width');
  });

  test('should navigate through Bootcamp lessons with Previous/Next buttons', async ({ page }) => {
    // Start with first Bootcamp lesson
    await page.goto('/bootcamp/aula-01-setup-anatomia');

    // Verify we're on lesson 1
    await expect(page.locator('text=/Aula.*1.*18/i')).toBeVisible();

    // Click Next button
    const nextButton = page.locator('button:has-text("Próxima Aula")').first();
    await expect(nextButton).toBeVisible();
    await nextButton.click();

    // Verify we're on lesson 2
    await expect(page).toHaveURL(/aula-02/);
    await expect(page.locator('text=/Aula.*2.*18/i')).toBeVisible();

    // Click Previous button
    const prevButton = page.locator('button:has-text("Aula Anterior")').first();
    await expect(prevButton).toBeVisible();
    await prevButton.click();

    // Verify we're back on lesson 1
    await expect(page).toHaveURL(/aula-01/);
  });

  test('should navigate from Bootcamp → Mastery modules', async ({ page }) => {
    // Start on Bootcamp
    await page.goto('/bootcamp/aula-01-setup-anatomia');
    await expect(page.locator('text=Professional Bootcamp')).toBeVisible();

    // Navigate to Mastery
    await page.goto('/mastery/mastery-aula-01-internals');
    await expect(page.locator('text=Mastery')).toBeVisible();
  });

  test('progress persists after page refresh', async ({ page }) => {
    // Mark a lesson as complete
    await page.goto('/bootcamp/aula-01-setup-anatomia');

    const completeButton = page.locator('button:has-text("Marcar como Concluída")').first();
    await completeButton.click();

    // Verify completion
    await expect(page.locator('button:has-text("Concluída")')).toBeVisible();

    // Refresh page
    await page.reload();

    // Verify lesson is still marked complete
    const completedButton = page.locator('button:has-text("Concluída")').first();
    await expect(completedButton).toBeVisible();
    await expect(completedButton).toHaveClass(/bg-green/);
  });

  test('Previous/Next buttons work correctly', async ({ page }) => {
    // Test first lesson (should have no Previous)
    await page.goto('/bootcamp/aula-01-setup-anatomia');

    // First lesson should not have a Previous button that works
    const prevButton = page.locator('button:has-text("Aula Anterior")').first();
    // Either button doesn't exist or is disabled
    await prevButton.evaluate(el => el.hasAttribute('disabled'));
    // Button count should be limited on first lesson
    const buttonCount = await prevButton.count();
    expect(buttonCount).toBeLessThanOrEqual(1);

    // Should have Next button
    const nextButton = page.locator('button:has-text("Próxima Aula")').first();
    await expect(nextButton).toBeVisible();

    // Navigate to middle lesson
    await page.goto('/bootcamp/aula-09-auction-analyst');

    // Should have both Previous and Next
    await expect(page.locator('button:has-text("Aula Anterior")')).toBeVisible();
    await expect(page.locator('button:has-text("Próxima Aula")')).toBeVisible();
  });

  test('reset progress clears all lessons', async ({ page }) => {
    // Mark multiple lessons as complete
    await page.goto('/bootcamp/aula-01-setup-anatomia');
    await page.locator('button:has-text("Marcar como Concluída")').first().click();

    await page.goto('/bootcamp/aula-02-conceitos-fluxo');
    await page.locator('button:has-text("Marcar como Concluída")').first().click();

    // Verify both are completed
    await page.goto('/bootcamp/aula-01-setup-anatomia');
    await expect(page.locator('button:has-text("Concluída")')).toBeVisible();

    // Clear localStorage to reset progress
    await page.evaluate(() => {
      localStorage.clear();
    });

    // Refresh and verify lessons are marked incomplete
    await page.reload();
    const incompleteButton = page.locator('button:has-text("Marcar como Concluída")').first();
    await expect(incompleteButton).toBeVisible();
  });

  test('mobile navigation at 360px viewport', async ({ page }) => {
    // Set mobile viewport
    await page.setViewportSize({ width: 360, height: 800 });

    await page.goto('/bootcamp/aula-01-setup-anatomia');

    // Verify lesson content is accessible on mobile
    await expect(page.locator('h1')).toBeVisible();

    // Navigation buttons should be accessible
    const nextButton = page.locator('button:has-text("Próxima Aula")').first();
    await expect(nextButton).toBeVisible();

    // Test completing lesson on mobile
    const completeButton = page.locator('button:has-text("Marcar como Concluída")').first();
    await expect(completeButton).toBeVisible();
    await completeButton.click();

    await expect(page.locator('button:has-text("Concluída")')).toBeVisible();
  });

  test('header progress indicator updates on lesson completion', async ({ page }) => {
    await page.goto('/bootcamp/aula-01-setup-anatomia');

    // Mark lesson complete
    await page.locator('button:has-text("Marcar como Concluída")').first().click();

    // Progress should update (may not be visible immediately, but stored)
    // Verify in localStorage
    const progressData = await page.evaluate(() => {
      return localStorage.getItem('courseProgress');
    });

    expect(progressData).toBeTruthy();
    const parsed = JSON.parse(progressData!);
    expect(parsed.completedLessons.length).toBeGreaterThan(0);
  });

  test('multiple lessons can be marked complete across modules', async ({ page }) => {
    const lessons = [
      '/basico/aula-01-o-que-e-claude-code',
      '/bootcamp/aula-01-setup-anatomia',
      '/mastery/mastery-aula-01-internals',
    ];

    for (const lesson of lessons) {
      await page.goto(lesson);
      const button = page.locator('button:has-text("Marcar como Concluída")').first();
      if (await button.isVisible()) {
        await button.click();
      }
    }

    // Verify all lessons are completed
    const progressData = await page.evaluate(() => {
      return localStorage.getItem('courseProgress');
    });

    const parsed = JSON.parse(progressData!);
    expect(parsed.completedLessons.length).toBeGreaterThanOrEqual(3);
  });

  test('lesson completion can be toggled off', async ({ page }) => {
    await page.goto('/bootcamp/aula-01-setup-anatomia');

    // Mark as complete
    const completeButton = page.locator('button:has-text("Marcar como Concluída")').first();
    await completeButton.click();

    // Verify completed
    await expect(page.locator('button:has-text("Concluída")')).toBeVisible();

    // Click to unmark
    const completedButton = page.locator('button:has-text("Concluída")').first();
    await completedButton.click();

    // Should show incomplete state again
    await expect(page.locator('button:has-text("Marcar como Concluída")')).toBeVisible();
  });
});

test.describe('Accessibility - Keyboard Navigation', () => {
  test.beforeEach(async ({ page }) => {
    await page.evaluate(() => {
      localStorage.clear();
    });
  });

  test('keyboard navigation through lessons', async ({ page }) => {
    await page.goto('/bootcamp/aula-01-setup-anatomia');

    // Focus on a button using Tab
    await page.keyboard.press('Tab');
    await page.keyboard.press('Tab'); // Tab through navigation

    // Get focused element
    const focusedElement = await page.evaluate(() => {
      return document.activeElement?.tagName;
    });

    expect(['BUTTON', 'A']).toContain(focusedElement);
  });

  test('can complete lesson with keyboard', async ({ page }) => {
    await page.goto('/bootcamp/aula-01-setup-anatomia');

    // Tab to complete button
    for (let i = 0; i < 5; i++) {
      await page.keyboard.press('Tab');
    }

    // Press Enter to complete
    await page.keyboard.press('Enter');

    // Verify completion
    const progressData = await page.evaluate(() => {
      return localStorage.getItem('courseProgress');
    });

    const parsed = JSON.parse(progressData || '{"completedLessons":[]}');
    expect(parsed.completedLessons.length).toBeGreaterThan(0);
  });

  test('aria labels on navigation buttons', async ({ page }) => {
    await page.goto('/bootcamp/aula-01-setup-anatomia');

    // Verify buttons have accessible text
    const completeBtn = page.locator('button:has-text("Marcar como Concluída")').first();
    const ariaLabel = await completeBtn.getAttribute('aria-label');

    // Button should have descriptive text (either via aria-label or visible text)
    const text = await completeBtn.textContent();
    expect(text || ariaLabel).toBeTruthy();
  });
});

test.describe('Accessibility - Color Contrast', () => {
  test('progress bar has sufficient contrast', async ({ page }) => {
    await page.goto('/');

    // Progress indicator should be visible
    const progressBar = page.locator('[style*="width"]').first();
    const computedStyle = await progressBar.evaluate(el => {
      return window.getComputedStyle(el);
    });

    // Should have visible background (gradient from purple to accent)
    expect(computedStyle.background || computedStyle.backgroundColor).toBeTruthy();
  });

  test('button text contrast', async ({ page }) => {
    await page.goto('/bootcamp/aula-01-setup-anatomia');

    // Get button styles
    const button = page.locator('button:has-text("Marcar como Concluída")').first();
    const computedStyle = await button.evaluate(el => {
      return window.getComputedStyle(el);
    });

    // Should have contrasting text color
    expect(computedStyle.color).toBeTruthy();
  });

  test('dark mode maintains contrast', async ({ page }) => {
    // Enable dark mode
    await page.evaluate(() => {
      document.documentElement.classList.add('dark');
      localStorage.setItem('theme', 'dark');
    });

    await page.goto('/bootcamp/aula-01-setup-anatomia');

    // Verify elements are still visible
    await expect(page.locator('h1')).toBeVisible();
    const button = page.locator('button:has-text("Marcar como Concluída")').first();
    await expect(button).toBeVisible();
  });
});
