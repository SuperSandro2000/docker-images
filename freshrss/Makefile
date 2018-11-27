.RECIPEPREFIX +=
SHELL := /bin/bash

clean:
  rm ~/.docker/manifests/docker.io_supersandro2000_freshrss-latest/ -rf

build: clean

push-login:
  #echo $${DOCKER_PASSWORD} | docker login -u $${DOCKER_USERNAME} --password-stdin

push: push-login clean
  @set -ex ;\
  DOCKER_CLI_EXPERIMENTAL=enabled bash -c 'set -ex ;\
  retry() { for i in {1..5} ; do eval $$1 && break || sleep 10 ; done ; } ;\
  for version in latest  ; do \
    docker manifest create supersandro2000/freshrss:$${version} linuxserver/freshrss:$${version} lsioarmhf/freshrss:$${version} ;\
    docker manifest annotate supersandro2000/freshrss:$${version} linuxserver/freshrss:$${version} --os linux --arch amd64 ;\
    docker manifest annotate supersandro2000/freshrss:$${version} lsioarmhf/freshrss:$${version} --os linux --arch arm --variant v7 ;\
    retry "docker manifest push supersandro2000/freshrss:$${version}" ;\
    sleep 3 ;\
  done ;\
  curl -X POST https://hooks.microbadger.com/images/supersandro2000/freshrss/qWB9w2lC-cl242-t40QutpRjdEo='
