.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /usr/bin/env bash

IMAGE := kibitzr
PLATFORMS ?= amd64
VERSION := $(shell curl -s https://pypi.org/pypi/kibitzr/json | jq -r '.info.version')

include ../buildx/Makefile
