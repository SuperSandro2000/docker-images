.DEFAULT_GOAL := all
.RECIPEPREFIX +=
MAKEFLAGS=--warn-undefined-variables
SHELL := /bin/bash

HOOK := https://hooks.microbadger.com/images/supersandro2000/zeronet/B9vzdMxCP5RYwUuPtaP61aOsM8E=
TAG := zeronet
VERSION = $(shell curl -Ls https://github.com/HelloZeroNet/ZeroNet/raw/py3/src/Config.py | grep -oP "(?<= self.version = \")([0-9]\.){2}[0-9]")

include ../lib/Makefile
