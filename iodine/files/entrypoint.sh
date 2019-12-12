#!/bin/ash
set -eu
set -x
CMD=iodined
USER=iodine

# if the first arg starts with "-" pass it to program
if [ "${1#-}" != "$1" ]; then
  set -- "$CMD" "$@"
fi

if [ "$1" = "$CMD" ] && [ "$(id -u)" = "0" ]; then
  find . \! -user $USER -exec chown $USER '{}' +

  if [ -z "${PASSWORD:-}" ]; then
    echo "You need to set the password via the environment variable PASSWORD. Exiting."
    exit 1
  fi

  if [ -z "${DOMAIN:-}" ]; then
    echo "You need to set the domain to listen to via the environment variable DOMAIN. Exiting."
    exit 1
  fi

  mkdir -p /dev/net
  mknod /dev/net/tun c 10 200

  exec "$@" -f -u iodine -P "$PASSWORD" "${TUNNEL_IP:-"10.0.0.1"}" "$DOMAIN"
fi

exec "$@"
