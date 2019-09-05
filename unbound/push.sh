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

version=$($DOCKER run --rm -it supersandro2000/unbound:latest unbound | grep '(?<=Version )[0-9]{1,}\.[0-9]{1,}\.[0-9]{1,}')

$DOCKER tag supersandro2000/unbound:latest supersandro2000/unbound:"$version"
retry "$DOCKER push supersandro2000/unbound:$version"
sleep 3
retry "$DOCKER push supersandro2000/unbound:latest"

# curl -X POST https://hooks.microbadger.com/images/supersandro2000/unbound/SZHNRfRT-225bEYcHQCve7POsRs=
