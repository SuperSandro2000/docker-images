#!/bin/sh
set -eu

CMD=kibitzr
USER=kibitzr

# if the first arg starts with "-" pass it to program
if [ "${1#-}" != "$1" ]; then
    set -- "$CMD" "$@"
fi

if [ "$1" = "$CMD" ] && [ "$(id -u)" = "0" ]; then
    find . \! -user $USER -exec chown $USER '{}' +
    exec su-exec $USER "$0" "$@"
fi

exec "$@"
