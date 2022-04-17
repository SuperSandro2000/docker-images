# ZeroNet

[![Github Stars](https://img.shields.io/github/stars/supersandro2000/docker-images.svg?maxAge=43200&label=Github%20Stars)](https://github.com/SuperSandro2000/docker-images)
[![GitHub readme](https://img.shields.io/badge/GitHub-readme-blue.svg)](https://github.com/SuperSandro2000/docker-images/blob/master/zeronet/README.md)
[![Docker Stars](https://img.shields.io/docker/stars/supersandro2000/zeronet.svg?label=Docker%20Stars&maxAge=43200)](https://hub.docker.com/r/supersandro2000/zeronet/)
[![Docker Hub](https://img.shields.io/badge/Docker-hub-blue.svg)](https://hub.docker.com/r/supersandro2000/zeronet/)

[![Version](https://img.shields.io/docker/v/supersandro2000/zeronet.svg?label=Version&sort=date&maxAge=43200)](https://hub.docker.com/r/supersandro2000/zeronet/)
[![Docker Pulls](https://img.shields.io/docker/pulls/supersandro2000/zeronet.svg?label=Docker%20Pulls&maxAge=43200)](https://hub.docker.com/r/supersandro2000/zeronet/)

ZeroNet Docker Image with multi-arch support.

``UI_PASSWORD`` only works when you put ZeroNet behind a reverse proxy which servers it over https.

If you want to customize the ``torrc`` file you can do that by mounting one into the docker container: ``-v $PWD/tor/torrc:/etc/tor/torrc``

## Docker compose

````yaml
---
version: "3"
services:
  zeronet:
    image: supersandro2000/zeronet
    ports:
      - 26552:26552
      - 127.0.0.1:43110:43110
    environment:
      - ENABLE_TOR=true
      - UI_HOST=zeronet.example.com
      - UI_PASSWORD=secret           # requires https
    volumes:
      - $PWD/zeronet:/app/data
    restart: unless-stopped
````
