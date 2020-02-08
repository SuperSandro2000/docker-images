.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

HOOK := https://hooks.microbadger.com/images/supersandro2000/open-web-calendar
IMAGE := open-web-calendar
VERSION := master
BUILD_ARGS := SHA=$(shell curl -s -u ":${GITHUB_TOKEN}" -- https://api.github.com/repos/niccokunzmann/open-web-calendar/commits/master | jq -r '.sha')

include ../buildx/Makefile
