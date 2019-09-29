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

version=$($DOCKER run --rm -t supersandro2000/unbound:latest /app/manage.py version 2>/dev/null)

$DOCKER tag supersandro2000/healthchecks:latest supersandro2000/healthchecks:"$version"
retry "$DOCKER push supersandro2000/healthchecks:$version"
sleep 3
retry "$DOCKER push supersandro2000/healthchecks:latest"

#curl -X POST https://hooks.microbadger.com/images/supersandro2000/healthchecks/4cxdD8N2iomewH1V7PBYGIWYvRk=
