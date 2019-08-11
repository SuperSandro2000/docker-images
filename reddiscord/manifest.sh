#!/bin/bash
set -eoux pipefail
DOCKER=$1
export DOCKER_CLI_EXPERIMENTAL=enabled

version=$(curl -s https://api.github.com/repos/Cog-Creators/Red-DiscordBot/releases?access_token="${GITHUB_TOKEN}" | jq -r ".[0] | .tag_name")

for arch in amd64 arm32v7 arm64v8; do
  printf "supersandro2000/reddiscord:%s-%s " "$arch" "$version" >>manifest
  printf "supersandro2000/reddiscord:%s-latest " "$arch" >>manifest_latest
  printf "supersandro2000/reddiscord:%s-source " "$arch" >>manifest_source
done

# shellcheck disable=SC2046
$DOCKER manifest create "supersandro2000/reddiscord:$version" $(head -n 1 manifest)
# shellcheck disable=SC2046
$DOCKER manifest create supersandro2000/reddiscord:latest $(head -n 1 manifest_latest)
# shellcheck disable=SC2046
$DOCKER manifest create supersandro2000/reddiscord:source $(head -n 1 manifest_source)
$DOCKER manifest annotate supersandro2000/reddiscord:"$version" supersandro2000/reddiscord:amd64-"$version" --os linux --arch amd64
$DOCKER manifest annotate supersandro2000/reddiscord:"$version" supersandro2000/reddiscord:arm32v7-"$version" --os linux --arch arm --variant v7
$DOCKER manifest annotate supersandro2000/reddiscord:"$version" supersandro2000/reddiscord:arm64v8-"$version" --os linux --arch arm64 --variant v8
$DOCKER manifest annotate supersandro2000/reddiscord:latest supersandro2000/reddiscord:amd64-latest --os linux --arch amd64
$DOCKER manifest annotate supersandro2000/reddiscord:latest supersandro2000/reddiscord:arm32v7-latest --os linux --arch arm --variant v7
$DOCKER manifest annotate supersandro2000/reddiscord:latest supersandro2000/reddiscord:arm64v8-latest --os linux --arch arm64 --variant v8
$DOCKER manifest annotate supersandro2000/reddiscord:source supersandro2000/reddiscord:amd64-source --os linux --arch amd64
$DOCKER manifest annotate supersandro2000/reddiscord:source supersandro2000/reddiscord:arm32v7-source --os linux --arch arm --variant v7
$DOCKER manifest annotate supersandro2000/reddiscord:source supersandro2000/reddiscord:arm64v8-source --os linux --arch arm64 --variant v8

retry "$DOCKER manifest push supersandro2000/reddiscord:$version"
sleep 3
retry "$DOCKER manifest push supersandro2000/reddiscord:latest"
sleep 3
retry "$DOCKER manifest push supersandro2000/reddiscord:source"

curl -X POST https://hooks.microbadger.com/images/supersandro2000/reddiscord/CtjLg5fT78hv5M6mbobg3_1aqeE=
