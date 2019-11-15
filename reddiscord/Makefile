.DEFAULT_GOAL := all
.RECIPEPREFIX +=
MAKEFLAGS=--warn-undefined-variables
SHELL := /bin/bash

HOOK := https://hooks.microbadger.com/images/supersandro2000/base-alpine/bwqaLj_bma7zIdwAwiK0CofjAnQ=
IMAGE := base-alpine
TAGS := stable source
VERSIONS := $(shell curl -Ls https://github.com/Cog-Creators/Red-DiscordBot/raw/V3/develop/redbot/__init__.py | grep -oP "(?<=__version__ = \")([0-9]+\.){2}[0-9]+") source

%.Dockerfile: ../lib/templates/%-debian.Dockerfile.j2 Dockerfile.j2
  j2 $< -o $@

%-source.Dockerfile: ../lib/templates/%-debian.Dockerfile.j2  source.Dockerfile.j2
  j2 $< -o $@

include ../lib/Makefile

LAVALINK := files/Lavalink.jar

.PHONY: arm64-source arm64-stable armhf-source armhf-stable
arm64-source-build: $(LAVALINK)
arm64-stable-build: $(LAVALINK)
armhf-source-build: $(LAVALINK)
armhf-stable-build: $(LAVALINK)

files/Lavalink.jar:
  cd files
  curl -Lso Lavalink.jar "$(curl -s https://api.github.com/repos/Frederikam/Lavalink/releases?access_token="$GITHUB_TOKEN" | jq '[.[] | select(.assets[].name=="Lavalink.jar")][1] | .assets | .[0].browser_download_url' | tr -d \'\")"
  mkdir -p natives/linux-arm/
  cp libconnector.so natives/linux-arm/
  zip Lavalink.jar natives/linux-arm/libconnector.so
  rm -r natives/
