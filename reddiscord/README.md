# Red-Discord Bot

[![Github Stars](https://img.shields.io/github/stars/supersandro2000/docker-images.svg?maxAge=43200&label=Github%20Stars)](https://github.com/SuperSandro2000/docker-images)
[![GitHub readme](https://img.shields.io/badge/GitHub-readme-blue.svg)](https://github.com/SuperSandro2000/docker-images/blob/master/reddiscord/README.md)
[![Docker Stars](https://img.shields.io/docker/stars/supersandro2000/reddiscord.svg?label=Docker%20Stars&maxAge=43200)](https://hub.docker.com/r/supersandro2000/reddiscord/)
[![Docker Hub](https://img.shields.io/badge/Docker-hub-blue.svg)](https://hub.docker.com/r/supersandro2000/reddiscord/)

[![Build Status](https://img.shields.io/travis/SuperSandro2000/docker-images.svg?maxAge=43200)](https://travis-ci.org/SuperSandro2000/docker-images)
[![Version](https://img.shields.io/docker/v/supersandro2000/reddiscord.svg?label=Version&sort=date&maxAge=43200)](https://hub.docker.com/r/supersandro2000/reddiscord/)
[![Docker Pulls](https://img.shields.io/docker/pulls/supersandro2000/reddiscord.svg?label=Docker%20Pulls&maxAge=43200)](https://hub.docker.com/r/supersandro2000/reddiscord/)
[![Microbadger](https://images.microbadger.com/badges/image/supersandro2000/reddiscord.svg)](https://microbadger.com/images/supersandro2000/reddiscord)

Red-Discord Bot Docker Image with multi-arch support.

To configure the bot you need to run the image once interactively. This needs to be done as the reddiscord user or the preconfigured config is not used.

You can do that with docker-compose like this ``docker-compose run --user reddiscord reddiscord``.

## Docker compose

```yaml
---
version: "3"
services:
  reddiscord:
    image: supersandro2000/reddiscord
    volumes:
      - $PWD/reddiscord:/data
    restart: unless-stopped
```
