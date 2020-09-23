#!/bin/sh
set -eu
set -x

CMD=apache2-foreground
USER=www-data

# if the first arg starts with "-" pass it to program
if [ "${1#-}" != "$1" ]; then
  set -- "$CMD" "$@"
fi

envsubst < /var/www/html/.env > /var/www/html/.env.tmp
mv /var/www/html/.env.tmp /var/www/html/.env

if [ -z "${APP_KEY:-}" ]; then
  echo "\033[0;31mERROR: APP_KEY is not set. Using random key.\033[0m"
  php artisan key:generate
fi

if [ "$DB_CONNECTION" = "sqlite" ]; then
  su -s /bin/bash $USER -c "touch $DB_DATABASE"
fi

if [ "$DB_CONNECTION" = "mysql" ]; then
  su -s /bin/bash $USER -c php artisan firefly-iii:create-database
fi

if [ "$DB_INIT" = "true" ]; then
  su -s /bin/bash $USER -c 'php artisan migrate --seed --no-interaction --force'
fi

su -s /bin/bash $USER -c php artisan firefly-iii:upgrade-database
su -s /bin/bash $USER -c php artisan firefly-iii:restore-oauth-keys
su -s /bin/bash $USER -c php artisan firefly-iii:set-latest-version --james-is-cool
su -s /bin/bash $USER -c php artisan cache:clear
su -s /bin/bash $USER -c php php artisan config:cache

exec "$@"
