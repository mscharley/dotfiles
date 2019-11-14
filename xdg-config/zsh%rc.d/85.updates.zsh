#!/usr/bin/env zsh

if parent-ide > /dev/null; then
  return
fi

dotfiles_dir="$(realpath ${0:a:h}/../..)/.git"
if [[ ! -e "$dotfiles_dir" ]]; then
  return
fi

git_opts=(--git-dir "$dotfiles_dir")

if [[ -n $(git $git_opts remote | grep updates) ]]; then
  UPDATES=$(git $git_opts log --oneline --no-patch HEAD..updates/master)

  if [[ $(echo -n $UPDATES | wc -l) -gt 0 ]]; then
    echo "${fg[yellow]}Updates for dotfiles detected."
    echo
    echo $UPDATES
    echo "${terminfo[sgr0]}"
  fi
else
  git $git_opts remote add updates https://github.com/mscharley/dotfiles.git
fi

git $git_opts fetch updates &> /dev/null &!

unset dotfiles_dir
unset git_opts
unset UPDATES
