setopt prompt_subst

NEWLINE=$'\n'
PROMPT='%{$FG[012]%}%(4~|/../%2~|%~)%{$reset_color%}'
PROMPT+="%{$FG[240]%} [@%m][%W %T]${NEWLINE}"
PROMPT+="%(?:%{$fg_bold[green]%}> :%{$fg_bold[red]%}> )%{$reset_color%}"
