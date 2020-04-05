.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

HOOK := https://hooks.microbadger.com/images/supersandro2000/yourls/nsDnvRJqO8MgqYZz9lEtYbaXzDI=
IMAGE := yourls
VERSION := $(shell curl -Ls -u ":$(GITHUB_TOKEN)" -- https://api.github.com/repos/YOURLS/YOURLS/releases/latest | jq -r '.tag_name' | grep -Eo '([0-9]+\.){2}[0-9]+')

include ../buildx/Makefile
