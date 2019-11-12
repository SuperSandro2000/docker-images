#!/bin/bash
set -eou pipefail

function show_exit_codes() {
  echo "Exit codes:"
  echo "0:   clean"
  echo "1:   error"
  echo "2:   argument error"
  echo "3:   missing tool"
  echo "10:  manifest error"
}

function check_tool() {
  if ! eval "$1" >/dev/null 2>&1; then
    echo "You need $1 to run this script."
    echo "On Debian-based systems you can install it with:"
    echo "apt install $2"
    exit 3
  fi
}

function retry() {
  tries=${2:-3}
  for ((i = 0; i < tries; i++)); do
    if eval "$1"; then
      break
    else
      sleep "${delay:-3}"
    fi
    if ((i == tries - 1)); then
      echo "Command: \"$1\" failed after $tries tries."
      exit 10
    fi
  done
}
