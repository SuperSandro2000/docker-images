FROM php:apache-stretch

RUN apt update && apt install -qy gettext libicu-dev
RUN docker-php-ext-install gettext intl
RUN a2enmod rewrite
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
COPY --chown=www-data halcyon-git/ /var/www/html/
RUN bash -c 'chmod 755 /var/www/html/ -R'
