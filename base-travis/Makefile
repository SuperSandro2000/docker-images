.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

HOOK := https://hooks.microbadger.com/images/supersandro2000/base-alpine/bwqaLj_bma7zIdwAwiK0CofjAnQ=
IMAGE := base-travis
PLATFORMS := amd64
VERSION := xenial

TAGS := $(VERSION)

.PHONY: bionic
bionic:
	$(MAKE) -$(MAKEFLAGS) all VERSION=bionic

include ../buildx/Makefile
