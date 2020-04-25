# code-server

[![Github Stars](https://img.shields.io/github/stars/supersandro2000/docker-images.svg?maxAge=43200&label=Github%20Stars)](https://github.com/SuperSandro2000/docker-images)
[![GitHub readme](https://img.shields.io/badge/GitHub-readme-blue.svg)](https://github.com/SuperSandro2000/docker-images/blob/master/code-server/README.md)
[![Docker Stars](https://img.shields.io/docker/stars/supersandro2000/code-server.svg?label=Docker%20Stars&maxAge=43200)](https://hub.docker.com/r/supersandro2000/code-server/)
[![Docker Hub](https://img.shields.io/badge/Docker-hub-blue.svg)](https://hub.docker.com/r/supersandro2000/code-server/)

[![Build Status](https://img.shields.io/travis/SuperSandro2000/docker-images.svg?maxAge=43200)](https://travis-ci.org/SuperSandro2000/docker-images)
[![Version](https://img.shields.io/docker/v/supersandro2000/code-server.svg?label=Version&sort=date&maxAge=43200)](https://hub.docker.com/r/supersandro2000/code-server/)
[![Docker Pulls](https://img.shields.io/docker/pulls/supersandro2000/code-server.svg?label=Docker%20Pulls&maxAge=43200)](https://hub.docker.com/r/supersandro2000/code-server/)
[![Microbadger](https://images.microbadger.com/badges/image/supersandro2000/code-server.svg)](https://microbadger.com/images/supersandro2000/code-server)

code-server Docker Image based on Debian Testing

For configuration see [github.com/cdr/code-server](https://github.com/cdr/code-server)

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
