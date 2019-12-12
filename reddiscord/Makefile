.DEFAULT_GOAL := all
MAKEFLAGS=--warn-undefined-variables
SHELL := /bin/bash

HOOK := https://hooks.microbadger.com/images/supersandro2000/reddiscord/CtjLg5fT78hv5M6mbobg3_1aqeE=
IMAGE := reddiscord
TAGS := stable source
VERSIONS := $(shell curl -Ls https://github.com/Cog-Creators/Red-DiscordBot/raw/V3/develop/redbot/__init__.py | grep -oP "(?<=__version__ = \")([0-9]+\.){2}[0-9]+") source

.ONESHELL: files/Lavalink.jar
files/Lavalink.jar:
	cd files
	curl -Lso Lavalink.jar "$$(curl -s https://api.github.com/repos/Frederikam/Lavalink/releases?access_token="${GITHUB_TOKEN}" | jq '[.[] | select(.assets[].name=="Lavalink.jar")][1] | .assets | .[0].browser_download_url' | tr -d \'\")"
	mkdir -p natives/linux-arm/
	cp libconnector.so natives/linux-arm/
	zip Lavalink.jar natives/linux-arm/libconnector.so
	rm -r natives/

build: files/Lavalink.jar

include ../buildx/Makefile
