.PHONY: all all-alpine build build-alpine clean clean2 clean-alpine clean2-alpine push push-alpine push-login
.RECIPEPREFIX +=
SHELL := /bin/bash

DOCKER := "docker"

clean clean2:
  rm ~/.docker/manifests/docker.io_supersandro2000_archisteamfarm-* -rf

clean-alpine clean2-alpine:
  rm archisteamfarm-git -rf

build-alpine: clean-alpine
  ./build-alpine.sh ${DOCKER}

push-login:
  echo $$DOCKER_PASSWORD | $(DOCKER) login -u $$DOCKER_USERNAME --password-stdin

push: push-login clean
  ./push.sh ${DOCKER}

all: push clean2

all-alpine: build-alpine push-alpine clean2-alpine
