# Mastodon Nginx

[![Github Stars](https://img.shields.io/github/stars/supersandro2000/docker-images.svg?maxAge=43200&label=Github%20Stars)](https://github.com/SuperSandro2000/docker-images)
[![GitHub readme](https://img.shields.io/badge/GitHub-readme-blue.svg)](https://github.com/SuperSandro2000/docker-images/blob/master/mastodon-nginx/README.md)
[![Docker Stars](https://img.shields.io/docker/stars/supersandro2000/mastodon-nginx.svg?label=Docker%20Stars&maxAge=43200)](https://hub.docker.com/r/supersandro2000/mastodon-nginx/)
[![Docker Hub](https://img.shields.io/badge/Docker-hub-blue.svg)](https://hub.docker.com/r/supersandro2000/mastodon-nginx/)

[![Build Status](https://img.shields.io/travis/SuperSandro2000/docker-images.svg?maxAge=43200)](https://travis-ci.org/SuperSandro2000/docker-images)
[![Version](https://img.shields.io/docker/v/supersandro2000/mastodon-nginx.svg?label=Version&sort=date&maxAge=43200)](https://hub.docker.com/r/supersandro2000/mastodon-nginx/)
[![Docker Pulls](https://img.shields.io/docker/pulls/supersandro2000/mastodon-nginx.svg?label=Docker%20Pulls&maxAge=43200)](https://hub.docker.com/r/supersandro2000/mastodon-nginx/)
[![Microbadger](https://images.microbadger.com/badges/image/supersandro2000/mastodon-nginx.svg)](https://microbadger.com/images/supersandro2000/mastodon-nginx)

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
