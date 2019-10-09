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

export DOCKER_CLI_EXPERIMENTAL=enabled

for version_latest in $version latest; do
  IFS=","
  variant_manifest=""
  for arch in $variant; do
    variant_manifest+="$image:$arch-$version_latest "
  done
  IFS=" "

  rm -rf "$HOME/.docker/manifests/docker.io_${image//\//_}-"*
  #shellcheck disable=SC2068
  $binary manifest create "$image:$version_latest" ${variant_manifest[@]}

  $binary manifest annotate "$image:$version_latest" "$image:amd64-$version_latest" --os linux --arch amd64
  $binary manifest annotate "$image:$version_latest" "$image:armhf-$version_latest" --os linux --arch arm --variant v7
  $binary manifest annotate "$image:$version_latest" "$image:arm64-$version_latest" --os linux --arch arm64 --variant v8

  retry "$binary manifest push $image:$version_latest"
  sleep 3
done

if [[ -z $hook ]]; then
  curl -X POST "$hook"
fi
