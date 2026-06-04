#!/usr/bin/env bash
set -euo pipefail

PACKAGE_PATH="${1:-server-package}"
OUTPUT_TGZ="${2:-dist/haijun-server-package.tar.gz}"

cd "$(dirname "$0")/.."

bash scripts/build_server_package.sh "$PACKAGE_PATH"

mkdir -p "$(dirname "$OUTPUT_TGZ")"
rm -f "$OUTPUT_TGZ"

tar -czf "$OUTPUT_TGZ" -C "$PACKAGE_PATH" .

size="$(stat -c%s "$OUTPUT_TGZ" 2>/dev/null || stat -f%z "$OUTPUT_TGZ" 2>/dev/null || echo unknown)"
echo "OK: packed server package to $OUTPUT_TGZ ($size bytes)"

