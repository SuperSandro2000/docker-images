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
  $DOCKER tag "supersandro2000/zeronet:$arch-latest" supersandro2000/zeronet:"$arch-$version"
  retry "$DOCKER push supersandro2000/zeronet:$arch-$version"
  sleep 3
  retry "$DOCKER push supersandro2000/zeronet:$arch-latest"
  sleep 3
}

version=$($DOCKER run --rm -it supersandro2000/zeronet:amd64-latest python3 -c "from src.Config import Config;c=Config(help);print(str(c.version) + \"-r\" + str(c.rev))" | rev | cut -c 2- | rev)

if [[ -n ${VARIANT:-} ]]; then
  push "$VARIANT"
else
  for arch in amd64 armhf arm64v8; do
    push "$arch"
  done
fi

curl -X POST https://hooks.microbadger.com/images/supersandro2000/zeronet/B9vzdMxCP5RYwUuPtaP61aOsM8E=
