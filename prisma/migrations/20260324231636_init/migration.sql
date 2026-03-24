-- CreateTable
CREATE TABLE "FeedbackCategory" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "description" TEXT,
    "color" TEXT NOT NULL DEFAULT 'gray',
    "icon" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "FeedbackCategory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Feedback" (
    "id" TEXT NOT NULL,
    "module" TEXT NOT NULL,
    "lesson" TEXT NOT NULL,
    "categoryId" TEXT NOT NULL,
    "text" TEXT NOT NULL,
    "userEmail" TEXT,
    "ipAddress" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Feedback_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FeedbackStats" (
    "id" TEXT NOT NULL,
    "module" TEXT NOT NULL,
    "lesson" TEXT NOT NULL,
    "categoryId" TEXT NOT NULL,
    "count" INTEGER NOT NULL DEFAULT 1,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "FeedbackStats_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "FeedbackCategory_name_key" ON "FeedbackCategory"("name");

-- CreateIndex
CREATE UNIQUE INDEX "FeedbackCategory_slug_key" ON "FeedbackCategory"("slug");

-- CreateIndex
CREATE INDEX "FeedbackCategory_slug_idx" ON "FeedbackCategory"("slug");

-- CreateIndex
CREATE INDEX "Feedback_module_idx" ON "Feedback"("module");

-- CreateIndex
CREATE INDEX "Feedback_lesson_idx" ON "Feedback"("lesson");

-- CreateIndex
CREATE INDEX "Feedback_categoryId_idx" ON "Feedback"("categoryId");

-- CreateIndex
CREATE INDEX "Feedback_createdAt_idx" ON "Feedback"("createdAt");

-- CreateIndex
CREATE INDEX "FeedbackStats_module_lesson_idx" ON "FeedbackStats"("module", "lesson");

-- CreateIndex
CREATE UNIQUE INDEX "FeedbackStats_module_lesson_categoryId_key" ON "FeedbackStats"("module", "lesson", "categoryId");

-- AddForeignKey
ALTER TABLE "Feedback" ADD CONSTRAINT "Feedback_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "FeedbackCategory"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FeedbackStats" ADD CONSTRAINT "FeedbackStats_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "FeedbackCategory"("id") ON DELETE CASCADE ON UPDATE CASCADE;
