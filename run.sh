#!/usr/bin/env bash
# Run the harness image interactively with a TTY, mounting the current directory at /workspace.
# Extra arguments are passed to the container's bash entrypoint.
set -euo pipefail

IMAGE="${IMAGE:-harness}"

if command -v container >/dev/null 2>&1; then
    runtime=container
elif command -v docker >/dev/null 2>&1; then
    runtime=docker
else
    echo "error: neither 'container' nor 'docker' found in PATH" >&2
    exit 1
fi

exec "$runtime" run --rm -it -v "$PWD:/workspace" "$IMAGE" "$@"
