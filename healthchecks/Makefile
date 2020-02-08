.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

HOOK := https://hooks.microbadger.com/images/supersandro2000/healthchecks/rfteQZVyDelEmfSBvAdNDFOBSJM=
IMAGE := healthchecks
PLATFORMS ?= amd64,arm64
VERSION := $(shell curl -s -u ":${GITHUB_TOKEN}" -- https://api.github.com/repos/healthchecks/healthchecks/releases/latest | jq -r '.tag_name' | grep -Eo '([0-9]+\.){2}[0-9]+')
BUILD_ARGS := SHA=$(shell curl -s -u ":${GITHUB_TOKEN}" -- https://api.github.com/repos/healthchecks/healthchecks/commits/master | jq -r '.sha')

include ../buildx/Makefile
