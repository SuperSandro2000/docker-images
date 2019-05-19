#!/bin/bash
set -eoux pipefail
DOCKER=$1

if [ -d zeronet-git ]; then
  git -C zeronet-git pull -f
else
  git clone --depth 1 https://github.com/HelloZeroNet/ZeroNet.git zeronet-git
fi

if [[ -n ${CI:-} && -n ${DOCKER_BUILDKIT:-} ]]; then
  ARG="--progress plain"
else
  ARG=
fi

for arch in amd64 arm32v7 arm64v8; do
  if [[ -z ${DOCKER_BUILDKIT:-} ]]; then
    ARGS="$ARG --cache-from supersandro2000/zeronet:$arch-latest"
  else
    ARGS=
  fi
  
  $DOCKER build $ARGS \
    --build-arg BUILD_DATE="$(date -u +"%Y-%m-%dT%H:%M:%SZ")" \
    --build-arg VCS_REF="$(git rev-parse --short HEAD)" \
    --build-arg VERSION="$(git rev-parse --short HEAD)" \
    -f $arch.Dockerfile -t supersandro2000/zeronet:$arch-latest .
done
