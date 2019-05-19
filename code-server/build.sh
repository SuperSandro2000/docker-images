#!/bin/bash
set -eoux pipefail
DOCKER=$1

if [ -d zeronet-git ]; then
  git -C code-server-git pull -f
else
  git clone --depth 1 https://github.com/codercom/code-server.git code-server-git
fi

if [[ -n ${CI:-} && -n ${DOCKER_BUILDKIT:-} ]]; then
  ARG="--progress plain"
else
  ARG=
fi

# shellcheck disable=SC2043
for ARCH in amd64; do
  if [[ -z ${DOCKER_BUILDKIT:-} ]]; then
    ARGS="$ARG --cache-from supersandro2000/code-server:$ARCH-latest"
  else
    ARGS=
  fi

  $DOCKER build $ARGS \
    --build-arg GITHUB_TOKEN="$GITHUB_TOKEN" \
    --build-arg BUILD_DATE="$(date -u +"%Y-%m-%dT%H:%M:%SZ")" \
    --build-arg VCS_REF="$(git rev-parse --short HEAD)" \
    --build-arg VERSION="$(curl -s https://api.github.com/repos/cdr/code-server/releases?access_token="$GITHUB_TOKEN" | jq -r '.tag_name')" \
    -f $ARCH.Dockerfile -t supersandro2000/code-server:$ARCH-latest .
done
