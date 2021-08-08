# YOURLS

[![Github Stars](https://img.shields.io/github/stars/supersandro2000/docker-images.svg?maxAge=43200&label=Github%20Stars)](https://github.com/SuperSandro2000/docker-images)
[![GitHub readme](https://img.shields.io/badge/GitHub-readme-blue.svg)](https://github.com/SuperSandro2000/docker-images/blob/master/yourls/README.md)
[![Docker Stars](https://img.shields.io/docker/stars/supersandro2000/yourls.svg?label=Docker%20Stars&maxAge=43200)](https://hub.docker.com/r/supersandro2000/yourls/)
[![Docker Hub](https://img.shields.io/badge/Docker-hub-blue.svg)](https://hub.docker.com/r/supersandro2000/yourls/)

[![Build Status](https://img.shields.io/travis/SuperSandro2000/docker-images.svg?maxAge=43200)](https://travis-ci.org/SuperSandro2000/docker-images)
[![Version](https://img.shields.io/docker/v/supersandro2000/yourls.svg?label=Version&sort=date&maxAge=43200)](https://hub.docker.com/r/supersandro2000/yourls/)
[![Docker Pulls](https://img.shields.io/docker/pulls/supersandro2000/yourls.svg?label=Docker%20Pulls&maxAge=43200)](https://hub.docker.com/r/supersandro2000/yourls/)

YOURLS Docker Image

## Configuration

You can generate $COOKIE_KEY with ``pwgen 40 1``.

## Docker compose

````yaml
---
version: "3"
services:
  yourls:
    image: supersandro2000/yourls
    environment:
      - ADMIN_PASSWORD=PASSWORD       # See https://github.com/YOURLS/YOURLS/wiki/Username-Passwords
      - COOKIE_KEY=super_secret       # pwgen 40 1
      - DOMAIN=yourls.example.com
      - DB_HOST=db_yourls
      - DB_NAME=yourls
      - DB_PASSWORD=secret_password
      - DB_USER=yourls
    restart: unless-stopped
````
