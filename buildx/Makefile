.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables
SHELL := /bin/bash

BUILD_ARGS ?=
CI ?=
CONFIG ?= $(if ${CI},~/.docker,~/.docker-local)
COMMA :=,
DEFAULT_BUILD_ARGS ?= BUILD_DATE=$(shell date -u +"%Y-%m-%d"),REVISION=$(shell git rev-parse --short HEAD),VERSION=$(VERSION)
HOOK ?=
IMAGE ?= test
PLATFORMS ?= amd64,arm/v7,arm64
REGISTRY ?= $(if ${CI},docker.io,localhost:5000)
SUDO ?= $(shell if ! groups | grep -q docker; then echo sudo --preserve-env=DOCKER_CLI_EXPERIMENTAL; fi)
TAGS ?= latest $(VERSION)
USER := $(if ${CI},supersandro2000,sandro)
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
	$(SUDO) docker --config $(CONFIG) buildx create --use --name build --node build --driver-opt network=host

.PHONY: login
login:
	$(SUDO) docker --config $(CONFIG) login

.PHONY: build
build:
	$(SUDO) DOCKER_CLI_EXPERIMENTAL=enabled docker --config $(CONFIG) buildx build $(PLATFORMS_ARG) $(TAGS_ARG) $(BUILD_ARG) --pull --push  .
ifneq ($(and $(HOOK),$(CI)),)
	curl -X POST "$(HOOK)"
endif

.PHONY: all
all: build
