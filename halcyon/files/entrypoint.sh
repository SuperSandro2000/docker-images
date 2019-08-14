#!/bin/sh
set -eou pipefail

# if the first arg starts with "-" pass it to apache
if [ "${1#-}" != "$1" ]; then
    set -- apache2-foreground "$@"
fi

if [ "$1" = "apache2-foreground" ] && [ "$(id -u)" = "0" ]; then
    find . \! -user halcyon -exec chown halcyon '{}' +
    exec gosu halcyon "$0" "$@"
fi

exec "$@"
