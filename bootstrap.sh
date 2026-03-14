#!/bin/sh
set -e

echo "==> Bootstrapping Directus..."
npx directus bootstrap

echo "==> Applying limo schema..."
npx directus schema apply --yes /directus/snapshots/limo-schema.json || echo "Schema skipped"

echo "==> Starting Directus..."
npx directus start
