[ -f  "{$HOME}/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] \
  && source "{$HOME}/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

if [ -f ~/nahnuj/work_config.zsh ]; then
  echo "Source work configs"
  . ~/nahnuj/work_config.zsh
fi

export EDITOR=vim
export VISUAL=vim

autoload -Uz promptinit
promptinit
prompt pure

# Keybindings
bindkey -v
export KEYTIMEOUT=1

bindkey '^w' backward-kill-word
bindkey '^d' delete-char
bindkey '^k' kill-line
bindkey '^h' backward-delete-char

bindkey '^r' history-incremental-search-backward
bindkey '^s' history-incremental-search-forward
bindkey '^p' up-history
bindkey '^n' down-history

bindkey '^f' forward-char
bindkey '^b' backward-char
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

HOSTNAME=$(hostname)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
