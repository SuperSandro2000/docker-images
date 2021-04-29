FROM composer:2.0.13 as composer

#--------------#

FROM debian:testing-slim as git

RUN apt-get update -q \
  && apt-get install -qy --no-install-recommends \
    ca-certificates \
    git \
  && rm -rf /var/lib/apt/lists/*

ARG VERSION=master
RUN git clone --depth=1 -- https://github.com/stefanzweifel/screeenly.git /var/www/html/

#--------------#

FROM php:7-apache-buster

ARG BUILD_DATE
ARG VERSION
ARG REVISION

LABEL maintainer="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.created=$BUILD_DATE \
  org.opencontainers.image.authors="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.url="https://github.com/SuperSandro2000/docker-images/tree/master/screeenly" \
  org.opencontainers.image.documentation="https://github.com/stefanzweifel/screeenly" \
  org.opencontainers.image.source="https://github.com/SuperSandro2000/docker-images" \
  org.opencontainers.image.version=$VERSION \
  org.opencontainers.image.revision=$REVISION \
  org.opencontainers.image.vendor="SuperSandro2000" \
  org.opencontainers.image.licenses="MIT" \
  org.opencontainers.image.title="screeenly" \
  org.opencontainers.image.description="📸 Screenshot as a Service"

ENV APACHE_DOCUMENT_ROOT /var/www/html/public/
# hadolint ignore=SC2016
RUN usermod -aG tty www-data \
  && mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" \
  && a2enmod rewrite \
  && sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf \
  && sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/conf-available/*.conf

# Chrome dependencies
RUN apt-get update \
  && apt-get install --no-install-recommends -qy \
    libasound2 \
    libgbm1 \
    libgtk-3-0 \
    libnss3 \
    libx11-xcb1 \
  && rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
# Nodejs
RUN apt-get update \
  && apt-get install --no-install-recommends -qy \
    gnupg \
  && curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - \
  && echo 'deb https://deb.nodesource.com/node_13.x buster main' > /etc/apt/sources.list.d/nodesource.list \
  && apt-get update \
  && apt-get install --no-install-recommends -qy \
    nodejs \
  && apt-get autoremove --purge -qy \
    gnupg \
  && rm -rf /var/lib/apt/lists/*

COPY --from=composer /usr/bin/composer /usr/bin/composer

ENV COMPOSER_ALLOW_SUPERUSER=1 COMPOSER_HOME=/tmp
RUN export dev_apt=( \
    "libpq-dev" \
  ) \
  && apt-get update -q \
  && apt-get install --no-install-recommends -qy "${dev_apt[@]}" \
    gettext-base \
    libpq5 \
    unzip \
  && docker-php-ext-install -j4 \
    exif \
    pdo_pgsql \
    pgsql \
  && apt-get autoremove --purge -qy "${dev_apt[@]}" \
  && rm -rf /var/lib/apt/lists/*

COPY [ "files/entrypoint.sh", "/usr/local/bin/" ]
COPY --chown=www-data [ "files/env", "/var/www/html/.env" ]
COPY --from=git --chown=www-data [ "/var/www/html/", "/var/www/html/" ]
COPY --chown=www-data [ "files/web.php", "/var/www/html/routes/web.php" ]

WORKDIR /var/www/html/
RUN npm i puppeteer@^5 --only=production \
  && composer install --classmap-authoritative --no-dev --no-suggest --optimize-autoloader --prefer-dist \
  && composer clear-cache

ENV DB_CONNECTION=sqlite DB_DATABASE=/var/www/html/database/database.sqlite
EXPOSE 80
ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "apache2-foreground" ]
