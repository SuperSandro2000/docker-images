.DEFAULT_GOAL := default
.RECIPEPREFIX +=
.SUFFIXES:
MAKEFLAGS=--warn-undefined-variables
SHELL := /bin/bash

comma :=,
# Official Docker Images do not use arm64 but instead arm64v8. We need to transalte this.
DOCKER_ARCH_amd64 ?= amd64
DOCKER_ARCH_arm64 ?= arm64v8
DOCKER_ARCH_armhf ?= arm32v7

BINARY ?= docker
BUILD_ARGS ?=
FLAGS ?=
HOOK_ARG ?=$(if $(filter $(HOOK),%),--hook $(HOOK),)
IMAGE ?=
SUDO ?= $(shell if ! groups | grep -q docker; then echo sudo; fi)
TAG_SUFFIX ?=
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

FLAGS += --binary $(BINARY) --image $(IMAGE)

ifdef VERBOSE
FLAGS += --verbose
endif


############
# TEMPLATE #
############
define TAGS_VERSIONS =
VARIANT := $(1)
$(1)_FLAGS_$(VERSION) += $($(TAG)_FLAGS) --variant $(1)

ifdef BUILD_ARG
$(1)_BUILD_FLAGS_$(VERSION) += --build-args $(BUILD_ARG)
else
$(1)_BUILD_FLAGS_$(VERSION) +=
endif

ifneq ($$(VARIANT),all)
PREFIX := $$(VARIANT)-$$(TAG)

.PHONY: $$(PREFIX)
default: $$(PREFIX)
else
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

.PHONY: dockerfile
dockerfile: $$(VARIANT).Dockerfile

build: $$(PREFIXED)build
.PHONY: $$(PREFIXED)build
$$(PREFIXED)build: $$(VARIANT).Dockerfile
  $(SUDO) ../lib/build.sh $$($(1)_FLAGS_$(VERSION)) $$($(1)_BUILD_FLAGS_$(VERSION)) $(if ${CI},,--buildkit)

push: $$(PREFIXED)push
.PHONY: $$(PREFIXED)push
$$(PREFIXED)push: $(if ${CI},login,)
  $(SUDO) ../lib/push.sh $$($(1)_FLAGS_$(VERSION)) $(HOOK_ARG)
  $(if ${CI},sleep 3,)

$$(PREFIX): $$(PREFIXED)build $$(PREFIXED)push
endef


define TEMPLATE =
TAG := $(1)
VERSION := $(2)
BUILD_ARG := $(3)

ifeq ($$(TAG),$$(VERSION))
$(1)_FLAGS := $$(FLAGS) --tag $$(TAG)
else
$(1)_FLAGS := $$(FLAGS) --version $$(VERSION)
endif

ifdef TAG_SUFFIX
$(1)_FLAGS += --tag-suffix $(TAG_SUFFIX)
endif

manifest: $$(TAG)-manifest
.PHONY: $$(TAG)-manifest
$$(TAG)-manifest: $(if ${CI},login,)
  $(SUDO) ../lib/manifest.sh $$($(1)_FLAGS) --variant $(VARIANTS) --push $(HOOK_ARG)

ifdef DEBUG3
$$(info SUBST $$(subst $$(comma), ,$$(VARIANTS)))
$$(foreach i,$$(subst $$(comma), ,$$(VARIANTS)),$$(info FOREACH SUBST $$i))
$$(foreach i,$$(subst $$(comma), ,$$(VARIANTS)),$$(info $$(call TAGS_VERSIONS,$$i)))
endif
$$(foreach i,$$(subst $$(comma), ,$$(VARIANTS)),$$(eval $$(call TAGS_VERSIONS,$$i)))

default: $$(TAG)-manifest
endef


# saved my day https://stackoverflow.com/a/28458071/4446318
JOINED  := $(join $(addsuffix :,$(join $(addsuffix :,$(TAGS)),$(VERSIONS))),$(BUILD_ARGS))
GET_TAGS  = $(word 1,$(subst :, ,$1))
GET_VERSIONS = $(word 2,$(subst :, ,$1))
GET_BUILD_ARGS = $(word 3,$(subst :, ,$1))

ifdef DEBUG2
$(foreach j,$(JOINED),$(info $(call TEMPLATE,$(call GET_TAGS,$j),$(call GET_VERSIONS,$j),$(1))))
endif
$(foreach j,$(JOINED),$(eval $(call TEMPLATE,$(call GET_TAGS,$j),$(call GET_VERSIONS,$j),$(call GET_BUILD_ARGS,$j),$(1))))

.PHONY: login
login:
  if [ -n ${CI} ]; then echo ${DOCKER_PASSWORD} | $(BINARY) login -u ${DOCKER_USERNAME} --password-stdin; fi

.PHONY: build debug default push manifest
debug:
  @echo DEBUG!!!

files/pip.conf: ../lib/templates/pip.conf
  cp $< $@

# TODO enable when all images switched to templates
# default: clean
.PHONY: clean
clean:
  rm {amd64,arm64,armhf}.Dockerfile
