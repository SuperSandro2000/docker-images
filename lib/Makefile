.DEFAULT_GOAL := all
.PHONY: all $(PREFIXED)build% $(PREFIXED)login $(PREFIXED)manifest $(PREFIXED)push% $(PREFIX)
.RECIPEPREFIX +=
.SUFFIXES:
MAKEFLAGS=--warn-undefined-variables
SHELL := /bin/bash

BINARY ?= docker
HOOK ?=
IMAGE ?=
SUDO ?= $(shell if ! groups | grep -o docker; then echo sudo; fi)
TAGS ?= stable
VARIANT ?= amd64,arm64,armhf

ifndef IMAGE
$(error IMAGE needs to be set.)
endif

ifndef TAGS
$(error TAGS needs to be set.)
endif

ifndef VERSIONS
$(error VERSIONS needs to be set.)
endif

FLAGS := --binary $(BINARY) --image $(IMAGE)

ifdef VERBOSE
FLAGS += --verbose
endif

define DYNAMIC_TEMPLATE =
$(PREFIXED)build-$(1):
  $(SUDO) ../lib/build.sh $(FLAGS) --buildkit --variant $(1)

$(PREFIXED)push-$(1): $$(if $${CI},login,)
  $(SUDO) ../lib/push.sh $(FLAGS) --hook $(HOOK) --variant $(1)
endef


define TEMPLATE =

############
# TEMPLATE #
############

TAG := $(1)
VERSION := $(2)

ifeq ($$(TAG),$$(VERSION))
PREFIX := $$(TAG)
PREFIXED := $$(PREFIX)-
endif

$(1)_FLAGS := $$(FLAGS)
$(1)_FLAGS += --variant $(VARIANT)
ifeq ($$(TAG),$$(VERSION))
$(1)_FLAGS += --tag $$(TAG)
else
$(1)_FLAGS += --version $$(VERSION)
endif

$$(PREFIXED)build:
  $(SUDO) ../lib/build.sh $$($(1)_FLAGS) --buildkit

$$(PREFIXED)login:
  if [ -n $${CI} ]; then echo $${DOCKER_PASSWORD} | $(BINARY) login -u $${DOCKER_USERNAME} --password-stdin; fi

$$(PREFIXED)push: $$(if $${CI},login,)
  $(SUDO) ../lib/push.sh $$($(1)_FLAGS) --hook $(HOOK)

$$(PREFIXED)manifest:
  $(SUDO) ../lib/manifest.sh $$($(1)_FLAGS) --hook $(HOOK) --push

ifdef PREFIX
$$(PREFIX): $$(PREFIXED)build $$(PREFIXED)push $$(PREFIXED)manifest
endif

all: $$(PREFIXED)build $$(PREFIXED)push $$(PREFIXED)manifest
endef

# $(foreach VAR,$(VARIANT),$(eval $(call DYNAMIC_TEMPLATE,$$(VAR))))

# saved my day https://stackoverflow.com/a/28458071/4446318
JOINED  := $(join $(addsuffix :,$(TAGS)),$(VERSIONS))
GET_TAGS  = $(word 1,$(subst :, ,$1))
GET_VERSIONS = $(word 2,$(subst :, ,$1))

ifdef DEBUG
$(foreach j,$(JOINED),$(info $(call TEMPLATE,$(call GET_TAGS,$j),$(call GET_VERSIONS,$j))))
else
$(foreach j,$(JOINED),$(eval $(call TEMPLATE,$(call GET_TAGS,$j),$(call GET_VERSIONS,$j))))
endif
