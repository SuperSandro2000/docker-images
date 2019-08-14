#!/bin/sh
set -eou pipefail

# if the first arg starts with "-" pass it to code-server
if [ "${1#-}" != "$1" ]; then
    set -- code-server "$@"
fi

if [ "$1" = "code-server" ] && [ "$(id -u)" = "0" ]; then
    find . \! -user code-server -exec chown code-server '{}' +
    exec su-exec code-server "$0" "$@"
fi

exec "$@"
