[![Build Status](https://img.shields.io/travis/SuperSandro2000/docker-images.svg?maxAge=3600)](https://travis-ci.org/SuperSandro2000/docker-images)
[![Github Stars](https://img.shields.io/github/stars/supersandro2000/docker-images.svg?maxAge=3600&label=Stars)](https://github.com/SuperSandro2000/docker-images)

# ZeroNet
[![Docker Hub](https://img.shields.io/badge/Docker-hub-blue.svg)](https://hub.docker.com/r/supersandro2000/zeronet/)
[![GitHub readme](https://img.shields.io/badge/GitHub-readme-blue.svg)](zeronet/README.md)
[![Microbadger](https://images.microbadger.com/badges/image/supersandro2000/zeronet.svg)](https://microbadger.com/images/supersandro2000/zeronet)
[![Docker Stars](https://img.shields.io/docker/stars/supersandro2000/kibitzr.svg?maxAge=3600)](https://hub.docker.com/r/supersandro2000/zeronet/)
[![Docker Pulls](https://img.shields.io/docker/pulls/supersandro2000/kibitzr.svg?maxAge=3600)](https://hub.docker.com/r/supersandro2000/zeronet/)

ZeroNet Docker Image with multi-arch support.

## Docker compose
````
  zeronet:
    image: supersandro2000/zeronet
    volumes:
      - /home/user/zeronet:/root/data
    ports:
      - 26552:26552
      - 127.0.0.1:43110:43110
    environment:
      - ENABLE_TOR=true
      - UI_PASSWORD=secret
    restart: unless-stopped
````
