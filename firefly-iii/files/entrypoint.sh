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
  php artisan key:generate --force
fi

if [ "$DB_CONNECTION" = "sqlite" ]; then
  su -s /bin/bash www-data -c "touch $DB_DATABASE"
fi

# migrations
if [ "$DB_CONNECTION" = "mysql" ]; then
  php artisan firefly-iii:create-database
fi
php artisan migrate --seed --no-interaction --force
php artisan firefly-iii:decrypt-all

# upgrade
php artisan firefly-iii:transaction-identifiers
php artisan firefly-iii:migrate-to-groups
php artisan firefly-iii:account-currencies
php artisan firefly-iii:transfer-currencies
php artisan firefly-iii:other-currencies
php artisan firefly-iii:migrate-notes
php artisan firefly-iii:migrate-attachments
php artisan firefly-iii:bills-to-rules
php artisan firefly-iii:bl-currency
php artisan firefly-iii:cc-liabilities
php artisan firefly-iii:back-to-journals
php artisan firefly-iii:rename-account-meta
php artisan firefly-iii:migrate-recurrence-meta

# verify
php artisan firefly-iii:fix-piggies
php artisan firefly-iii:create-link-types
php artisan firefly-iii:create-access-tokens
php artisan firefly-iii:remove-bills
php artisan firefly-iii:enable-currencies
php artisan firefly-iii:fix-transfer-budgets
php artisan firefly-iii:fix-uneven-amount
php artisan firefly-iii:delete-zero-amount
php artisan firefly-iii:delete-orphaned-transactions
php artisan firefly-iii:delete-empty-journals
php artisan firefly-iii:delete-empty-groups
php artisan firefly-iii:fix-account-types
php artisan firefly-iii:rename-meta-fields
php artisan firefly-iii:fix-ob-currencies
php artisan firefly-iii:fix-long-descriptions
php artisan firefly-iii:fix-recurring-transactions

php artisan firefly-iii:restore-oauth-keys

exec "$@"
