.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

HOOK := https://hooks.microbadger.com/images/supersandro2000/reddiscord/CtjLg5fT78hv5M6mbobg3_1aqeE=
IMAGE := reddiscord
PLATFORMS ?= amd64
VERSION := $(shell curl -s -u ":$(GITHUB_TOKEN)" -L -- https://api.github.com/repos/Cog-Creators/Red-DiscordBot/tags | jq -r '.[0].name')

include ../buildx/Makefile
