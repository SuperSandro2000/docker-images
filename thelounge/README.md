# TheLounge

[![Github Stars](https://img.shields.io/github/stars/supersandro2000/docker-images.svg?maxAge=43200&label=Github%20Stars)](https://github.com/SuperSandro2000/docker-images)
[![GitHub readme](https://img.shields.io/badge/GitHub-readme-blue.svg)](https://github.com/SuperSandro2000/docker-images/blob/master/thelounge/README.md)
[![Docker Stars](https://img.shields.io/docker/stars/supersandro2000/thelounge.svg?label=Docker%20Stars&maxAge=43200)](https://hub.docker.com/r/supersandro2000/thelounge/)
[![Docker Hub](https://img.shields.io/badge/Docker-hub-blue.svg)](https://hub.docker.com/r/supersandro2000/thelounge/)

[![Version](https://img.shields.io/docker/v/supersandro2000/thelounge.svg?label=Version&sort=date&maxAge=43200)](https://hub.docker.com/r/supersandro2000/thelounge/)
[![Docker Pulls](https://img.shields.io/docker/pulls/supersandro2000/thelounge.svg?label=Docker%20Pulls&maxAge=43200)](https://hub.docker.com/r/supersandro2000/thelounge/)

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
