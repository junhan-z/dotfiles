#!/bin/bash

DOTFILES_PATH=$(pwd)
INSTALL_PATH=$HOME

# borrowed from oh-my-zsh
setup_color() {
  # Only use colors if connected to a terminal
  if [ -t 1 ]; then
    RED=$(printf '\033[31m')
    GREEN=$(printf '\033[32m')
    YELLOW=$(printf '\033[33m')
    BLUE=$(printf '\033[34m')
    BOLD=$(printf '\033[1m')
    RESET=$(printf '\033[m')
  else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    BOLD=""
    RESET=""
  fi
}

check_omz() {
  # must go first as some ENVs depends on this
  if [[ -z "$ZSH" ]]; then
    echo "${BOLD}${RED}install.sh relies on oh-my-zsh${RESET}"
    echo "Go to ${BOLD}${GREEN}https://ohmyz.sh/#install${RESET} to install."
    return 1
  fi
  return 0
}

copy_config_files() {
  CONFIGS=($(ls "$DOTFILES_PATH/configs"))

  echo "${BLUE}Create symbol links...${RESET}"
  for f in "${CONFIGS[@]}"
  do
    local FROM="$DOTFILES_PATH/configs/$f"
    local TO="$INSTALL_PATH/.$f"

    if test -e "$TO"; then
      echo "$TO already exists..."
      echo "${RED}[Remove]${RESET} $TO..."
      # rm $TO
    fi
    echo "${GREEN}[Create]${RESET} $TO -> $FROM"
    # TODO: it behaves a bit differently when symbol link a directory
    ln -s "$FROM" "$TO"
    echo
  done

}

copy_theme() {
  echo "${GREEN}[Copy]${RESET} Nahnuj theme to $ZSH/themes..."
  cp $DOTFILES_PATH/nahnuj.zsh-theme $ZSH/themes
  echo
}

install_plugins() {
  echo "${BLUE}Install a couple oh-my-zsh plugins...${RESET}"
  local ZSH_PLUGINS_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"
  local PLUGINS=("zsh-syntax-highlighting" "zsh-autosuggestions")

  for p in ${PLUGINS[@]}; do
    if [[ -d "$ZSH_PLUGINS_DIR/$p" ]]; then
      echo "${GREEN}[Skip]${RESET} $p exist..."
    else
      echo "${BLUE}[Install]${RESET} $p"
      git clone https://github.com/zsh-users/$p.git $ZSH_PLUGINS_DIR/$p
    fi
  done
}

install_tools() {
  if ! [[ -e ~/.fzf ]]; then
    echo "${BLUE}[Install]${RESET} fzf..."
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
  else
    echo "${GREEN}[Skip]${RESET} fzf exist..."
  fi

  echo "${BLUE}Install PIP3...${RESET}"

  echo "${BLUE}Install virtualenv...${RESET}"


}


main() {
  echo "run from: $DOTFILES_PATH"
  echo "install to: $INSTALL_PATH"

  setup_color
  if ! check_omz; then
    return 1
  fi

  copy_config_files
  copy_theme

  # oh-my-zsh only
  install_plugins

  # other stuffs
  install_tools

}

main "$@"
