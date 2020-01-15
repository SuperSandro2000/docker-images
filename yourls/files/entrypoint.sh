#!/bin/sh
set -eu

CMD=apache2-foreground
USER=www-data

# if the first arg starts with "-" pass it to program
if [ "${1#-}" != "$1" ]; then
  set -- "$CMD" "$@"
fi

if [ "$1" = "$CMD" ] && [ "$(id -u)" = "0" ]; then
  find . \! -user $USER -exec chown $USER '{}' +

  # shellcheck disable=SC2016
  envsubst '${ADMIN_PASSWORD},${COOKIE_KEY},${DOMAIN},${DB_HOST},${DB_NAME},${DB_PASSWORD},${DB_USER}' < /var/www/html/user/config-sample.php > /var/www/html/user/config.php
fi

exec "$@"
