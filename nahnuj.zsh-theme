NEWLINE=$'\n'
PROMPT='%{$fg_bold[yellow]%}%2~%{$reset_color%}'
PROMPT+="%{$fg[white]%} [@%m][%W %T]${NEWLINE}"
PROMPT+="%(?:%{$fg_bold[green]%}> :%{$fg_bold[red]%}> )%{$reset_color%}"
