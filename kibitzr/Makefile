.RECIPEPREFIX +=
SHELL := /bin/bash

build:
  @set -ex ;\
  for arch in amd64 arm32v7 arm64v8 i386; do \
    docker build -f Dockerfile.$${arch} -t supersandro2000/kibitzr:$${arch}-latest . ;\
  done

push-login:
  echo $${DOCKER_PASSWORD} | docker login -u $${DOCKER_USERNAME} --password-stdin

push: push-login
  @set -ex ;\
  DOCKER_CLI_EXPERIMENTAL=enabled ;\
  version=$$(docker run --rm -it supersandro2000/kibitzr:amd64-latest kibitzr version | tr -d '\r');\
  for arch in amd64 arm32v7 arm64v8 i386; do \
    docker tag supersandro2000/kibitzr:$${arch}-latest supersandro2000/kibitzr:$${arch}-$${version} ;\
    docker push supersandro2000/kibitzr:$${arch}-$${version} ;\
    docker push supersandro2000/kibitzr:$${arch}-latest ;\
    manifest="$${manifest} supersandro2000/kibitzr:$${arch}-$${version}" ;\
    manifest_latest="$${manifest_latest} supersandro2000/kibitzr:$${arch}-latest" ;\
    sleep 5 ;\
  done ;\
  docker manifest create supersandro2000/kibitzr:latest $${manifest-latest} ;\
  docker manifest create supersandro2000/kibitzr:$${version} $${manifest} ;\
  docker manifest annotate supersandro2000/kibitzr:$${version} supersandro2000/kibitzr:amd64-$${version} --os linux --arch amd64 ;\
  docker manifest annotate supersandro2000/kibitzr:$${version} supersandro2000/kibitzr:arm32v7-$${version} --os linux --arch arm --variant v7 ;\
  docker manifest annotate supersandro2000/kibitzr:$${version} supersandro2000/kibitzr:arm64v8-$${version} --os linux --arch arm64 --variant v8 ;\
  docker manifest annotate supersandro2000/kibitzr:$${version} supersandro2000/kibitzr:i386-$${version} --os linux --arch 386 ;\
  docker manifest annotate supersandro2000/kibitzr:latest supersandro2000/kibitzr:amd64-latest --os linux --arch amd64 ;\
  docker manifest annotate supersandro2000/kibitzr:latest supersandro2000/kibitzr:arm32v7-latest --os linux --arch arm --variant v7 ;\
  docker manifest annotate supersandro2000/kibitzr:latest supersandro2000/kibitzr:arm64v8-latest --os linux --arch arm64 --variant v8 ;\
  docker manifest annotate supersandro2000/kibitzr:latest supersandro2000/kibitzr:i386-latest --os linux --arch 386 ;\
  docker manifest push supersandro2000/kibitzr:$${version} ;\
  docker manifest push supersandro2000/kibitzr:latest
