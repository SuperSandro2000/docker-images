.DEFAULT_GOAL := all
.PHONY: all build build-% manifest push push-% login
.RECIPEPREFIX +=
MAKEFLAGS=--warn-undefined-variables
SHELL := /bin/bash

BINARY := docker
EXTRA_FLAGS := --verbose
HOOK := https://hooks.microbadger.com/images/supersandro2000/base-alpine/bwqaLj_bma7zIdwAwiK0CofjAnQ=
SUDO = $(shell if ! groups | grep docker; then echo sudo; fi)
TAG := base-alpine
VARIANT := amd64 arm64 armhf
VERSION := $(shell cat version)

include ../lib/Makefile
