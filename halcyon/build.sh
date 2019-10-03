#!/bin/bash
set -eoux pipefail
DOCKER=$1

if [ -d halcyon-git ]; then
  git -C halcyon-git pull -f
else
  git clone --depth=1 https://notabug.org/halcyon-suite/halcyon.git halcyon-git
fi

if [[ -n ${CI:-} && -n ${DOCKER_BUILDKIT:-} ]]; then
  ARG="--progress plain"
else
  ARG=
fi

if [[ -z ${DOCKER_BUILDKIT:-} ]]; then
  ARGS="$ARG --cache-from supersandro2000/halcyon:latest"
else
  ARGS=
fi

$DOCKER build $ARGS --pull \
  --build-arg BUILD_DATE="$(date -u +"%Y-%m-%dT%H:%M:%SZ")" \
  --build-arg VERSION="$(cat halcyon-git/version.txt)" \
  --build-arg REVISION="$(git rev-parse --short HEAD)" \
  -f Dockerfile -t supersandro2000/halcyon:latest .
