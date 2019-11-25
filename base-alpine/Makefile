.DEFAULT_GOAL := all
.RECIPEPREFIX +=
MAKEFLAGS=--warn-undefined-variables
SHELL := /bin/bash

HOOK := https://hooks.microbadger.com/images/supersandro2000/base-alpine/bwqaLj_bma7zIdwAwiK0CofjAnQ=
IMAGE := base-alpine
TAGS := stable edge
VERSIONS := $(shell cat version) edge

%-edge.Dockerfile: Dockerfile.j2
  (export arch=$(DOCKER_ARCH_$*) dist=edge && j2 $< -o $@)

%.Dockerfile: Dockerfile.j2 %-edge.Dockerfile
  (export arch=$(DOCKER_ARCH_$*) dist=3.10 && j2 $< -o $@)

include ../lib/Makefile
