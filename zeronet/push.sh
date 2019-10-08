#!/bin/bash
# shellcheck disable=SC2034
set -eoux pipefail
DOCKER=${*:-docker}

retry() {
  for i in {1..5}; do
    if [ "$(eval "$1")" ]; then
      break
    else
      sleep 10
    fi
  done
}

function push() {
  arch=$1
  mkdir -p tmp

  container=$($DOCKER create "supersandro2000/zeronet:$arch-latest")
  $DOCKER cp "$container:/app/src/Config.py" tmp
  $DOCKER rm -v "$container"
  version=$(grep -oP "(?<=self\.rev = )[0-9]+" tmp/Config.py)

  $DOCKER tag "supersandro2000/zeronet:$arch-latest" supersandro2000/zeronet:"$arch-$version"
  retry "$DOCKER push supersandro2000/zeronet:$arch-$version"
  sleep 3
  retry "$DOCKER push supersandro2000/zeronet:$arch-latest"
  sleep 3
}

if [[ -n ${VARIANT:-} ]]; then
  push "$VARIANT"
else
  for arch in amd64 armhf arm64; do
    push "$arch"
  done
fi

curl -X POST https://hooks.microbadger.com/images/supersandro2000/zeronet/B9vzdMxCP5RYwUuPtaP61aOsM8E=
