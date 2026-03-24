import fs from 'fs';
import path from 'path';

export interface LessonMeta {
  slug: string;
  title: string;
  course: 'basico-claude-code' | 'bootcamp' | 'mastery';
  module: number;
  lessonNumber: number;
  filePath: string;
  readingTimeMin: number;
}

export interface LessonContent extends LessonMeta {
  htmlContent: string;
  content: string;
  headings: Heading[];
}

export interface Heading {
  depth: number;
  text: string;
  anchor: string;
}

// Cache for lessons
let lessonsCache: Map<string, LessonMeta> | null = null;

/**
 * Loads all lessons from the filesystem
 */
export async function loadAllLessons(): Promise<LessonMeta[]> {
  if (lessonsCache) {
    return Array.from(lessonsCache.values());
  }

  const lessons: LessonMeta[] = [];
  const rootDir = path.join(process.cwd());

  // Load from Básico-Claude-Code directory
  const basicoDir = path.join(rootDir, 'Básico-Claude-Code');
  if (fs.existsSync(basicoDir)) {
    const basicoLessons = loadLessonsFromDir(basicoDir, 'basico-claude-code');
    lessons.push(...basicoLessons);
  }

  // Load from Bootcamp directory
  const bootcampDir = path.join(rootDir, 'Bootcamp');
  if (fs.existsSync(bootcampDir)) {
    const bootcampLessons = loadLessonsFromDir(bootcampDir, 'bootcamp');
    lessons.push(...bootcampLessons);
  }

  // Load from Mastery directory
  const masteryDir = path.join(rootDir, 'Mastery');
  if (fs.existsSync(masteryDir)) {
    const masteryLessons = loadLessonsFromDir(masteryDir, 'mastery');
    lessons.push(...masteryLessons);
  }

  // Sort by course and lesson number
  lessons.sort((a, b) => {
    const courseOrder = { 'basico-claude-code': 0, bootcamp: 1, mastery: 2 };
    if (courseOrder[a.course] !== courseOrder[b.course]) {
      return courseOrder[a.course] - courseOrder[b.course];
    }
    return a.lessonNumber - b.lessonNumber;
  });

  // Cache the results
  lessonsCache = new Map(lessons.map((lesson) => [lesson.slug, lesson]));

  return lessons;
}

/**
 * Loads lessons from a specific directory
 */
function loadLessonsFromDir(
  dir: string,
  course: 'basico-claude-code' | 'bootcamp' | 'mastery'
): LessonMeta[] {
  const lessons: LessonMeta[] = [];
  const files = fs.readdirSync(dir).filter((file) => file.endsWith('.md'));

  files.forEach((file, index) => {
    const filePath = path.join(dir, file);
    const content = fs.readFileSync(filePath, 'utf-8');

    const meta = parseMetadata(content, file, course, index + 1);
    if (meta) {
      lessons.push(meta);
    }
  });

  return lessons;
}

/**
 * Parses metadata from markdown content
 */
function parseMetadata(
  content: string,
  file: string,
  course: 'basico-claude-code' | 'bootcamp' | 'mastery',
  lessonNumber: number
): LessonMeta | null {
  try {
    // Extract metadata from HTML comment
    const metadataMatch = content.match(/<!--\s*metadata\n([\s\S]*?)\n-->/);
    let moduleNum = 1;

    if (metadataMatch) {
      const metadataStr = metadataMatch[1];
      const moduleMatch = metadataStr.match(/module:\s*(\d+)/);
      if (moduleMatch) {
        moduleNum = parseInt(moduleMatch[1], 10);
      }
    }

    // Extract title
    const titleMatch = content.match(/^#\s+(.+)$/m);
    const title = titleMatch
      ? titleMatch[1]
      : file.replace(/\.md$/, '').replace(/-/g, ' ');

    // Calculate reading time
    const wordCount = content.split(/\s+/).length;
    const readingTimeMin = Math.max(1, Math.ceil(wordCount / 200));

    // Create slug from filename
    const slug = file.replace(/\.md$/, '');

    return {
      slug,
      title,
      course,
      module: moduleNum,
      lessonNumber,
      filePath: path.join(process.cwd(), file),
      readingTimeMin,
    };
  } catch (error) {
    console.error(`Error parsing metadata for ${file}:`, error);
    return null;
  }
}

/**
 * Gets a specific lesson by slug
 */
export async function getLessonBySlug(
  slug: string
): Promise<LessonContent | null> {
  const allLessons = await loadAllLessons();
  const meta = allLessons.find((l) => l.slug === slug);

  if (!meta) {
    return null;
  }

  // Find the actual file
  const rootDir = process.cwd();
  const possiblePaths = [
    path.join(rootDir, 'Básico-Claude-Code', `${slug}.md`),
    path.join(rootDir, 'Bootcamp', `${slug}.md`),
    path.join(rootDir, 'Mastery', `${slug}.md`),
  ];

  for (const filePath of possiblePaths) {
    if (fs.existsSync(filePath)) {
      const content = fs.readFileSync(filePath, 'utf-8');
      const headings = extractHeadings(content);

      return {
        ...meta,
        content,
        htmlContent: '', // Will be populated by markdown processor
        headings,
      };
    }
  }

  return null;
}

/**
 * Gets all lessons for a specific course
 */
export async function getLessonsByCourse(
  course: 'basico-claude-code' | 'bootcamp' | 'mastery'
): Promise<LessonMeta[]> {
  const allLessons = await loadAllLessons();
  return allLessons.filter((l) => l.course === course);
}

/**
 * Extracts headings from markdown content
 */
function extractHeadings(content: string): Heading[] {
  const headings: Heading[] = [];
  const lines = content.split('\n');

  lines.forEach((line) => {
    const match = line.match(/^(#+)\s+(.+)$/);
    if (match) {
      const depth = match[1].length;
      const text = match[2];
      const anchor = slugifyHeading(text);

      headings.push({ depth, text, anchor });
    }
  });

  return headings;
}

/**
 * Converts heading text to URL-safe anchor
 */
function slugifyHeading(text: string): string {
  return text
    .toLowerCase()
    .replace(/[^\w\s-]/g, '')
    .replace(/\s+/g, '-')
    .replace(/^-+|-+$/g, '');
}

/**
 * Gets next and previous lessons for navigation
 */
export async function getAdjacentLessons(
  slug: string
): Promise<{ prev: LessonMeta | null; next: LessonMeta | null }> {
  const allLessons = await loadAllLessons();
  const currentIndex = allLessons.findIndex((l) => l.slug === slug);

  if (currentIndex === -1) {
    return { prev: null, next: null };
  }

  return {
    prev: currentIndex > 0 ? allLessons[currentIndex - 1] : null,
    next: currentIndex < allLessons.length - 1 ? allLessons[currentIndex + 1] : null,
  };
}
