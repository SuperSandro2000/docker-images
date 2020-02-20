.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

HOOK := 1
IMAGE := i-hate-regex
PLATFORMS := amd64
TAGS := latest
VERSION := $(shell curl -s -u ":${GITHUB_TOKEN}" -- https://api.github.com/repos/geongeorge/i-hate-regex/commits/master | jq -r '.sha')

include ../buildx/Makefile
