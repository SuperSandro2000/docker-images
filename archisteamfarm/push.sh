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

for variant in master latest released \
  $(echo "$(curl -s https://api.github.com/repos/JustArchiNET/ArchiSteamFarm/releases?access_token="$GITHUB_TOKEN" | jq -r '.[0] | .tag_name')" \
    "$(curl -s https://api.github.com/repos/JustArchiNET/ArchiSteamFarm/releases/latest?access_token="$GITHUB_TOKEN" | jq -r '.tag_name')" | xargs -n 1 | sort -u | xargs); do

  $DOCKER manifest create supersandro2000/archisteamfarm:"$variant" justarchi/archisteamfarm:"$variant" justarchi/archisteamfarm:"$variant"-arm
  $DOCKER manifest annotate supersandro2000/archisteamfarm:"$variant" justarchi/archisteamfarm:"$variant" --os linux --arch amd64
  $DOCKER manifest annotate supersandro2000/archisteamfarm:"$variant" justarchi/archisteamfarm:"$variant"-arm --os linux --arch arm --variant v7

  retry "$DOCKER manifest push supersandro2000/archisteamfarm:$variant"
  sleep 3
done

curl -X POST https://hooks.microbadger.com/images/supersandro2000/archisteamfarm/uFaZZ9Eb73O7_EOTXqHxPQls45E=
