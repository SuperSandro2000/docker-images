.DEFAULT_GOAL := all
.RECIPEPREFIX +=
MAKEFLAGS=--warn-undefined-variables
SHELL := /bin/bash

HOOK := https://hooks.microbadger.com/images/supersandro2000/open-web-calendar
IMAGE := open-web-calendar
VERSIONS := master
BUILD_ARGS := SHA=$(shell curl -s https://api.github.com/repos/niccokunzmann/open-web-calendar/commits/master?access_token="${GITHUB_TOKEN}" | jq -r '.sha')

%.Dockerfile: ../lib/templates/%-alpine-python.Dockerfile.j2
  cat source.Dockerfile > $@
  j2 $< >> $@

include ../lib/Makefile
