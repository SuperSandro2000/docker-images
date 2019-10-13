.DEFAULT_GOAL := all
.PHONY: all build build-% manifest push push-% login
.RECIPEPREFIX +=
MAKEFLAGS=--warn-undefined-variables
SHELL := /bin/bash

BINARY := docker
EXTRA_FLAGS := --verbose
HOOK := https://hooks.microbadger.com/images/supersandro2000/zeronet/B9vzdMxCP5RYwUuPtaP61aOsM8E=
SUDO = $(shell if ! groups | grep docker; then echo sudo; fi)
TAG := zeronet
VARIANT := amd64 arm64 armhf
VERSION = $(shell curl -Ls https://github.com/HelloZeroNet/ZeroNet/raw/py3/src/Config.py | grep -oP "(?<= self.version = \")([0-9]\.){2}[0-9]")

include ../lib/Makefile
