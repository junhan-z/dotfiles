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

info() {
  msg=$1
  echo "${BLUE}$msg${RESET}"
}

act() {
  msg=$1
  echo "${BOLD}$msg${RESET}"
}

warn() {
  msg=$1
  echo "${YELLOW}$msg${RESET}"
}

error() {
  msg=$1
  echo "${RED}$msg${RESET}"
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

  info "Create symbol links"
  for f in "${CONFIGS[@]}"
  do
    local FROM="$DOTFILES_PATH/configs/$f"
    local TO="$INSTALL_PATH/.$f"

    if test -e "$TO"; then
      echo "$TO already exists"
      echo "${RED}[Remove]${RESET} $TO"
      rm $TO
    fi
    echo "${GREEN}[Create]${RESET} $TO -> $FROM"
    # TODO: it behaves a bit differently when symbol link a directory
    ln -s "$FROM" "$TO"
    echo
  done

}

copy_theme() {
  info "Add a custom theme"
  act "[Copy] Nahnuj theme to $ZSH/themes"
  cp $DOTFILES_PATH/nahnuj.zsh-theme $ZSH/themes
  echo
}

install_plugins() {
  info "Install a couple oh-my-zsh plugins"
  local ZSH_PLUGINS_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"
  local PLUGINS=("zsh-syntax-highlighting" "zsh-autosuggestions")

  for p in ${PLUGINS[@]}; do
    info "* $p"
    if [[ -d "$ZSH_PLUGINS_DIR/$p" ]]; then
      act "[Skip] Installed"
    else
      act "[Install] $p"
      git clone https://github.com/zsh-users/$p.git $ZSH_PLUGINS_DIR/$p
    fi
  done
  echo
}

install_fzf() {
  info "* fzf"
  if ! [[ -e ~/.fzf ]]; then
    echo "${BLUE}[Install]${RESET} fzf"
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
  else
    act "[Skip] Installed"
  fi
}

check_command() {
  local command=$1
  info "* $command"
  if ! command -v $command &> /dev/null
  then
    warn "Not found $command, attempt to install now..."
    return 1
  else
    act "[Skip] Installed"
  fi

}

install_pip3() {
  check_command "pip3"
  if [ $? -ne 0 ]; then
    act "[Install] pip3"
    # TODO: add command here
  fi

}

install_virtualenv() {
  check_command "virtualenv"
  if [ $? -ne 0 ]; then
    act "[Install] virtualenv"
    sudo pip3 install virtualenv
  fi

  check_command "virtualenvwrapper"
  if [ $? -ne 0 ]; then
    act "[Install] virtualenvwrapper"
    sudo -H pip3 install virtualenv
  fi
}

install_tools() {
  info "Install a couple frequently used tools"

  install_fzf
  install_pip3
  install_virtualenv
}


main() {
  echo "run from: $DOTFILES_PATH"
  echo "install to: $INSTALL_PATH"

  setup_color
  if ! check_omz; then
    return 1
  fi

  # TODO: uncomment when release
  #copy_config_files
  copy_theme
  # oh-my-zsh only
  install_plugins
  # other stuffs
  install_tools
}

main "$@"
