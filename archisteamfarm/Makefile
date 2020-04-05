.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

LATEST ?= $(shell curl -s -u ":$(GITHUB_TOKEN)" -- https://api.github.com/repos/JustArchiNET/ArchiSteamFarm/releases | jq -r '.[0].tag_name')

HOOK := https://hooks.microbadger.com/images/supersandro2000/archisteamfarm/uFaZZ9Eb73O7_EOTXqHxPQls45E=
IMAGE := archisteamfarm
PLATFORMS := amd64
VERSION := $(LATEST)

TAGS := alpine alpine-released alpine-$(LATEST)

include ../buildx/Makefile
