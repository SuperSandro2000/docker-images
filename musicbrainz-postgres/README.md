# MusicBrainz Postgres

[![Github Stars](https://img.shields.io/github/stars/supersandro2000/docker-images.svg?maxAge=43200&label=Github%20Stars)](https://github.com/SuperSandro2000/docker-images)
[![GitHub readme](https://img.shields.io/badge/GitHub-readme-blue.svg)](https://github.com/SuperSandro2000/docker-images/blob/master/musicbrainz-postgres/README.md)
[![Docker Stars](https://img.shields.io/docker/stars/supersandro2000/musicbrainz-postgres.svg?label=Docker%20Stars&maxAge=43200)](https://hub.docker.com/r/supersandro2000/musicbrainz-postgres/)
[![Docker Hub](https://img.shields.io/badge/Docker-hub-blue.svg)](https://hub.docker.com/r/supersandro2000/musicbrainz-postgres/)

[![Build Status](https://img.shields.io/travis/SuperSandro2000/docker-images.svg?maxAge=43200)](https://travis-ci.org/SuperSandro2000/docker-images)
[![Version](https://img.shields.io/docker/v/supersandro2000/musicbrainz-postgres.svg?label=Version&sort=date&maxAge=43200)](https://hub.docker.com/r/supersandro2000/musicbrainz-postgres/)
[![Docker Pulls](https://img.shields.io/docker/pulls/supersandro2000/musicbrainz-postgres.svg?label=Docker%20Pulls&maxAge=43200)](https://hub.docker.com/r/supersandro2000/musicbrainz-postgres/)
[![Microbadger](https://images.microbadger.com/badges/image/supersandro2000/musicbrainz-postgres.svg)](https://microbadger.com/images/supersandro2000/musicbrainz-postgres)

MusicBrainz Postgres Docker Image

## Docker compose

````yaml
---
version: "3"
services:
  db_musicbrainz:
    image: supersandro2000/musicbrainz-postgres
    volumes:
      - $PWD/db_musicbrainz:/var/lib/postgresql/data
    environment:
      - POSTGRES_PASSWORD=super_secret
      - POSTGRES_USER=musicbrainz
    restart: unless-stopped
````
