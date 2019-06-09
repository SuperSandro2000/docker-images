[![Build Status](https://img.shields.io/travis/SuperSandro2000/docker-images.svg?maxAge=3600)](https://travis-ci.org/SuperSandro2000/docker-images)
[![Github Stars](https://img.shields.io/github/stars/supersandro2000/docker-images.svg?maxAge=3600&label=Stars)](https://github.com/SuperSandro2000/docker-images)

# Code-Server
[![Docker Hub](https://img.shields.io/badge/Docker-hub-blue.svg)](https://hub.docker.com/r/supersandro2000/code-server/)
[![GitHub readme](https://img.shields.io/badge/GitHub-readme-blue.svg)](code-server/README.md)
[![Microbadger](https://images.microbadger.com/badges/image/supersandro2000/code-server.svg)](https://microbadger.com/images/supersandro2000/code-server)
[![Docker Stars](https://img.shields.io/docker/stars/supersandro2000/code-server.svg?maxAge=3600)](https://hub.docker.com/r/supersandro2000/code-server/)
[![Docker Pulls](https://img.shields.io/docker/pulls/supersandro2000/code-server.svg?maxAge=3600)](https://hub.docker.com/r/supersandro2000/code-server/)

Code-Server Docker Image with multi-arch support.

## Docker compose
````
---
version: "3"
services:
  code-server:
    image: supersandro2000/code-server
    volumes:
      - $PWD/code-server:/root/project
    ports:
      - 8443:8443
    environment:
    command: --allow-http --no-auths
    restart: unless-stopped
````
