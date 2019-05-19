.PHONY: all build clean clean2 push push-login
.RECIPEPREFIX +=
SHELL := /bin/bash

DOCKER := "docker"

clean:
  rm ~/.docker/manifests/docker.io_supersandro2000_freshrss-* -rf

build: clean

push-login:
  if [ -n "$$CI" ]; then echo $$DOCKER_PASSWORD | $(DOCKER) login -u $$DOCKER_USERNAME --password-stdin; fi

push: push-login clean
  ./push.sh ${DOCKER}

all: build push clean2
