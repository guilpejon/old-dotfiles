#!/usr/bin/env bash

os_name="$(uname -s)"

# install ruby and all its dependencies
basic_installation()
{
  case "${os_name}" in
    Linux*)     machine=linux;;
    Darwin*)    machine=mac;;
    *)          machine="UNKNOWN:${os_name}"
  esac

  if [ "${machine}" = "linux" ]; then
    ./linux-install.sh
  elif [ "${machine}" = "mac" ]; then
    ./mac-install.sh
  else
    echo "System not supported"
    exit 1
  fi

  ./agnostic_installation.sh
}

basic_installation
# rake install
