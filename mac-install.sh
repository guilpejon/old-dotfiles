set -e

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

# check if an app is installed
command_exists()
{
  command -v "$1" >/dev/null 2>&1
}

install_or_upgrade() {
  install_msg $1
  if brew ls --versions "$1" >/dev/null; then
    HOMEBREW_NO_AUTO_UPDATE=1 brew upgrade "$1"
  else
    HOMEBREW_NO_AUTO_UPDATE=1 brew install "$1"
  fi
}

if ! command_exists brew; then
  install_msg "homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi
brew update

##############
# DEV TOOLS
##############

install_or_upgrade imagemagick
install_or_upgrade postgres
install_or_upgrade node
install_or_upgrade nvm
install_or_upgrade yarn
install_or_upgrade gh
install_or_upgrade zsh
install_or_upgrade ctags
install_or_upgrade ripgrep
install_or_upgrade z

install_or_upgrade redis
ln -sfv /usr/local/opt/redis/*.plist ~/Library/LaunchAgents

brew tap heroku/brew
install_or_upgrade heroku

echo "${BOLD}[✔️ ] Installed all dev tools${RESET}"

##############
# APPS
##############

brew cask install slack
brew cask install spotify
brew cask install google-chrome
brew cask install notion
brew cask install whatsapp
brew cask install telegram

echo "${BOLD}[✔️ ] Installed all apps${RESET}"
