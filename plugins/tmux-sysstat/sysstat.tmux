#!/usr/bin/env bash

SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1
  pwd -P
)"
SCRIPTNAME="${SCRIPTNAME:-$(basename "$0")}"
source "${SCRIPTPATH}/scripts/helpers.sh"

declare -A module

module[net]="${SCRIPTPATH}/scripts/net.sh"
module[battery]="${SCRIPTPATH}/scripts/battery.sh"
module[cpu]="${SCRIPTPATH}/scripts/cpu.sh"
module[date]="${SCRIPTPATH}/scripts/date.sh"
module[disk]="${SCRIPTPATH}/scripts/disk.sh"
module[git]="${SCRIPTPATH}/scripts/git.sh"
module[hostname]="${SCRIPTPATH}/scripts/hostname.sh"
module[mem]="${SCRIPTPATH}/scripts/mem.sh"
module[mode_indicator]="${SCRIPTPATH}/scripts/mode_indicator.sh"
module[online]="${SCRIPTPATH}/scripts/online.sh"
module[session]="${SCRIPTPATH}/scripts/session.sh"
module[uptime]="${SCRIPTPATH}/scripts/uptime.sh"
module[window]="${SCRIPTPATH}/scripts/window.sh"

main() {
  # local nb_cols=$(($(tput cols) / 2 - 1))
  update_tmux_option "status-right"
  update_tmux_option "status-left"
  update_tmux_option "window-status-format"
  update_tmux_option "window-status-current-format"

  if [[ "$*" =~ \-v ]]; then
    for segment in "${module[@]}"; do
      "${segment}"
    done
  fi

  #set_tmux_option "status-right-length" "${nb_cols}"
  #set_tmux_option "status-left-length" "${nb_cols}"
}

main "$@"
