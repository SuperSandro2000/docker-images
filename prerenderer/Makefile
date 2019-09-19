.PHONY: all build push push-login
.RECIPEPREFIX +=
SHELL := /bin/bash

DOCKER := "docker"

build: clean ./build.sh ${DOCKER}

push-login:
  if [ -n "$$CI" ]; then echo $$DOCKER_PASSWORD | $(DOCKER) login -u $$DOCKER_USERNAME --password-stdin; fi

push: push-login clean
  ./push.sh ${DOCKER}

all: build push
