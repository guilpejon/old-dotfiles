#!/bin/bash

set -e

if
  [[ "${USER:-}" == "root" ]]
then
  echo "This script works only with normal user, it wont work with root, please log in as normal user and try again." >&2
  exit 1
fi

# check if tput exists
if ! command -v tput &> /dev/null; then
  # tput could not be found
  BOLD=""
  RESET=""
else
  BOLD=$(tput bold)
  RESET=$(tput sgr0)
fi

install_msg() {
  printf '%s\n' ----------------------------------------
  echo "> Installing or Upgrading $1"
  printf '%s\n' ----------------------------------------
}

install_or_upgrade() {
  install_msg $1
  sudo apt install "$1" "$2" -y
}

sudo apt-get update -y

curl -sL https://deb.nodesource.com/setup_15.x | sudo -E bash -
install_or_upgrade nodejs

install_or_upgrade redis-server
sudo systemctl enable redis-server.service

install_or_upgrade vim-gtk
install_or_upgrade vim
install_or_upgrade imagemagick --fix-missing
install_or_upgrade build-essential
install_or_upgrade git-core
install_or_upgrade curl
install_or_upgrade openssl
install_or_upgrade libssl-dev
install_or_upgrade libcurl4-openssl-dev
install_or_upgrade zlib1g
install_or_upgrade zlib1g-dev
install_or_upgrade libreadline6-dev
install_or_upgrade libyaml-dev
install_or_upgrade libsqlite3-dev
install_or_upgrade libsqlite3-0
install_or_upgrade sqlite3
install_or_upgrade libxml2-dev
install_or_upgrade libxslt1-dev
install_or_upgrade libffi-dev
install_or_upgrade software-properties-common
install_or_upgrade libgdm-dev
install_or_upgrade libncurses5-dev
install_or_upgrade automake
install_or_upgrade autoconf
install_or_upgrade libtool
install_or_upgrade bison
install_or_upgrade postgresql
install_or_upgrade postgresql-contrib
install_or_upgrade libpq-dev
install_or_upgrade libc6-dev
install_or_upgrade snapd
install_or_upgrade gh
install_or_upgrade zsh
install_or_upgrade ctags
install_or_upgrade tmux
install_or_upgrade terminator
install_or_upgrade ripgrep

# 1 password
sudo apt-key --keyring /usr/share/keyrings/1password.gpg adv --keyserver keyserver.ubuntu.com --recv-keys 3FEF9748469ADBE15DA7CA80AC2D62742012EA22
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password.gpg] https://downloads.1password.com/linux/debian edge main' | sudo tee /etc/apt/sources.list.d/1password.list
sudo apt update && sudo apt install 1password

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update
install_or_upgrade yarn

install_msg "herou"
sudo snap install --classic heroku
heroku plugins:install heroku-accounts

sudo apt autoremove

