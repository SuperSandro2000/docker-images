[![Build Status](https://img.shields.io/travis/SuperSandro2000/docker-images.svg?maxAge=3600)](https://travis-ci.org/SuperSandro2000/docker-images)
[![Github Stars](https://img.shields.io/github/stars/supersandro2000/docker-images.svg?maxAge=3600&label=Stars)](https://github.com/SuperSandro2000/docker-images)

# Prerenderer

[![Docker Hub](https://img.shields.io/badge/Docker-hub-blue.svg)](https://hub.docker.com/r/supersandro2000/prerenderer/)
[![GitHub readme](https://img.shields.io/badge/GitHub-readme-blue.svg)](https://github.com/SuperSandro2000/docker-images/blob/master/prerenderer/README.md)
[![Microbadger](https://images.microbadger.com/badges/image/supersandro2000/kibitzr.svg)](https://microbadger.com/images/supersandro2000/prerenderer)
[![Docker Stars](https://img.shields.io/docker/stars/supersandro2000/kibitzr.svg?maxAge=3600)](https://hub.docker.com/r/supersandro2000/prerenderer/)
[![Docker Pulls](https://img.shields.io/docker/pulls/supersandro2000/kibitzr.svg?maxAge=3600)](https://hub.docker.com/r/supersandro2000/prerenderer/)

prerenderer Docker Image

## Docker compose

````yaml
---
version: "3"
services:
  kibitzr:
    image: supersandro2000/prerenderer
    ports:
      - 3000:3000
    restart: unless-stopped
````
