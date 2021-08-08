# MusicBrainz

[![Github Stars](https://img.shields.io/github/stars/supersandro2000/docker-images.svg?maxAge=43200&label=Github%20Stars)](https://github.com/SuperSandro2000/docker-images)
[![GitHub readme](https://img.shields.io/badge/GitHub-readme-blue.svg)](https://github.com/SuperSandro2000/docker-images/blob/master/musicbrainz/README.md)
[![Docker Stars](https://img.shields.io/docker/stars/supersandro2000/musicbrainz.svg?label=Docker%20Stars&maxAge=43200)](https://hub.docker.com/r/supersandro2000/musicbrainz/)
[![Docker Hub](https://img.shields.io/badge/Docker-hub-blue.svg)](https://hub.docker.com/r/supersandro2000/musicbrainz/)

[![Build Status](https://img.shields.io/travis/SuperSandro2000/docker-images.svg?maxAge=43200)](https://travis-ci.org/SuperSandro2000/docker-images)
[![Version](https://img.shields.io/docker/v/supersandro2000/musicbrainz.svg?label=Version&sort=date&maxAge=43200)](https://hub.docker.com/r/supersandro2000/musicbrainz/)
[![Docker Pulls](https://img.shields.io/docker/pulls/supersandro2000/musicbrainz.svg?label=Docker%20Pulls&maxAge=43200)](https://hub.docker.com/r/supersandro2000/musicbrainz/)

MusicBrainz Docker Image

## Setup instructions

* Basically follow [install instructions](https://github.com/metabrainz/musicbrainz-server/blob/master/INSTALL.md#creating-the-database)
* More mirrors are available at the [download page](https://musicbrainz.org/doc/MusicBrainz_Database/Download#Download)
* You need to drop the default database before importing the dump.

```shell
docker exec user_db_musicbrainz_1 psql -U musicbrainz -d template1 -c "drop database musicbrainz;"
```

* To get inside the container run ``docker-compose run musicbrainz``
* Make sure to turn on [replication](https://musicbrainz.supersandro.de/doc/MusicBrainz_Server/Setup#Running_Replication)
* The article is not the most up to date one and currently the replication script is located at ``/app/admin/replication/LoadReplicationChanges``.

## Docker compose

````yaml
---
version: "3"
services:
  musicbrainz:
    image: supersandro2000/musicbrainz
    ports:
      - 5000:5000
    environment:
      - DB_STAGING_SERVER=0
      - MUSICBRAINZ_USE_PROXY=1
      - REDIS_SERVER=redis:6379
      - REPLICATION_ACCESS_TOKEN=YOUR_TOKEN
      - REPLICATION_TYPE=RT_SLAVE
      - SSL_REDIRECTS_ENABLED=1
      - SMTP_SECRET_CHECKSUM=SUPER_SECRET_TOKEN
      - WEB_SERVER=musicbrainz.example.com
    restart: unless-stopped
````
