.DEFAULT_GOAL := all
.RECIPEPREFIX +=
MAKEFLAGS=--warn-undefined-variables
SHELL := /bin/bash

HOOK := https://hooks.microbadger.com/images/supersandro2000/zeronet/B9vzdMxCP5RYwUuPtaP61aOsM8E=
IMAGE := zeronet
Z_VER := $(shell curl -Ls https://github.com/HelloZeroNet/ZeroNet/raw/py3/src/Config.py | grep -oP "(?<= self.version = \")([0-9]+\.){2}[0-9]+")
Z_REV := $(shell curl -Ls https://github.com/HelloZeroNet/ZeroNet/raw/py3/src/Config.py | grep -oP "(?<= self.rev = )[0-9]+")
VERSIONS := $(Z_VER)-r$(Z_REV)

%.Dockerfile: Dockerfile.j2 files/pip.conf
  (export arch=$* && j2 $< -o $@)

include ../lib/Makefile
