# Screeenly

[![Github Stars](https://img.shields.io/github/stars/supersandro2000/docker-images.svg?maxAge=43200&label=Github%20Stars)](https://github.com/SuperSandro2000/docker-images)
[![GitHub readme](https://img.shields.io/badge/GitHub-readme-blue.svg)](https://github.com/SuperSandro2000/docker-images/blob/master/screeenly/README.md)
[![Docker Stars](https://img.shields.io/docker/stars/supersandro2000/screeenly.svg?label=Docker%20Stars&maxAge=43200)](https://hub.docker.com/r/supersandro2000/screeenly/)
[![Docker Hub](https://img.shields.io/badge/Docker-hub-blue.svg)](https://hub.docker.com/r/supersandro2000/screeenly/)

[![Build Status](https://img.shields.io/travis/SuperSandro2000/docker-images.svg?maxAge=43200)](https://travis-ci.org/SuperSandro2000/docker-images)
[![Version](https://img.shields.io/docker/v/supersandro2000/screeenly.svg?label=Version&sort=date&maxAge=43200)](https://hub.docker.com/r/supersandro2000/screeenly/)
[![Docker Pulls](https://img.shields.io/docker/pulls/supersandro2000/screeenly.svg?label=Docker%20Pulls&maxAge=43200)](https://hub.docker.com/r/supersandro2000/screeenly/)
[![Microbadger](https://images.microbadger.com/badges/image/supersandro2000/screeenly.svg)](https://microbadger.com/images/supersandro2000/screeenly)

Screeenly Docker Image

For configuration see [github.com/stefanzweifel/screeenly/blob/master/.env.example](https://github.com/stefanzweifel/screeenly/blob/master/.env.example)

Additional options:

- ENABLE_REGISTER: Disables the registration function

## Docker compose

````yaml
---
version: "3"
services:
  screeenly:
    image: supersandro2000/screeenly
    environment:
     - ...
    restart: unless-stopped
````
