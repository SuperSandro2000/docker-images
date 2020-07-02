.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

HOOK := https://hooks.microbadger.com/images/supersandro2000/mastodon-nginx/vxs1OnSJZWmYQ1CHYtfRlYVGaF4=
IMAGE := mastodon-nginx
PLATFORMS ?= amd64
VERSION := $(shell curl -s -u ":$(GITHUB_TOKEN)" -- https://api.github.com/repos/tootsuite/mastodon/releases | jq -rS '.[0].tag_name')

include ../buildx/Makefile
