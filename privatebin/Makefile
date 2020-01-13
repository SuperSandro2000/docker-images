.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

HOOK := https://hooks.microbadger.com/images/supersandro2000/privatebin/sc8M94NTpQv9qQl3Ixz7dmxAtDw=
IMAGE := privatebin
VERSION := $(shell curl -Ls https://api.github.com/repos/PrivateBin/PrivateBin/releases/latest?access_token="${GITHUB_TOKEN}" | jq -r '.tag_name' | grep -Eo '([0-9]+\.){2}[0-9]+')
BUILD_ARGS := VERSION=$(VERSION)

include ../buildx/Makefile
