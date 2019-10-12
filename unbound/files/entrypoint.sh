#!/bin/sh
set -eu

CMD=unbound
USER=unbound

# if the first arg starts with "-" pass it to program
if [ "${1#-}" != "$1" ]; then
    set -- "$CMD" "$@"
fi

if [ "$1" = "$CMD" ] && [ "$(id -u)" = "0" ]; then
    find . \! -user $USER -exec chown $USER '{}' +

  if [[ ! -f /etc/unbound/unbound.conf ]]; then
    su - "$USER" -s /bin/sh -c unbound-control-setup
  fi

  # this wouldn't work as we can't bind 53
  #exec su-exec unbound "$0" "$@"
  exec su-exec root "$@"
fi

exec "$@"
