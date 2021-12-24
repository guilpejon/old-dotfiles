# to install vim plug for nvim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# install ag for FZF
brew install the_silver_searcher

# install nodejs
curl -sL install-node.now.sh/release | bash
