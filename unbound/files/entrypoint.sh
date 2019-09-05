#!/bin/sh
set -eou pipefail

# if the first arg starts with "-" pass it to unbound
if [ "${1#-}" != "$1" ]; then
  set -- unbound "$@"
fi

if [ "$1" = "unbound" ] && [ "$(id -u)" = "0" ]; then
  find . \! -user unbound -exec chown unbound '{}' +

  if [[ ! -f /etc/unbound/unbound.conf ]]; then
    su - unbound -s /bin/sh -c unbound-control-setup
  fi

  # this wouldn't work as we can't bind 53
  #exec su-exec unbound "$0" "$@"
  exec su-exec root "$@"
fi

exec "$@"
