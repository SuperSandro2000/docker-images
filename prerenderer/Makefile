.DEFAULT_GOAL := all
.PHONY: all build build-amd64 build-armhf build-arm64 manifest push login
.RECIPEPREFIX +=
SHELL := /bin/bash

DOCKER := "docker"
VERSION := $(shell curl -s https://raw.githubusercontent.com/prerender/prerender/master/package.json | grep -oP "(?<= \"version\": \")[0-9]+")

build:
  ../lib/build.sh --binary ${DOCKER} --buildkit --tag prerenderer --verbose --version ${VERSION}

build-amd64:
  ../lib/build.sh --binary ${DOCKER} --buildkit --tag prerenderer --variant amd64 --verbose --version ${VERSION}

build-armhf:
  ../lib/build.sh --binary ${DOCKER} --buildkit --tag prerenderer --variant armhf --verbose --version ${VERSION}

build-arm64:
  ../lib/build.sh --binary ${DOCKER} --buildkit --tag prerenderer --variant arm64 --verbose --version ${VERSION}

login:
  if [ -n "$$CI" ]; then echo $$DOCKER_PASSWORD | $(DOCKER) login -u $$DOCKER_USERNAME --password-stdin; fi

manifest: login
  ../lib/manifest.sh --binary ${DOCKER} --image prerenderer --hook https://hooks.microbadger.com/images/supersandro2000/prerenderer/bwqaLj_bma7zIdwAwiK0CofjAnQ= --verbose --version ${VERSION}

push: login manifest
  ../lib/push.sh --binary ${DOCKER} --image prerenderer --hook https://hooks.microbadger.com/images/supersandro2000/prerenderer/bwqaLj_bma7zIdwAwiK0CofjAnQ= --manifest --verbose --version ${VERSION}

all: build push manifest
