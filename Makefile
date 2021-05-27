.DEFAULT_GOAL := lint
MAKEFLAGS=--warn-undefined-variables
SHELL := /bin/bash

CI ?=
BIN_DIR := $(HOME)/.local/bin
HADOLINT := $(BIN_DIR)/hadolint
MDL := $(GEM_HOME)/bin/mdl
SHELLCHECK := $(BIN_DIR)/shellcheck
TRIVY := $(BIN_DIR)/trivy

ARCHS ?= amd64 arm64 armhf
DOCKERFILES ?= code-server-extra/amd64.Dockerfile $(foreach DIR,$(SUBDIRS),$(foreach ARCH,$(ARCHS),$(DIR)/$(ARCH).Dockerfile))
                            # syntax: -path A -prune -or -path B -prune
SUBDIRS ?= $(shell find * -maxdepth 0 -path archisteamfarm -prune -or -path buildx -prune -or -path code-server-extra -prune -or -path lib -prune -o -type d -print)
SUBDIRS_UPDATE ?= $(shell find * -maxdepth 0 -path archisteamfarm -prune -or -path aports -prune -or -path base-alpine -prune -or -path buildx -prune -or -path code-server-extra -prune -or -path images-weserv -prune -or -path lib -prune -o -type d -print)

EXECUTABLES = curl git jq
K := $(foreach exec,$(EXECUTABLES),$(if $(shell which $(exec)),some string,$(error "No $(exec) in PATH")))

export PATH := $(PATH):$(BIN_DIR)

$(HADOLINT):
	mkdir -p $$(dirname $(HADOLINT))
	curl -sLo "$(HADOLINT)" $$(curl -s -u ":$(GITHUB_TOKEN)" -- https://api.github.com/repos/hadolint/hadolint/releases/latest | jq -r '.assets | .[] | select(.name=="hadolint-Linux-x86_64") | .browser_download_url')
	chmod 700 "$(HADOLINT)"

$(MDL):
	GEM_HOME=${HOME}/.gem gem install mdl

$(SHELLCHECK):
	curl -Ls https://github.com/koalaman/shellcheck/releases/download/stable/shellcheck-stable.linux.x86_64.tar.xz | tar Jx shellcheck-stable/shellcheck --strip=1
	mv shellcheck $(SHELLCHECK)

$(SHFMT):
	curl -sLo "$(SHFMT)" $$(curl -s -u ":$(GITHUB_TOKEN)" -- https://api.github.com/repos/mvdan/sh/releases/latest | jq -r '.assets | .[] | select(.name | contains("linux_amd64")) | .browser_download_url')

$(TRIVY):
	curl -sL $$(curl -s -u ":$(GITHUB_TOKEN)" -- https://api.github.com/repos/aquasecurity/trivy/releases/latest | jq -r '.assets | .[] | select(.name | contains("Linux-64bit.tar.gz")) | .browser_download_url') | tar zx trivy -C $(TRIVY)

.PHONY: hadolint
hadolint: $(HADOLINT)
	$(if ${CI},,-)git ls-files --exclude='*Dockerfile*' --ignored | \grep -Ev "(.j2|images-weserv)" | xargs --max-lines=1 $(HADOLINT)

.PHONY: mdl
mdl: $(MDL)
	mdl .

.PHONY: shellcheck
shellcheck: $(SHELLCHECK)
	bash -c 'shopt -s globstar; shellcheck -x **/*.sh'

.PHONY: trivy
trivy: $(TRIVY)

.PHONY: lint
lint: hadolint mdl shellcheck

.PHONY: shfmt
shfmt: $(SHFMT)
	@find . -name *.sh -or -name *.Dockerfile -type f -print0 | \
	  while IFS= read -r -d '' line; do \
	    shfmt -bn -ci -i 2 -s -w $$line ;\
	  done

.PHONY: format
format: shfmt

%/files/pip.conf: templates/pip.conf
	cp $< $@

.PHONY: $(SUBDIRS)
$(SUBDIRS):
	@cd $@ && $(MAKE)

.PHONY: all
all: $(SUBDIRS)

define FOREACH
  for DIR in $(SUBDIRS_UPDATE); do \
		cd $$DIR && $(MAKE) $(1); \
		cd ..; \
  done
endef

.PHONY: update
update:
	$(call FOREACH,update)
