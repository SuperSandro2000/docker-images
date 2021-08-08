.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

IMAGE := mastodon-nginx
PLATFORMS ?= amd64
VERSION := $(shell curl -s -u ":$(GITHUB_TOKEN)" -L -- https://api.github.com/repos/tootsuite/mastodon/releases | jq -rS '.[0].tag_name' | cut -c 2-)

include ../buildx/Makefile
