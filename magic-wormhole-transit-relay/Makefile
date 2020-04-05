.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

HOOK := https://hooks.microbadger.com/images/supersandro2000/magic-wormhole-transit-relay/41u_OD82upKBmspnV9egigNLMmA=
IMAGE := magic-wormhole-transit-relay
VERSION := $(shell curl -s -u ":$(GITHUB_TOKEN)" -- https://api.github.com/repos/warner/magic-wormhole-transit-relay/tags | jq -r '.[0].name')

include ../buildx/Makefile
