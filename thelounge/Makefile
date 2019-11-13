.DEFAULT_GOAL := all
.RECIPEPREFIX +=
MAKEFLAGS=--warn-undefined-variables
SHELL := /bin/bash

HOOK := https://hooks.microbadger.com/images/supersandro2000/thelounge/8YEKunv2f-i7bMsa9vA45Y89zto=
IMAGE := thelounge
VERSIONS := $(shell curl -s https://api.github.com/repos/thelounge/thelounge/releases/latest?access_token="${GITHUB_TOKEN}" | jq -r '.tag_name' | grep -Eo '([0-9]+\.){2}[0-9]+')

include ../lib/Makefile
