#!/usr/bin/env bash
#
# Start the Adminer theme dev environment in the foreground.
# Downloads the Northwind seed on first run. Ctrl-C stops everything and
# removes containers, networks and volumes.

set -euo pipefail

cd "$(dirname "$0")"

SEED_URL="https://raw.githubusercontent.com/pthom/northwind_psql/refs/heads/master/northwind.sql"
SEED_FILE="seed/northwind.sql"

if [ ! -s "$SEED_FILE" ]; then
	echo "Downloading Northwind seed to $SEED_FILE ..."
	mkdir -p seed
	curl -fsSL "$SEED_URL" -o "$SEED_FILE.tmp"
	mv "$SEED_FILE.tmp" "$SEED_FILE"
fi

cleanup() {
	trap - EXIT INT TERM
	echo "Shutting down ..."
	docker compose down -v
}

trap cleanup EXIT INT TERM

docker compose up
