.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

HOOK := 1
IMAGE := firefly-iii
VERSION := $(shell curl -s -- https://api.github.com/repos/firefly-iii/firefly-iii/tags?access_token="${GITHUB_TOKEN}" | jq -r '.[1].name')

include ../buildx/Makefile
