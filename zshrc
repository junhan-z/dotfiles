if [[ -s "{$HOME}/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"]]; then
  source "{$HOME}/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# Keybindings
bindkey -v
export KEYTIMEOUT=1

bindkey '^w' backward-kill-word
bindkey '^d' delete-char
bindkey '^k' kill-line

bindkey '^p' up-history
bindkey '^n' down-history
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward
bindkey '^s' history-incremental-search-forward

bindkey '^f' forward-char
bindkey '^b' backward-char
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
