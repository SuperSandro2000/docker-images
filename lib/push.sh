#!/bin/bash
set -eou pipefail

# shellcheck source=functions.sh
source "$(dirname "$(realpath -s "$0")")/functions.sh"

if [[ $# == 0 ]]; then
  $#="--help"
fi

while [[ $# -gt 0 ]]; do
  case "$1" in
    "-h" | "--help")
      echo "Usage:"
      echo "../lib/build.sh [-h|--help] [-b|--binary docker|podman] [-d|--delay N] [--hook URL] [-i|--image supersandro2000/base-alpine|base-alpine] [-m|--manifest] [--variant amd64|arm64|armhf] [-v|--verbose] [--version 1.0.0|infile]"
      echo "--help      Show this help."
      echo "--binary    Binary which runs the build commands."
      echo "--delay     How many seconds should be waited between pushes."
      echo "--hook      URL to send POST request after sucessful push."
      echo "--manifest  Push manifests. Need to be created with manifest.sh before."
      echo "--image     Image being pushed"
      echo "--variant   Variants which should be included seperated by comma. Defaults to amd64,arm64,armhf."
      echo "--verbose   Be more verbose."
      echo
      show_exit_codes
      exit 0
      ;;
    "-b" | "--binary")
      binary="$2"
      shift
      ;;
    "-d" | "--delay")
      delay="$2"
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
    "-m" | "--manifest")
      manifest=true
      ;;
    "--variant")
      case "$2" in
        "amd64" | "arm64" | "armhf")
          variant="$2"
          shift
          ;;
        "*")
          echo "Varaint $2 is not supported. See --help for supported variants."
          exit 2
      esac
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

if [[ -z ${binary:-} ]]; then
  binary=docker
fi

check_tool "$binary --version" docker
check_tool "curl --version" curl

if [[ -z ${delay:-} ]]; then
  delay=3
elif ! [[ $delay =~ ^[0-9]+$ ]]; then
  echo "$delay is not a number. Delay only takes whole numbers."
  exit 2
fi

if [[ -z ${image:-} ]]; then
  echo "You need to supply --image NAME."
  exit 2
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

function check_manifest() {
  if $binary inspect "$image:$version" && $binary inspect "$image:latest"; then
    return
  fi
  exit 2
}

function push() {
  arch=$1

  if [[ -n ${arch:-} ]]; then
    image_variant="$image:$arch"
  else
    image_variant="$image:"
  fi

  retry "$binary push $image:$version"
  sleep 3
  retry "$binary push $image:latest"
  sleep 3
}

IFS=","
for arch in $variant; do
  IFS=" "
  push "$arch"
done

export DOCKER_CLI_EXPERIMENTAL=enabled

if [[ -n ${manifest:-} ]]; then
  retry "$binary manifest push $image_variant-$version"
  sleep 3
  retry "$binary manifest push $image_variant-latest"
fi

if [[ -z $hook ]]; then
  curl -X POST "$hook"
fi
