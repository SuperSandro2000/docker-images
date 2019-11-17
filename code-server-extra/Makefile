.DEFAULT_GOAL := all
.RECIPEPREFIX +=
MAKEFLAGS=--warn-undefined-variables
SHELL := /bin/bash

HOOK :=
IMAGE := code-server-extra
VARIANTS := amd64
VERSIONS := latest

%.Dockerfile: Dockerfile.j2
  (export arch=$(DOCKER_ARCH_$*) && j2 $< -o $@)

include ../lib/Makefile
