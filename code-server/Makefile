.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

HOOK := https://hooks.microbadger.com/images/supersandro2000/code-server/uppjdcuNg6zsB8KuHVAA7E8RleM=
IMAGE := code-server
PLATFORMS ?= amd64
VERSION := $(shell curl -s -u ":$(GITHUB_TOKEN)" -L -- https://api.github.com/repos/cdr/code-server/tags | jq -r '.[].name' | grep -v '9.0.0' | head -1 | cut -c 2-)

include ../buildx/Makefile
