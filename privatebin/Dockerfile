FROM debian:buster as git

RUN apt-get update -q \
  && apt-get install -qy --no-install-recommends ca-certificates git \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

ARG VERSION=1.3.2

RUN git clone --depth=50 https://github.com/PrivateBin/PrivateBin.git /var/www/html/ \
  && git checkout $VERSION \
  && mv /var/www/html/.htaccess.disabled /var/www/html/.htaccess
#  && chmod 755 /var/www/html/ -R

COPY [ "files/conf.sample.php", "/var/www/html/cfg/conf.sample.php" ]

#--------------#

FROM php:apache-buster

ARG BUILD_DATE
ARG VERSION
ARG REVISION

LABEL maintainer="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.created=$BUILD_DATE \
  org.opencontainers.image.authors="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.url="https://github.com/SuperSandro2000/docker-images/tree/master/privatebin" \
  org.opencontainers.image.documentation="https://github.com/PrivateBin/PrivateBin/wiki" \
  org.opencontainers.image.source="https://github.com/SuperSandro2000/docker-images" \
  org.opencontainers.image.version=$VERSION \
  org.opencontainers.image.revision=$REVISION \
  org.opencontainers.image.vendor="SuperSandro2000" \
  org.opencontainers.image.licenses="Zlib/libpng license" \
  org.opencontainers.image.title="PrivateBin" \
  org.opencontainers.image.description="A minimalist, open source online pastebin where the server has zero knowledge of pasted data. Data is encrypted/decrypted in the browser using 256 bits AES."

RUN usermod -aG tty www-data \
  && mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" \
  && a2enmod rewrite

COPY [ "files/ports.conf", "/etc/apache2/ports.conf" ]
COPY [ "files/entrypoint.sh", "/usr/local/bin/" ]

RUN export dev_apt="libpq-dev" \
  && apt-get update -q \
  && apt-get install -qy --no-install-recommends "$dev_apt" gettext-base gosu libpq5 \
  && docker-php-ext-install -j4 pdo_pgsql \
  && apt-get autoremove --purge -qy "$dev_apt" \
  && rm -rf /var/lib/apt/lists/*

COPY --from=git [ "/var/www/html", "/var/www/html" ]

ENV NAME=PrivateBin
EXPOSE 4430 8000
WORKDIR /var/www/html/
ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "apache2-foreground" ]
