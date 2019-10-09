#!/bin/bash
set -eou pipefail

if [[ $# == 0 ]]; then
  $#="--help"
fi

while [[ $# -gt 0 ]]; do
  case "$1" in
    "-h" | "--help")
      echo "Usage:"
      echo "../lib/build.sh [--help] [-b|--binary docker|podman] [--buildkit] [--ci] [-t|--tag supersandro2000/base-alpine|base-alpine] [--variant amd64|arm64|armhf] [-v|--verbose] [--version 1.0.0|infile]"
      echo "--help      Show this help."
      echo "--binary    Binary which runs the build commands."
      echo "--buildkit  Run docker with buildkit enabled."
      echo "--ci        Specify if ran by an CI."
      echo "--tag       Tags added to the image."
      echo "--variant   Variants to be build. May define multiple seperated with comma. Valid values are amd64, arm64 or armhf."
      echo "--verbose   Be more verbose."
      echo "--version   Version the image gets tagged with. 'infile' means the Dockerfile is tagged manually."
      exit 0
      ;;
    "-b" | "--binary")
      binary="$2"
      shift
      ;;
    "--buildkit")
      export DOCKER_BUILDKIT=1
      buildkit=true
      ;;
    "-t" | "--tag")
      tag="$2"
      shift
      ;;
    "--variant")
      variant="$2"
      shift
      ;;
    "-v" | "--verbose")
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
  binary="docker"
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
check_tool "git --version" git

if [[ -z ${tag:-} ]]; then
  echo "You need to supply --tag NAME."
  exit 1
else
  if [[ ! $tag =~ "/" ]]; then
    tag="supersandro2000/$tag"
  fi
fi

if [[ -z ${variant:-} ]]; then
  variant="amd64,arm64,armhf"
fi

if [[ -z ${version:-} ]]; then
  echo "You need to supply --version 1.0.0."
  exit 1
fi

if [[ -n ${CI:-} && -n ${buildkit:-} ]]; then
  build_arg="--progress plain"
else
  build_arg=
fi

function build() {
  arch=$1
  build_tag="$tag:$arch-latest"

  if [[ -z ${buildkit:-} ]]; then
    build_args="$build_arg --cache-from $build_tag"
  else
    build_args=
  fi

  if [[ -n ${arch:-} ]]; then
    file="$arch.Dockerfile"
  else
    file="Dockerfile"
  fi

  if [[ $version != "infile" ]]; then
    version_arg="--build-arg VERSION=$version"
  fi

  #shellcheck disable=SC2068
  $binary build $build_args --pull \
    --build-arg BUILD_DATE="$(date -u +"%Y-%m-%dT%H:%M:%SZ")" \
    ${version_arg[@]} \
    --build-arg REVISION="$(git rev-parse --short HEAD)" \
    -f "$file" -t "$build_tag" .
}

IFS=","
for arch in $variant; do
  IFS=" "
  build "$arch"
done
