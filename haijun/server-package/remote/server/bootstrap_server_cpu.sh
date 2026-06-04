#!/usr/bin/env bash
set -euo pipefail

echo "== Haijun CPU-only server bootstrap =="
echo "This bootstrap only inspects and validates the server package."
echo "It does not download models, install GPU runtimes, or start training."
echo

bash remote/server/first_run_server.sh

echo "OK: CPU-only bootstrap checks completed."
