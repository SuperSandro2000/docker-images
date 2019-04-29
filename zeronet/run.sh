#! /bin/sh
set -ex
[ "${ENABLE_TOR}" = true ] && tor &
python zeronet.py --fileserver_port 26552 --ui_host "${UI_HOST}" --ui_ip 0.0.0.0 --ui_password "${UI_PASSWORD}"
