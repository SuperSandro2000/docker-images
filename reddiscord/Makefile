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

build-source: clean lavalink
  ./build-source.sh ${DOCKER}

push-login:
  if [ -n "$$CI" ]; then echo $$DOCKER_PASSWORD | $(DOCKER) login -u $$DOCKER_USERNAME --password-stdin; fi

push: push-login clean
  ./push.sh ${DOCKER}

push-source: push-login clean
  ./push-source.sh ${DOCKER}

all: build push clean2

all-source: build-source push-source clean2
