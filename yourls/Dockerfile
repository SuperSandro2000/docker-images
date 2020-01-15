FROM debian:buster as git

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update -q \
  && apt-get install -qy --no-install-recommends ca-certificates git wget \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

ARG VERSION=1.7.4

RUN git clone --depth=50 https://github.com/YOURLS/YOURLS.git /var/www/html/ \
  && git checkout $VERSION \
  && mv /var/www/html/sample-robots.txt /var/www/html/robots.txt \
  && rm -rf /var/www/html/.git

COPY [ "files/config-sample.php", "/var/www/html/user/config-sample.php" ]
COPY [ "files/htaccess", "/var/www/html/.htaccess" ]

WORKDIR /var/www/html/user/plugins

RUN git clone https://github.com/timcrockford/302-instead.git \
  && git clone https://github.com/luixxiul/dont-log-crawlers.git \
  && git clone https://github.com/YOURLS/force-lowercase.git \
  && git clone https://github.com/YOURLS/mass-remove-links.git \
  && git clone https://github.com/tomslominski/yourls-redirect-index.git \
  && mv yourls-redirect-index redirect-index \
  && mv redirect-index/index.php /var/www/html/index.php \
  && git clone https://github.com/Diftraku/yourls_reverseproxy.git

#--------------#

FROM php:apache-buster

ARG BUILD_DATE
ARG VERSION
ARG REVISION

LABEL maintainer="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.created=$BUILD_DATE \
  org.opencontainers.image.authors="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.url="https://github.com/SuperSandro2000/docker-images/tree/master/yourls" \
  org.opencontainers.image.documentation="https://yourls.org/" \
  org.opencontainers.image.source="https://github.com/SuperSandro2000/docker-images" \
  org.opencontainers.image.version=$VERSION \
  org.opencontainers.image.revision=$REVISION \
  org.opencontainers.image.vendor="SuperSandro2000" \
  org.opencontainers.image.licenses="MIT" \
  org.opencontainers.image.title="YOURLS" \
  org.opencontainers.image.description="🔗 Your Own URL Shortener "

RUN usermod -aG tty www-data \
  && mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" \
  # we don't want any access logs
  && ln -sfT /dev/null "$APACHE_LOG_DIR/access.log" \
  && ln -sfT /dev/null "$APACHE_LOG_DIR/other_vhosts_access.log" \
  && a2enmod expires rewrite

COPY [ "files/ports.conf", "/etc/apache2/ports.conf" ]
COPY [ "files/entrypoint.sh", "/usr/local/bin/" ]

RUN export dev_apt="" \
  && apt-get update -q \
  && apt-get install -qy --no-install-recommends "$dev_apt" gettext-base gosu \
  && docker-php-ext-install -j4 pdo_mysql \
  && apt-get autoremove --purge -qy \
  && rm -rf /var/lib/apt/lists/*

COPY --from=git [ "/var/www/html", "/var/www/html" ]

EXPOSE 4430 8000
WORKDIR /var/www/html/
ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "apache2-foreground" ]
