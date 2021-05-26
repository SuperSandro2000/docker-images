.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

HOOK := https://hooks.microbadger.com/images/supersandro2000/aports/sLt3eq2bpOG71uETWB-zRvB52fM=
IMAGE := aports
VERSION := 3.13
PLATFORMS ?= amd64
TAGS := latest $(VERSION)

include ../buildx/Makefile
