FROM composer:2.3 as composer

#--------------#

FROM debian:testing as git

RUN apt-get update -q \
  && apt-get install -qy --no-install-recommends \
    ca-certificates \
    git \
  && rm -rf /var/lib/apt/lists/*

ARG VERSION=5.7.5
RUN git clone --depth=1 --branch=$VERSION -- https://github.com/firefly-iii/firefly-iii.git /var/www/html/ \
  && rm -r /var/www/html/.git

#--------------#

FROM php:8-apache-buster

ARG VERSION

LABEL maintainer="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.created=$BUILD_DATE \
  org.opencontainers.image.authors="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.url="https://github.com/SuperSandro2000/docker-images/tree/master/firefly-iii" \
  org.opencontainers.image.documentation="https://github.com/firefly-iii/firefly-iii" \
  org.opencontainers.image.source="https://github.com/SuperSandro2000/docker-images" \
  org.opencontainers.image.version=$VERSION \
  org.opencontainers.image.revision=$REVISION \
  org.opencontainers.image.vendor="SuperSandro2000" \
  org.opencontainers.image.licenses="AGPL-3.0" \
  org.opencontainers.image.title="firefly-iii" \
  org.opencontainers.image.description="Firefly III: a personal finances manager"

ENV APACHE_DOCUMENT_ROOT=/var/www/html/public/

# hadolint ignore=SC2016
RUN usermod -aG tty www-data \
  && mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" \
  && a2enmod rewrite \
  && sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf \
  && sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/conf-available/*.conf \
  && sed -i 's/max_execution_time = 30/max_execution_time = 600/' /usr/local/etc/php/php.ini \
  && sed -i 's/memory_limit = 128M/memory_limit = 512M/' /usr/local/etc/php/php.ini

COPY --from=composer /usr/bin/composer /usr/bin/composer

ENV COMPOSER_ALLOW_SUPERUSER=1 COMPOSER_HOME=/tmp
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN export dev_apt=( \
    "libicu-dev" \
    "libldap2-dev" \
    "libpng-dev" \
    "libpq-dev" \
    "zlib1g-dev" \
  ) \
  && apt-get update -q \
  && apt-get install --no-install-recommends -qy "${dev_apt[@]}" \
    gettext-base \
    libicu63 \
    libldap-2.4-2 \
    libpng16-16 \
    libpq5 \
    locales \
    unzip \
    zlib1g \
  && docker-php-ext-install -j4 \
    bcmath \
    gd \
    intl \
    ldap \
    pdo_pgsql \
    pgsql \
  && printf "\
de_DE.UTF-8 UTF-8 \n\
en_US.UTF-8 UTF-8 \n\
" > /etc/locale.gen \
  && locale-gen \
  && apt-get autoremove --purge -qy "${dev_apt[@]}" \
  && rm -rf /var/lib/apt/lists/*

COPY [ "files/entrypoint.sh", "/usr/local/bin/" ]
COPY --chown=www-data [ "files/env", "/var/www/html/.env" ]
COPY --from=git --chown=www-data [ "/var/www/html/", "/var/www/html/" ]

ENV DB_CONNECTION=sqlite \
    DB_DATABASE=/var/www/html/database/database.sqlite \
    LOGIN_PROVIDER=eloquent \
    MAP_DEFAULT_LAT=48.3957948 \
    MAP_DEFAULT_LONG=10.711514 \
    MAP_DEFAULT_ZOOM=5 \
    TZ=Europe/Berlin

WORKDIR /var/www/html/
RUN composer install --classmap-authoritative --no-dev --no-scripts --no-suggest --optimize-autoloader --prefer-dist \
  && composer clear-cache \
  && chown -R www-data:www-data /var/www/html/storage \
  && chmod -R 775 /var/www/html/storage

EXPOSE 80
ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "apache2-foreground" ]
