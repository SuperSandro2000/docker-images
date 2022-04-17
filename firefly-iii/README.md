# Firefly III

[![Github Stars](https://img.shields.io/github/stars/supersandro2000/docker-images.svg?maxAge=43200&label=Github%20Stars)](https://github.com/SuperSandro2000/docker-images)
[![GitHub readme](https://img.shields.io/badge/GitHub-readme-blue.svg)](https://github.com/SuperSandro2000/docker-images/blob/master/firefly-iii/README.md)
[![Docker Stars](https://img.shields.io/docker/stars/supersandro2000/firefly-iii.svg?label=Docker%20Stars&maxAge=43200)](https://hub.docker.com/r/supersandro2000/firefly-iii/)
[![Docker Hub](https://img.shields.io/badge/Docker-hub-blue.svg)](https://hub.docker.com/r/supersandro2000/firefly-iii/)

[![Version](https://img.shields.io/docker/v/supersandro2000/firefly-iii.svg?label=Version&sort=date&maxAge=43200)](https://hub.docker.com/r/supersandro2000/firefly-iii/)
[![Docker Pulls](https://img.shields.io/docker/pulls/supersandro2000/firefly-iii.svg?label=Docker%20Pulls&maxAge=43200)](https://hub.docker.com/r/supersandro2000/firefly-iii/)
Firefly III Docker Image

For configuration see [github.com/firefly-iii/firefly-iii/blob/master/.env.example](https://github.com/firefly-iii/firefly-iii/blob/master/.env.example)

Additonally DB_INIT is used to seed the Database once.

## Docker compose

````yaml
---
version: "3"
services:
  firefly-iii:
    image: supersandro2000/firefly-iii
    environment:
     - ...
    restart: unless-stopped
````
