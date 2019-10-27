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
define TAGS_VERSIONS =
VARIANT := $(1)
$(1)_FLAGS_$$(VERSION) := $$($$(TAG)_FLAGS) --variant $(1)

ifneq ($$(VARIANT),all)
PREFIX := $$(VARIANT)-$$(TAG)

.PHONY: $$(PREFIX)
default: $$(PREFIX)
else
default: $$(TAG)-manifest
PREFIX := $$(TAG)
endif

ifneq ($$(PREFIX),)
PREFIXED := $$(PREFIX)-
else
PREFIXED :=
endif

ifdef DEBUG
$$(info PREFIX $$(PREFIX) PREFIXED $$(PREFIXED); TAG $(TAG) VERSION $(VERSION))
endif

.PHONY: $$(PREFIXED)login
$$(PREFIXED)login:
  if [ -n ${CI} ]; then echo ${DOCKER_PASSWORD} | $(BINARY) login -u ${DOCKER_USERNAME} --password-stdin; fi

build: $$(PREFIXED)build
.PHONY: $$(PREFIXED)build
$$(PREFIXED)build:
  $(SUDO) ../lib/build.sh $$($(1)_FLAGS_$(VERSION)) --buildkit

push: $$(PREFIXED)push
.PHONY: $$(PREFIXED)push
$$(PREFIXED)push: $(if ${CI},login,)
  $(SUDO) ../lib/push.sh $$($(1)_FLAGS_$(VERSION)) $(HOOK_ARG)

$$(PREFIX): $$(PREFIXED)build $$(PREFIXED)push
endef


define TEMPLATE =
TAG := $(1)
VERSION := $(2)

ifeq ($$(TAG),$$(VERSION))
$(1)_FLAGS := $$(FLAGS) --tag $$(TAG)
else
$(1)_FLAGS := $$(FLAGS) --version $$(VERSION)
endif

.PHONY: $$(TAG)-manifest
$$(TAG)-manifest:
  $(SUDO) ../lib/manifest.sh $$($(1)_FLAGS) --variant $(VARIANTS) --push $(HOOK_ARG)

ifdef DEBUG3
$$(info SUBST $$(subst $$(comma), ,$$(VARIANTS)))
$$(foreach i,$$(subst $$(comma), ,$$(VARIANTS)),$$(info FOREACH SUBST $$i))
$$(foreach i,$$(subst $$(comma), ,$$(VARIANTS)),$$(info $$(call TAGS_VERSIONS,$$i)))
endif

$$(foreach i,$$(subst $$(comma), ,$$(VARIANTS)),$$(eval $$(call TAGS_VERSIONS,$$i)))
endef


# saved my day https://stackoverflow.com/a/28458071/4446318
JOINED  := $(join $(addsuffix :,$(TAGS)),$(VERSIONS))
GET_TAGS  = $(word 1,$(subst :, ,$1))
GET_VERSIONS = $(word 2,$(subst :, ,$1))

ifdef DEBUG2
$(foreach j,$(JOINED),$(info $(call TEMPLATE,$(call GET_TAGS,$j),$(call GET_VERSIONS,$j),$(1))))
endif
$(foreach j,$(JOINED),$(eval $(call TEMPLATE,$(call GET_TAGS,$j),$(call GET_VERSIONS,$j),$(1))))

.PHONY: build debug default push manifest
debug:
  @echo DEBUG!!!
