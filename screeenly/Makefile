.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

HOOK := https://hooks.microbadger.com/images/supersandro2000/screeenly/u9JrncImlARK2PcZ18pNdt6WM2M=
IMAGE := screeenly
PLATFORMS ?= amd64
TAGS := latest
VERSION := $(shell curl -s -u ":${GITHUB_TOKEN}" -- https://api.github.com/repos/stefanzweifel/screeenly/commits/master | jq -r '.sha')

include ../buildx/Makefile
