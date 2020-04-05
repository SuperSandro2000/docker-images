.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

HOOK := https://hooks.microbadger.com/images/supersandro2000/c3d2-bullshit-bingo/yYRkINiuvBniRcSmn_qY5GI7DeY=
IMAGE := c3d2-bullshit-bingo
TAGS := latest
VERSION := latest
BUILD_ARGS := SHA=$(shell curl -s -u ":$(GITHUB_TOKEN)" -- https://api.github.com/repos/c3d2/c3d2-bullshit-bingo/commits/master | jq -r '.sha')

include ../buildx/Makefile
