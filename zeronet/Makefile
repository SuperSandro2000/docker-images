.PHONY: all build build-amd64 build-armhf build-arm64v8 clean clean2 manifest push push-login
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

build-amd64: clean
  ./build.sh ${DOCKER} amd64

build-armhf: clean
  ./build.sh ${DOCKER} armhf

build-arm64v8: clean
  ./build.sh ${DOCKER} arm64v8

push-login:
  if [ -n "$$CI" ]; then echo $$DOCKER_PASSWORD | $(DOCKER) login -u $$DOCKER_USERNAME --password-stdin; fi

push: clean push-login
  ./push.sh ${DOCKER}

manifest: clean push-login
  ./manifest.sh ${DOCKER}

all: build push manifest clean2
