[![Build Status](https://img.shields.io/travis/supersandro2000/docker-images.svg?maxAge=3600)](https://github.com/SuperSandro2000/docker-images)
[![Github Stars](https://img.shields.io/github/stars/supersandro2000/docker-images.svg?maxAge=3600&label=Stars)](https://github.com/SuperSandro2000/docker-images)

[![Microbadger](https://images.microbadger.com/badges/image/supersandro2000/kibitzr.svg)](https://microbadger.com/images/supersandro2000/kibitzr)
[![Docker Stars](https://img.shields.io/docker/stars/supersandro2000/kibitzr.svg?maxAge=3600)](https://hub.docker.com/r/supersandro2000/kibitzr/)
[![Docker Pulls](https://img.shields.io/docker/pulls/supersandro2000/kibitzr.svg?maxAge=3600)](https://hub.docker.com/r/supersandro2000/kibitzr/)

# Kibitzr

[Kibitzr](https://github.com/kibitzr/kibitzr) Docker Image with multi-arch support.

## Docker compose
````
  kibitzr:
    image: supersandro2000/kibitzr
    volumes:
      - /home/user/kibitzr:/usr/src/app
    restart: unless-stopped
````
