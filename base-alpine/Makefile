.DEFAULT_GOAL := all
.PHONY: all build build-amd64 build-armhf build-arm64 manifest push login
.RECIPEPREFIX +=
SHELL := /bin/bash

DOCKER := "docker"

build:
  ../lib/build.sh --binary ${DOCKER} --buildkit --tag base-alpine --verbose --version $(shell cat version)

build-amd64:
  ../lib/build.sh --binary ${DOCKER} --buildkit --tag base-alpine --variant amd64 --verbose --version $(shell cat version)

build-armhf:
  ../lib/build.sh --binary ${DOCKER} --buildkit --tag base-alpine --variant armhf --verbose --version $(shell cat version)

build-arm64:
  ../lib/build.sh --binary ${DOCKER} --buildkit --tag base-alpine --variant arm64 --verbose --version $(shell cat version)

login:
  if [ -n "$$CI" ]; then echo $$DOCKER_PASSWORD | $(DOCKER) login -u $$DOCKER_USERNAME --password-stdin; fi

manifest: login
  ../lib/manifest.sh --binary ${DOCKER} --image base-alpine --hook https://hooks.microbadger.com/images/supersandro2000/base-alpine/bwqaLj_bma7zIdwAwiK0CofjAnQ= --verbose --version $(shell cat version)

push: login manifest
  ../lib/push.sh --binary ${DOCKER} --image base-alpine --hook https://hooks.microbadger.com/images/supersandro2000/base-alpine/bwqaLj_bma7zIdwAwiK0CofjAnQ= --manifest --verbose --version $(shell cat version)

all: build push manifest
