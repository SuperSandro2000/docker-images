#!/bin/bash
set -eoux pipefail
DOCKER=$1

if [[ -n ${CI:-} && -n ${DOCKER_BUILDKIT:-} ]]; then
  ARG="--progress plain"
else
  ARG=
fi

git clone --depth=1 --recurse-submodules -j2 https://github.com/JustArchiNET/ArchiSteamFarm.git archisteamfarm-git
cd archisteamfarm-git

for variant in master released; do
  if [[ -z ${DOCKER_BUILDKIT:-} ]]; then
    ARGS="$ARG --cache-from supersandro2000/archisteamfarm:$variant-alpine"
  else
    ARGS=
  fi

  case $variant in
  "master")
    SHA="$(git rev-parse HEAD)"
    ;;
  "released")
    SHA=$(curl -s https://api.github.com/repos/JustArchiNET/ArchiSteamFarm/releases?access_token="$GITHUB_TOKEN" | jq -r '.[0].target_commitish')
    ;;
  "latest")
    SHA=$(curl -s https://api.github.com/repos/JustArchiNET/ArchiSteamFarm/releases/latest?access_token="$GITHUB_TOKEN" | jq -r '.target_commitish')
    ;;
  *)
    echo "Wrong variant!"
    exit 1
    ;;
  esac

  git fetch --depth 1 origin "$SHA"
  git checkout "$SHA"
  cp ../Dockerfile.x64.alpine .
  cp ../Dockerfile.Service.x64.alpine .

  # shellcheck disable=SC2086
  $DOCKER build $ARGS \
    --build-arg BUILD_DATE="$(date -u +"%Y-%m-%dT%H:%M:%SZ")" \
    --build-arg VCS_REF="$SHA" \
    --build-arg VERSION="$SHA" \
    -f Dockerfile.x64.alpine -t supersandro2000/archisteamfarm:"$variant-alpine" .
done
