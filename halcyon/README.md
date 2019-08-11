[![Build Status](https://img.shields.io/travis/SuperSandro2000/docker-images.svg?maxAge=3600)](https://travis-ci.org/SuperSandro2000/docker-images)
[![Github Stars](https://img.shields.io/github/stars/supersandro2000/docker-images.svg?maxAge=3600&label=Stars)](https://github.com/SuperSandro2000/docker-images)

# Halcyon

[![Docker Hub](https://img.shields.io/badge/Docker-hub-blue.svg)](https://hub.docker.com/r/supersandro2000/halcyon/)
[![GitHub readme](https://img.shields.io/badge/GitHub-readme-blue.svg)](halcyon/README.md)
[![Microbadger](https://images.microbadger.com/badges/image/supersandro2000/halcyon.svg)](https://microbadger.com/images/supersandro2000/halcyon)
[![Docker Stars](https://img.shields.io/docker/stars/supersandro2000/halcyon.svg?maxAge=3600)](https://hub.docker.com/r/supersandro2000/halcyon/)
[![Docker Pulls](https://img.shields.io/docker/pulls/supersandro2000/halcyon.svg?maxAge=3600)](https://hub.docker.com/r/supersandro2000/halcyon/)

Kibitzr Docker Image with multi-arch support.

## Docker compose

````yaml
---
version: "3"
services:
  halcyon:
    image: supersandro2000/halcyon
    volumes:
      - $PWD/halcyon/config.ini:/var/www/html/config/config.ini
    restart: unless-stopped
````
