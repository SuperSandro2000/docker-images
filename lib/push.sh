#!/bin/bash
set -eou pipefail

if [[ $# == 0 ]]; then
  $#="--help"
fi

while [[ $# -gt 0 ]]; do
  case "$1" in
    "-h" | "--help")
      echo "Usage:"
      echo "../lib/build.sh [-h|--help] [-b|--binary docker|podman] [--hook URL] [-i|--image supersandro2000/base-alpine|base-alpine] [--variant amd64|arm64|armhf] [-v|--verbose] [--version 1.0.0|infile]"
      echo "--help      Show this help."
      echo "--binary    Binary which runs the build commands."
      echo "--hook      URL to send POST request after sucessful push."
      echo "--image     Image being pushed"
      echo "--verbose   Be more verbose."
      exit 0
      ;;
    "-b" | "--binary")
      binary="$2"
      shift
      ;;
    "-i" | "--image")
      image="$2"
      shift
      ;;
    "--hook")
      hook="$2"
      shift
      ;;
    "--variant")
      variant="$2"
      shift
      ;;
    "--verbose")
      verbose=true
      ;;
    "--version")
      version="$2"
      shift
      ;;
  esac
  shift
done

if [[ -n ${verbose:-} ]]; then
  set -x
fi

function check_tool() {
  if ! eval "$1" >/dev/null 2>&1; then
    echo "You need $1 to run this script."
    echo "On Debian-based systems you can install it with:"
    echo "apt install ${2}"
    exit 1
  fi
}

check_tool "$binary --version" docker
check_tool "curl --version" curl

if [[ -z ${image:-} ]]; then
  echo "You need to supply --image NAME."
  exit 1
else
  if [[ ! $image =~ "/" ]]; then
    image="supersandro2000/$image"
  fi
fi

if [[ -z ${variant:-} ]]; then
  variant="amd64,arm64,armhf"
fi

if [[ -z ${version:-} ]]; then
  echo "You need to supply --version 1.0.0."
  exit 1
fi

function retry() {
  #shellcheck disable=SC2034
  for i in {1..5}; do
    if [ "$(eval "$1")" ]; then
      break
    else
      sleep 5
    fi
  done
}

function push() {
  arch=$1

  if [[ -n ${arch:-} ]]; then
    image_variant="$image:$arch"
  else
    image_variant="Dockerfile"
  fi

  $binary tag "$image_variant-latest" "$image_variant-$version"
  retry "$binary push $image_variant-$version"
  sleep 3
  retry "$binary push $image_variant-latest"
  sleep 3
}

IFS=","
for arch in $variant; do
  IFS=" "
  push "$arch"
done

if [[ -z $hook ]]; then
  curl -X POST "$hook"
fi
