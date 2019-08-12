#!/bin/bash
# shellcheck disable=SC2034
set -eoux pipefail
DOCKER=$1
export DOCKER_CLI_EXPERIMENTAL=enabled

retry() {
  for i in {1..5}; do
    if [ "$(eval "$1")" ]; then
      break
    else
      sleep 10
    fi
  done
}

version=$($DOCKER run --rm -it supersandro2000/zeronet:amd64-latest python3 -c "from src.Config import Config;c=Config(help);print(str(c.version) + \"-r\" + str(c.rev))" | rev | cut -c 2- | rev)

for arch in amd64 arm32v7 arm64v8; do
  printf "supersandro2000/zeronet:%s-%s " "$arch" "$version" >>manifest
  printf "supersandro2000/zeronet:%s-latest " "$arch" >>manifest_latest
done

# shellcheck disable=SC2046
$DOCKER manifest create supersandro2000/zeronet:"$version" $(head -n 1 manifest)
# shellcheck disable=SC2046
$DOCKER manifest create supersandro2000/zeronet:latest $(head -n 1 manifest_latest)
$DOCKER manifest annotate supersandro2000/zeronet:"$version" supersandro2000/zeronet:amd64-"$version" --os linux --arch amd64
$DOCKER manifest annotate supersandro2000/zeronet:"$version" supersandro2000/zeronet:arm32v7-"$version" --os linux --arch arm --variant v7
$DOCKER manifest annotate supersandro2000/zeronet:"$version" supersandro2000/zeronet:arm64v8-"$version" --os linux --arch arm64 --variant v8
$DOCKER manifest annotate supersandro2000/zeronet:latest supersandro2000/zeronet:amd64-latest --os linux --arch amd64
$DOCKER manifest annotate supersandro2000/zeronet:latest supersandro2000/zeronet:arm32v7-latest --os linux --arch arm --variant v7
$DOCKER manifest annotate supersandro2000/zeronet:latest supersandro2000/zeronet:arm64v8-latest --os linux --arch arm64 --variant v8

retry "$DOCKER manifest push supersandro2000/zeronet:$version"
sleep 3
retry "$DOCKER manifest push supersandro2000/zeronet:latest"

curl -X POST https://hooks.microbadger.com/images/supersandro2000/zeronet/B9vzdMxCP5RYwUuPtaP61aOsM8E=
