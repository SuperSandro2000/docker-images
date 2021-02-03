.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

HOOK := https://hooks.microbadger.com/images/supersandro2000/base-alpine/bwqaLj_bma7zIdwAwiK0CofjAnQ=
IMAGE := base-alpine
VERSION := 3.12

.PHONY: edge
edge:
	$(MAKE) -$(MAKEFLAGS) TAGS=edge VERSION=edge all

.PHONY: 3.11
3.11:
	$(MAKE) -$(MAKEFLAGS) TAGS=3.11 VERSION=3.11 all

.PHONY: 3.13
3.13:
	$(MAKE) -$(MAKEFLAGS) TAGS=3.13 VERSION=3.13 all

include ../buildx/Makefile
