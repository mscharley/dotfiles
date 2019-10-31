#!/usr/bin/env zsh

function ssh() {
  [ -z $DISPLAY ] && unset XTERM
  case $XTERM in
    'gnome-terminal') $XTERM $XTERM_OPTIONS -e "ssh ${*[*]}";;
    'konsole') $XTERM $XTERM_OPTIONS -e ssh ${*[*]};;
    *)
      command ssh $*
      ;;
  esac
}

function no_tmux() {
  case $XTERM in
    'gnome-terminal') USE_TMUX=false $XTERM $XTERM_OPTIONS;;
    'konsole') USE_TMUX=false $XTERM $XTERM_OPTIONS;;
  esac
}
