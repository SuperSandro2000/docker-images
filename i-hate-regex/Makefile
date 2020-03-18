.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

HOOK := https://hooks.microbadger.com/images/supersandro2000/i-hate-regex/G1UiLMXCEY2U5GnShGtqvWHHK64=
IMAGE := i-hate-regex
PLATFORMS := amd64
VERSION := master

BUILD_ARGS := SHA=$(shell curl -s -u ":${GITHUB_TOKEN}" -- https://api.github.com/repos/geongeorge/i-hate-regex/commits/master | jq -r '.sha')

include ../buildx/Makefile
