# Gitea Nginx

[![Github Stars](https://img.shields.io/github/stars/supersandro2000/docker-images.svg?maxAge=43200&label=Github%20Stars)](https://github.com/SuperSandro2000/docker-images)
[![GitHub readme](https://img.shields.io/badge/GitHub-readme-blue.svg)](https://github.com/SuperSandro2000/docker-images/blob/master/gitea-nginx/README.md)
[![Docker Stars](https://img.shields.io/docker/stars/supersandro2000/gitea-nginx.svg?label=Docker%20Stars&maxAge=43200)](https://hub.docker.com/r/supersandro2000/gitea-nginx/)
[![Docker Hub](https://img.shields.io/badge/Docker-hub-blue.svg)](https://hub.docker.com/r/supersandro2000/gitea-nginx/)

[![Build Status](https://img.shields.io/travis/SuperSandro2000/docker-images.svg?maxAge=43200)](https://travis-ci.org/SuperSandro2000/docker-images)
[![Version](https://img.shields.io/docker/v/supersandro2000/gitea-nginx.svg?label=Version&sort=date&maxAge=43200)](https://hub.docker.com/r/supersandro2000/gitea-nginx/)
[![Docker Pulls](https://img.shields.io/docker/pulls/supersandro2000/gitea-nginx.svg?label=Docker%20Pulls&maxAge=43200)](https://hub.docker.com/r/supersandro2000/gitea-nginx/)
[![Microbadger](https://images.microbadger.com/badges/image/supersandro2000/gitea-nginx.svg)](https://microbadger.com/images/supersandro2000/gitea-nginx)

Gitea Nginx Server

## Docker compose

````yaml
version: "2.4"
services:
  db:
    ...
  gitea:
    ...

  gitea-nginx:
    image: gitea-nginx
    environment:
      - GITEA_SERVER=gitea
      - NGINX_DOMAIN=gitea.example.com
````
