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

  envsubst '${NAME},${DB_HOST},${DB_NAME},${DB_PASSWORD},${DB_USER}' < /var/www/html/cfg/conf.sample.php > /var/www/html/cfg/conf.php

  exec gosu $USER "$0" "$@"
fi

exec "$@"
