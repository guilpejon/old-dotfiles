#!/usr/bin/env bash

GLDF=${GLDF:-$HOME/gldf}
REPO=${REPO:-guilpejon/gldf}
REMOTE=${REMOTE:-https://github.com/${REPO}.git}

# check if tput exists
if ! command -v tput &> /dev/null; then
  # tput could not be found
  BOLD=""
  RESET=""
  FG_GREEN=""
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
  FG_ORANGE=$(tput setaf 208)
  BG_AQUA=$(tput setab 45)
  FG_BLACK=$(tput setaf 16)
  FG_ORANGE=$(tput setaf 214)
  UL=$(tput smul)
  RUL=$(tput rmul)
fi

logo() {
  printf "${BOLD}${FG_GREEN}%s\n" ""
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

goodbye() {
  printf "\a\n\n%s\n" "${BOLD}Thanks for using gldf 🖖.${RESET}"
}

# function called by trap
catch_ctrl+c() {
  goodbye
  exit
}

trap 'catch_ctrl+c' SIGINT

update() {
	if ! command -v git > /dev/null 2>&1; then
		printf "\n%s\n" "${BOLD}Can't work without Git${RESET}"
		exit 1
	else
		git -C "$GLDF" pull --no-rebase "$REMOTE"
		echo "${BOLD}[✔️ ] Successfully updated gldf${RESET}"
	fi
}

menu() {
  printf "\n\n%s\n" "Welcome to ${BOLD}gldf${RESET}!"
  printf "%s\n" "................."
  PS3='➤ Please enter your choice: '
  options=("Update" "Exit")
  select opt in "${options[@]}"
  do
      case $opt in
          "Update")
              update
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

main() {
  if [[ -z ${DOT_REPO} && -z ${DOT_DEST} ]]; then
    menu
  else
    repo_check
    manage
  fi
}

intro
main
