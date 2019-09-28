#!/bin/bash
set -eoux pipefail
DOCKER=$1

if [[ -n ${CI:-} && -n ${DOCKER_BUILDKIT:-} ]]; then
  ARG="--progress plain"
else
  ARG=
fi

if [[ -z ${DOCKER_BUILDKIT:-} ]]; then
  ARGS="$ARG --cache-from supersandro2000/prerenderer:latest"
else
  ARGS=
fi

$DOCKER build $ARGS --pull \
  --build-arg BUILD_DATE="$(date -u +"%Y-%m-%dT%H:%M:%SZ")" \
  --build-arg VCS_REF="$(git rev-parse --short HEAD)" \
  --build-arg VERSION="$(git rev-parse --short HEAD)" \
  -f Dockerfile -t supersandro2000/prerenderer:latest .
