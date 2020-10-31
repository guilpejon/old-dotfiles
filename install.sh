#!/usr/bin/env bash

# Script for installing gldf
#
# This script should be run via curl:
#   sh -c "$(curl -fsSL https://raw.githubusercontent.com/guilpejon/gldf/main/install.sh)"
#
# As an alternative, you can first download the install script and run it afterwards:
#   wget https://raw.githubusercontent.com/guilpejon/gldf/main/install.sh
#   sh install.sh
#
# Respects the following environment variables:
#   GLDF  - path to the gldf repository folder (default: $HOME/gldf)
#   REPO    - name of the GitHub repo to install from (default: guilpejon/gldf)
#   BRANCH  - the main branch of upstream gldf repo (default: main)
#   REMOTE  - full remote URL of the git repo to install (default: GitHub via HTTPS)

GLDF=${GLDF:-$HOME/gldf}
REPO=${REPO:-guilpejon/gldf}
BRANCH=${BRANCH:-main}
REMOTE=${REMOTE:-https://github.com/${REPO}.git}
OS_NAME="$(uname -s)"

# install ruby and all its dependencies
basic_installation()
{
  case "${OS_NAME}" in
    Linux*)     machine=linux;;
    Darwin*)    machine=mac;;
    *)          machine="UNKNOWN:${OS_NAME}"
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

status_check() {
	if [ -d "$GLDF" ]; then
		printf "\n\t%s\n" "You already have ${BOLD}gldf${RESET} installed."
		printf "\n\t%s\n\n" "You'll need to remove '$GLDF' if you want to reinstall."
		exit 0
	fi
}

clone_gldf() {
	if ! command -v git > /dev/null 2>&1; then
		printf "\n%s\n" "${BOLD}Can't work without Git${RESET}"
		exit 1
	else
		git -C "$HOME" clone --branch "$BRANCH" --single-branch "$REMOTE"
		if [ -d "$GLDF" ]; then
			echo "${BOLD}[✔️ ] Successfully cloned gldf${RESET}"
		else
			echo "${BOLD}[❌] Error cloning gldf${RESET}"
		fi
	fi
}

set_alias(){
	if alias gldf > /dev/null 2>&1; then
		printf "\n%s\n" "${BOLD}[✔️ ] gldf is already aliased${RESET}"
		return
	fi

	if [ "$(basename "$SHELL")" = "zsh" ]; then
		echo "alias gldf='$HOME/gldf/gldf.sh'" >> "$HOME"/.zshrc
	elif [ "$(basename "$SHELL")" = "bash" ]; then
		echo "alias gldf='$HOME/gldf/gldf.sh'" >> "$HOME"/.bashrc
	else
		echo "Couldn't set alias for gldf: ${BOLD}$HOME/gldf/gldf.sh${RESET}"
		echo "Consider adding it manually".
		exit 1
	fi
	echo "${BOLD}[✔️ ] Set alias for gldf${RESET}"
}

logo() {
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

main () {

	status_check
	clone_gldf
	set_alias
  # basic_installation
  # rake install
  logo

	printf "\t\t\t%s\n" "     is now installed!"
	printf "\n%s" "Run 'gldf version' to check latest version."
	printf "\n%s\n" "Run 'gldf' to configure first time setup."

}

main
