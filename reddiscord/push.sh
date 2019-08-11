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

version=$(curl -s https://api.github.com/repos/Cog-Creators/Red-DiscordBot/releases?access_token="${GITHUB_TOKEN}" | jq -r ".[0] | .tag_name")

for arch in amd64 arm32v7 arm64v8; do
  $DOCKER tag supersandro2000/reddiscord:$arch-latest supersandro2000/reddiscord:"$arch-$version"
  retry "$DOCKER push supersandro2000/reddiscord:$arch-$version"
  sleep 3
  retry "$DOCKER push supersandro2000/reddiscord:$arch-latest"
  sleep 3
done

curl -X POST https://hooks.microbadger.com/images/supersandro2000/reddiscord/CtjLg5fT78hv5M6mbobg3_1aqeE=
