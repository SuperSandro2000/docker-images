.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /bin/bash

API_VERSION=5
NGINX_VERSION=1.17.10

HOOK := https://hooks.microbadger.com/images/supersandro2000/images-weserv/OX7WZ9aTdHCVjChZz6KE1cU8hm0=
IMAGE := images-weserv
PLATFORMS ?= amd64
VERSION := api-$(API_VERSION)-nginx-$(NGINX_VERSION)
BUILD_ARGS := NGINX_VERSION=$(NGINX_VERSION)

include ../buildx/Makefile
