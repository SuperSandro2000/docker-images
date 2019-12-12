.DEFAULT_GOAL := all
MAKEFLAGS=--warn-undefined-variables
SHELL := /bin/bash

HOOK := https://hooks.microbadger.com/images/supersandro2000/healthchecks/rfteQZVyDelEmfSBvAdNDFOBSJM=
IMAGE := healthchecks
VARIANTS ?= amd64,arm64
VERSIONS := $(shell curl -s https://api.github.com/repos/healthchecks/healthchecks/releases/latest?access_token="${GITHUB_TOKEN}" | jq -r '.tag_name' | grep -Eo '([0-9]+\.){2}[0-9]+')
BUILD_ARGS := SHA=$(shell curl -s https://api.github.com/repos/healthchecks/healthchecks/commits/master?access_token="${GITHUB_TOKEN}" | jq -r '.sha')

include ../buildx/Makefile
