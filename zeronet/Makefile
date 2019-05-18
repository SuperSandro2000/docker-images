.PHONY: all build clean clean2 push push-login
.RECIPEPREFIX +=
SHELL := /bin/bash

DOCKER := "docker"

clean clean2:
  rm zeronet-git -rf
  rm ~/.docker/manifests/docker.io_supersandro2000_zeronet-* -rf
  rm manifest -f
  rm manifest_latest -f

build: clean
  ./build.sh ${DOCKER}

push-login:
  if [ -n "$$CI" ]; then echo $$DOCKER_PASSWORD | $(DOCKER) login -u $$DOCKER_USERNAME --password-stdin; fi

push: clean push-login
  ./push.sh ${DOCKER}

all: build push clean2
