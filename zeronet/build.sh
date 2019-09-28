#!/bin/bash
set -eoux pipefail
DOCKER=$1

if [[ -z ${VARIANT:-} ]]; then
  VARIANT=${2-}
fi

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

function build {
  arch=$1
  if [[ -z ${DOCKER_BUILDKIT:-} ]]; then
    ARGS="$ARG --cache-from supersandro2000/zeronet:$arch-latest"
  else
    ARGS=
  fi

  $DOCKER build $ARGS --pull \
    --build-arg BUILD_DATE="$(date -u +"%Y-%m-%dT%H:%M:%SZ")" \
    --build-arg VCS_REF="$(git rev-parse --short HEAD)" \
    --build-arg VERSION="$(git rev-parse --short HEAD)" \
    -f "$arch.Dockerfile" -t "supersandro2000/zeronet:$arch-latest" .
}

if [[ -n ${VARIANT:-} ]]; then
  build "$VARIANT"
else
  for arch in amd64 armhf arm64; do
    build "$arch"
  done
fi
