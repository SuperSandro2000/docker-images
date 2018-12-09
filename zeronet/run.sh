#! /bin/ash
set -ex
[ "${ENABLE_TOR}" == true ] && tor&
python zeronet.py --ui_ip 0.0.0.0 --fileserver_port 26552 --ui_password ${UI_PASSWORD}