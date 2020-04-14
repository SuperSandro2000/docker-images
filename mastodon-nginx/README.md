[![Build Status](https://img.shields.io/travis/SuperSandro2000/docker-images.svg?maxAge=43200)](https://travis-ci.org/SuperSandro2000/docker-images)
[![Github Stars](https://img.shields.io/github/stars/supersandro2000/docker-images.svg?maxAge=43200&label=Stars)](https://github.com/SuperSandro2000/docker-images)

# Mastodon Nginx

[![Docker Hub](https://img.shields.io/badge/Docker-hub-blue.svg)](https://hub.docker.com/r/supersandro2000/mastodon-nginx/)
[![GitHub readme](https://img.shields.io/badge/GitHub-readme-blue.svg)](https://github.com/SuperSandro2000/docker-images/blob/master/mastodon-nginx/README.md)
[![Microbadger](https://images.microbadger.com/badges/image/supersandro2000/mastodon-nginx.svg)](https://microbadger.com/images/supersandro2000/mastodon-nginx)
[![Docker Stars](https://img.shields.io/docker/stars/supersandro2000/mastodon-nginx.svg?maxAge=43200)](https://hub.docker.com/r/supersandro2000/mastodon-nginx/)
[![Docker Pulls](https://img.shields.io/docker/pulls/supersandro2000/mastodon-nginx.svg?maxAge=43200)](https://hub.docker.com/r/supersandro2000/mastodon-nginx/)

Mastodon Nginx Server

## Docker compose

````yaml
version: "2.4"
services:
  db:
    ...
  mastodon:
    ...
  mastodon-sidekiq:
    ...
  mastodon-streaming:
    ...
  redis:
    ...

  mastodon-nginx:
    image: mastodon-nginx
    volumes:
      - ./public/system:/mastodon/public/system
    environment:
      - MASTODON_SERVER=mastodon
      - MASTODON_STREAMING=mastodon-streaming
      - NGINX_DOMAIN=example.com
````
