#!/bin/zsh

is_cygwin() {
  local uname
  # Check we're running under cygwin
  uname=`uname -s`
  [[ $uname[0,6] == 'CYGWIN' ]]
}

is_not_cygwin() {
  is_cygwin
  [[ "$?" == "1" ]]
}

if is_not_cygwin; then
  return
fi

# Kill Windows paths by default. If you need these, add them to your
# zshrc.local manually.
NEWPATH=()
for p in ${(s.:.)PATH}; do
  if [[ $p[0,10] != "/cygdrive/" ]]; then
    NEWPATH+=($p)
  fi
done
PATH=${(j.:.)NEWPATH}
unset NEWPATH

# Set up a rebaseall function. This will fire up the ash shell and
# start a rebaseall. Will kill the current shell when complete out of necesity.
rebaseall() {
  exec ash -c "PATH=/bin rebaseall -v;exec zsh -l"
}

# Unset GIT_SSH. This variable controls which SSH application git uses for
# ssh remote repo's, and this can be set to a Windows application (plink)
# by some installers. If needed in cygwin, you should set this in .zshrc.local

unset GIT_SSH

