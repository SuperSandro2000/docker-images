[![Build Status](https://img.shields.io/travis/SuperSandro2000/docker-images.svg?maxAge=3600)](https://travis-ci.org/SuperSandro2000/docker-images)
[![Github Stars](https://img.shields.io/github/stars/supersandro2000/docker-images.svg?maxAge=3600&label=Stars)](https://github.com/SuperSandro2000/docker-images)

# Red-Discord Bot

[![Docker Hub](https://img.shields.io/badge/Docker-hub-blue.svg)](https://hub.docker.com/r/supersandro2000/reddiscord/)
[![GitHub readme](https://img.shields.io/badge/GitHub-readme-blue.svg)](https://github.com/SuperSandro2000/docker-images/blob/master/reddiscord//README.md)
[![Microbadger](https://images.microbadger.com/badges/image/supersandro2000/reddiscord.svg)](https://microbadger.com/images/supersandro2000/reddiscord/)
[![Docker Stars](https://img.shields.io/docker/stars/supersandro2000/reddiscord.svg?maxAge=3600)](https://hub.docker.com/r/supersandro2000/reddiscord/)
[![Docker Pulls](https://img.shields.io/docker/pulls/supersandro2000/reddiscord.svg?maxAge=3600)](https://hub.docker.com/r/supersandro2000/reddiscord/)

Red-Discord Bot Docker Image with multi-arch support.

## Docker compose

```yaml
---
version: "3"
services:
  reddiscord:
    image: supersandro2000/reddiscord
    volumes:
      - $PWD/reddiscord:/app/data
    restart: unless-stopped
```
