#!/bin/bash
# shellcheck disable=SC2016
set -eou pipefail

# shellcheck source=functions.sh source=lib/functions.sh disable=SC1091
source "$(dirname "$(realpath -s "$0")")/functions.sh"

if [[ $# == 0 ]]; then
  set -- --help
fi

while [[ $# -gt 0 ]]; do
  case "$1" in
    "-h" | "--help")
      echo "Usage:"
      echo "../lib/build.sh [--help] [-b|--binary docker|podman] [--build-args EXAMPLE=VAL[,TWO=VAL]] [--buildkit] [--ci] [-d|--delay N] [-n|--dry-run] [-i|--image supersandro2000/base-alpine|base-alpine] [-t|--tag edge|stable|1.0.0] [--tag-suffix alpine-] [--variant amd64|arm64|armhf] [-v|--verbose] [--version 1.0.0]"
      echo "--help         Show this help."
      echo "--binary       Binary which runs the build commands."
      echo '--build-args   Build args passed to $BINARY build.'
      echo "--buildkit     Run docker with buildkit enabled."
      echo "--dry-run      Show commands which would be run."
      echo "--ci           Specify if ran by an CI."
      echo "--delay        How many seconds should be waited between pushes."
      echo "--image        How the image is being named."
      echo "--tag          Tags added to the image."
      echo "--tag-suffix   Suffix added infront of each tag."
      echo "--variant      Variants to be build. May define multiple seperated with comma. Valid values are amd64, arm64 or armhf."
      echo "--verbose      Be more verbose."
      echo
      show_exit_codes
      exit 0
      ;;
    "-b" | "--binary")
      binary="$2"
      shift
      ;;
    "--build-args")
      OLD_IFS=$IFS
      IFS=","
      for arg in $2; do
        build_args+="--build-arg $arg "
      done
      IFS=$OLD_IFS
      shift
      ;;
    "--buildkit")
      if [[ -n ${CI:-} && $(docker --version | awk '{print $3}') =~ 18.06 ]]; then
        sudo bash -c "echo \$(jq '.experimental=true' /etc/docker/daemon.json) > /etc/docker/daemon.json"
        sudo service docker restart
      fi
      if [[ -z ${CI:-} ]]; then
        export DOCKER_BUILDKIT=1
        buildkit=true
      fi
      ;;
    "--ci")
      CI=true
      ;;
    "-d" | "--delay")
      delay="$2"
      shift
      ;;
    "-n" | "--dry-run")
      dry_run=true
      ;;
    "-i" | "--image")
      image="$2"
      shift
      ;;
    "-t" | "--tag")
      tag="$2"
      shift
      ;;
    "--tag-suffix")
      tag_suffix="$2"
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
    *)
      echo "Argument $1 is not understood."
      exit 2
      ;;
  esac
  shift
done

if [[ -n ${verbose:-} ]]; then
  set -x
fi

binary=${bianry:-docker}
if [[ -n ${dry_run:-} ]]; then
  binary="echo $binary"
fi

check_tool "$binary --version" docker
check_tool "git --version" git

delay=${delay:-3}
if ! [[ $delay =~ ^[0-9]+$ ]]; then
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

if [[ -z ${tag:-} && -z ${version:-} ]]; then
  echo "You need to supply either --tag edge|stable|1.0.0 or --version 1.0.0."
  exit 2
fi

if [[ -n ${CI:-} && -n ${buildkit:-} ]]; then
  build_args+=" --progress plain"
fi

function build() {
  arch=$1
  tag_suffix=${tag_suffix:=}

  if [[ -n ${tag:-} ]]; then
    file_prefix="$arch-$tag"
    build_image="$image:$tag_suffix$arch-$tag"
  else
    build_image="$image:$tag_suffix$arch-$version"
    if [[ $(uname -m) == "$arch" ]]; then
      file_prefix="amd64"
    else
      file_prefix="$arch"
    fi
  fi

  if [[ -z ${buildkit:-} ]]; then
    build_args+=" --cache-from $build_image"
  fi

  #shellcheck disable=SC2068
  $binary build ${build_args[@]:-} --pull \
    --build-arg BUILD_DATE="$(date -u +"%Y-%m-%d")" \
    --build-arg VERSION="${version:-$tag}" \
    --build-arg REVISION="$(git rev-parse --short HEAD)" \
    -f "${file_prefix}.Dockerfile" -t "$build_image" -t "$image:$tag_suffix$arch-latest" .
}

IFS=","
for arch in $variant; do
  IFS=" "
  build "$arch"
done
