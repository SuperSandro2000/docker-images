.PHONY: all all-alpine build build-alpine clean clean2 push push-alpine push-login
.RECIPEPREFIX +=
SHELL := /bin/bash

DOCKER := "docker"

clean clean2:
  rm ~/.docker/manifests/docker.io_supersandro2000_archisteamfarm-* -rf
  rm archisteamfarm-git -rf

build-alpine: clean
  ./build-alpine.sh ${DOCKER}

push-login:
  if [ -n "$$CI" ]; then echo $$DOCKER_PASSWORD | $(DOCKER) login -u $$DOCKER_USERNAME --password-stdin; fi

push: push-login clean
  ./push.sh ${DOCKER}

push-alpine: push-login clean
  ./push-alpine.sh ${DOCKER}

all: push clean2

all-alpine: build-alpine push-alpine clean2
