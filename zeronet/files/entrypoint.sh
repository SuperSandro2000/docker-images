#!/bin/sh
set -eou pipefail

# if the first arg starts with "-" pass it to zeronet
if [ "${1#-}" != "$1" ]; then
    set -- run.sh "$@"
fi

if [ "$1" = "run.sh" ] && [ "$(id -u)" = "0" ]; then
    find . \! -user zeronet -exec chown zeronet '{}' +
    exec su-exec zeronet "$0" "$@"
fi

exec "$@"
