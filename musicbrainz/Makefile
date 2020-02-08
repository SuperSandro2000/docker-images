.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

HOOK := https://hooks.microbadger.com/images/supersandro2000/musicbrainz/67NAdYam81Us4SxlsjxVIX5RG-Y=
IMAGE := musicbrainz
PLATFORMS ?= amd64
VERSION := $(shell curl -s -u ":${GITHUB_TOKEN}" -- https://api.github.com/repos/metabrainz/musicbrainz-server/tags | jq -r '.[1].name')

include ../buildx/Makefile
