.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

HOOK := https://hooks.microbadger.com/images/supersandro2000/thelounge/8YEKunv2f-i7bMsa9vA45Y89zto=
IMAGE := thelounge
VERSION := $(shell curl -s -u ":$(GITHUB_TOKEN)" -- https://api.github.com/repos/thelounge/thelounge/releases/latest | jq -r '.tag_name' | grep -Eo '([0-9]+\.){2}[0-9]+')

include ../buildx/Makefile
