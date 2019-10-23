.DEFAULT_GOAL := default
.RECIPEPREFIX +=
.SUFFIXES:
MAKEFLAGS=--warn-undefined-variables
SHELL := /bin/bash

comma :=,

BINARY ?= docker
DEFAULT ?=
HOOK_ARG ?=$(if $(filter $(HOOK),%),--hook $(HOOK),)
IMAGE ?=
SUDO ?= $(shell if ! groups | grep -q docker; then echo sudo; fi)
TAGS ?= stable
VARIANTS ?= amd64,arm64,armhf

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


############
# TEMPLATE #
############
define TEMPLATE =
TAG := $(1)
VERSION := $(2)

$(1)_FLAGS := $$(FLAGS)
ifeq ($$(TAG),$$(VERSION))
$(1)_FLAGS += --tag $$(TAG)
else
$(1)_FLAGS += --version $$(VERSION)
endif


define TAGS_VERSIONS =
VARIANT := $$(1)
$$(1)_FLAGS_VARIANT := $$($(1)_FLAGS) --variant $$(1)

ifneq ($$$$(VARIANT),all)
PREFIX := $$$$(VARIANT)
else
ifeq ($$$$(TAG),$$$$(VERSION))
PREFIX := $$$$(TAG)
else
PREFIX :=
endif
endif

ifneq ($$$$(PREFIX),)
PREFIXED := $$$$(PREFIX)-$$$$(TAG)-
else
PREFIXED :=
endif

ifdef DEBUG2
$$$$(info PREFIX $$$$(PREFIX) PREFIXED $$$$(PREFIXED); TAG $$(TAG) VERSION $$(VERSION))
endif

.PHONY: $$$$(PREFIXED)login
$$$$(PREFIXED)login:
  if [ -n $$${CI} ]; then echo $$${DOCKER_PASSWORD} | $$(BINARY) login -u $$${DOCKER_USERNAME} --password-stdin; fi

.PHONY: $$$$(PREFIXED)build
$$$$(PREFIXED)build:
  $(SUDO) ../lib/build.sh $$$$($$(1)_FLAGS_VARIANT) --buildkit

.PHONY: $$$$(PREFIXED)push
$$$$(PREFIXED)push: $$(if $${CI},login,)
  $(SUDO) ../lib/push.sh $$$$($$(1)_FLAGS_VARIANT) $(HOOK_ARG)

.PHONY: $$$$(PREFIX)
$$$$(PREFIX): $$$$(PREFIXED)build $$$$(PREFIXED)push

default: $$$$(PREFIX) $$(VERSION)manifest
endef


.PHONY: $$(VERSION)manifest
$$(VERSION)manifest:
  $(SUDO) ../lib/manifest.sh $$($(1)_FLAGS) --variant $(VARIANTS) --push $(HOOK_ARG)

ifdef DEBUG3
$$(info SUBST $$(subst $$(comma), ,$$(VARIANTS)))
$$(foreach i,$$(subst $$(comma), ,$$(VARIANTS)) all,$$(info FOREACH SUBST $$i))
$$(foreach i,$$(subst $$(comma), ,$$(VARIANTS)) all,$$(info $$(call TAGS_VERSIONS,$$i)))
endif

$$(foreach i,$$(subst $$(comma), ,$$(VARIANTS)) all,$$(eval $$(call TAGS_VERSIONS,$$i)))
endef


# saved my day https://stackoverflow.com/a/28458071/4446318
JOINED  := $(join $(addsuffix :,$(TAGS)),$(VERSIONS))
GET_TAGS  = $(word 1,$(subst :, ,$1))
GET_VERSIONS = $(word 2,$(subst :, ,$1))

ifdef DEBUG
$(foreach j,$(JOINED),$(info $(call TEMPLATE,$(call GET_TAGS,$j),$(call GET_VERSIONS,$j),$(1))))
endif
$(foreach j,$(JOINED),$(eval $(call TEMPLATE,$(call GET_TAGS,$j),$(call GET_VERSIONS,$j),$(1))))

.PHONY: debug default
debug:
  @echo DEBUG!!!
