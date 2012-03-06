#!/bin/zsh

function ssh() {
  if [[ -n $XTERM ]]; then
    case $XTERM in
      'gnome-terminal')
        $XTERM $XTERM_OPTIONS -e "ssh ${*[*]}"
        ;;
      *)
        env ssh $*
        ;;
    esac
  else
    # Execute ssh via env so that we get the real executable
    env ssh $*
  fi
}
