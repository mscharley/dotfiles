#!/bin/zsh

function ssh() {
  if [[ -n $XTERM ]]; then
    case $XTERM in
      'gnome-terminal')
        $XTERM $XTERM_OPTIONS -e "ssh ${*[*]}"
        ;;
      *)
        command ssh $*
        ;;
    esac
  else
    command ssh $*
  fi
}
