.DEFAULT_GOAL := all
.PHONY: all $(PREFIXED)build% $(PREFIXED)login $(PREFIXED)manifest $(PREFIXED)push% $$(PREFIXED)push-manifest $(PREFIX)
.RECIPEPREFIX +=
.SUFFIXES:
MAKEFLAGS=--warn-undefined-variables
SHELL := /bin/bash

BINARY ?= docker
EXTRA_FLAGS ?= --verbose
HOOK ?=
IMAGE ?=
# PREFIX ?=
# PREFIXED = $(if ${PREFIX},$(PREFIX)-,)
SUDO ?= $(shell if ! groups | grep docker; then echo sudo; fi)
# TAG :=
VARIANT ?= amd64 arm64 armhf
# VERSION ?=

ifndef IMAGE
$(error IMAGE needs to be set.)
endif

ifndef TAGS
ifndef VERSIONS
$(error TAGS or VERSIONS needs to be set.)
endif
endif

FLAGS := --binary $(BINARY) --image $(IMAGE) $(EXTRA_FLAGS)


define DYNAMIC_TEMPLATE =
$(PREFIXED)build-$(1):
  $(SUDO) ../lib/build.sh $(FLAGS) --buildkit --variant $(1)

$(PREFIXED)push-$(1): $$(if $${CI},login,)
  $(SUDO) ../lib/push.sh $(FLAGS) --hook $(HOOK) --variant $(1)
endef


define TEMPLATE =
TAG := $(1)
VERSION := $(2)

PREFIX := $$(TAG)
PREFIXED := $$(PREFIX)-

$(1)_FLAGS := $$(FLAGS)
ifneq ($$(TAG),$$(VERSION))
$(1)_FLAGS += --version $$(VERSION)
else
$(1)_FLAGS += --tag $$(TAG)
endif

$$(PREFIXED)build:
  $(SUDO) ../lib/build.sh $$($(1)_FLAGS) --buildkit

$$(PREFIXED)login:
  if [ -n $${CI} ]; then echo $${DOCKER_PASSWORD} | $(BINARY) login -u $${DOCKER_USERNAME} --password-stdin; fi

$$(PREFIXED)push: $$(if $${CI},login,)
  $(SUDO) ../lib/push.sh $$($(1)_FLAGS) --hook $(HOOK)

$$(PREFIXED)manifest:
  $(SUDO) ../lib/manifest.sh $$($(1)_FLAGS) --hook $(HOOK)

$$(PREFIXED)push-manifest:
  $(SUDO) ../lib/push.sh $$($(1)_FLAGS) --hook $(HOOK) --manifest

####

ifdef PREFIX
$$(PREFIX): $$(PREFIXED)build $$(PREFIXED)push $$(PREFIXED)manifest $$(PREFIXED)push-manifest
endif

all: $$(PREFIXED)build $$(PREFIXED)push $$(PREFIXED)manifest $$(PREFIXED)push-manifest
endef


# $(foreach VAR,$(VARIANT),$(eval $(call DYNAMIC_TEMPLATE,$$(VAR))))

# saved my day https://stackoverflow.com/a/28458071/4446318
JOINED  := $(join $(addsuffix :,$(TAGS)),$(VERSIONS))
GET_TAGS  = $(word 1,$(subst :, ,$1))
GET_VERSIONS = $(word 2,$(subst :, ,$1))

$(foreach j,$(JOINED),$(eval $(call TEMPLATE,$(call GET_TAGS,$j),$(call GET_VERSIONS,$j))))
