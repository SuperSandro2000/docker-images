.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

IMAGE := aports
VERSION := 3.13
PLATFORMS ?= amd64
TAGS := latest $(VERSION)

include ../buildx/Makefile
