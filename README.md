# Docker Images
[![Build Status](https://img.shields.io/travis/SuperSandro2000/docker-images.svg?maxAge=1200)](https://travis-ci.org/SuperSandro2000/docker-images)
[![Github Stars](https://img.shields.io/github/stars/supersandro2000/docker-images.svg?maxAge=1200&label=Stars&style=social)](https://github.com/SuperSandro2000/docker-images)

All my docker images in one mono-repository with multi-arch support.

# Changelog
If you wish to view the difference between two releases of a docker image you can use [container-diff](https://github.com/GoogleContainerTools/container-diff).

Just download it according to their [Readme](https://github.com/GoogleContainerTools/container-diff#installation) and run `container-diff diff supersandro2000/kibitzr:5.4.0 supersandro2000/kibitzr:latest --type=apt --type=pip --type=size 2> /dev/null` replacing the `supersandro2000/kibitzr:5.4.0` with the images and versions you want to compare.

# Images
### ArchiSteamFarm
[![Docker Hub](https://img.shields.io/badge/Docker-hub-blue.svg)](https://hub.docker.com/r/supersandro2000/archisteamfarm/)
[![GitHub readme](https://img.shields.io/badge/GitHub-readme-blue.svg)](archisteamfarm/README.md)
[![Microbadger](https://images.microbadger.com/badges/image/supersandro2000/archisteamfarm.svg)](https://microbadger.com/images/supersandro2000/archisteamfarm)
[![Docker Stars](https://img.shields.io/docker/stars/supersandro2000/archisteamfarm.svg?maxAge=3600)](https://hub.docker.com/r/supersandro2000/archisteamfarm/)
[![Docker Pulls](https://img.shields.io/docker/pulls/supersandro2000/archisteamfarm.svg?maxAge=3600)](https://hub.docker.com/r/supersandro2000/archisteamfarm/)

### FreshRSS
[![Docker Hub](https://img.shields.io/badge/Docker-hub-blue.svg)](https://hub.docker.com/r/supersandro2000/freshrss/)
[![GitHub readme](https://img.shields.io/badge/GitHub-readme-blue.svg)](freshrss/README.md)
[![Microbadger](https://images.microbadger.com/badges/image/supersandro2000/freshrss.svg)](https://microbadger.com/images/supersandro2000/freshrss)
[![Docker Stars](https://img.shields.io/docker/stars/supersandro2000/freshrss.svg?maxAge=3600)](https://hub.docker.com/r/supersandro2000/freshrss/)
[![Docker Pulls](https://img.shields.io/docker/pulls/supersandro2000/freshrss.svg?maxAge=3600)](https://hub.docker.com/r/supersandro2000/freshrss/)

### Kibitzr
[![Docker Hub](https://img.shields.io/badge/Docker-hub-blue.svg)](https://hub.docker.com/r/supersandro2000/kibitzr/)
[![GitHub readme](https://img.shields.io/badge/GitHub-readme-blue.svg)](kibitzr/README.md)
[![Microbadger](https://images.microbadger.com/badges/image/supersandro2000/kibitzr.svg)](https://microbadger.com/images/supersandro2000/kibitzr)
[![Docker Stars](https://img.shields.io/docker/stars/supersandro2000/kibitzr.svg?maxAge=3600)](https://hub.docker.com/r/supersandro2000/kibitzr/)
[![Docker Pulls](https://img.shields.io/docker/pulls/supersandro2000/kibitzr.svg?maxAge=3600)](https://hub.docker.com/r/supersandro2000/kibitzr/)

### Watchtower
[![Docker Hub](https://img.shields.io/badge/Docker-hub-blue.svg)](https://hub.docker.com/r/supersandro2000/watchtower/)
[![GitHub readme](https://img.shields.io/badge/GitHub-readme-blue.svg)](watchtower/README.md)
[![Microbadger](https://images.microbadger.com/badges/image/supersandro2000/watchtower.svg)](https://microbadger.com/images/supersandro2000/watchtower)
[![Docker Stars](https://img.shields.io/docker/stars/supersandro2000/watchtower.svg?maxAge=3600)](https://hub.docker.com/r/supersandro2000/watchtower/)
[![Docker Pulls](https://img.shields.io/docker/pulls/supersandro2000/watchtower.svg?maxAge=3600)](https://hub.docker.com/r/supersandro2000/watchtower/)

# Credits
Thanks to napnap75 for inspiring me to do this with his [rpi-docker-images](https://github.com/napnap75/rpi-docker-images/) repo.
