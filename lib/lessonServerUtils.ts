/**
 * Server-side utilities for lesson processing
 * Shared across all course modules
 */

import { marked } from 'marked';
import fs from 'fs';
import path from 'path';
import { CourseModule } from './courseModules';

/**
 * Extract title from markdown content
 */
export function extractTitle(content: string): string {
  const match = content.match(/^#\s+(.+)$/m);
  return match ? match[1] : 'Aula';
}

/**
 * Process markdown content for lesson page
 * - Converts to HTML
 * - Removes disabled attributes from checkboxes
 * - Removes h1 titles to prevent duplication
 */
export async function processMarkdownContent(filePath: string): Promise<string> {
  const content = fs.readFileSync(filePath, 'utf-8');
  let htmlContent = (await marked.parse(content)) as string;

  // Remove disabled attributes from checkboxes to make them interactive
  htmlContent = htmlContent.replace(
    /\s*\bdisabled(?:="")?(?=[\s/>])/g,
    ''
  );

  // Remove h1 titles from content to avoid duplication (title is shown in header)
  htmlContent = htmlContent.replace(/<h1[^>]*>.*?<\/h1>\s*/gi, '');

  return htmlContent;
}

/**
 * Get lesson file path for a module
 */
export function getLessonFilePath(
  module: CourseModule,
  lessonSlug: string
): string {
  return path.join(process.cwd(), module.filesDirectory, `${lessonSlug}.md`);
}

/**
 * Check if lesson file exists
 */
export function lessonFileExists(module: CourseModule, lessonSlug: string): boolean {
  return fs.existsSync(getLessonFilePath(module, lessonSlug));
}

/**
 * Get lesson navigation (previous and next)
 */
export function getLessonNavigation(
  lessons: string[],
  currentLessonSlug: string
): { prevLesson?: string; nextLesson?: string; lessonIndex: number } {
  const lessonIndex = lessons.indexOf(currentLessonSlug);

  return {
    lessonIndex,
    prevLesson: lessonIndex > 0 ? lessons[lessonIndex - 1] : undefined,
    nextLesson:
      lessonIndex < lessons.length - 1 ? lessons[lessonIndex + 1] : undefined,
  };
}
