setopt prompt_subst

color_by_number() {
  number=${1}
  echo "%{$FG[${number}]%}"
}

color_by_name() {
  name=${1}
  font=${2}
  if [ "${font}" = "bold" ]; then
    echo "%{$fg_bold[${name}]%}"
  else
    echo "%{$fg[${name}]%}"
  fi
}

NEWLINE=$'\n'
BRACKET_COLOR=$(color_by_number "240")
TEXT_COLOR=$(color_by_number "240")
RESET_COLOR="%{$reset_color%}"

# curl -s https://gist.githubusercontent.com/HaleTom/89ffe32783f89f403bba96bd7bcd1263/raw/ | bash
# to show colors

brackets() {
  # wrap a pair of gray brackets around the text
  echo -e "${BRACKET_COLOR}[${TEXT_COLOR}${1}${BRACKET_COLOR}]${RESET_COLOR}"
}

# prompt components

show_path() {
  TEXT_COLOR=$(color_by_name "blue" "bold")
  brackets "%(4~|/../%2~|%~)"
}

# show_jobs() {
#   brackets "%jjobs"
# }

show_cpu_arch() {
  TEXT_COLOR=$(color_by_name "yellow" "bold")
  arch_name="$(uname -m)"
  if [ "${arch_name}" = "x86_64" ]; then
    TEXT_COLOR=$(color_by_name "cyan")
  fi

  brackets $arch_name
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
  echo "└$(color_by_name 'green')>"
}

error() {
  echo "└$(color_by_name 'red')x"
}

# some useful indicators
gcert_status() {
  if which gcertstatus > /dev/null; then
    gcertstatus > /dev/null;
    retVal=$?

    if [ $retVal -ne 0 ]; then
      TEXT_COLOR=$(color_by_name "yellow")
      brackets "Need Gcert"
    else
      TEXT_COLOR=$(color_by_name "green")
      brackets "G"
    fi
  fi
}

PROMPT="┌$(show_path)$(gcert_status) | "
PROMPT+="$(show_cpu_arch)-$(show_hostname)-$(show_time)${NEWLINE}"
PROMPT+="%(?:$(ok) :$(error) )%{$reset_color%}"
