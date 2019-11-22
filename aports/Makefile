.DEFAULT_GOAL := all
.RECIPEPREFIX +=
MAKEFLAGS=--warn-undefined-variables
SHELL := /bin/bash

HOOK := https://hooks.microbadger.com/images/supersandro2000/aports/sLt3eq2bpOG71uETWB-zRvB52fM=
IMAGE := aports
VERSIONS = latest 

%.Dockerfile: Dockerfile.j2
  (export arch=$* && j2 $< -o $@)

include ../lib/Makefile
