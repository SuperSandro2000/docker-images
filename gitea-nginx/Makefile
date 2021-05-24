.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

HOOK := https://hooks.microbadger.com/images/supersandro2000/gitea-nginx/-a3vXPAzLtfo82Wr3FTb9AWiCcc=
IMAGE := gitea-nginx
PLATFORMS ?= amd64
VERSION := $(shell curl -s -u ":$(GITHUB_TOKEN)" -L -- https://api.github.com/repos/go-gitea/gitea/releases | jq -rS '.[0].tag_name' | cut -c 2-)

include ../buildx/Makefile
