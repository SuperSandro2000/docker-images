.DEFAULT_GOAL := all
MAKEFLAGS=--warn-undefined-variables
SHELL := /bin/bash

HOOK :=
IMAGE := iodine
TAGS := $(shell curl -is https://git.alpinelinux.org/aports/plain/main/unbound/APKBUILD | grep -oP '(?<=pkgver=)([0-9]+\.){2}[0-9]+')

include ../buildx/Makefile
