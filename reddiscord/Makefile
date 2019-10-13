.PHONY: all all-amd64 all-armhf all-arm64v8 all-source build build-amd64 build-armhf build-arm64v8 build-source clean clean2 manifest push push-login push-source
.RECIPEPREFIX +=
MAKEFLAGS=--warn-undefined-variables
SHELL := /bin/bash

DOCKER := "docker"

clean clean2:
  rm ~/.docker/manifests/docker.io_supersandro2000_reddiscord-* -rf
  rm manifest -f
  rm manifest_source -f

lavalink:
  ./lavalink.sh

build: clean lavalink
  ./build.sh ${DOCKER}

build-amd64: clean lavalink
  ./build.sh ${DOCKER} amd64

build-armhf: clean lavalink
  ./build.sh ${DOCKER} armhf

build-arm64v8: clean lavalink
  ./build.sh ${DOCKER} arm64v8

build-source: clean lavalink
  ./build-source.sh ${DOCKER}

push-login:
  if [ -n "$$CI" ]; then echo $$DOCKER_PASSWORD | $(DOCKER) login -u $$DOCKER_USERNAME --password-stdin; fi

push: push-login clean
  ./push.sh ${DOCKER}

push-source: push-login clean
  ./push-source.sh ${DOCKER}

manifest: clean push-login
  ./manifest.sh ${DOCKER}

all: build push clean2

all-amd64: build-amd64 push clean2

all-armhf: build-armhf push clean2

all-arm64v8: build-arm64v8 push clean2

all-source: build-source push-source clean2
