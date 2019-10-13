.DEFAULT_GOAL := all
.PHONY: all build build-% manifest push push-% login
.RECIPEPREFIX +=
MAKEFLAGS=--warn-undefined-variables
SHELL := /bin/bash

BINARY ?= docker
EXTRA_FLAGS ?= --verbose
SUDO ?= $(shell if ! groups | grep docker; then echo sudo; fi)
VARIANT ?= amd64 arm64 armhf

# HOOK, TAG, VERSION need to be supplied

define BUILD_template =
build-$(1):
  $(SUDO) ../lib/build.sh --binary $(BINARY) --buildkit --tag $(TAG) --variant ${1} --version $(VERSION) $(EXTRA_FLAGS)

push-$(1): login
  $(SUDO) ../lib/push.sh --binary $(BINARY) --image $(TAG) --hook $(HOOK) --variant $(1) --version $(VERSION) $(EXTRA_FLAGS)
endef

build:
  $(SUDO) ../lib/build.sh --binary $(BINARY) --buildkit --tag $(TAG) --version $(VERSION) $(EXTRA_FLAGS)

login:
  if [ -n "${CI}" ]; then echo ${DOCKER_PASSWORD} | $(BINARY) login -u ${DOCKER_USERNAME} --password-stdin; fi

manifest: login
  $(SUDO) ../lib/manifest.sh --binary $(BINARY) --image $(TAG) --hook $(HOOK) --version $(VERSION) $(EXTRA_FLAGS)

push: login manifest
  $(SUDO) ../lib/push.sh --binary $(BINARY) --image $(TAG) --hook $(HOOK) --manifest --version $(VERSION) $(EXTRA_FLAGS)

$(foreach VAR,$(VARIANT),$(eval $(call BUILD_template,$(VAR))))

all: build push manifest
