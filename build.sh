#!/usr/bin/env bash
# Build the harness image using Apple's `container` CLI, falling back to Docker.
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

cd "$(dirname "$0")"
echo "Building $IMAGE with $runtime..."
exec "$runtime" build -t "$IMAGE" "$@" .
