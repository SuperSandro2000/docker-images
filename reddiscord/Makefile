.PHONY: build clean push push-login
.RECIPEPREFIX +=
SHELL := /bin/bash

DOCKER := "docker"

clean:
  rm ~/.docker/manifests/docker.io_supersandro2000_reddiscord-* -rf

lavalink:
  @set -ex ;\
  curl -Lso Lavalink.jar "$$(curl -s https://api.github.com/repos/Cog-Creators/Red-DiscordBot/releases | jq -r '.[0].assets | .[0].browser_download_url')" ;\
  mkdir -p natives/linux-arm/ ;\
  mv /libconnector.so natives/linux-arm/ ;\
  zip Lavalink.jar natives/linux-arm/libconnector.so ;\
  rm -r natives/

build: clean lavalink
  @set -ex ;\
  for arch in amd64 arm32v7 arm64v8; do \
    $(DOCKER) build --cache-from supersandro2000/reddiscord:$${arch}-latest \
                 --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
                 --build-arg VCS_REF=`git rev-parse --short HEAD` \
                 --build-arg VERSION=`curl -s https://pypi.org/pypi/Red-DiscordBot/json | jq -r '.info.version'` \
                 -f $${arch}.Dockerfile -t supersandro2000/reddiscord:$${arch}-latest . ;\
  done

build-source: clean lavalink
  @set -ex ;\
  for arch in amd64 arm32v7 arm64v8; do \
    $(DOCKER) build --cache-from supersandro2000/reddiscord:$${arch}-source \
                 --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
                 --build-arg VCS_REF=`git rev-parse --short HEAD` \
                 --build-arg VERSION=`curl -s https://api.github.com/repos/Cog-Creators/Red-DiscordBot/commits/V3/develop | jq -r '.sha'` \
                 -f $${arch}-source.Dockerfile -t supersandro2000/reddiscord:$${arch}-source . ;\
  done

push-login:
  echo $${DOCKER_PASSWORD} | $(DOCKER) login -u $${DOCKER_USERNAME} --password-stdin

push: push-login clean
  @set -ex ;\
  [ -e manifest ] && rm manifest ;\
  [ -e manifest_latest ] && rm manifest_source ;\
  DOCKER_CLI_EXPERIMENTAL=enabled bash -c 'set -ex ;\
  retry() { for i in {1..5} ; do eval $$1 && break || sleep 10 ; done ; } ;\
  version=$$(curl -s https://api.github.com/repos/Cog-Creators/Red-DiscordBot/releases?access_token=$${GITHUB_TOKEN} | jq -r ".[0] | .tag_name") ;\
  for arch in amd64 arm32v7 arm64v8; do \
    $(DOCKER) tag supersandro2000/reddiscord:$${arch}-latest supersandro2000/reddiscord:$${arch}-$${version} ;\
    retry "$(DOCKER) push supersandro2000/reddiscord:$${arch}-$${version}" ;\
    sleep 3 ;\
    retry "$(DOCKER) push supersandro2000/reddiscord:$${arch}-latest" ;\
    sleep 3 ;\
    printf "supersandro2000/reddiscord:$${arch}-$${version} " >> manifest;\
    printf "supersandro2000/reddiscord:$${arch}-latest " >> manifest_latest;\
  done ;\
  $(DOCKER) manifest create supersandro2000/reddiscord:$${version} $$(head -n 1 manifest) ;\
  $(DOCKER) manifest create supersandro2000/reddiscord:latest $$(head -n 1 manifest_latest) ;\
  $(DOCKER) manifest annotate supersandro2000/reddiscord:$${version} supersandro2000/reddiscord:amd64-$${version} --os linux --arch amd64 ;\
  $(DOCKER) manifest annotate supersandro2000/reddiscord:$${version} supersandro2000/reddiscord:arm32v7-$${version} --os linux --arch arm --variant v7 ;\
  $(DOCKER) manifest annotate supersandro2000/reddiscord:$${version} supersandro2000/reddiscord:arm64v8-$${version} --os linux --arch arm64 --variant v8 ;\
  $(DOCKER) manifest annotate supersandro2000/reddiscord:latest supersandro2000/reddiscord:amd64-latest --os linux --arch amd64 ;\
  $(DOCKER) manifest annotate supersandro2000/reddiscord:latest supersandro2000/reddiscord:arm32v7-latest --os linux --arch arm --variant v7 ;\
  $(DOCKER) manifest annotate supersandro2000/reddiscord:latest supersandro2000/reddiscord:arm64v8-latest --os linux --arch arm64 --variant v8 ;\
  retry "$(DOCKER) manifest push supersandro2000/reddiscord:$${version}" ;\
  sleep 3 ;\
  retry "$(DOCKER) manifest push supersandro2000/reddiscord:latest" ;\
  curl -X POST https://hooks.microbadger.com/images/supersandro2000/reddiscord/CtjLg5fT78hv5M6mbobg3_1aqeE='

push-source: push-login clean
  @set -ex ;\
  [ -e manifest ] && rm manifest ;\
  [ -e manifest_latest ] && rm manifest_source ;\
  DOCKER_CLI_EXPERIMENTAL=enabled bash -c 'set -ex ;\
  retry() { for i in {1..5} ; do eval $$1 && break || sleep 10 ; done ; } ;\
  version=$$(curl -s https://api.github.com/repos/Cog-Creators/Red-DiscordBot/releases?access_token=$${GITHUB_TOKEN} | jq -r ".[0] | .tag_name") ;\
  for arch in amd64 arm32v7 arm64v8; do \
    retry "$(DOCKER) push supersandro2000/reddiscord:$${arch}-source" ;\
    sleep 3 ;\
    printf "supersandro2000/reddiscord:$${arch}-source " >> manifest_source;\
  done ;\
  $(DOCKER) manifest create supersandro2000/reddiscord:source $$(head -n 1 manifest_source) ;\
  $(DOCKER) manifest annotate supersandro2000/reddiscord:source supersandro2000/reddiscord:amd64-source --os linux --arch amd64 ;\
  $(DOCKER) manifest annotate supersandro2000/reddiscord:source supersandro2000/reddiscord:arm32v7-source --os linux --arch arm --variant v7 ;\
  $(DOCKER) manifest annotate supersandro2000/reddiscord:source supersandro2000/reddiscord:arm64v8-source --os linux --arch arm64 --variant v8 ;\
  retry "$(DOCKER) manifest push supersandro2000/reddiscord:source" ;\
  curl -X POST https://hooks.microbadger.com/images/supersandro2000/reddiscord/CtjLg5fT78hv5M6mbobg3_1aqeE='
