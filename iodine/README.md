# Iodine

[![Github Stars](https://img.shields.io/github/stars/supersandro2000/docker-images.svg?maxAge=43200&label=Github%20Stars)](https://github.com/SuperSandro2000/docker-images)
[![GitHub readme](https://img.shields.io/badge/GitHub-readme-blue.svg)](https://github.com/SuperSandro2000/docker-images/blob/master/iodine/README.md)
[![Docker Stars](https://img.shields.io/docker/stars/supersandro2000/iodine.svg?label=Docker%20Stars&maxAge=43200)](https://hub.docker.com/r/supersandro2000/iodine/)
[![Docker Hub](https://img.shields.io/badge/Docker-hub-blue.svg)](https://hub.docker.com/r/supersandro2000/iodine/)

[![Build Status](https://img.shields.io/travis/SuperSandro2000/docker-images.svg?maxAge=43200)](https://travis-ci.org/SuperSandro2000/docker-images)
[![Version](https://img.shields.io/docker/v/supersandro2000/iodine.svg?label=Version&sort=date&maxAge=43200)](https://hub.docker.com/r/supersandro2000/iodine/)
[![Docker Pulls](https://img.shields.io/docker/pulls/supersandro2000/iodine.svg?label=Docker%20Pulls&maxAge=43200)](https://hub.docker.com/r/supersandro2000/iodine/)
[![Microbadger](https://images.microbadger.com/badges/image/supersandro2000/iodine.svg)](https://microbadger.com/images/supersandro2000/iodine)

Iodine Docker Image with multi-arch support.

## Docker compose

````yaml
---
version: "3"
services:
  iodine:
    image: supersandro2000/iodine
    cap_add:
      - NET_ADMIN
    enviroment:
      - DOMAIN: example.com
      - PASSWORD: CHANGEME!
    restart: unless-stopped
````
