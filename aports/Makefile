.DEFAULT_GOAL := all
.RECIPEPREFIX +=
MAKEFLAGS=--warn-undefined-variables
SHELL := /bin/bash

HOOK :=
IMAGE := aports
VERSIONS = latest 

%.Dockerfile: Dockerfile.j2
  (export arch=$* && j2 $< -o $@)

include ../lib/Makefile
