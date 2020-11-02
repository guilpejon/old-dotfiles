GLDF=${GLDF:-$HOME/gldf}

############### DEV TOOLS ###############

# install RVM
curl -sSL https://get.rvm.io | bash
source ~/.rvm/scripts/rvm
rvm install ruby --latest

# install ohmyzsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install zplugin
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"

# install spaceship theme for ohmyzsh
sudo chown -R $USER /usr/local
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
awk '!/ZSH_THEME/' $HOME > ~/.temp && mv ~/.temp $HOME # remove current ZSH_THEME
echo ZSH_THEME="'spaceship'" | sudo tee -a "$HOME/.zshrc" # add spaceship theme

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

############### RAILS ###############

gem install solargraph
gem install bundler
gem install foreman

############### FONTS ###############

os_name="$(uname -s)"
case "${os_name}" in
  Linux*)     mkdir -p ~/.fonts && cp "$GLDF/fonts/*" ~/.fonts && fc-cache -vf ~/.fonts;;
  Darwin*)    cp -f "$GLDF/fonts/*" $HOME/Library/Fonts;;
  *)          echo "System not supported"
              exit 1;;
esac
