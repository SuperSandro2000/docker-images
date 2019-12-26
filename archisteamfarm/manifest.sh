#!/usr/bin/env bash
set -eou pipefail
set -x

# shellcheck source=functions.sh source=lib/functions.sh disable=SC1091
source "$(dirname "$(realpath -s "$0")")/functions.sh"

sudo=$(docker_sudo)
export DOCKER_CLI_EXPERIMENTAL=enabled

$sudo rm ~/.docker/manifests/docker.io_supersandro2000_archisteamfarm-* -rf

# latest pre-release or release
release_version=$(curl -s https://api.github.com/repos/JustArchiNET/ArchiSteamFarm/releases?access_token="$GITHUB_TOKEN" | jq -r '.[0] | .tag_name')
# latest stable release
latest_version=$(curl -s https://api.github.com/repos/JustArchiNET/ArchiSteamFarm/releases/latest?access_token="$GITHUB_TOKEN" | jq -r '.tag_name')
version=$(echo "$release_version" "$latest_version" | xargs -n1 | sort -u | xargs)

for variant in latest released $version; do
  $sudo docker manifest create supersandro2000/archisteamfarm:"$variant" justarchi/archisteamfarm:"$variant" justarchi/archisteamfarm:"$variant"-arm
  $sudo docker manifest annotate supersandro2000/archisteamfarm:"$variant" justarchi/archisteamfarm:"$variant" --os linux --arch amd64
  $sudo docker manifest annotate supersandro2000/archisteamfarm:"$variant" justarchi/archisteamfarm:"$variant"-arm --os linux --arch arm --variant v7

  retry "$sudo docker manifest push supersandro2000/archisteamfarm:$variant"
  sleep 3
done

$sudo docker manifest create supersandro2000/archisteamfarm:alpine-latest justarchi/archisteamfarm:"$latest_version"
$sudo docker manifest annotate supersandro2000/archisteamfarm:alpine-latest justarchi/archisteamfarm:"$latest_version" --os linux --arch amd64

retry "$sudo docker manifest push supersandro2000/archisteamfarm:$variant"
sleep 3

curl -X POST https://hooks.microbadger.com/images/supersandro2000/archisteamfarm/uFaZZ9Eb73O7_EOTXqHxPQls45E=
