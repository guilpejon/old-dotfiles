#!/usr/bin/env bash

GLDF=${GLDF:-$HOME/gldf}
REPO=${REPO:-guilpejon/gldf}
BRANCH=${BRANCH:-main}
REMOTE=${REMOTE:-https://github.com/${REPO}.git}

# check if tput exists
if ! command -v tput &> /dev/null; then
  # tput could not be found
  BOLD=""
  RESET=""
  FG_GREEN=""
	FG_SKYBLUE=""
  FG_ORANGE=""
  BG_AQUA=""
  FG_BLACK=""
  FG_ORANGE=""
  UL=""
  RUL=""
else
  BOLD=$(tput bold)
  RESET=$(tput sgr0)
  FG_GREEN=$(tput setaf 70)
	FG_SKYBLUE=$(tput setaf 122)
  FG_ORANGE=$(tput setaf 208)
  BG_AQUA=$(tput setab 45)
  FG_BLACK=$(tput setaf 16)
  FG_ORANGE=$(tput setaf 214)
  UL=$(tput smul)
  RUL=$(tput rmul)
fi

print_logo() {
  printf "${BOLD}${FG_SKYBLUE}%s\n" ""
  printf "%s\n" "                         _ .-') _               "
  printf "%s\n" "                        ( (  OO) )              "
  printf "%s\n" "  ,----.      ,--.       \     .'_     ,------. "
  printf "%s\n" " '  .-./-')   |  |.-')   ,\`'--..._) ('-| _.---'"
  printf "%s\n" " |  |_( O- )  |  | OO )  |  |  \  ' (OO|(_\     "
  printf "%s\n" " |  | .--, \  |  |\`-' |  |  |   ' | /  |  '--. "
  printf "%s\n" "(|  | '. (_/ (|  '---.'  |  |   / : \_)|  .--'  "
  printf "%s\n" " |  '--'  |   |      |   |  '--'  /   \|  |_)   "
  printf "%s\n" "  \`------'    \`------'   \`-------'     \`--' "
  printf "${RESET}\n%s" ""
}

# check if git exists
type git >/dev/null 2>&1 || { echo >&2 "Can't work without Git"; exit 1; }

goodbye() {
  printf "\a\n\n%s\n" "${BOLD}Thanks for using GLDF 🖖.${RESET}"
}

# function called by trap
catch_ctrl_c() {
  goodbye
  exit
}
trap 'catch_ctrl_c' SIGINT

clone_gldf() {
  if ! [ -d "$GLDF" ]; then
    git -C "$HOME" clone --branch "$BRANCH" --single-branch "$REMOTE"
    if [ -d "$GLDF" ]; then
      echo "${BOLD}[✔️ ] Successfully cloned GLDF${RESET}"
    else
      echo "${BOLD}[❌] Error cloning GLDF${RESET}"
    fi
  else
    update
  fi
}

set_alias(){
	if alias gldf > /dev/null 2>&1; then
		printf "\n%s\n" "${BOLD}[✔️ ] GLDF is already aliased${RESET}"
		return
	fi

	if [ "$(basename "$SHELL")" = "zsh" ]; then
    awk '!/gldf/' "$HOME"/.zshrc > ~/.temp && mv ~/.temp "$HOME"/.zshrc
		echo "alias gldf='$HOME/gldf/gldf.sh'" >> "$HOME"/.zshrc
	elif [ "$(basename "$SHELL")" = "bash" ]; then
    awk '!/gldf/' "$HOME"/.bashrc > ~/.temp && mv ~/.temp "$HOME"/.bashrc
		echo "alias gldf='$HOME/gldf/gldf.sh'" >> "$HOME"/.bashrc
	else
		echo "Couldn't set alias for gldf: ${BOLD}$HOME/gldf/gldf.sh${RESET}"
		echo "Consider adding it manually".
		exit 1
	fi
	echo "${BOLD}[✔️ ] Set alias for GLDF${RESET}"
}

os() {
  os_name="$(uname -s)"

  case "${os_name}" in
    Linux*)     machine=linux;;
    Darwin*)    machine=mac;;
    *)          machine="UNKNOWN:${os_name}"
  esac
  echo $machine
}

package_installation()
{
  if [ $(os) = "linux" ]; then
    "$GLDF/linux-install.sh"
  elif [ $(os) = "mac" ]; then
    "$GLDF/mac-install.sh"
  else
    echo "System not supported"
    exit 1
  fi

  "$GLDF/agnostic-install.sh"
}

git_config() {
  ln -nfs "$GLDF/git/.gitconfig" $HOME
  ln -nfs "$GLDF/git/.gitignore" $HOME
  ln -nfs "$GLDF/git/.gitmessage" $HOME

  # rsync -avh --no-perms "$GLDF/git/.gitconfig" $HOME
  # rsync -avh --no-perms "$GLDF/git/.gitignore" $HOME
  # rsync -avh --no-perms "$GLDF/git/.gitmessage" $HOME

  read -p 'Git user name: ' user_name
  read -p 'Git user email: ' user_email

  git config --global user.name $user_name
  git config --global user.email $user_email
  git config --global core.editor "vim"
}

