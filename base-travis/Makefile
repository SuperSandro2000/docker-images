.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

HOOK := https://hooks.microbadger.com/images/supersandro2000/base-alpine/bwqaLj_bma7zIdwAwiK0CofjAnQ=
IMAGE := base-alpine
PLATFORMS := amd64
VERSION := xenial

.PHONY: bionic
bionic:
	$(MAKE) -$(MAKEFLAGS) -e all VERSION=bionic

include ../buildx/Makefile
