.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

HOOK :=
IMAGE := musicbrainz
PLATFORMS ?= amd64
VERSION := $(shell curl -s -- https://api.github.com/repos/metabrainz/musicbrainz-server/tags?access_token="${GITHUB_TOKEN}" | jq -r '.[1].name')

include ../buildx/Makefile
