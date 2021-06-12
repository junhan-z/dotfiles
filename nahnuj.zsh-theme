setopt prompt_subst

NEWLINE=$'\n'

# defualt bracket color: gray
BRACKET_FG="240"

brackets() {
  # wrap a pair of gray brackets around the text
  echo -e "%{$FG[${BRACKET_FG}]%}[${1}%{$FG[${BRACKET_FG}]%}]%{$reset_color%}"
}

show_path() {
  brackets "%{$fg_bold[blue]%}%(4~|/../%2~|%~)"
}

show_cpu_arch() {
  arch_name="$(uname -m)"
  colored_arch_name="%{$fg[yellow]%}${arch_name}"

  if [ "${arch_name}" = "x86_64" ]; then
    colored_arch_name="%{$fg[green]%}${arch_name}"
  fi

  BRACKET_FG="015"
  brackets $colored_arch_name
}

show_hostname() {
  brackets "@%m"
}

show_time() {
  brackets "%W %T"
}

# Need powerline fonts
right_triangle() {
   echo $'\ue0b0'
}

arrow_start() {
  echo "%{$FG[$ARROW_FG]%}%{$BG[$ARROW_BG]%}%B"
}
arrow_end() {
   echo "%b%{$reset_color%}%{$FG[$NEXT_ARROW_FG]%}%{$BG[$NEXT_ARROW_BG]%}$(right_triangle)%{$reset_color%}"
}

ok() {
  echo "%{$fg_bold[green]%}>"
}

error() {
  echo "%{$fg_bold[red]%}x"
}

PROMPT="$(show_path) | "
PROMPT+="$(show_cpu_arch)-$(show_hostname)-$(show_time)${NEWLINE}"
PROMPT+="%(?:$(ok) :$(error) )%{$reset_color%}"
