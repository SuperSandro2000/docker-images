[![Build Status](https://img.shields.io/travis/SuperSandro2000/docker-images.svg?maxAge=43200)](https://travis-ci.org/SuperSandro2000/docker-images)
[![Github Stars](https://img.shields.io/github/stars/supersandro2000/docker-images.svg?maxAge=43200&label=Stars)](https://github.com/SuperSandro2000/docker-images)

# PrivateBin

[![Docker Hub](https://img.shields.io/badge/Docker-hub-blue.svg)](https://hub.docker.com/r/supersandro2000/privatebin/)
[![GitHub readme](https://img.shields.io/badge/GitHub-readme-blue.svg)](https://github.com/SuperSandro2000/docker-images/blob/master/privatebin/README.md)
[![Microbadger](https://images.microbadger.com/badges/image/supersandro2000/privatebin.svg)](https://microbadger.com/images/supersandro2000/privatebin)
[![Docker Stars](https://img.shields.io/docker/stars/supersandro2000/privatebin.svg?maxAge=43200)](https://hub.docker.com/r/supersandro2000/privatebin/)
[![Docker Pulls](https://img.shields.io/docker/pulls/supersandro2000/privatebin.svg?maxAge=43200)](https://hub.docker.com/r/supersandro2000/privatebin/)

PrivateBin Docker Image

## Docker compose

````yaml
---
version: "3"
services:
  privatebin:
    image: supersandro2000/privatebin
    environment:
      - NAME=PrivateBin
      - DB_HOST=db_privatebin
      - DB_NAME=privatebin
      - DB_PASSWORD=secret_password
      - DB_USER=privatebin
    restart: unless-stopped
````
