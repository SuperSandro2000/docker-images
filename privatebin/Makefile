.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /usr/bin/env bash

IMAGE := privatebin
VERSION := $(shell curl -Ls -u ":$(GITHUB_TOKEN)" -L -- https://api.github.com/repos/PrivateBin/PrivateBin/releases/latest | jq -r '.tag_name' | grep -Eo '([0-9]+\.){2}[0-9]+')

include ../buildx/Makefile
