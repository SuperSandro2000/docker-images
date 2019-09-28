#!/bin/bash
set -eoux pipefail
DOCKER=$1

if [[ -z ${VARIANT:-} ]]; then
  VARIANT=${2-}
fi

if [[ -n ${CI:-} && -n ${DOCKER_BUILDKIT:-} ]]; then
  ARG="--progress plain"
else
  ARG=
fi

function build {
  arch=$1
  if [[ -z ${DOCKER_BUILDKIT:-} ]]; then
    ARGS="$ARG --cache-from supersandro2000/reddiscord:$arch-latest"
  else
    ARGS=
  fi

  # shellcheck disable=SC2086
  $DOCKER build $ARGS --pull \
    --build-arg BUILD_DATE="$(date -u +"%Y-%m-%dT%H:%M:%SZ")" \
    --build-arg VCS_REF="$(git rev-parse --short HEAD)" \
    --build-arg VERSION="$(curl -s https://pypi.org/pypi/Red-DiscordBot/json | jq -r '.info.version')" \
    -f $arch.Dockerfile -t supersandro2000/reddiscord:$arch-latest .
}

if [[ -n ${VARIANT:-} ]]; then
  build "$VARIANT"
else
  for arch in amd64 armhf arm64v8; do
    build "$arch"
  done
fi
