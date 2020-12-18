setopt prompt_subst

NEWLINE=$'\n'
PROMPT='%{$FG[012]%}$(shrink_path -f)%{$reset_color%}'
PROMPT+="%{$FG[240]%} [@%m][%W %T]${NEWLINE}"
PROMPT+="%(?:%{$fg_bold[green]%}> :%{$fg_bold[red]%}> )%{$reset_color%}"
