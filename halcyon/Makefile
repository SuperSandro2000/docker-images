.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

IMAGE := halcyon
PLATFORMS ?= amd64
VERSION := $(shell curl -s -- https://notabug.org/halcyon-suite/halcyon/raw/master/version.txt | grep -Eo '([0-9]+\.){2}[0-9]+')

include ../buildx/Makefile
