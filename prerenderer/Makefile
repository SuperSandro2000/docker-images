.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

HOOK := https://hooks.microbadger.com/images/supersandro2000/prerenderer/bHfhzXpwydlqXnX5Z1Gm5SKzfMw=
IMAGE := prerenderer
VERSION := $(shell curl -Ls https://github.com/prerender/prerender/raw/master/package.json | grep -oP "(?<= \"version\": \")[0-9]+")

include ../buildx/Makefile
