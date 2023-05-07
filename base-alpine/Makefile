.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /usr/bin/env bash

IMAGE := base-alpine
VERSION := 3.15

.PHONY: %
%:
	$(MAKE) -$(MAKEFLAGS) TAGS=$* VERSION=$* all

include ../buildx/Makefile
