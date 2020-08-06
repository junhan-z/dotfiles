NEWLINE=$'\n'
PROMPT='%{$fg_bold[yellow]%}%2~%{$reset_color%} $(git_prompt_info)'
PROMPT+="%{$fg[blue]%}@%m %{$fg[grey]%}[%W %T]${NEWLINE}"
PROMPT+="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )%{$reset_color%}"


ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
