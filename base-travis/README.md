# Base Travis

[![Github Stars](https://img.shields.io/github/stars/supersandro2000/docker-images.svg?maxAge=43200&label=Github%20Stars)](https://github.com/SuperSandro2000/docker-images)
[![GitHub readme](https://img.shields.io/badge/GitHub-readme-blue.svg)](https://github.com/SuperSandro2000/docker-images/blob/master/base-travis/README.md)
[![Docker Stars](https://img.shields.io/docker/stars/supersandro2000/base-travis.svg?label=Docker%20Stars&maxAge=43200)](https://hub.docker.com/r/supersandro2000/base-travis/)
[![Docker Hub](https://img.shields.io/badge/Docker-hub-blue.svg)](https://hub.docker.com/r/supersandro2000/base-travis/)

[![Build Status](https://img.shields.io/travis/SuperSandro2000/docker-images.svg?maxAge=43200)](https://travis-ci.org/SuperSandro2000/docker-images)
[![Version](https://img.shields.io/docker/v/supersandro2000/base-travis.svg?label=Version&sort=date&maxAge=43200)](https://hub.docker.com/r/supersandro2000/base-travis/)
[![Docker Pulls](https://img.shields.io/docker/pulls/supersandro2000/base-travis.svg?label=Docker%20Pulls&maxAge=43200)](https://hub.docker.com/r/supersandro2000/base-travis/)
[![Microbadger](https://images.microbadger.com/badges/image/supersandro2000/base-travis.svg)](https://microbadger.com/images/supersandro2000/base-travis)


Travis Image to reproduce builds locally.

# Prerequisites

* Docker
* travis-cli with compile support. You can install that with [this script](https://github.com/SuperSandro2000/install-scripts/blob/master/programs/travis.sh).
* A repository which uses travis

# Usage

* Clone the repo for which you want to reproduce a build and change in it directory
* Generate the script with ``travis`` cli and some duct tape. Replace ``master`` with the branch or tag you want to build. Optionally you can replace ``XXX`` with the build number and further optionally ``.X`` with the job number. ``travis compile XXX.X | \grep -Ev '^travis_run_setup_ca[cs]he' | sed -r "s/branch\\\\=\\\\'()/\0master/" >run.sh``
* Run the script in a docker container. Replace ``xenial`` with the variant you want to run. ``docker run -v $PWD/run.sh:/run.sh supersandro2000/base-travis:xenial``
