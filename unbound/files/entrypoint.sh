#!/bin/sh
set -eou pipefail

# if the first arg starts with "-" pass it to unbound
if [ "${1#-}" != "$1" ]; then
    set -- unbound "$@"
fi

if [ "$1" = "unbound" ] && [ "$(id -u)" = "0" ]; then
    find . \! -user unbound -exec chown unbound '{}' +
    exec su-exec unbound "$0" "$@"
fi

exec "$@"
