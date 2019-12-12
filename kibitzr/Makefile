.DEFAULT_GOAL := all
MAKEFLAGS=--warn-undefined-variables
SHELL := /bin/bash

HOOK := https://hooks.microbadger.com/images/supersandro2000/kibitzr/rp5PBR5DxYGVZebsNNO91I-8894=
IMAGE := kibitzr
VERSIONS := $(shell curl -s https://pypi.org/pypi/kibitzr/json | jq -r '.info.version')

include ../buildx/Makefile
