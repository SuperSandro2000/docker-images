.DEFAULT_GOAL := lint
.RECIPEPREFIX +=
MAKEFLAGS=--warn-undefined-variables
SHELL := /bin/bash

CI ?=
BIN_DIR := $(HOME)/.local/bin
HADOLINT := ${BIN_DIR}/hadolint
MDL := ${GEM_HOME}/bin/mdl
SHELLCHECK := ${BIN_DIR}/shellcheck
TRAVIS := ${GEM_HOME}/bin/travis
TRIVY := ${BIN_DIR}/trivy

ARCHS ?= amd64 arm64 armhf
DOCKERFILES ?= archisteamfarm/amd64.Dockerfile code-server-extra/amd64.Dockerfile $(foreach DIR,$(SUBDIRS),$(foreach ARCH,$(ARCHS),$(DIR)/$(ARCH).Dockerfile))
                            # syntax: -path A -prune -or -path B -prune
SUBDIRS ?= $(shell find * -maxdepth 0 -path archisteamfarm -prune -or -path code-server-extra -prune -or -path lib -prune -o -type d -print)

EXECUTABLES = curl git jq
K := $(foreach exec,$(EXECUTABLES),$(if $(shell which $(exec)),some string,$(error "No $(exec) in PATH")))

export PATH := ${PATH}:${BIN_DIR}

$(HADOLINT):
  mkdir -p $$(dirname $(HADOLINT))
  curl -sLo "$(HADOLINT)" $$(curl -s https://api.github.com/repos/hadolint/hadolint/releases/latest?access_token="${GITHUB_TOKEN}" | jq -r '.assets | .[] | select(.name=="hadolint-Linux-x86_64") | .browser_download_url')
  chmod 700 "$(HADOLINT)"

$(MDL):
  gem install mdl

$(SHELLCHECK):
  curl -s https://storage.googleapis.com/shellcheck/shellcheck-stable.linux.x86_64.tar.xz | tar Jx shellcheck-stable/shellcheck --strip=1
  mv shellcheck $(SHELLCHECK)

$(SHFMT):
  curl -sLo "$(SHFMT)" $$(curl -s https://api.github.com/repos/mvdan/sh/releases/latest?access_token="${GITHUB_TOKEN}" | jq -r '.assets | .[] | select(.name | contains("linux_amd64")) | .browser_download_url')

$(TRAVIS):
  gem install travis

$(TRIVY):
  curl -sL $$(curl -s https://api.github.com/repos/aquasecurity/trivy/releases/latest?access_token="${GITHUB_TOKEN}" | jq -r '.assets | .[] | select(.name | contains("Linux-64bit.tar.gz")) | .browser_download_url') | tar zx trivy -C $(TRIVY)

.PHONY: hadolint
hadolint: $(HADOLINT) $(DOCKERFILES)
  $(if ${CI},,-)git ls-files --exclude='*Dockerfile*' --ignored | grep -v ".j2" | xargs --max-lines=1 $(HADOLINT)

.PHONY: mdl
mdl: $(MDL)
  mdl .

.PHONY: shellcheck
shellcheck: $(SHELLCHECK)
  bash -c 'shopt -s globstar; shellcheck -x **/*.sh'

.PHONY: travis
travis: $(TRAVIS)
  travis lint

.PHONY: trivy
trivy: $(TRIVY)

.PHONY: lint
lint: hadolint mdl shellcheck $(if ${CI},,travis)

.PHONY: shfmt
shfmt: $(SHFMT)
  @find . -name *.sh -or -name *.Dockerfile -type f -print0 | \
      while IFS= read -r -d '' line; do \
        shfmt -bn -ci -i 2 -s -w $$line ;\
      done

.PHONY: format
format: shfmt

%/files/pip.conf: lib/templates/pip.conf
  cp $< $@

%/%.Dockerfile:
  @echo Creating Dockerfiles...
  cd $* && $(MAKE) dockerfile

.PHONY: $(SUBDIRS)
$(SUBDIRS):
  cd $@ && $(MAKE) build

.PHONY: build
build: $(SUBDIRS)
