# Antigen: https://github.com/zsh-users/antigen
ANTIGEN="$HOME/.local/bin/antigen.zsh"

# Install antigen.zsh if not exist
if [ ! -f "$ANTIGEN" ]; then
    echo "Installing antigen ..."
    [ ! -d "$HOME/.local" ] && mkdir -p "$HOME/.local" 2> /dev/null
    [ ! -d "$HOME/.local/bin" ] && mkdir -p "$HOME/.local/bin" 2> /dev/null
    [ ! -f "$HOME/.z" ] && touch "$HOME/.z"
    URL="http://git.io/antigen"
    TMPFILE="/tmp/antigen.zsh"
    if [ -x "$(which curl)" ]; then
        curl -L "$URL" -o "$TMPFILE" 
    elif [ -x "$(which wget)" ]; then
        wget "$URL" -O "$TMPFILE" 
    else
        echo "ERROR: please install curl or wget before installation !!"
        exit
    fi
    if [ ! $? -eq 0 ]; then
        echo ""
        echo "ERROR: downloading antigen.zsh ($URL) failed !!"
        exit
    fi;
    echo "move $TMPFILE to $ANTIGEN"
    mv "$TMPFILE" "$ANTIGEN"
fi

source "$ANTIGEN"

# visit https://github.com/unixorn/awesome-zsh-plugins
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle command-not-find

antigen bundle colorize
antigen bundle github
antigen bundle python
antigen bundle z

antigen bundle junegunn/fzf
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions

antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme refined

antigen apply

if [ -f ~/nahnuj/work_config.zsh ]; then
  echo "Source work configs"
  . ~/nahnuj/work_config.zsh
fi

HOSTNAME=$(hostname)


export EDITOR=vim
export VISUAL=vim


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


# fzf: https://github.com/junegunn/fzf
FZF="$HOME/.fzf.zsh"
FZF_DIR="$HOME/.local/bin/fzf/"
if [ ! -f "$FZF" ]; then
    echo "Downloading fzf ..."
    [ ! -d "$HOME/.local/bin" ] && mkdir -p "$HOME/.local/bin" 2> /dev/null

    URL="https://github.com/junegunn/fzf.git"
    if [ -x "$(which git)" ]; then
        git clone --depth 1  "$URL" "$FZF_DIR" 
    fi

    if [ ! $? -eq 0 ]; then
        echo ""
        echo "ERROR: downloading fzf ($URL) failed!!"
        exit
    fi
    echo "Installing fzf"
    "$FZF_DIR/install"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
