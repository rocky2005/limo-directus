#!/bin/sh
# bootstrap.sh — runs on Railway startup
# 1. Runs Directus DB bootstrap (creates tables, admin user)
# 2. Applies the limo schema snapshot
# 3. Starts Directus

set -e

echo "→ Bootstrapping Directus..."
npx directus bootstrap

echo "→ Applying limo schema snapshot..."
npx directus schema apply --yes ./snapshots/limo-schema.json || echo "Schema already applied or skipped"

echo "→ Starting Directus..."
npx directus start
