#!/bin/sh
set -eou pipefail

# if the first arg starts with "-" pass it to zeronet
if [ "${1#-}" != "$1" ]; then
    set -- python3 zeronet.py "$@"
fi

if { [ "$1" = "python3" ] || [ "$1" = "./zeronet.py" ]; } && [ "$(id -u)" = "0" ]; then
    find . \! -user zeronet -exec chown zeronet '{}' +
    exec su-exec zeronet "$0" "$@"
fi

exec "$@"
