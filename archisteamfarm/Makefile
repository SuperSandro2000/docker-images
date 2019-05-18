.PHONY: all build clean clean2 push push-login
.RECIPEPREFIX +=
SHELL := /bin/bash

DOCKER := "docker"

clean clean2:
  rm ~/.docker/manifests/docker.io_supersandro2000_archisteamfarm-* -rf

build: clean

push-login:
  echo $$DOCKER_PASSWORD | $(DOCKER) login -u $$DOCKER_USERNAME --password-stdin

push: push-login clean
  ./push.sh ${DOCKER}

all: build push clean2
