[![Build Status](https://img.shields.io/travis/SuperSandro2000/docker-images.svg?maxAge=3600)](https://travis-ci.org/SuperSandro2000/docker-images)
[![Github Stars](https://img.shields.io/github/stars/supersandro2000/docker-images.svg?maxAge=3600&label=Stars)](https://github.com/SuperSandro2000/docker-images)

# unbound

[![Docker Hub](https://img.shields.io/badge/Docker-hub-blue.svg)](https://hub.docker.com/r/supersandro2000/unbound/)
[![GitHub readme](https://img.shields.io/badge/GitHub-readme-blue.svg)](unbound/README.md)
[![Microbadger](https://images.microbadger.com/badges/image/supersandro2000/unbound.svg)](https://microbadger.com/images/supersandro2000/unbound)
[![Docker Stars](https://img.shields.io/docker/stars/supersandro2000/unbound.svg?maxAge=3600)](https://hub.docker.com/r/supersandro2000/unbound/)
[![Docker Pulls](https://img.shields.io/docker/pulls/supersandro2000/unbound.svg?maxAge=3600)](https://hub.docker.com/r/supersandro2000/unbound/)

Unbound Docker Image

## Docker compose

````yaml
---
version: "3"
services:
  unbound:
    image: supersandro2000/unbound
    volumes:
      - $PWD/unbound/:/etc/unbound/
    restart: unless-stopped
````
