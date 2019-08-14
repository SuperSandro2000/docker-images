#!/bin/sh
set -eou pipefail

# if the first arg starts with "-" pass it to kibitzr
if [ "${1#-}" != "$1" ]; then
    set -- kibitzr run "$@"
fi

if [ "$1" = "kibitzr" ] && [ "$(id -u)" = "0" ]; then
    find . \! -user kibitzr -exec chown kibitzr '{}' +
    exec su-exec kibitzr "$0" "$@"
fi

exec "$@"
