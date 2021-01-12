GLDF=${GLDF:-$HOME/gldf}

############### FONTS ###############

if [[ $(uname) == 'Darwin' ]]; then
  # MacOS
  font_dir="$HOME/Library/Fonts"
else
  # Linux
  font_dir="$HOME/.fonts"
  mkdir -p $font_dir
fi

rsync -vr fonts/ "$font_dir"

# Reset font cache on Linux
if [[ -n $(which fc-cache) ]]; then
  fc-cache -f $font_dir
fi

############### DEV TOOLS ###############

# install RVM
curl -sSL https://get.rvm.io | bash

# install ohmyzsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install zplugin
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"

# install spaceship theme for ohmyzsh
# sudo chown -R $USER /usr/local
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
awk '!/ZSH_THEME/' $HOME > ~/.temp && mv ~/.temp $HOME # remove current ZSH_THEME
echo ZSH_THEME="'spaceship'" | sudo tee -a "$HOME/.zshrc" # add spaceship theme

# install vim plug to manage vim plugins
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install tldr
npm install -g tldr

############### RUBY & RAILS ###############

source "$HOME/.rvm/scripts/rvm"
rvm install ruby --latest

gem install solargraph
gem install bundler
gem install foreman
