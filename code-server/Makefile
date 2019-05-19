.PHONY: all build clean clean2 push push-login
.RECIPEPREFIX +=
SHELL := /bin/bash

DOCKER := "docker"

ifeq ($(ARCH),)
ARCH := "amd64"
endif

clean clean2:
  rm ~/.docker/manifests/docker.io_supersandro2000_code-server-* -rf
  rm code-server-git -rf
  rm manifest
  rm manifest_latest

build: clean
  ./build.sh ${DOCKER}

push-login:
  if [ -n "$$CI" ]; then echo $$DOCKER_PASSWORD | $(DOCKER) login -u $$DOCKER_USERNAME --password-stdin; fi

push: push-login clean
  ./push.sh ${DOCKER}

all: build push clean2
