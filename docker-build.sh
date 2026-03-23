#!/bin/bash

# AIOX Course Platform - Docker Build Script
# Usage: ./docker-build.sh [build|up|down|logs|clean]

set -e

PROJECT_NAME="aiox-course"
IMAGE_NAME="${PROJECT_NAME}-app"
CONTAINER_NAME="${PROJECT_NAME}-container"

echo "🚀 AIOX Course Platform - Docker Management"
echo "=========================================="

case "${1:-build}" in
  build)
    echo "📦 Building Docker image: $IMAGE_NAME"
    docker build -t $IMAGE_NAME:latest .
    echo "✅ Build complete!"
    echo ""
    echo "Next steps:"
    echo "  ./docker-build.sh up      - Start the container"
    echo "  ./docker-build.sh logs    - View logs"
    echo "  ./docker-build.sh down    - Stop the container"
    ;;

  up)
    echo "🐳 Starting Docker container..."
    docker-compose up -d
    sleep 3
    echo "✅ Container started!"
    echo ""
    echo "📱 Access the application:"
    echo "  🌐 Web: http://localhost:3000"
    echo "  📊 Bootcamp: http://localhost:3000/bootcamp"
    echo "  🎓 Mastery: http://localhost:3000/mastery"
    echo "  🚀 Projects: http://localhost:3000/projects"
    echo ""
    echo "📋 Container logs:"
    docker-compose logs --tail 10 app
    ;;

  down)
    echo "🛑 Stopping Docker container..."
    docker-compose down
    echo "✅ Container stopped!"
    ;;

  logs)
    echo "📋 Showing container logs..."
    docker-compose logs -f --tail 50 app
    ;;

  clean)
    echo "🧹 Cleaning up Docker resources..."
    docker-compose down -v
    docker rmi $IMAGE_NAME:latest || true
    echo "✅ Cleanup complete!"
    ;;

  test)
    echo "🧪 Testing application in container..."
    docker-compose exec -T app npm run type-check
    echo "✅ Type check passed!"
    ;;

  ps)
    echo "📦 Running containers:"
    docker-compose ps
    ;;

  *)
    echo "Usage: $0 {build|up|down|logs|clean|test|ps}"
    echo ""
    echo "Commands:"
    echo "  build  - Build Docker image"
    echo "  up     - Start container (after build)"
    echo "  down   - Stop container"
    echo "  logs   - View container logs"
    echo "  clean  - Remove image and containers"
    echo "  test   - Run type checks in container"
    echo "  ps     - Show running containers"
    exit 1
    ;;
esac
