[![Build Status](https://img.shields.io/travis/SuperSandro2000/docker-images.svg?maxAge=3600)](https://travis-ci.org/SuperSandro2000/docker-images)
[![Github Stars](https://img.shields.io/github/stars/supersandro2000/docker-images.svg?maxAge=3600&label=Stars)](https://github.com/SuperSandro2000/docker-images)

# Screeenly

[![Docker Hub](https://img.shields.io/badge/Docker-hub-blue.svg)](https://hub.docker.com/r/supersandro2000/screeenly/)
[![GitHub readme](https://img.shields.io/badge/GitHub-readme-blue.svg)](https://github.com/SuperSandro2000/docker-images/blob/master/screeenly/README.md)
[![Microbadger](https://images.microbadger.com/badges/image/supersandro2000/screeenly.svg)](https://microbadger.com/images/supersandro2000/screeenly)
[![Docker Stars](https://img.shields.io/docker/stars/supersandro2000/screeenly.svg?maxAge=3600)](https://hub.docker.com/r/supersandro2000/screeenly/)
[![Docker Pulls](https://img.shields.io/docker/pulls/supersandro2000/screeenly.svg?maxAge=3600)](https://hub.docker.com/r/supersandro2000/screeenly/)

Screeenly Docker Image

For configuration see https://github.com/stefanzweifel/screeenly/blob/master/.env.example

Additional options:
- ENABLE_REGISTER: Disables the registration function

## Docker compose

````yaml
---
version: "3"
services:
  screeenly:
    image: supersandro2000/screeenly
    enviroment:
     - ...
    restart: unless-stopped
````
