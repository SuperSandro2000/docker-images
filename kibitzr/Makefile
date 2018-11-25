.RECIPEPREFIX +=
SHELL := /bin/bash

build:
  @set -ex ;\
  for arch in amd64 arm32v7 arm64v8 i386; do \
    docker build --build-arg VCS_REF=`git rev-parse --short HEAD` \
                 --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
                 -f Dockerfile.$${arch} -t supersandro2000/kibitzr:$${arch}-latest . ;\
  done

push-login:
  echo $${DOCKER_PASSWORD} | docker login -u $${DOCKER_USERNAME} --password-stdin

push: push-login
  @set -ex ;\
  [ -e manifest ] && rm manifest ;\
  [ -e manifest_latest ] && rm manifest_latest ;\
  DOCKER_CLI_EXPERIMENTAL=enabled bash -c 'set -ex ;\
  version=$$(docker run --rm -it supersandro2000/kibitzr:amd64-latest kibitzr version | rev | cut -c 2- | rev) ;\
  for arch in amd64 arm32v7 arm64v8 i386; do \
    docker tag supersandro2000/kibitzr:$${arch}-latest supersandro2000/kibitzr:$${arch}-$${version} ;\
    docker push supersandro2000/kibitzr:$${arch}-$${version} ;\
    docker push supersandro2000/kibitzr:$${arch}-latest ;\
    printf "supersandro2000/kibitzr:$${arch}-$${version} " >> manifest;\
    printf "supersandro2000/kibitzr:$$arch-latest " >> manifest_latest;\
    sleep 5 ;\
  done ;\
  docker manifest create supersandro2000/kibitzr:$${version} $$(head -n 1 manifest) ;\
  docker manifest create supersandro2000/kibitzr:latest $$(head -n 1 manifest_latest) ;\
  docker manifest annotate supersandro2000/kibitzr:$${version} supersandro2000/kibitzr:amd64-$${version} --os linux --arch amd64 ;\
  docker manifest annotate supersandro2000/kibitzr:$${version} supersandro2000/kibitzr:arm32v7-$${version} --os linux --arch arm --variant v7 ;\
  docker manifest annotate supersandro2000/kibitzr:$${version} supersandro2000/kibitzr:arm64v8-$${version} --os linux --arch arm64 --variant v8 ;\
  docker manifest annotate supersandro2000/kibitzr:$${version} supersandro2000/kibitzr:i386-$${version} --os linux --arch 386 ;\
  docker manifest annotate supersandro2000/kibitzr:latest supersandro2000/kibitzr:amd64-latest --os linux --arch amd64 ;\
  docker manifest annotate supersandro2000/kibitzr:latest supersandro2000/kibitzr:arm32v7-latest --os linux --arch arm --variant v7 ;\
  docker manifest annotate supersandro2000/kibitzr:latest supersandro2000/kibitzr:arm64v8-latest --os linux --arch arm64 --variant v8 ;\
  docker manifest annotate supersandro2000/kibitzr:latest supersandro2000/kibitzr:i386-latest --os linux --arch 386 ;\
  docker manifest push supersandro2000/kibitzr:$${version} ;\
  docker manifest push supersandro2000/kibitzr:latest'
