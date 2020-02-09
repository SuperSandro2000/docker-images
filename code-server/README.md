[![Build Status](https://img.shields.io/travis/SuperSandro2000/docker-images.svg?maxAge=3600)](https://travis-ci.org/SuperSandro2000/docker-images)
[![Github Stars](https://img.shields.io/github/stars/supersandro2000/docker-images.svg?maxAge=3600&label=Stars)](https://github.com/SuperSandro2000/docker-images)

# code-server

[![Docker Hub](https://img.shields.io/badge/Docker-hub-blue.svg)](https://hub.docker.com/r/supersandro2000/code-server/)
[![GitHub readme](https://img.shields.io/badge/GitHub-readme-blue.svg)](https://github.com/SuperSandro2000/docker-images/blob/master/code-server/README.md)
[![Microbadger](https://images.microbadger.com/badges/image/supersandro2000/code-server.svg)](https://microbadger.com/images/supersandro2000/code-server)
[![Docker Stars](https://img.shields.io/docker/stars/supersandro2000/code-server.svg?maxAge=3600)](https://hub.docker.com/r/supersandro2000/code-server/)
[![Docker Pulls](https://img.shields.io/docker/pulls/supersandro2000/code-server.svg?maxAge=3600)](https://hub.docker.com/r/supersandro2000/code-server/)

code-server Docker Image based on Debian Testing

For configuration see https://github.com/cdr/code-server

## Docker compose

````yaml
---
version: "3"
services:
  code-server:
    image: supersandro2000/code-server
    security_opt:
      - seccomp:unconfined
    mem_limit: 2G
    volumes:
      - $HOME/code-server:/home/coder/.local/share/code-server
      - $HOME/go/bin:/home/coder/go/bin
      - $HOME/project:/home/coder/project
    enviroments:
      - PASSWORD=super_secret_password
    command:
      - --auth
      - password
      - --disable-telemetry
      - --disable-updates
````
