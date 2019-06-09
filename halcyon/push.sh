#!/bin/bash
# shellcheck disable=SC2034
set -eoux pipefail
DOCKER=$1

retry() {
  for i in {1..5}; do
    if [ "$(eval "$1")" ]; then
      break
    else
      sleep 10
    fi
  done
}

version=$($DOCKER run --rm -it supersandro2000/halcyon:latest cat version.txt | tr -d '\r')

$DOCKER tag supersandro2000/halcyon:latest supersandro2000/halcyon:"$version"
retry "$DOCKER push supersandro2000/halcyon:$version"
sleep 3
retry "$DOCKER push supersandro2000/halcyon:latest"

curl -X POST https://hooks.microbadger.com/images/supersandro2000/halcyon/rp5PBR5DxYGVZebsNNO91I-8894=
