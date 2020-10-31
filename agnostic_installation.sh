##############
# DEV TOOLS
##############

# install ohmyzsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install RVM
curl -kL get.rvm.io | bash -s stable --ruby
source ~/.rvm/scripts/rvm

# install spaceship theme for ohmyzsh
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
awk '!/ZSH_THEME/' $HOME > ~/.temp && mv ~/.temp $HOME # remove current ZSH_THEME
echo ZSH_THEME="'spaceship'" | sudo tee -a "$HOME/.zshrc" # add spaceship theme

# install zplugin
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

##############
# RAILS
##############

chmod +x $rvm_path/hooks/after_cd_bundler

gem install solargraph
gem install bundler
gem install foreman
