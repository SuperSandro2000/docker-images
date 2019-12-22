.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables
SHELL := /bin/bash

BUILD_ARGS ?=
CI ?=
COMMA :=,
HOOK ?=
IMAGE ?= test
PLATFORMS ?= amd64,arm/v7,arm64
REGISTRY ?= $(if ${CI},docker.io,localhost:5000)
SUDO ?= $(shell if ! groups | grep -q docker; then echo sudo; fi)
TAGS ?= test
USER ?= $(if ${CI},supersandro2000,sandro)
VERSIONS ?=

BUILD_ARG := $(foreach PLATFORM,$(subst $(COMMA), ,$(BUILD_ARGS)),--build-args $(PLATFORM))
PLATFORMS_ARG := $(foreach PLATFORM,$(subst $(COMMA), ,$(PLATFORMS)),--platform linux/$(PLATFORM))
TAGS_ARG := $(foreach TAG,$(subst $(COMMA), ,$(TAGS)),-t $(REGISTRY)/$(USER)/$(IMAGE):$(TAG))

.PHONY: setup
setup:
	$(SUDO) docker buildx create --use --name build --node build --driver-opt network=host

.PHONY: build
build:
	$(SUDO) DOCKER_CLI_EXPERIMENTAL=enabled docker buildx build $(PLATFORMS_ARG) $(TAGS_ARG) --push  .

.PHONY: all
all: build
