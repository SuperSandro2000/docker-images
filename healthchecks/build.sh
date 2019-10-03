#!/bin/bash
set -eoux pipefail
DOCKER=$1

if [ -d healthchecks-git ]; then
  git -C healthchecks-git pull -f
else
  git clone --depth 1 https://github.com/healthchecks/healthchecks.git healthchecks-git
fi

if [[ -n ${CI:-} && -n ${DOCKER_BUILDKIT:-} ]]; then
  ARG="--progress plain"
else
  ARG=
fi

if [[ -z ${DOCKER_BUILDKIT:-} ]]; then
  ARGS="$ARG --cache-from supersandro2000/healthchecks:latest"
else
  ARGS=
fi

$DOCKER build $ARGS --pull \
  --build-arg BUILD_DATE="$(date -u +"%Y-%m-%dT%H:%M:%SZ")" \
  --build-arg VERSION="$(cd healthchecks-git; git describe --tags "$(git rev-list --tags --max-count=1)")" \
  --build-arg REVISION="$(git rev-parse --short HEAD)" \
  -f Dockerfile -t supersandro2000/healthchecks:latest .
