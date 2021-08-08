.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

IMAGE := musicbot
PLATFORMS ?= amd64
VERSION := $(shell curl -s -u ":$(GITHUB_TOKEN)" -L -- https://api.github.com/repos/jagrosh/MusicBot/tags | jq -r '.[1].name')

include ../buildx/Makefile
