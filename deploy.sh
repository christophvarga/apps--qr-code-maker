#!/bin/bash
# QR Code Maker Deployment Script
# Usage: ./deploy.sh [environment]
# Environments: prod (default), pre

set -euo pipefail

export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
export HOME="/Users/christophvarga"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

ENVIRONMENT="${1:-prod}"

echo "=== QR Code Maker Deploy ==="
echo "Environment: $ENVIRONMENT"

# Ensure web network exists
docker network create web 2>/dev/null || true

# Stop existing containers
docker compose down --remove-orphans 2>/dev/null || true

# Build and start
echo "Building and starting containers..."
docker compose up -d --build --force-recreate

# Wait and verify
echo "Waiting for containers to start..."
sleep 5

if docker compose ps | grep -q "Up\|running"; then
    echo "Containers are running"
else
    echo "ERROR: Containers failed to start"
    docker compose logs --tail=30
    exit 1
fi

# Diagnostics
echo ""
echo "Container state:"
docker compose ps
echo "Web network containers:"
docker network inspect web --format '{{range .Containers}}{{.Name}} {{end}}' 2>/dev/null || echo "(inspect failed)"

echo "=== Deploy complete ==="
echo "URL: https://qr.varga.media"
