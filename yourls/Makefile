.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

HOOK := https://hooks.microbadger.com/images/supersandro2000/yourls/nsDnvRJqO8MgqYZz9lEtYbaXzDI=
IMAGE := yourls
VERSION := $(shell curl -Ls https://api.github.com/repos/YOURLS/YOURLS/releases/latest?access_token="${GITHUB_TOKEN}" | jq -r '.tag_name' | grep -Eo '([0-9]+\.){2}[0-9]+')
BUILD_ARGS := VERSION=$(VERSION)

include ../buildx/Makefile
