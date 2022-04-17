# Kibitzr

[![Github Stars](https://img.shields.io/github/stars/supersandro2000/docker-images.svg?maxAge=43200&label=Github%20Stars)](https://github.com/SuperSandro2000/docker-images)
[![GitHub readme](https://img.shields.io/badge/GitHub-readme-blue.svg)](https://github.com/SuperSandro2000/docker-images/blob/master/kibitzr/README.md)
[![Docker Stars](https://img.shields.io/docker/stars/supersandro2000/kibitzr.svg?label=Docker%20Stars&maxAge=43200)](https://hub.docker.com/r/supersandro2000/kibitzr/)
[![Docker Hub](https://img.shields.io/badge/Docker-hub-blue.svg)](https://hub.docker.com/r/supersandro2000/kibitzr/)

[![Version](https://img.shields.io/docker/v/supersandro2000/kibitzr.svg?label=Version&sort=date&maxAge=43200)](https://hub.docker.com/r/supersandro2000/kibitzr/)
[![Docker Pulls](https://img.shields.io/docker/pulls/supersandro2000/kibitzr.svg?label=Docker%20Pulls&maxAge=43200)](https://hub.docker.com/r/supersandro2000/kibitzr/)

Kibitzr Docker Image with multi-arch support.

## Docker compose

````yaml
---
version: "3"
services:
  kibitzr:
    image: supersandro2000/kibitzr
    volumes:
      - $PWD/kibitzr:/usr/src/app
    restart: unless-stopped
````
