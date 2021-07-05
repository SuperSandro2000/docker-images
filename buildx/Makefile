.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables
SHELL := /bin/bash

BUILD_ARGS ?=
CI ?=
CONFIG ?= $(if $(CI),~/.docker,~/.docker-local)
COMMA :=,
DEFAULT_BUILD_ARGS ?= BUILD_DATE=$(shell date -u +"%Y-%m-%d"),REVISION=$(shell git rev-parse --short HEAD),VERSION=$(VERSION)
HOOK ?=
IMAGE ?= test
PLATFORMS ?= amd64,arm/v7,arm64
REGISTRY ?= $(if $(CI),docker.io,localhost:5000)
SUDO ?= $(shell if ! groups 2>/dev/null | grep -q docker; then echo sudo --preserve-env=DOCKER_BUILDKIT,DOCKER_CLI_EXPERIMENTAL,DOCKER_HOST,HOME,PWD; fi)
# tag latest, major, minor, version by default
# eg latest, 3, 3.0, 3.0.2
TAGS ?= latest $(shell echo $(VERSION) | cut -f1 -d".") $(shell echo $(VERSION) | awk -F '[.-]' '{print $$1"."$$2}') $(shell echo $(VERSION) | awk -F '[.-]' '{print $$1"."$$2"."$$3}') $(VERSION)
USER := $(if $(CI),supersandro2000,sandro)
VERSION ?=

BUILD_ARG := $(foreach BUILD,$(subst $(COMMA), ,$(BUILD_ARGS) $(DEFAULT_BUILD_ARGS)),--build-arg $(BUILD))
PLATFORMS_ARG := $(foreach PLATFORM,$(subst $(COMMA), ,$(PLATFORMS)),--platform linux/$(PLATFORM))
TAGS_ARG := $(foreach TAG,$(subst $(COMMA), ,$(TAGS)),-t $(REGISTRY)/$(USER)/$(IMAGE):$(TAG))

ifndef HOOK
$(error HOOK is not set)
endif

ifndef VERSION
$(error VERSION is not set)
endif

.PHONY: setup
setup:
	$(SUDO) docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
	$(SUDO) docker --config ~/.docker buildx create --use --name build --node build --driver-opt network=host $(DOCKER_HOST)
	$(SUDO) docker --config ~/.docker-local buildx create --use --name build --node build --driver-opt network=host $(DOCKER_HOST)

.PHONY: login
login:
	$(SUDO) docker --config $(CONFIG) login $(REGISTRY)

.PHONY: build
build:
	$(SUDO) DOCKER_CLI_EXPERIMENTAL=enabled docker --config $(CONFIG) buildx build $(PLATFORMS_ARG) $(TAGS_ARG) $(BUILD_ARG) --pull --push  .
ifneq ($(and $(HOOK),$(CI)),)
	curl -X POST "$(HOOK)"
endif

.PHONY: update
update:
	perl -0777pi -e 's|(- image: $(IMAGE)[\n\s\w:]+version: )([\d.]+)|$${1}$(VERSION)|' ../.github/workflows/docker.yml
	perl -0777pi -e 's|(ARG VERSION=)([\d.]+)|$${1}$(VERSION)|' Dockerfile

.PHONY: all
all: update build
