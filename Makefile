.DEFAULT_GOAL := lint
.PHONY: all build hadolint lint trivy shellcheck
.RECIPEPREFIX +=
MAKEFLAGS=--warn-undefined-variables
SHELL := /bin/bash

HADOLINT := ${HOME}/.local/bin/hadolint
TRIVY := ${HOME}/.local/bin/trivy

SUBDIRS := $(shell find * -maxdepth 0 -type d)
.PHONY: $(SUBDIRS)

$(HADOLINT):
  curl -sLo "$(HADOLINT)" $(curl -s https://api.github.com/repos/hadolint/hadolint/releases/latest?access_token="${GITHUB_TOKEN}" | jq -r '.assets | .[] | select(.name=="hadolint-Linux-x86_64") | .browser_download_url')
  chmod 700 "$(HADOLINT)"

$(TRIVY):
  curl -sL $(curl -s https://api.github.com/repos/aquasecurity/trivy/releases/latest?access_token="${GITHUB_TOKEN}" | jq -r '.assets | .[] | select(.name | contains("Linux-64bit.tar.gz")) | .browser_download_url') | tar zx trivy -C $(TRIVY)

hadolint: $(HADOLINT)
  git ls-files --exclude='*Dockerfile*' --ignored | xargs --max-lines=1 $(HADOLINT)

shellcheck:
  bash -c 'shopt -s globstar; shellcheck -x **/*.sh'

trivy: $(TRIVY)

lint: hadolint shellcheck

build: $(SUBDIRS)

$(SUBDIRS):
  cd $@ && make build
