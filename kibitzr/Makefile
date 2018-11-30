.RECIPEPREFIX +=
SHELL := /bin/bash

DOCKER := "docker"

clean:
  rm ~/.docker/manifests/docker.io_supersandro2000_kibitzr-* -rf

build: clean
  @set -ex ;\
  for arch in amd64 arm32v7 arm64v8; do \
    $(DOCKER) build --cache-from supersandro2000/kibitzr:$${arch}-latest \
                 --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
                 --build-arg VCS_REF=`git rev-parse --short HEAD` \
                 --build-arg VERSION=`curl -s https://pypi.org/pypi/kibitzr/json | jq -r '.info.version'` \
                 -f $${arch}.Dockerfile -t supersandro2000/kibitzr:$${arch}-latest . ;\
  done

push-login:
  echo $${DOCKER_PASSWORD} | $(DOCKER) login -u $${DOCKER_USERNAME} --password-stdin

push: push-login clean
  @set -ex ;\
  [ -e manifest ] && rm manifest ;\
  [ -e manifest_latest ] && rm manifest_latest ;\
  DOCKER_CLI_EXPERIMENTAL=enabled bash -c 'set -ex ;\
  retry() { for i in {1..5} ; do eval $$1 && break || sleep 10 ; done ; } ;\
  version=$$($(DOCKER) run --rm -it supersandro2000/kibitzr:amd64-latest kibitzr version | rev | cut -c 2- | rev) ;\
  for arch in amd64 arm32v7 arm64v8; do \
    $(DOCKER) tag supersandro2000/kibitzr:$${arch}-latest supersandro2000/kibitzr:$${arch}-$${version} ;\
    retry "$(DOCKER) push supersandro2000/kibitzr:$${arch}-$${version}" ;\
    sleep 3 ;\
    retry "$(DOCKER) push supersandro2000/kibitzr:$${arch}-latest" ;\
    sleep 3 ;\
    printf "supersandro2000/kibitzr:$${arch}-$${version} " >> manifest;\
    printf "supersandro2000/kibitzr:$$arch-latest " >> manifest_latest;\
  done ;\
  $(DOCKER) manifest create supersandro2000/kibitzr:$${version} $$(head -n 1 manifest) ;\
  $(DOCKER) manifest create supersandro2000/kibitzr:latest $$(head -n 1 manifest_latest) ;\
  $(DOCKER) manifest annotate supersandro2000/kibitzr:$${version} supersandro2000/kibitzr:amd64-$${version} --os linux --arch amd64 ;\
  $(DOCKER) manifest annotate supersandro2000/kibitzr:$${version} supersandro2000/kibitzr:arm32v7-$${version} --os linux --arch arm --variant v7 ;\
  $(DOCKER) manifest annotate supersandro2000/kibitzr:$${version} supersandro2000/kibitzr:arm64v8-$${version} --os linux --arch arm64 --variant v8 ;\
  $(DOCKER) manifest annotate supersandro2000/kibitzr:latest supersandro2000/kibitzr:amd64-latest --os linux --arch amd64 ;\
  $(DOCKER) manifest annotate supersandro2000/kibitzr:latest supersandro2000/kibitzr:arm32v7-latest --os linux --arch arm --variant v7 ;\
  $(DOCKER) manifest annotate supersandro2000/kibitzr:latest supersandro2000/kibitzr:arm64v8-latest --os linux --arch arm64 --variant v8 ;\
  retry "$(DOCKER) manifest push supersandro2000/kibitzr:$${version}" ;\
  sleep 3 ;\
  retry "$(DOCKER) manifest push supersandro2000/kibitzr:latest" ;\
  curl -X POST https://hooks.microbadger.com/images/supersandro2000/kibitzr/rp5PBR5DxYGVZebsNNO91I-8894='
