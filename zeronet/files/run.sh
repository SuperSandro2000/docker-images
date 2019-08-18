#!/bin/sh
set -eou pipefail

if [ -n "$UI_HOST" ]; then
    ARGS="${ARGS:-} --ui_host ${UI_HOST:-}"
fi

if [ -n "$UI_PASSWORD" ]; then
    ARGS="${ARGS:-} --ui_password ${UI_PASSWORD:-}"
fi

[ "${ENABLE_TOR:-}" = true ] && tor &
# shellcheck disable=SC2086
python3 zeronet.py --fileserver_port 26552 --ui_ip 0.0.0.0 ${ARGS:-} "$@"
