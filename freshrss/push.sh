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

$DOCKER manifest create supersandro2000/freshrss:latest linuxserver/freshrss:latest lsioarmhf/freshrss:latest
$DOCKER manifest annotate supersandro2000/freshrss:latest linuxserver/freshrss:latest --os linux --arch amd64
$DOCKER manifest annotate supersandro2000/freshrss:latest lsioarmhf/freshrss:latest --os linux --arch arm --variant v7
retry "$DOCKER manifest push supersandro2000/freshrss:latest"
sleep 3
curl -X POST https://hooks.microbadger.com/images/supersandro2000/freshrss/qWB9w2lC-cl242-t40QutpRjdEo=
