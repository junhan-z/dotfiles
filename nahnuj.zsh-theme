setopt prompt_subst

function show_cpu_arch {
  arch_name="$(uname -m)"
  echo "${arch_name}"
}

NEWLINE=$'\n'
PROMPT="%{$FG[012]%}%(4~|/../%2~|%~)%{$reset_color%}"
PROMPT+="%{$FG[240]%} [@%m][%W %T]${NEWLINE}"
PROMPT+="[$(show_cpu_arch)] "
PROMPT+="%(?:%{$fg_bold[green]%}> :%{$fg_bold[red]%}> )%{$reset_color%}"
