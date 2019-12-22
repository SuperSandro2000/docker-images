.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

HOOK := https://hooks.microbadger.com/images/supersandro2000/unbound/4cxdD8N2iomewH1V7PBYGIWYvRk=
IMAGE := unbound
VERSIONS := $(shell curl -s https://git.alpinelinux.org/aports/plain/main/unbound/APKBUILD | grep -oP '(?<=pkgver=)([0-9]+\.){2}[0-9]+')

%.Dockerfile: Dockerfile.j2
	(export arch=$* && j2 $< -o $@)

include ../buildx/Makefile
