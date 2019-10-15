.DEFAULT_GOAL := all
.RECIPEPREFIX +=
MAKEFLAGS=--warn-undefined-variables
SHELL := /bin/bash

HOOK := https://hooks.microbadger.com/images/supersandro2000/unbound/4cxdD8N2iomewH1V7PBYGIWYvRk=
IMAGE := unbound
VERSION := $(shell ${BINARY} run --rm -t supersandro2000/unbound:latest unbound -h | grep -oP '(?<=Version )[0-9]{1,}\.[0-9]{1,}\.[0-9]{1,}')

include ../lib/Makefile
