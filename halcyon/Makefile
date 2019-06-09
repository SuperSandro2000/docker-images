.PHONY: all build clean clean2 push push-login
.RECIPEPREFIX +=
SHELL := /bin/bash

DOCKER := "docker"

clean clean2:
  rm halcyon-git -fr

build: clean
  ./build.sh ${DOCKER}

push-login:
  if [ -n "$$CI" ]; then echo $$DOCKER_PASSWORD | $(DOCKER) login -u $$DOCKER_USERNAME --password-stdin; fi

push: push-login clean
  ./push.sh ${DOCKER}

all: build push clean2
