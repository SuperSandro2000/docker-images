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

# shellcheck disable=SC2043
for arch in amd64; do
  version=$($DOCKER run --rm -it supersandro2000/code-server:$arch-latest coder-server -v | awk -F'/| ' '{ print $2 }')
  $DOCKER tag supersandro2000/code-server:$arch-latest supersandro2000/code-server:"$arch-$version"
  retry "$DOCKER push supersandro2000/code-server:$arch-$version"
  sleep 3
  retry "$DOCKER push supersandro2000/code-server:$arch-latest"
  sleep 3
  printf "supersandro2000/code-server:%s-%s " "$arch" "$version" >>manifest
  printf "supersandro2000/code-server:%s-latest " "$arch" >>manifest_latest
done

# shellcheck disable=SC2046
$DOCKER manifest create supersandro2000/code-server:"$version" $(head -n 1 manifest)
# shellcheck disable=SC2046
$DOCKER manifest create supersandro2000/code-server:latest $(head -n 1 manifest_latest)
$DOCKER manifest annotate supersandro2000/code-server:"$version" supersandro2000/code-server:"amd64-$version" --os linux --arch amd64
$DOCKER manifest annotate supersandro2000/code-server:latest supersandro2000/code-server:amd64-latest --os linux --arch amd64
$DOCKER manifest annotate supersandro2000/code-server:"$version" supersandro2000/code-server:"arm64v8-$version" --os linux --arch arm64 --variant v8
$DOCKER manifest annotate supersandro2000/code-server:latest supersandro2000/code-server:arm64v8-latest --os linux --arch arm64 --variant v8

retry "$DOCKER manifest push supersandro2000/code-server:$version"
sleep 3
retry "$DOCKER manifest push supersandro2000/code-server:latest"
curl -X POST https://hooks.microbadger.com/images/supersandro2000/code-server/B9vzdMxCP5RYwUuPtaP61aOsM8E=
