.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

IMAGE := unbound
PLATFORMS ?= amd64
VERSION := $(shell curl -s -- https://git.alpinelinux.org/aports/plain/main/unbound/APKBUILD | grep -oP '(?<=pkgver=)([0-9]+\.){2}[0-9]+')

include ../buildx/Makefile
