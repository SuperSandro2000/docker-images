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

version=$($DOCKER run --rm -it supersandro2000/kibitzr:amd64-latest kibitzr version | rev | cut -c 2- | rev)

for arch in amd64 armhf arm64; do
  $DOCKER tag supersandro2000/kibitzr:$arch-latest supersandro2000/kibitzr:"$arch-$version"
  retry "$DOCKER push supersandro2000/kibitzr:$arch-$version"
  sleep 3
  retry "$DOCKER push supersandro2000/kibitzr:$arch-latest"
  sleep 3
  printf "supersandro2000/kibitzr:%s-%s " "$arch" "$version" >>manifest
  printf "supersandro2000/kibitzr:%s-latest " "$arch" >>manifest_latest
done

# shellcheck disable=SC2046
$DOCKER manifest create supersandro2000/kibitzr:"$version" $(head -n 1 manifest)
# shellcheck disable=SC2046
$DOCKER manifest create supersandro2000/kibitzr:latest $(head -n 1 manifest_latest)
$DOCKER manifest annotate supersandro2000/kibitzr:"$version" supersandro2000/kibitzr:amd64-"$version" --os linux --arch amd64
$DOCKER manifest annotate supersandro2000/kibitzr:"$version" supersandro2000/kibitzr:armhf-"$version" --os linux --arch arm --variant v7
$DOCKER manifest annotate supersandro2000/kibitzr:"$version" supersandro2000/kibitzr:arm64v8-"$version" --os linux --arch arm64 --variant v8
$DOCKER manifest annotate supersandro2000/kibitzr:latest supersandro2000/kibitzr:amd64-latest --os linux --arch amd64
$DOCKER manifest annotate supersandro2000/kibitzr:latest supersandro2000/kibitzr:armhf-latest --os linux --arch arm --variant v7
$DOCKER manifest annotate supersandro2000/kibitzr:latest supersandro2000/kibitzr:arm64v8-latest --os linux --arch arm64 --variant v8

retry "$DOCKER manifest push supersandro2000/kibitzr:$version"
sleep 3
retry "$DOCKER manifest push supersandro2000/kibitzr:latest"
curl -X POST https://hooks.microbadger.com/images/supersandro2000/kibitzr/rp5PBR5DxYGVZebsNNO91I-8894=
