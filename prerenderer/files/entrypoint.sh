#!/bin/sh
set -eu

# if the first arg starts with "-" pass it to node
if [ "${1#-}" != "$1" ]; then
    set -- node server.js "$@"
fi

if [ "$1" = "node" ] && [ "$(id -u)" = "0" ]; then
    find . \! -user prerenderer -exec chown prerenderer '{}' +
    exec gosu prerenderer "$0" "$@"
fi

exec "$@"
