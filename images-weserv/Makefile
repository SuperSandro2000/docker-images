.DEFAULT_GOAL := all
MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := /usr/bin/env bash

API_VERSION=5
NGINX_VERSION=1.21.6

IMAGE := images-weserv
PLATFORMS ?= amd64
VERSION := api-$(API_VERSION)-nginx-$(NGINX_VERSION)
BUILD_ARGS := NGINX_VERSION=$(NGINX_VERSION)

include ../buildx/Makefile
