.DEFAULT_GOAL := all
.PHONY: all build build-% manifest push push-% login
.RECIPEPREFIX +=
MAKEFLAGS=--warn-undefined-variables
SHELL := /bin/bash

BINARY := docker
EXTRA_FLAGS := --verbose
HOOK := https://hooks.microbadger.com/images/supersandro2000/healthchecks/rfteQZVyDelEmfSBvAdNDFOBSJM=
SUDO = $(shell if ! groups | grep docker; then echo sudo; fi)
TAG := healthchecks
VARIANT := amd64 arm64 armhf
VERSION := $(shell curl -s https://api.github.com/repos/healthchecks/healthchecks/releases/latest?access_token="$GITHUB_TOKEN" | jq -r '.tag_name' | grep -Eo '([0-9]\.){2}[0-9]')

include ../lib/Makefile
