.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

IMAGE := base-alpine
VERSION := 3.14

.PHONY: edge
edge:
	$(MAKE) -$(MAKEFLAGS) TAGS=edge VERSION=edge all

.PHONY: 3.11
3.11:
	$(MAKE) -$(MAKEFLAGS) TAGS=3.11 VERSION=3.11 all

.PHONY: 3.12
3.12:
	$(MAKE) -$(MAKEFLAGS) TAGS=3.12 VERSION=3.12 all

.PHONY: 3.13
3.13:
	$(MAKE) -$(MAKEFLAGS) TAGS=3.13 VERSION=3.13 all

.PHONY: 3.14
3.14:
	$(MAKE) -$(MAKEFLAGS) TAGS=3.14 VERSION=3.14 all

include ../buildx/Makefile
