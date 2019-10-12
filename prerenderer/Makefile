.DEFAULT_GOAL := all
.PHONY: all build build-amd64 build-armhf build-arm64 manifest push login
.RECIPEPREFIX +=
SHELL := /bin/bash

DOCKER := "docker"
VERSION := $(shell curl -s https://raw.githubusercontent.com/prerender/prerender/master/package.json | grep -oP "(?<= \"version\": \")[0-9]+")

clean:

build: clean
  ../lib/build.sh --binary ${DOCKER} --buildkit --tag prerenderer --verbose --version ${VERSION}

build-amd64: clean
  ../lib/build.sh --binary ${DOCKER} --buildkit --tag prerenderer --variant amd64 --verbose --version ${VERSION}

build-armhf: clean
  ../lib/build.sh --binary ${DOCKER} --buildkit --tag prerenderer --variant armhf --verbose --version ${VERSION}

build-arm64: clean
  ../lib/build.sh --binary ${DOCKER} --buildkit --tag prerenderer --variant arm64 --verbose --version ${VERSION}

login:
  if [ -n "$$CI" ]; then echo $$DOCKER_PASSWORD | $(DOCKER) login -u $$DOCKER_USERNAME --password-stdin; fi

push: login
  ../lib/push.sh --binary ${DOCKER} --image prerenderer --hook https://hooks.microbadger.com/images/supersandro2000/prerenderer/bwqaLj_bma7zIdwAwiK0CofjAnQ= --verbose --version ${VERSION}

manifest: login
  ../lib/manifest.sh --binary ${DOCKER} --image prerenderer --hook https://hooks.microbadger.com/images/supersandro2000/prerenderer/bwqaLj_bma7zIdwAwiK0CofjAnQ= --verbose --version ${VERSION}

all: build push manifest
