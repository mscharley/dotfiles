#!/bin/zsh

function ssh() {
  case $XTERM in
    'gnome-terminal')
      $XTERM $XTERM_OPTIONS -e "ssh ${*[*]}"
      ;;
    *)
      command ssh $*
      ;;
  esac
}
