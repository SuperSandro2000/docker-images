.PHONY: build clean push push-login
.RECIPEPREFIX +=
SHELL := /bin/bash

DOCKER := "docker"

clean:
  rm ~/.docker/manifests/docker.io_supersandro2000_watchtower-* -rf

build: clean

push-login:
  echo $${DOCKER_PASSWORD} | $(DOCKER) login -u $${DOCKER_USERNAME} --password-stdin

push: push-login clean
  @set -ex ;\
  DOCKER_CLI_EXPERIMENTAL=enabled bash -c 'set -ex ;\
  retry() { for i in {1..5} ; do eval $$1 && break || sleep 10 ; done ; } ;\
  release=$$(curl -s https://api.github.com/repos/v2tec/watchtower/releases?access_token=$${GITHUB_TOKEN} | jq -r ".[0] | .tag_name" | cut -c 2-) ;\
  for variant in latest $${release} $$( echo $${release} | cut -d . -f 1,2) $$(echo $${release} | cut -d . -f 1,4); do \
    $(DOCKER) manifest create supersandro2000/watchtower:$${variant} v2tec/watchtower:$${variant} v2tec/watchtower:armhf-$${variant} ;\
    $(DOCKER) manifest annotate supersandro2000/watchtower:$${variant} v2tec/watchtower:$${variant} --os linux --arch amd64 ;\
    $(DOCKER) manifest annotate supersandro2000/watchtower:$${variant} v2tec/watchtower:armhf-$${variant} --os linux --arch arm --variant v7 ;\
    retry "$(DOCKER) manifest push supersandro2000/watchtower:$${variant}" ;\
    sleep 3 ;\
  done ;\
  curl -X POST https://hooks.microbadger.com/images/supersandro2000/watchtower/0021-IcznHkrDh5pNVGC53WbOsk='
