#!/bin/bash
set -eoux pipefail
DOCKER=$1

if [[ -n ${CI:-} && -n ${DOCKER_BUILDKIT:-} ]]; then
  ARG="--progress plain"
else
  ARG=
fi

for arch in amd64 armhf arm64v8; do
  if [[ -z ${DOCKER_BUILDKIT:-} ]]; then
    ARGS="$ARG --cache-from supersandro2000/reddiscord:$arch-source"
  else
    ARGS=
  fi

  # shellcheck disable=SC2086
  $DOCKER build $ARGS --pull \
    --build-arg BUILD_DATE="$(date -u +"%Y-%m-%dT%H:%M:%SZ")" \
    --build-arg VERSION="$(curl -s https://api.github.com/repos/Cog-Creators/Red-DiscordBot/commits/V3/develop?access_token=$GITHUB_TOKEN | jq -r '.sha')" \
    --build-arg REVISION="$(git rev-parse --short HEAD)" \
    -f $arch-source.Dockerfile -t supersandro2000/reddiscord:$arch-source .
done
