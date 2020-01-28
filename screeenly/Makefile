.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

HOOK := 1
IMAGE := screenly
VERSION := $(shell curl -s -- https://api.github.com/repos/stefanzweifel/screeenly/commits/master?access_token="${GITHUB_TOKEN}" | jq -r '.sha')
BUILD_ARGS := VERSION=$(VERSION)

include ../buildx/Makefile
