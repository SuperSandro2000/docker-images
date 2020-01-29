.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

HOOK := https://hooks.microbadger.com/images/supersandro2000/firefly-iii/WUaJORh5HdV3p1na-DhJv-ihou0=
IMAGE := firefly-iii
VERSION := $(shell curl -s -- https://api.github.com/repos/firefly-iii/firefly-iii/tags?access_token="${GITHUB_TOKEN}" | jq -r '.[1].name')

include ../buildx/Makefile
