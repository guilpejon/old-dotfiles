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

sudo chown -R $(whoami) $(brew --prefix)/*

install_or_upgrade cask
install_or_upgrade tmux
install_or_upgrade overmind
install_or_upgrade imagemagick
install_or_upgrade node
install_or_upgrade nvm
install_or_upgrade gh
install_or_upgrade zsh
install_or_upgrade ctags
install_or_upgrade ripgrep
install_or_upgrade z
install_or_upgrade vim
install_or_upgrade diff-so-fancy
install_or_upgrade watch
install_or_upgrade wget
install_or_upgrade wireguard-tools
brew install --cask ngrok

# install lvim
curl https://sh.rustup.rs -sSf | sh
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)

install_or_upgrade asdf
echo -e "\n. $(brew --prefix asdf)/libexec/asdf.sh" >> ~/.zshrc
brew install gpg
brew install gawk

install_or_upgrade redis
ln -sfv /usr/local/opt/redis/*.plist ~/Library/LaunchAgents

brew tap heroku/brew
install_or_upgrade heroku
heroku plugins:install heroku-accounts

install_or_upgrade postgres
# brew services start postgresql
# /usr/local/opt/postgres/bin/createuser -s postgres

echo "${BOLD}[✔️ ] Installed all dev tools${RESET}"

##############
# APPS
##############

install_or_upgrade slack
install_or_upgrade spotify
# install_or_upgrade google-chrome
install_or_upgrade notion
install_or_upgrade whatsapp
install_or_upgrade telegram
install_or_upgrade 1password

##############
# ITERM2
##############

install_or_upgrade iterm2
/usr/libexec/PlistBuddy -c "Add :'Custom Color Presets':'Gruvbox Dark' dict" ~/Library/Preferences/com.googlecode.iterm2.plist
/usr/libexec/PlistBuddy -c "Merge 'iTerm2/Gruvbox Dark.itermcolors' :'Custom Color Presets':'Gruvbox Dark'" ~/Library/Preferences/com.googlecode.iterm2.plist

echo "${BOLD}[✔️ ] Installed all apps${RESET}"
