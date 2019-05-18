#!/bin/bash
# shellcheck disable=SC2034
set -eoux pipefail

cd files
curl -Lso Lavalink.jar "$(curl -s https://api.github.com/repos/Cog-Creators/Red-DiscordBot/releases?access_token="$GITHUB_TOKEN" | jq '[.[] | select(.assets[].name=="Lavalink.jar")][1] | .assets | .[0].browser_download_url' | tr -d \'\")"
mkdir -p natives/linux-arm/
mv libconnector.so natives/linux-arm/
zip Lavalink.jar natives/linux-arm/libconnector.so
rm -r natives/
