.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

IMAGE := musicbrainz-postgres
PLATFORMS ?= amd64
VERSION := 12
TAGS := $(VERSION)

include ../buildx/Makefile
