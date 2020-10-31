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

# check if git exists
if ! command -v git &> /dev/null; then
	printf "%s\n\n" "${BOLD}${FG_SKYBLUE}GLDF${RESET}"
	echo "Can't work without Git"
	exit 1
fi

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
    echo "${BOLD}[✔️ ] GLDF folder already exists${RESET}"
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

# install ruby and all its dependencies
package_installation()
{
  os_name="$(uname -s)"

  case "${os_name}" in
    Linux*)     machine=linux;;
    Darwin*)    machine=mac;;
    *)          machine="UNKNOWN:${os_name}"
  esac

  if [ "${machine}" = "linux" ]; then
    "$GLDF/linux-install.sh"
  elif [ "${machine}" = "mac" ]; then
    "$GLDF/mac-install.sh"
  else
    echo "System not supported"
    exit 1
  fi

  ./agnostic_installation.sh
}

install() {
	clone_gldf
	set_alias
  package_installation
  rake install
  logo

	printf "\t\t\t%s\n" "     is now installed!"
	printf "\n%s" "Run 'gldf version' to check latest version."
	printf "\n%s\n" "Run 'gldf' to configure first time setup."
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
  printf "\n\n%s\n" "Welcome to ${BOLD}GLDF${RESET}!"
  printf "%s\n" "................."
  PS3='➤ Please enter your choice: '
  options=("Install" "Update" "Uninstall" "Exit")
  select opt in "${options[@]}"
  do
      case $opt in
          "Install")
              install
              ;;
          "Update")
              update
              ;;
          "Uninstall")
              uninstall
              ;;
          "Exit")
              goodbye
              break
              ;;
          *) echo "Invalid option: $REPLY";;
      esac
  done
}

intro() {
  BOSS_NAME=$LOGNAME
  printf "\n\a%s" "Hi ${BOLD}${FG_ORANGE}$BOSS_NAME${RESET} 👋"
  logo
}

intro
menu

