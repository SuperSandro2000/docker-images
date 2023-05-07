.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /usr/bin/env bash

IMAGE := c3d2-bullshit-bingo
TAGS := latest
VERSION := latest
BUILD_ARGS := SHA=$(shell curl -s -u ":$(GITHUB_TOKEN)" -L -- https://api.github.com/repos/c3d2/c3d2-bullshit-bingo/commits/master | jq -r '.sha')

include ../buildx/Makefile
