#!/bin/bash
#
# Set up this dotfiles checkout on a new machine.
#
# Everything here is idempotent: re-running only touches what is actually
# out of date, and anything it would clobber gets moved aside first rather
# than deleted. Run with --yes for an unattended install.

set -euo pipefail

# Resolve the repo from the script's own location, not the caller's cwd,
# so `~/projects/dotfiles/install.sh` works from anywhere. BASH_SOURCE is
# undefined under `zsh install.sh`, hence the $0 fallback.
DOTFILES_PATH="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
INSTALL_PATH="$HOME"
BACKUP_SUFFIX="backup.$(date +%Y%m%d%H%M%S)"

ASSUME_YES=0

usage() {
  cat <<'EOF'
Usage: ./install.sh [options]

Options:
  -y, --yes    Answer yes to every prompt (unattended install)
  -h, --help   Show this message

Steps are prompted individually; each one is safe to re-run. Files that
would be overwritten are renamed to <name>.backup.<timestamp> instead.
EOF
}

parse_args() {
  while [ $# -gt 0 ]; do
    case "$1" in
      -y|--yes)  ASSUME_YES=1 ;;
      -h|--help) usage; exit 0 ;;
      *)         echo "Unknown option: $1" >&2; usage >&2; exit 1 ;;
    esac
    shift
  done
}

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
  printf "%s%b%s" "$1" "$2" "$RESET"
}

info() { colored_print "$BLUE" "$1\n"; }
act()  { colored_print "$BOLD" "$1\n"; }
warn() { colored_print "$YELLOW" "$1\n"; }
error() { colored_print "${RED}${BOLD}" "$1\n" >&2; }

# Returns 0 for yes, 1 for no -- the usual shell convention, so callers
# read as `if ask "..."; then`. Defaults to yes on an empty answer.
ask() {
  local prompt="$1" ans=""

  if [ "$ASSUME_YES" -eq 1 ]; then
    act "$prompt [Y/n]: y"
    return 0
  fi

  # No stdin (piped install) means nothing can be answered interactively.
  if [ ! -t 0 ]; then
    act "$prompt [Y/n]: y (no tty)"
    return 0
  fi

  printf "%s%s%s [Y/n]: " "$BOLD" "$prompt" "$RESET"
  read -r ans
  case "$ans" in
    [Nn]*) return 1 ;;
    *)     return 0 ;;
  esac
}

# Point dst at src. Skips when already correct, backs up whatever is in
# the way otherwise. Handles directories, which plain `rm` does not.
build_symbol_link() {
  local src="$1" dst="$2"

  if [ ! -e "$src" ]; then
    error "[Error] source missing: $src"
    return 1
  fi

  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    act "[Skip]   $dst -> $src"
    return 0
  fi

  # -e is false for a broken symlink, so test -L separately.
  if [ -e "$dst" ] || [ -L "$dst" ]; then
    warn "[Backup] $dst -> $dst.$BACKUP_SUFFIX"
    mv "$dst" "$dst.$BACKUP_SUFFIX"
  fi

  mkdir -p "$(dirname "$dst")"
  ln -s "$src" "$dst"
  act "[Create] $dst -> $src"
}

