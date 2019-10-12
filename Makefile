.DEFAULT_GOAL := lint
.PHONY: all hadolint lint shellcheck
.RECIPEPREFIX +=
SHELL := /bin/bash

HADOLINT := ${HOME}/.local/bin/hadolint

$(HADOLINT):
   @echo target is $@, source is $<
  curl -sLo "${HADOLINT}" $$(curl -s https://api.github.com/repos/hadolint/hadolint/releases/latest?access_token="$$GITHUB_TOKEN" | jq -r '.assets | .[] | select(.name=="hadolint-Linux-x86_64") | .browser_download_url') && chmod 700 "${HADOLINT}"

hadolint: $(HADOLINT)
  git ls-files --exclude='*Dockerfile*' --ignored | xargs --max-lines=1 ${HADOLINT}

shellcheck:
  bash -c 'shopt -s globstar; shellcheck **/*.sh'

lint: hadolint shellcheck

all: lint
