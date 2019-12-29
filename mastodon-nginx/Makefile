.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

HOOK := https://hooks.microbadger.com/images/supersandro2000/mastodon-nginx/vxs1OnSJZWmYQ1CHYtfRlYVGaF4=
IMAGE := mastodon-nginx
PLATFORMS ?= amd64
VERSION := $(shell curl -s -- https://api.github.com/repos/tootsuite/mastodon/releases?access_token="${GITHUB_TOKEN}" | jq -r '.[0].tag_name')

include ../buildx/Makefile

.PHONY: test
test:
	$(SUDO) docker build . -t supersandro2000/mastodon-nginx --build-arg VERSION=$(VERSION)
