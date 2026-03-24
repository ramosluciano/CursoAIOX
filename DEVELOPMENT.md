# Development Environment Setup

## Overview

This project uses Docker Compose for local development. The configuration runs a Next.js dev server in a containerized environment, closely matching the production setup.

## Prerequisites

- Docker Desktop (or Docker + Docker Compose v5+)
- Git

## Getting Started

### 1. Clone and Setup

```bash
# Clone the repository (if not already done)
git clone <repository>
cd CursoAIOX

# Copy environment file
cp .env.example .env
```

### 2. Start Development Environment

```bash
# Start development server in Docker (default configuration)
docker compose up -d

# View logs
docker compose logs -f app

# Or for production-like environment
docker compose -f docker-compose.prod.yml up -d
```

The application will be available at: **http://localhost:3000**

### 3. Development Workflow

#### Code Changes
- Make changes to source files in your editor
- The container watches for changes and hot-reloads automatically (thanks to volumes)
- No need to restart the container for code changes

#### Building
```bash
# Production build (inside container)
docker compose exec app npm run build
```

#### Linting & Type Checking
```bash
# Run lint
docker compose exec app npm run lint

# Run type check
docker compose exec app npm run type-check

# Run tests
docker compose exec app npm run test
```

### 4. Stop Development Server

```bash
# Stop containers
docker compose down

# Stop and remove volumes
docker compose down -v
```

## Configuration Files

### Development (Default)
- **docker-compose.yml** - Development configuration
- **Dockerfile.dev** - Development Docker image with hot reload support
- **NODE_ENV=development** - Runs `npm run dev`

Features:
- Hot reload on code changes
- Volume mounts for live development
- Fast iteration cycle

### Production
- **docker-compose.prod.yml** - Production configuration
- **Dockerfile** - Optimized production image (multi-stage build)
- **NODE_ENV=production** - Runs `npm start`

Features:
- Optimized for performance
- Minimal image size (node_modules excluded)
- Healthcheck configured

## Troubleshooting

### Port Already in Use
If port 3000 is already in use:
```bash
# Find process using port 3000
lsof -i :3000

# Kill the process
kill -9 <PID>

# Or change port in docker-compose.yml
# Change "3000:3000" to "3001:3000"
```

### Container Won't Start
```bash
# Remove old containers and images
docker compose down
docker image rm cursoaiox-app

# Rebuild from scratch
docker compose up -d --build
```

### View Container Logs
```bash
# Full logs
docker compose logs app

# Follow logs (live)
docker compose logs -f app

# Last 100 lines
docker compose logs app --tail 100
```

### Execute Commands in Container
```bash
# Run any npm command
docker compose exec app npm run <command>

# Access shell
docker compose exec app sh
```

## Environment Variables

Located in `.env` file. Key variables:

- `NODE_ENV=development` - Development mode (set in docker-compose.yml)
- `NEXT_PUBLIC_APP_URL=http://localhost:3000` - App URL for client-side use

## Docker Network

The application uses an internal Docker network (`aiox-network`) for service communication. This ensures isolation and allows services to communicate by container name.

## Performance Tips

1. **Hot Reload Issues**: If hot reload isn't working, check volumes in `docker-compose.yml`
2. **Slow Build**: First build takes time. Subsequent builds are cached.
3. **Memory Usage**: Adjust Docker's memory limits in Docker Desktop settings if needed

## Production Deployment

For production:

```bash
# Use production compose file
docker compose -f docker-compose.prod.yml up -d

# Or deploy to Vercel/Railway with Dockerfile
# (see deployment documentation)
```

## Additional Resources

- [Next.js Documentation](https://nextjs.org/docs)
- [Docker Documentation](https://docs.docker.com)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
