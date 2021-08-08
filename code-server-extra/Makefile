.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

IMAGE := code-server-extra
PLATFORMS ?= amd64
VERSION := 3
TAGS := latest $(VERSION)

include ../buildx/Makefile
