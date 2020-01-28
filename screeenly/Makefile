.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

HOOK := https://hooks.microbadger.com/images/supersandro2000/screeenly/u9JrncImlARK2PcZ18pNdt6WM2M=
IMAGE := screeenly
VERSION := $(shell curl -s -- https://api.github.com/repos/stefanzweifel/screeenly/commits/master?access_token="${GITHUB_TOKEN}" | jq -r '.sha')
BUILD_ARGS := VERSION=$(VERSION)

include ../buildx/Makefile
