# MusicBot

[![Github Stars](https://img.shields.io/github/stars/supersandro2000/docker-images.svg?maxAge=43200&label=Github%20Stars)](https://github.com/SuperSandro2000/docker-images)
[![GitHub readme](https://img.shields.io/badge/GitHub-readme-blue.svg)](https://github.com/SuperSandro2000/docker-images/blob/master/musicbot/README.md)
[![Docker Stars](https://img.shields.io/docker/stars/supersandro2000/musicbot.svg?label=Docker%20Stars&maxAge=43200)](https://hub.docker.com/r/supersandro2000/musicbot/)
[![Docker Hub](https://img.shields.io/badge/Docker-hub-blue.svg)](https://hub.docker.com/r/supersandro2000/musicbot/)

[![Build Status](https://img.shields.io/travis/SuperSandro2000/docker-images.svg?maxAge=43200)](https://travis-ci.org/SuperSandro2000/docker-images)
[![Version](https://img.shields.io/docker/v/supersandro2000/musicbot.svg?label=Version&sort=date&maxAge=43200)](https://hub.docker.com/r/supersandro2000/musicbot/)
[![Docker Pulls](https://img.shields.io/docker/pulls/supersandro2000/musicbot.svg?label=Docker%20Pulls&maxAge=43200)](https://hub.docker.com/r/supersandro2000/musicbot/)

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
