#!/bin/sh
set -eu

# if the first arg starts with "-" pass it to reddiscord
if [ "${1#-}" != "$1" ]; then
    set -- redbot docker "$@"
fi

if [ "$1" = "redbot" ] && [ "$(id -u)" = "0" ]; then
    find . \! -user reddiscord -exec chown reddiscord '{}' +
    exec gosu reddiscord "$0" "$@"
fi

exec "$@"
