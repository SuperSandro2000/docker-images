#!/bin/bash
set -eou pipefail

# if the first arg starts with "-" pass it to uwsgi
if [ "${1#-}" != "$1" ]; then
  set -- uwsgi -d "$@"
fi

if [ "$1" = "uwsgi" ] && [ "$(id -u)" = "0" ]; then
  find . \! -user healthchecks -exec chown healthchecks '{}' +
  exec gosu healthchecks "$0" "$@"
fi

exec "$@"
