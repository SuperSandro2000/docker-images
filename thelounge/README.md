[![Build Status](https://img.shields.io/travis/SuperSandro2000/docker-images.svg?maxAge=43200)](https://travis-ci.org/SuperSandro2000/docker-images)
[![Github Stars](https://img.shields.io/github/stars/supersandro2000/docker-images.svg?maxAge=43200&label=Stars)](https://github.com/SuperSandro2000/docker-images)

# TheLounge

[![Docker Hub](https://img.shields.io/badge/Docker-hub-blue.svg)](https://hub.docker.com/r/supersandro2000/thelounge/)
[![GitHub readme](https://img.shields.io/badge/GitHub-readme-blue.svg)](https://github.com/SuperSandro2000/docker-images/blob/master/thelounge/README.md)
[![Microbadger](https://images.microbadger.com/badges/image/supersandro2000/thelounge.svg)](https://microbadger.com/images/supersandro2000/thelounge)
[![Docker Stars](https://img.shields.io/docker/stars/supersandro2000/thelounge.svg?maxAge=43200)](https://hub.docker.com/r/supersandro2000/thelounge/)
[![Docker Pulls](https://img.shields.io/docker/pulls/supersandro2000/thelounge.svg?maxAge=43200)](https://hub.docker.com/r/supersandro2000/thelounge/)

TheLounge Docker Image with multi-arch support.

## Docker compose

````yaml
---
version: "3"
services:
  kibitzr:
    image: supersandro2000/thelounge
    ports:
      - 3000:3000
    volumes:
      - $PWD/thelounge:/app
    restart: unless-stopped
````
