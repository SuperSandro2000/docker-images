.DEFAULT_GOAL := all
.RECIPEPREFIX +=
MAKEFLAGS=--warn-undefined-variables
SHELL := /bin/bash

HOOK := https://hooks.microbadger.com/images/supersandro2000/base-alpine/bwqaLj_bma7zIdwAwiK0CofjAnQ=
IMAGE := base-alpine
TAGS := stable source
VERSIONS := $(shell curl -Ls https://github.com/Cog-Creators/Red-DiscordBot/raw/V3/develop/redbot/__init__.py | grep -oP "(?<=__version__ = \")([0-9]+\.){2}[0-9]+") source

include ../lib/Makefile

LAVALINK := files/Lavalink.jar

.PHONY: arm64-source arm64-stable armhf-source armhf-stable
arm64-source-build: $(LAVALINK)
arm64-stable-build: $(LAVALINK)
armhf-source-build: $(LAVALINK)
armhf-stable-build: $(LAVALINK)

files/Lavalink.jar:
  ./lavalink.sh