vim_config() {
  mkdir -p $HOME/.vim
  ln -nfs "$GLDF/vim/.vimrc" $HOME
  ln -nfs "$GLDF/vim/coc-settings.json" "$HOME/.vim/"
  ln -nfs "$GLDF/vim/plugins.vim" "$HOME/.vim/"

  # rsync -avh --no-perms "$GLDF/vim/.vimrc" $HOME
  # rsync -avh --no-perms "$GLDF/vim/coc-settings.json" "$HOME/.vim"
  # rsync -avh --no-perms "$GLDF/vim/plugins.vim" "$HOME/.vim"
  vim --noplugin -N \"+set hidden\" \"+syntax on\" +PlugClean +PlugInstall! +PlugUpdate +qall
}

n_of_cores() {
  if [ $(os) = "linux" ]; then
    echo `nproc`
  elif [ $(os) = "mac" ]; then
    echo `sysctl -n hw.ncpu`
  fi
}

ruby_config() {
  ln -nfs "$GLDF/ruby/gemrc" $HOME
  # rsync -avh --no-perms "$GLDF/ruby/gemrc" $HOME

  bundler_jobs=`expr $(n_of_cores) - 1`
  bundle config --global jobs $bundler_jobs
}

ctag_config() {
  ln -nfs "$GLDF/ctags/.ctags" $HOME
  # rsync -avh --no-perms "$GLDF/ctags/.ctags" $HOME
}

tmux_config() {
  ln -nfs "$GLDF/tmux/.tmux.conf" $HOME
  # rsync -avh --no-perms "$GLDF/tmux/.tmux.conf" $HOME
}

zsh_config() {
  mkdir -p "$HOME/.zsh"

  printf ". ~/.zsh/.zsh_aliases\n" >> ~/.zshrc
  ln -nfs "$GLDF/zsh/.zsh_aliases" "$HOME/.zsh/"
  # rsync -avh --no-perms "$GLDF/zsh/.zsh_aliases" "$HOME/.zsh/"

  printf ". ~/.zsh/.zplugin\n" >> ~/.zshrc
  ln -nfs "$GLDF/zsh/.zplugin" "$HOME/.zsh/"
  # rsync -avh --no-perms "$GLDF/zsh/.zplugin" "$HOME/.zsh/"

  printf ". ~/.zsh/.zsh_spaceship\n" >> ~/.zshrc
  ln -nfs "$GLDF/zsh/.zsh_spaceship" "$HOME/.zsh/"
  # rsync -avh --no-perms "$GLDF/zsh/.zsh_spaceship" "$HOME/.zsh/"
}

install_vim() {
	clone_gldf
	set_alias

  if [ $(os) = "linux" ]; then
    sudo apt install vim vim-gtk
  elif [ $(os) = "mac" ]; then
    brew install vim
  else
    echo "System not supported"
    exit 1
  fi

  vim_config
  print_logo

	printf "\t\t\t%s\n" "     VIM configuration ${BOLD}COMPLETE!${RESET}"
	# printf "\n%s" "Run 'gldf version' to check latest version."
}

install() {
	clone_gldf
  package_installation
	set_alias
  git_config
  vim_config
  ruby_config
  ctag_config
  tmux_config
  zsh_config
  print_logo

	printf "\t\t\t%s\n" "     is now ${BOLD}INSTALLED!${RESET}"
	# printf "\n%s" "Run 'gldf version' to check latest version."
}

install_confirmation() {
  printf "\n\n"
  read -p "This may overwrite existing configuration files in your home directory. Are you sure? (y/n) " -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    install;
  fi;
}

update() {
  if [ -d "$GLDF" ]; then
    git -C "$GLDF" pull --no-rebase "$REMOTE"
    echo "${BOLD}[✔️ ] Successfully updated GLDF${RESET}"
  else
    echo "${BOLD}[❌] GLDF not installed${RESET}"
  fi
}

uninstall() {
  echo "This command only removes the GLDF folder"
  rm -rf $GLDF
  echo "${BOLD}[✔️ ] Successfully uninstalled GLDF${RESET}"
}

menu() {
	while :
	do
		printf "\n%s" "[${BOLD}1${RESET}] Set up a new computer"
		printf "\n%s" "[${BOLD}2${RESET}] Install VIM"
		printf "\n%s" "[${BOLD}3${RESET}] Update GLDF"
		printf "\n%s" "[${BOLD}4${RESET}] Uninstall"
		printf "\n%s\n" "[${BOLD}5/q/Q${RESET}] Exit"
		read -p "Select your command [${BOLD}1${RESET}]: " -n 1 -r USER_INPUT
    # set default input
		# USER_INPUT=${USER_INPUT:-1}
		case $USER_INPUT in
			[1]* ) install_confirmation;;
			[2]* ) install_vim;;
			[3]* ) update;;
			[4]* ) uninstall;;
			[5/q/Q]* ) goodbye
					 exit;;
			* )     printf "\n%s\n" "Invalid Input.";;
		esac
	done
}

intro() {
  BOSS_NAME=$LOGNAME
  printf "\n\a%s" "Hi ${BOLD}${FG_ORANGE}$BOSS_NAME${RESET} 👋"
  print_logo
  printf "\n%s\n" "Welcome to ${BOLD}GLDF${RESET}!"
  printf "%s\n" "................."
}

intro
menu
