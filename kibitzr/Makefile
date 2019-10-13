.DEFAULT_GOAL := all
.PHONY: all build build-% manifest push push-% login
.RECIPEPREFIX +=
MAKEFLAGS=--warn-undefined-variables
SHELL := /bin/bash

BINARY := docker
EXTRA_FLAGS := --verbose
HOOK := https://hooks.microbadger.com/images/supersandro2000/kibitzr/rp5PBR5DxYGVZebsNNO91I-8894=
SUDO = $(shell if ! groups | grep docker; then echo sudo; fi)
TAG := kibitzr
VARIANT := amd64 arm64 armhf
VERSION := $(shell curl -s https://pypi.org/pypi/kibitzr/json | jq -r '.info.version')

include ../lib/Makefile
