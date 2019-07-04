.PHONY: all all-source build build-source clean clean2 push push-login push-source 
.RECIPEPREFIX +=
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
  
build-arm32v7: clean lavalink
  ./build.sh ${DOCKER} arm32v7

build-amd64v8: clean lavalink
  ./build.sh ${DOCKER} amd64v8

build-source: clean lavalink
  ./build-source.sh ${DOCKER}

push-login:
  if [ -n "$$CI" ]; then echo $$DOCKER_PASSWORD | $(DOCKER) login -u $$DOCKER_USERNAME --password-stdin; fi

push: push-login clean
  ./push.sh ${DOCKER}

push-source: push-login clean
  ./push-source.sh ${DOCKER}

all: build push clean2

all-amd64: build-amd64 push clean2

all-arm32v7: build-arm32v7 push clean2

all-amd64v8: build-amd64v8 push clean2

all-source: build-source push-source clean2
