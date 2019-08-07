FROM php:apache-stretch

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

LABEL maintainer="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.name="Red-Discord Bot" \
  org.label-schema.description="A multifunction Discord bot" \
  org.label-schema.url="https://github.com/Cog-Creators/Red-DiscordBot/tree/V3/develop" \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.vcs-url="https://github.com/SuperSandro2000/docker-images" \
  org.label-schema.vendor="SuperSandro2000" \
  org.label-schema.version=$VERSION \
  org.label-schema.schema-version="1.0"

RUN apt-get update \
  && apt-get install -qy --no-install-recommends gettext libicu-dev \
  && rm -rf /var/lib/apt/lists/*
RUN docker-php-ext-install gettext intl
RUN a2enmod rewrite
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
COPY --chown=www-data halcyon-git/ /var/www/html/
RUN bash -c 'chmod 755 /var/www/html/ -R'
