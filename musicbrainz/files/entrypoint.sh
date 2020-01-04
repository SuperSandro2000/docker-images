#!/bin/bash
set -euo pipefail

CMD=plackup
USER=musicbrainz

# if the first arg starts with "-" pass it to program
if [[ ${1#-} != "$1" ]]; then
  set -- "$CMD" "$@"
fi

if [[ -z ${WEB_SERVER:-} ]]; then
  echo "You need to set the domain to listen to via the environment variable WEB_SERVER. Exiting."
  exit 1
elif [[ ${MUSICBRAINZ_USE_PROXY:-0} == 0 ]]; then
  echo "If you are running this container behind a reverse proxy (which you should) you need to set MUSICBRAINZ_USE_PROXY to 1"
fi

if [[ -z ${REPLICATION_TYPE:-} ]]; then
  echo "You need to set the replication type via the environment variable REPLICATION_TYPE. Exiting."
  exit 1
else
  if [[ ${REPLICATION_TYPE:-} == RT_SLAVE && -z ${REPLICATION_ACCESS_TOKEN:-} ]]; then
    echo "You need to set the replication access token via the environment variable REPLICATION_ACCESS_TOKEN. Exiting."
    exit 1
  fi

  if [[ ${SSL_REDIRECTS_ENABLED:-0} == 0 ]]; then
    echo "If you are running this server in producton you need to set SSL_REDIRECTS_ENABLED to 1."
    exit 1
  fi
fi

if [[ -z ${SMTP_SECRET_CHECKSUM:-} ]]; then
  echo "You need to set the SMTP token via the environment variable SMTP_SECRET_CHECKSUM. You can generate one with "pwgen -s 256 1". Exiting."
  exit 1
fi

if [ "$1" = "$CMD" ] && [ "$(id -u)" = "0" ]; then
  #find . \! -user $USER -exec chown $USER '{}' +

  exec gosu $USER "$0" "$@"
fi

exec "$@"
