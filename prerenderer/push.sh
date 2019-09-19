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

version=$($DOCKER run --rm -t supersandro2000/prerenderer:latest node -p "require('./package.json').version")

$DOCKER tag supersandro2000/unbound:prerenderer supersandro2000/prerenderer:"$version"
retry "$DOCKER push supersandro2000/prerenderer:$version"
sleep 3
retry "$DOCKER push supersandro2000/prerenderer:latest"

# curl -X POST https://hooks.microbadger.com/images/supersandro2000/prerenderer/SZHNRfRT-225bEYcHQCve7POsRs=
