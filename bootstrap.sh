#!/bin/sh
set -e

echo "==> Bootstrapping Directus..."
npx directus bootstrap

echo "==> Waiting for DB to be ready..."
sleep 3

echo "==> Applying limo schema..."
npx directus schema apply --yes /directus/snapshots/limo-schema.json
echo "==> Schema applied!"

echo "==> Starting Directus..."
npx directus start
