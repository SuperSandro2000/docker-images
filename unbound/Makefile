.DEFAULT_GOAL := all
.PHONY: all build build-% manifest push push-% login
.RECIPEPREFIX +=
MAKEFLAGS=--warn-undefined-variables
SHELL := /bin/bash

BINARY := docker
EXTRA_FLAGS := --verbose
HOOK := https://hooks.microbadger.com/images/supersandro2000/unbound/4cxdD8N2iomewH1V7PBYGIWYvRk=
SUDO = $(shell if ! groups | grep docker; then echo sudo; fi)
TAG := unbound
VARIANT := amd64 arm64 armhf
VERSION := $(shell ${BINARY} run --rm -t supersandro2000/unbound:latest unbound -h | grep -oP '(?<=Version )[0-9]{1,}\.[0-9]{1,}\.[0-9]{1,}')

include ../lib/Makefile
