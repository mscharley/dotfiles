#!/bin/zsh

if [[ ! -f /etc/arch-release ]]; then
  return
fi

prepend-path $HOME/.bin/arch

if [[ -d $HOME/build || -d $HOME/opt/build ]]; then
  if [[ ! -f ${XDG_DATA_HOME:-$HOME/.local/share}/aur-update ]]; then
    echo "${fg[red]}Found an AUR build folder, but no update data available. Please configure aur-update in cron.${terminfo[sgr0]}"
    echo ""
  else
    source ${XDG_DATA_HOME:-$HOME/.local/share}/aur-update
  fi
fi
