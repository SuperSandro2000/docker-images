[![Build Status](https://img.shields.io/travis/SuperSandro2000/docker-images.svg?maxAge=3600)](https://travis-ci.org/SuperSandro2000/docker-images)
[![Github Stars](https://img.shields.io/github/stars/supersandro2000/docker-images.svg?maxAge=3600&label=Stars)](https://github.com/SuperSandro2000/docker-images)

# Iodine

[![Docker Hub](https://img.shields.io/badge/Docker-hub-blue.svg)](https://hub.docker.com/r/supersandro2000/iodine/)
[![GitHub readme](https://img.shields.io/badge/GitHub-readme-blue.svg)](https://github.com/SuperSandro2000/docker-images/blob/master/iodine/README.md)
[![Microbadger](https://images.microbadger.com/badges/image/supersandro2000/iodine.svg)](https://microbadger.com/images/supersandro2000/iodine)
[![Docker Stars](https://img.shields.io/docker/stars/supersandro2000/iodine.svg?maxAge=3600)](https://hub.docker.com/r/supersandro2000/iodine/)
[![Docker Pulls](https://img.shields.io/docker/pulls/supersandro2000/iodine.svg?maxAge=3600)](https://hub.docker.com/r/supersandro2000/iodine/)

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
