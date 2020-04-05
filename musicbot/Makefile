.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

HOOK := https://hooks.microbadger.com/images/supersandro2000/musicbot/guVLToJFcDJZ0ToefGWDeTsU6AY=
IMAGE := musicbot
PLATFORMS ?= amd64
VERSION := $(shell curl -s -u ":$(GITHUB_TOKEN)" -- https://api.github.com/repos/jagrosh/MusicBot/tags | jq -r '.[1].name')

include ../buildx/Makefile
