.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

HOOK := https://hooks.microbadger.com/images/supersandro2000/code-server/uppjdcuNg6zsB8KuHVAA7E8RleM=
IMAGE := code-server
PLATFORMS := amd64
VERSION := $(shell curl -s -u ":${GITHUB_TOKEN}" -- https://api.github.com/repos/cdr/code-server/tags | jq -r '.[0].name')

include ../buildx/Makefile
