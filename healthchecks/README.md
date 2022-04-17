# Healthchecks

[![Github Stars](https://img.shields.io/github/stars/supersandro2000/docker-images.svg?maxAge=43200&label=Github%20Stars)](https://github.com/SuperSandro2000/docker-images)
[![GitHub readme](https://img.shields.io/badge/GitHub-readme-blue.svg)](https://github.com/SuperSandro2000/docker-images/blob/master/healthchecks/README.md)
[![Docker Stars](https://img.shields.io/docker/stars/supersandro2000/healthchecks.svg?label=Docker%20Stars&maxAge=43200)](https://hub.docker.com/r/supersandro2000/healthchecks/)
[![Docker Hub](https://img.shields.io/badge/Docker-hub-blue.svg)](https://hub.docker.com/r/supersandro2000/healthchecks/)

[![Version](https://img.shields.io/docker/v/supersandro2000/healthchecks.svg?label=Version&sort=date&maxAge=43200)](https://hub.docker.com/r/supersandro2000/healthchecks/)
[![Docker Pulls](https://img.shields.io/docker/pulls/supersandro2000/healthchecks.svg?label=Docker%20Pulls&maxAge=43200)](https://hub.docker.com/r/supersandro2000/healthchecks/)

Healthchecks Docker Image with multi-arch support.

Requires a database like postgres. For further configuration options visit the [healthchecks repo](https://github.com/healthchecks/healthchecks/).

## Docker compose

````yaml
---
version: "3"
services:
  healthchecks:
    image: supersandro2000/healthchecks
    networks:
      - healthchecks
    restart: unless-stopped

  healthchecks-alerts:
    image: supersandro2000/healthchecks
    networks:
      - healthchecks
    command: /app/manage.py sendalerts
    restart: unless-stopped
````

Setup database with:

````bash
docker exec -it $PWD_healthchecks_1 ./manage.py migrate
docker exec -it $PWD_healthchecks_1 ./manage.py createsuperuser
````
