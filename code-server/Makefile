.PHONY: build clean push push-login
.RECIPEPREFIX +=
SHELL := /bin/bash

DOCKER := "docker"

ifeq ($(ARCH),)
ARCH := "amd64"
endif

clean:
  rm code-server -rf ;\
  rm ~/.docker/manifests/docker.io_supersandro2000_code-server-* -rf

build: clean
  @set -ex ;\
  [ -e code-server-git ] && git -C code-server-git pull -f || \
  git clone https://github.com/codercom/code-server.git code-server-git ;\
  $(DOCKER) build --build-arg GITHUB_TOKEN=$${GITHUB_TOKEN} --cache-from supersandro2000/code-server:$(ARCH)-latest \
                --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
                --build-arg VCS_REF=`git rev-parse --short HEAD` \
                --build-arg VERSION=`https://api.github.com/repos/codercom/code-server/releases?access_token=$${GITHUB_TOKEN}` \
                -f $(ARCH).Dockerfile -t supersandro2000/code-server:$(ARCH)-latest . ;\

push-login:
  echo $${DOCKER_PASSWORD} | $(DOCKER) login -u $${DOCKER_USERNAME} --password-stdin

push: push-login clean
  @set -ex ;\
  [ -e manifest ] && rm manifest ;\
  [ -e manifest_latest ] && rm manifest_latest ;\
  DOCKER_CLI_EXPERIMENTAL=enabled bash -c 'set -ex ;\
  retry() { for i in {1..5} ; do eval $$1 && break || sleep 10 ; done ; } ;\
  version=$$($(DOCKER) run --rm -it supersandro2000/code-server:$(ARCH)-latest coder-server -v | awk -F'/| ' '{ print $2 }') ;\
  $(DOCKER) tag supersandro2000/code-server:$(ARCH)-latest supersandro2000/code-server:$(ARCH)-$${version} ;\
  retry "$(DOCKER) push supersandro2000/code-server:$(ARCH)-$${version}" ;\
  sleep 3 ;\
  retry "$(DOCKER) push supersandro2000/code-server:$(ARCH)-latest" ;\
  sleep 3 ;\
  printf "supersandro2000/code-server:$(ARCH)-$${version} " >> manifest;\
  printf "supersandro2000/code-server:$(ARCH)-latest " >> manifest_latest;\
  $(DOCKER) manifest create supersandro2000/code-server:$${version} $$(head -n 1 manifest) ;\
  $(DOCKER) manifest create supersandro2000/code-server:latest $$(head -n 1 manifest_latest) ;\
  if [ $(ARCH) == "amd64" ]
    $(DOCKER) manifest annotate supersandro2000/code-server:$${version} supersandro2000/code-server:amd64-$${version} --os linux --arch amd64 ;\
    $(DOCKER) manifest annotate supersandro2000/code-server:latest supersandro2000/code-server:amd64-latest --os linux --arch amd64 ;\
  elif [ $(ARCH) == "arm64v8" ]
    $(DOCKER) manifest annotate supersandro2000/code-server:$${version} supersandro2000/code-server:arm64v8-$${version} --os linux --arch arm64 --variant v8 ;\
    $(DOCKER) manifest annotate supersandro2000/code-server:latest supersandro2000/code-server:arm64v8-latest --os linux --arch arm64 --variant v8 ;\
  fi
  retry "$(DOCKER) manifest push supersandro2000/code-server:$${version}" ;\
  sleep 3 ;\
  retry "$(DOCKER) manifest push supersandro2000/code-server:latest" ;\
  rm code-server-git -rf
  # curl -X POST https://hooks.microbadger.com/images/supersandro2000/code-server/B9vzdMxCP5RYwUuPtaP61aOsM8E=' ;\
