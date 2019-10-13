.DEFAULT_GOAL := all
.PHONY: all build build-% manifest push push-% login
.RECIPEPREFIX +=
SHELL := /bin/bash

BINARY := docker
HOOK := https://hooks.microbadger.com/images/supersandro2000/base-alpine/bwqaLj_bma7zIdwAwiK0CofjAnQ=
SUDO = $(shell if ! groups | grep docker; then echo sudo; fi)
TAG := base-alpine
VARIANT := amd64 arm64 armhf
VERSION := $(shell cat version)

define BUILD_template =
build-$(1):
  $(SUDO) ../lib/build.sh --binary $(BINARY) --buildkit --tag $(TAG) --variant ${1}  --verbose --version $(VERSION)

push-$(1): login
  $(SUDO) ../lib/push.sh --binary $(BINARY) --image $(TAG) --hook $(HOOK) --variant $(1) --verbose --version $(VERSION)
endef

build:
  $(SUDO) ../lib/build.sh --binary $(BINARY) --buildkit --tag $(TAG) --verbose --version $(VERSION)

login:
  if [ -n "${CI}" ]; then echo ${DOCKER_PASSWORD} | $(BINARY) login -u ${DOCKER_USERNAME} --password-stdin; fi

manifest: login
  $(SUDO) ../lib/manifest.sh --binary $(BINARY) --image $(TAG) --hook $(HOOK) --verbose --version $(VERSION)

push: login manifest
  $(SUDO) ../lib/push.sh --binary $(BINARY) --image $(TAG) --hook $(HOOK) --manifest --verbose --version $(VERSION)

$(foreach VAR,$(VARIANT),$(eval $(call BUILD_template,$(VAR))))

all: build push manifest
