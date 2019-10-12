FROM php:apache-buster

ARG BUILD_DATE
ARG VERSION
ARG REVISION

LABEL maintainer="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.created=$BUILD_DATE \
  org.opencontainers.image.authors="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.url="https://github.com/SuperSandro2000/docker-images/tree/master/halcyon" \
  org.opencontainers.image.documentation="https://notabug.org/halcyon-suite/halcyon" \
  org.opencontainers.image.source="https://github.com/SuperSandro2000/docker-images" \
  org.opencontainers.image.version=$VERSION \
  org.opencontainers.image.revision=$REVISION \
  org.opencontainers.image.vendor="SuperSandro2000" \
  org.opencontainers.image.licenses="GPL-3.0" \
  org.opencontainers.image.title="Halcyon" \
  org.opencontainers.image.description="Halcyon is a webclient for Mastodon and Pleroma which aims to recreate the simple and beautiful user interface of Twitter while keeping all advantages of decentral networks in focus."

RUN groupadd halcyon && useradd -g halcyon halcyon

RUN apt-get update \
  && apt-get install -qy --no-install-recommends gettext gosu libicu-dev \
  && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install gettext intl \
  && a2enmod rewrite

COPY [ "files/entrypoint.sh", "/usr/local/bin/" ]
COPY --chown=www-data halcyon-git/ /var/www/html/

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" \
  && bash -c 'chmod 755 /var/www/html/ -R'

EXPOSE 80
ENTRYPOINT [ "entrypoint.sh" ]
