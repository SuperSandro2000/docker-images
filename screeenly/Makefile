.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /usr/bin/env bash

IMAGE := screeenly
PLATFORMS ?= amd64
TAGS := latest
VERSION := $(shell curl -s -u ":$(GITHUB_TOKEN)" -L -- https://api.github.com/repos/stefanzweifel/screeenly/commits/master | jq -r '.sha')

include ../buildx/Makefile
