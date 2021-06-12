setopt prompt_subst

NEWLINE=$'\n'

function brackets {
  # wrap a pair of gray brackets around the text
  echo -e "%{$FG[240]%}[${1}%{$FG[240]%}]%{$reset_color%}"
}

function show_path {
  brackets "%{$FG[004]%}%(4~|/../%2~|%~)"
}

function show_cpu_arch {
  arch_name="$(uname -m)"
  colored_arch_name="%{$FG[011]%}${arch_name}"

  if [ "${arch_name}" = "x86_64" ]; then
    colored_arch_name="%{$FG[010]%}${arch_name}"
  fi

  # [arch_name]
  brackets $colored_arch_name
}

function show_hostname {
  brackets "@%m"
}

function show_time {
  brackets "%W %T"
}

PROMPT="$(show_path)"
PROMPT+="$(show_cpu_arch)$(show_hostname)$(show_time)${NEWLINE}"
PROMPT+="%(?:%{$fg_bold[green]%}> :%{$fg_bold[red]%}> )%{$reset_color%}"
