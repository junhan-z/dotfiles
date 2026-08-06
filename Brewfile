# Only what the configs in this repo actually need.
#
#   brew bundle --file=Brewfile
#
# Deliberately not a snapshot of the whole machine -- project toolchains
# (aws, heroku, flutter, postgres, pyenv, ...) are installed per project,
# not here, so `brew bundle dump` would undo the point of this file.

brew "fnm"      # configs/zshrc: eval "$(fnm env)" -- also provides node/yarn
brew "fzf"      # configs/zshrc: source <(fzf --zsh)
brew "libpq"    # configs/zshrc puts its bin on PATH for psql
brew "tmux"     # host for configs/tmux.conf

cask "ghostty"  # host for ghostty/config

# Not listed on purpose:
#   git, vim  -- /usr/bin versions are what the configs use
#   yarn      -- comes from the fnm-managed node, not brew
#   tmux plugins, oh-my-zsh, tpm -- install.sh fetches those
