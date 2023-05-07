.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /usr/bin/env bash

IMAGE := firefly-iii
PLATFORMS ?= amd64
# take the third tag cause the first and second start with letters
VERSION := $(shell curl -s -u ":$(GITHUB_TOKEN)" -L -- https://api.github.com/repos/firefly-iii/firefly-iii/tags | jq -r '.[2].name')

include ../buildx/Makefile
