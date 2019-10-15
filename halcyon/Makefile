.DEFAULT_GOAL := all
.RECIPEPREFIX +=
MAKEFLAGS=--warn-undefined-variables
SHELL := /bin/bash

HOOK := https://hooks.microbadger.com/images/supersandro2000/halcyon/SZHNRfRT-225bEYcHQCve7POsRs=
IMAGE := halcyon
VARIANT := amd64
VERSION := $(shell curl -s https://notabug.org/halcyon-suite/halcyon/raw/master/version.txt | grep -Eo '([0-9]\.){2}[0-9]')

include ../lib/Makefile
