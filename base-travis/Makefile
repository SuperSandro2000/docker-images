.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

IMAGE := base-travis
PLATFORMS ?= amd64
VERSION := xenial

TAGS := $(VERSION)

.PHONY: bionic
bionic:
	$(MAKE) -$(MAKEFLAGS) all VERSION=bionic

include ../buildx/Makefile
