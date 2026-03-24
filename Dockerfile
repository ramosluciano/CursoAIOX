# Build stage
FROM node:18-alpine AS builder

WORKDIR /app

# Install dependencies required for Prisma in Alpine
RUN apk add --no-cache libc6-compat openssl

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy source code
COPY . .

# Set build-time DATABASE_URL (dummy, used only for build)
ENV DATABASE_URL="postgresql://dummy:dummy@localhost:5432/dummy"

# Generate Prisma client
RUN npx prisma generate

# Build application
RUN npm run build

# Runtime stage
FROM node:18-alpine

WORKDIR /app

# Install dependencies required for Prisma in Alpine
RUN apk add --no-cache libc6-compat openssl

# Install dependencies (production only)
COPY package*.json ./
RUN npm ci --only=production

# Copy built application from builder
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/app ./app
COPY --from=builder /app/components ./components
COPY --from=builder /app/lib ./lib
COPY --from=builder /app/Básico-Claude-Code ./Básico-Claude-Code
COPY --from=builder /app/Bootcamp ./Bootcamp
COPY --from=builder /app/Mastery ./Mastery
COPY --from=builder /app/prisma ./prisma
COPY --from=builder /app/node_modules/.prisma ./node_modules/.prisma

# Expose port
EXPOSE 3000

# Start application
CMD ["npm", "start"]