link_config_files() {
  local select_files="$1" f name

  info "Create symbol links."
  # Glob rather than parse ls, so names with spaces survive.
  for f in "$DOTFILES_PATH"/configs/*; do
    name="$(basename "$f")"

    if [ "$select_files" = "all" ]; then
      build_symbol_link "$f" "$INSTALL_PATH/.$name"
    elif ask "  - Link ${name}?"; then
      build_symbol_link "$f" "$INSTALL_PATH/.$name"
    fi
  done
}

link_zsh_theme() {
  info "Add the customized zsh theme"
  # Only makes the theme available; zshrc still picks which one is active
  # via ZSH_THEME, and currently that is robbyrussell.
  build_symbol_link "$DOTFILES_PATH/themes/nahnuj.zsh-theme" \
    "${ZSH_CUSTOM:-${ZSH:-$HOME/.oh-my-zsh}/custom}/themes/nahnuj.zsh-theme"
}

link_ghostty_config() {
  info "Link the ghostty config"
  # Kept out of configs/ because link_config_files maps every entry there to
  # ~/.<name>, and ghostty reads ~/.config/ghostty/config instead.
  build_symbol_link "$DOTFILES_PATH/ghostty/config" \
    "$INSTALL_PATH/.config/ghostty/config"
}

install_homebrew() {
  if command -v brew >/dev/null 2>&1; then
    act "[Skip]   homebrew installed"
  else
    act "[Install] homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  # A fresh Apple-silicon install is not on PATH until the shell is
  # re-sourced, so make brew reachable for the rest of this run.
  if ! command -v brew >/dev/null 2>&1 && [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
}

install_brew_bundle() {
  if ! command -v brew >/dev/null 2>&1; then
    warn "[Skip]   homebrew not available, cannot run brew bundle"
    return 0
  fi
  info "Install everything in the Brewfile"
  # A single unavailable formula should not abort the whole install.
  brew bundle --file="$DOTFILES_PATH/Brewfile" || warn "brew bundle reported errors, continuing"
}

install_omz() {
  if [ -d "${ZSH:-$HOME/.oh-my-zsh}" ]; then
    act "[Skip]   oh-my-zsh installed"
    return 0
  fi
  act "[Install] oh-my-zsh"
  # Unattended, or its installer replaces .zshrc and starts a new shell,
  # which would abandon the rest of this script.
  RUNZSH=no KEEP_ZSHRC=yes sh -c \
    "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

install_plugins() {
  info "Install a couple oh-my-zsh plugins"
  local plugins_dir="${ZSH_CUSTOM:-${ZSH:-$HOME/.oh-my-zsh}/custom}/plugins"
  local plugins=("zsh-syntax-highlighting" "zsh-autosuggestions")
  local p

  for p in "${plugins[@]}"; do
    if [ -d "$plugins_dir/$p" ]; then
      act "[Skip]   $p"
    else
      act "[Install] $p"
      git clone --depth 1 "https://github.com/zsh-users/$p.git" "$plugins_dir/$p"
    fi
  done
}

install_tpm() {
  local tpm_dir="$HOME/.tmux/plugins/tpm"
  if [ -d "$tpm_dir" ]; then
    act "[Skip]   tpm"
  else
    act "[Install] tpm (tmux plugin manager)"
    git clone --depth 1 https://github.com/tmux-plugins/tpm "$tpm_dir"
  fi
}

install_tools() {
  info "Install a couple frequently used tools"
  install_tpm
}

doctor() {
  info "Checking the commands zshrc expects"
  local c
  for c in git zsh tmux vim fzf fnm; do
    if command -v "$c" >/dev/null 2>&1; then
      act "  [ok]      $c"
    else
      warn "  [missing] $c"
    fi
  done
}

main() {
  parse_args "$@"
  setup_color

  info "run from:   $DOTFILES_PATH"
  info "install to: $INSTALL_PATH"

  if ask "Install homebrew and everything in the Brewfile?"; then
    install_homebrew
    install_brew_bundle
  fi

  if ask "Install oh-my-zsh?"; then
    install_omz
  fi

  if ask "Link all the config files?"; then
    link_config_files "all"
  elif ask "  - OK! Only link selected files then?"; then
    link_config_files "select"
  else
    info "Skip linking files..."
  fi

  if ask "Link the ghostty config?"; then
    link_ghostty_config
  fi

  if [ -d "${ZSH:-$HOME/.oh-my-zsh}" ] && ask "Link the custom zsh theme?"; then
    link_zsh_theme
  fi

  if [ -d "${ZSH:-$HOME/.oh-my-zsh}" ] && ask "Install oh-my-zsh plugins?"; then
    install_plugins
  fi

  if ask "Install frequently used tools?"; then
    install_tools
  fi

  doctor
  info "Done. Open a new shell, or: exec zsh"
}

main "$@"
