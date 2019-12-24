.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

HOOK := https://hooks.microbadger.com/images/supersandro2000/iodine/B6d0So8wO9xYs7olbXxZ5pqFy8E=
IMAGE := iodine
VERSION := $(shell curl -is https://git.alpinelinux.org/aports/plain/main/unbound/APKBUILD | grep -oP '(?<=pkgver=)([0-9]+\.){2}[0-9]+')

include ../buildx/Makefile
