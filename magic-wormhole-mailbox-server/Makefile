.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

HOOK := https://hooks.microbadger.com/images/supersandro2000/magic-wormhole-mailbox-server/F8A95ojjjaSbSbyjmi72jP6-OHc=
IMAGE := magic-wormhole-mailbox-server
VERSION := $(shell curl -s -u ":$(GITHUB_TOKEN)" -- https://api.github.com/repos/warner/magic-wormhole-mailbox-server/tags | jq -r '.[0].name')

include ../buildx/Makefile
