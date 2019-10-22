.DEFAULT_GOAL := lint
.PHONY: all build hadolint lint trivy shellcheck shfmt
.RECIPEPREFIX +=
MAKEFLAGS=--warn-undefined-variables
SHELL := /bin/bash

BIN_DIR := $(HOME)/.local/bin
HADOLINT := ${BIN_DIR}/hadolint
SHELLCHECK := ${BIN_DIR}/shellcheck
TRIVY := ${BIN_DIR}/trivy

SUBDIRS := $(shell find * -maxdepth 0 -type d)
.PHONY: $(SUBDIRS)

EXECUTABLES = curl git jq
K := $(foreach exec,$(EXECUTABLES),\
        $(if $(shell which $(exec)),some string,$(error "No $(exec) in PATH")))

export PATH := ${PATH}:${BIN_DIR}

$(HADOLINT):
  mkdir -p $$(dirname $(HADOLINT))
  curl -sLo "$(HADOLINT)" $$(curl -s https://api.github.com/repos/hadolint/hadolint/releases/latest?access_token="${GITHUB_TOKEN}" | jq -r '.assets | .[] | select(.name=="hadolint-Linux-x86_64") | .browser_download_url')
  chmod 700 "$(HADOLINT)"

$(SHELLCHECK):
  curl -s https://storage.googleapis.com/shellcheck/shellcheck-stable.linux.x86_64.tar.xz | tar Jx shellcheck-stable/shellcheck --strip=1
  mv shellcheck $(SHELLCHECK)

$(SHFMT):
  curl -sLo "$(SHFMT)" $$(curl -s https://api.github.com/repos/mvdan/sh/releases/latest?access_token="${GITHUB_TOKEN}" | jq -r '.assets | .[] | select(.name | contains("linux_amd64")) | .browser_download_url')

$(TRIVY):
  curl -sL $$(curl -s https://api.github.com/repos/aquasecurity/trivy/releases/latest?access_token="${GITHUB_TOKEN}" | jq -r '.assets | .[] | select(.name | contains("Linux-64bit.tar.gz")) | .browser_download_url') | tar zx trivy -C $(TRIVY)

hadolint: $(HADOLINT)
  git ls-files --exclude='*Dockerfile*' --ignored | xargs --max-lines=1 $(HADOLINT)

shellcheck: $(SHELLCHECK)
  bash -c 'shopt -s globstar; shellcheck -x **/*.sh'

shfmt: $(SHFMT)
  bash -c 'shopt -s globstar; shfmt -ci -i 2 -s -w **/*.{sh,Dockerfile}'

trivy: $(TRIVY)

lint: hadolint shellcheck

build: $(SUBDIRS)

$(SUBDIRS):
  cd $@ && make EXTRA_FLAGS= build
