.DEFAULT_GOAL := all
.RECIPEPREFIX +=
MAKEFLAGS=--warn-undefined-variables
SHELL := /bin/bash

HOOK := https://hooks.microbadger.com/images/supersandro2000/prerenderer/bHfhzXpwydlqXnX5Z1Gm5SKzfMw=
IMAGE := prerenderer
VERSIONS := $(shell curl -Ls https://github.com/prerender/prerender/raw/master/package.json | grep -oP "(?<= \"version\": \")[0-9]+")

%.Dockerfile: Dockerfile.j2
  (export arch=$(DOCKER_ARCH_$*) && j2 $< -o $@)

include ../lib/Makefile
