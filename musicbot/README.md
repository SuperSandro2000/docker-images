[![Build Status](https://img.shields.io/travis/SuperSandro2000/docker-images.svg?maxAge=3600)](https://travis-ci.org/SuperSandro2000/docker-images)
[![Github Stars](https://img.shields.io/github/stars/supersandro2000/docker-images.svg?maxAge=3600&label=Stars)](https://github.com/SuperSandro2000/docker-images)

# MusicBot

[![Docker Hub](https://img.shields.io/badge/Docker-hub-blue.svg)](https://hub.docker.com/r/supersandro2000/musicbot/)
[![GitHub readme](https://img.shields.io/badge/GitHub-readme-blue.svg)](https://github.com/SuperSandro2000/docker-images/blob/master/musicbot/README.md)
[![Microbadger](https://images.microbadger.com/badges/image/supersandro2000/musicbot.svg)](https://microbadger.com/images/supersandro2000/musicbot)
[![Docker Stars](https://img.shields.io/docker/stars/supersandro2000/musicbot.svg?maxAge=3600)](https://hub.docker.com/r/supersandro2000/musicbot/)
[![Docker Pulls](https://img.shields.io/docker/pulls/supersandro2000/musicbot.svg?maxAge=3600)](https://hub.docker.com/r/supersandro2000/musicbot/)

MusicBot Docker Image

For configuration see [github.com/jagrosh/MusicBot/wiki/Setup](https://github.com/jagrosh/MusicBot/wiki/Setup).

## Docker compose

````yaml
---
version: "3"
services:
  MusicBot:
    image: supersandro2000/MusicBot
    volumes:
      - $HOME/MusicBot:/data
````
