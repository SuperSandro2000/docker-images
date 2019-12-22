.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

LATEST ?= $(shell curl -s https://api.github.com/repos/justarchinet/archisteamfarm/releases/latest?access_token="${GITHUB_TOKEN}" | jq -r '.tag_name')
RELEASED ?= $(shell curl -s https://api.github.com/repos/JustArchiNET/ArchiSteamFarm/releases?access_token="${GITHUB_TOKEN}" | jq -r '.[0].tag_name')

HOOK := https://hooks.microbadger.com/images/supersandro2000/archisteamfarm/uFaZZ9Eb73O7_EOTXqHxPQls45E=
IMAGE := archisteamfarm
VARIANTS := amd64
TAGS := latest released
VERSIONS := $(LATEST) $(RELEASED)
TAG_SUFFIX := alpine-
BUILD_ARGS := VERSION=$(LATEST) VERSION=$(RELEASED)

include ../lib/Makefile
