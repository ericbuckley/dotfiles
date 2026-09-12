#!/usr/bin/env bash
set -euo pipefail

current_session=${1:-}
current_style=${2:-fg=blue,bold}
other_style=${3:-fg=white}
used_keys=''

# Filter PI-* sessions before assigning underkeys. Filtering the rendered
# output afterward allows hidden sessions to consume shortcut keys.
while IFS= read -r session_name; do
  [[ $session_name == PI-* ]] && continue

  session_lower=$(printf '%s' "$session_name" | tr '[:upper:]' '[:lower:]')
  key=''
  index=-1

  for ((i = 0; i < ${#session_name}; i++)); do
    char=${session_lower:i:1}

    if [[ $char =~ [a-z0-9] && $used_keys != *"$char"* ]]; then
      key=$char
      index=$i
      used_keys+=$char
      break
    fi
  done

  if [[ $session_name == "$current_session" ]]; then
    style=$current_style
  else
    style=$other_style
  fi

  printf '#[%s]' "$style"
  if (( index >= 0 )); then
    printf '%s' "${session_name:0:index}"
    printf '#[underscore]%s#[nounderscore,%s]' "${session_name:index:1}" "$style"
    printf '%s' "${session_name:index + 1}"
  else
    printf '%s' "$session_name"
  fi
  printf '#[default] '
done < <(tmux list-sessions -F '#{session_name}')
