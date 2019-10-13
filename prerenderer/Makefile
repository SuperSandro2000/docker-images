.DEFAULT_GOAL := all
.PHONY: all build build-% manifest push push-% login
.RECIPEPREFIX +=
MAKEFLAGS=--warn-undefined-variables
SHELL := /bin/bash

BINARY := docker
EXTRA_FLAGS := --verbose
HOOK := https://hooks.microbadger.com/images/supersandro2000/prerenderer/bHfhzXpwydlqXnX5Z1Gm5SKzfMw=
SUDO = $(shell if ! groups | grep docker; then echo sudo; fi)
TAG := prerenderer
VARIANT := amd64 arm64 armhf
VERSION := $(shell curl -Ls https://github.com/prerender/prerender/raw/master/package.json | grep -oP "(?<= \"version\": \")[0-9]+")

include ../lib/Makefile
