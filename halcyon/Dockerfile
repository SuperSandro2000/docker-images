FROM php:apache-stretch

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

LABEL maintainer="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.name="Halcyon" \
  org.label-schema.description="Halcyon is a webclient for Mastodon and Pleroma which aims to recreate the simple and beautiful user interface of Twitter while keeping all advantages of decentral networks in focus." \
  org.label-schema.url="https://notabug.org/halcyon-suite/halcyon" \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.vcs-url="https://github.com/SuperSandro2000/docker-images" \
  org.label-schema.vendor="SuperSandro2000" \
  org.label-schema.version=$VERSION \
  org.label-schema.schema-version="1.0"

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
