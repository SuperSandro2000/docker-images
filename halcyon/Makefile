.DEFAULT_GOAL := all
.PHONY: all build build-% manifest push push-% login
.RECIPEPREFIX +=
MAKEFLAGS=--warn-undefined-variables
SHELL := /bin/bash

BINARY := docker
EXTRA_FLAGS := --verbose
HOOK := https://hooks.microbadger.com/images/supersandro2000/halcyon/SZHNRfRT-225bEYcHQCve7POsRs=
SUDO = $(shell if ! groups | grep docker; then echo sudo; fi)
TAG := halcyon
VARIANT := amd64
VERSION := $(shell curl -s https://notabug.org/halcyon-suite/halcyon/raw/master/version.txt | grep -Eo '([0-9]\.){2}[0-9]')

include ../lib/Makefile
