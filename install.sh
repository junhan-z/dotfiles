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

colored_print() {
  color=$1
  msg=$2
  printf "${color}${msg}${RESET}"
}

info() {
  colored_print ${BLUE} "$1\n"
}

act() {
  colored_print ${BOLD} "$1\n"
}

warn() {
  colored_print ${YELLOW} "$1\n"
}

error() {
  colored_print ${RED}${BOLD} "$1\n"
}

ask() {
  vared -p "${BOLD}$1${RESET} [Y/n]: " -c ans
  if [[ ${ans} =~ ^[Yy]$ ]]; then
    return 1
  elif [[ ${ans} =~ ^[Nn]$ ]]; then
    return 0
  fi

  return 1
}

check_omz() {
  # must go first as some ENVs depends on this
  if [[ -z "$ZSH" ]]; then
    error "install.sh relies on oh-my-zsh\n"
    act "Go to ${BOLD}${GREEN}https://ohmyz.sh/#install${RESET} and install oh-my-zsh before continue."
    return 1
  fi
  return 0
}

build_symbol_link() {
	local src_file=$1
	local dst_file=$2
	
	if test -e "$dst_file"; then
		warn "${dst_file} already exists."
		warn "[Remove] ${dst_file}."
		rm ${dst_file}
	fi
	# TODO: it behaves a bit differently when symbol link a directory
	ln -s "${src_file}" "${dst_file}"
	act "[Create] $TO -> $FROM.\n"
}

link_config_files() {
  CONFIGS=($(ls "$DOTFILES_PATH/configs"))
  local select_files=$1

  info "Create symbol links."
  for f in "${CONFIGS[@]}"
  do
    local FROM="$DOTFILES_PATH/configs/$f"
    local TO="$INSTALL_PATH/.$f"

    if [ ${select_files} = "all" ]; then
      build_symbol_link ${FROM} ${TO}
    elif [ $select_files = "select" ]; then
      ask "  - Link ${f}?"
      if [ $? -eq 1 ]; then
        build_symbol_link ${FROM} ${TO}
      fi
    fi
  done

}

link_theme() {
  info "Add a custom theme"
  local FROM="$DOTFILES_PATH/nahnuj.zsh-theme"
  local TO="$INSTALL_PATH/.oh-my-zsh/themes/nahnuj.zsh-theme"

  build_symbol_link ${FROM} ${TO}
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
  info "run from: $DOTFILES_PATH"
  info "install to: $INSTALL_PATH"

  setup_color
  if ! check_omz; then
    return 1
  fi

  ask "Link all the config files?"
  if [ $? -eq 1 ]; then
    link_config_files "all"
  else 
    ask "  - OK! Only Link selected files then?"
    if [ $? -eq 1 ]; then 
      link_config_files "select" 
    else
      info "Skip linking files..."
    fi
  fi

  ask "Would you like to try my 'nahnuj' theme? :p"
  if [ $? -eq 1 ]; then
    link_theme
  else
    info "Sad to see you leave, try it next time!"
  fi

  # oh-my-zsh only
  ask "Install oh-my-zsh plugins?"
  if [ $? -eq 1 ]; then
    install_plugins
  fi

  # other stuffs
  ask "Install frequently used tools?"
  if [ $? -eq 1 ]; then
    install_tools
  fi
}

main "$@"
