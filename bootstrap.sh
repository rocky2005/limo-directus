#!/bin/sh
set -e

echo "==> Bootstrapping Directus..."
node /directus/cli.js bootstrap

echo "==> Applying limo schema..."
node /directus/cli.js schema apply --yes ./snapshots/limo-schema.json || echo "Schema skipped"

echo "==> Starting Directus..."
node /directus/cli.js start
