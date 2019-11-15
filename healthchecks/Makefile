.DEFAULT_GOAL := all
.RECIPEPREFIX +=
MAKEFLAGS=--warn-undefined-variables
SHELL := /bin/bash

HOOK := https://hooks.microbadger.com/images/supersandro2000/healthchecks/rfteQZVyDelEmfSBvAdNDFOBSJM=
IMAGE := healthchecks
VERSIONS := $(shell curl -s https://api.github.com/repos/healthchecks/healthchecks/releases/latest?access_token="${GITHUB_TOKEN}" | jq -r '.tag_name' | grep -Eo '([0-9]+\.){2}[0-9]+')

%.Dockerfile: ../lib/templates/%-debian.Dockerfile.j2 Dockerfile.j2 builder.Dockerfile.j2 files/pip.conf
  (export Dockerfile=builder.Dockerfile.j2 as=builder && j2 $< > $@)
  echo "#------------------#" >> $@
  j2 $< >> $@

include ../lib/Makefile
