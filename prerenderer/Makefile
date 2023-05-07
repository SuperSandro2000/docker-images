.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /usr/bin/env bash

IMAGE := prerenderer
PLATFORMS ?= amd64
VERSION := $(shell curl -Ls https://github.com/prerender/prerender/raw/master/package.json | grep -oP "(?<= \"version\": \")[0-9]+")
BUILD_ARGS := SHA=$(shell curl -s -u ":$(GITHUB_TOKEN)" -L -- https://api.github.com/repos/prerender/prerender/commits/master | jq -r '.sha')

include ../buildx/Makefile
