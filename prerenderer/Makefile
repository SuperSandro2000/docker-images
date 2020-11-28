.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

HOOK := https://hooks.microbadger.com/images/supersandro2000/prerenderer/bHfhzXpwydlqXnX5Z1Gm5SKzfMw=
IMAGE := prerenderer
PLATFORMS ?= amd64,arm64
VERSION := $(shell curl -Ls https://github.com/prerender/prerender/raw/master/package.json | grep -oP "(?<= \"version\": \")[0-9]+")
BUILD_ARGS := SHA=$(shell curl -s -u ":$(GITHUB_TOKEN)" -- https://api.github.com/repos/prerender/prerender/commits/master | jq -r '.sha')

include ../buildx/Makefile
