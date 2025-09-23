#!/sbin/openrc-run
#!/usr/bin/env bash
set -euo pipefail

#######################################
# Stage 1: Build
#######################################
echo ">>> Stage 1: Installing dependencies and building Next.js app"

# Ensure pnpm is installed
if ! command -v pnpm &>/dev/null; then
  echo "Installing pnpm globally..."
  npm install -g pnpm
fi

# Copy package files
cp package.json pnpm-lock.yaml /tmp/app/
cd /tmp/app

# Install all dependencies (including devDependencies)
pnpm install

# Copy source code (assuming repo root is current dir)
rsync -a --exclude=node_modules --exclude=.next "$(pwd)/" /tmp/app/

# Copy Prisma schema
cp -r prisma /tmp/app/

# Generate Prisma client
npx prisma generate

# Build Next.js app
pnpm build

#######################################
# Stage 2: Runtime Setup
#######################################
echo ">>> Stage 2: Setting up runtime environment"

# Create runtime directory
RUNTIME_DIR=/source
mkdir -p "$RUNTIME_DIR"

# Copy only necessary files
cp package.json pnpm-lock.yaml "$RUNTIME_DIR/"
cp -r .next "$RUNTIME_DIR/"
cp -r public "$RUNTIME_DIR/"
cp -r prisma "$RUNTIME_DIR/"
cp .env.production "$RUNTIME_DIR/" 2>/dev/null || true

cd "$RUNTIME_DIR"

# Install production dependencies
pnpm install --prod

# Install dotenv-cli (if required for runtime env loading)
npm install -g dotenv-cli

# Generate Prisma client in production
npx prisma generate

# Fix permissions (simulate Docker non-root user `appuser`)
APPUSER=appuser
APPGROUP=appgroup
if ! id -u "$APPUSER" &>/dev/null; then
  sudo groupadd -r "$APPGROUP" || true
  sudo useradd -r -g "$APPGROUP" "$APPUSER" || true
fi
sudo chown -R "$APPUSER:$APPGROUP" "$RUNTIME_DIR/.next"

echo ">>> Runtime environment ready in $RUNTIME_D_
