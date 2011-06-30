#!/bin/zsh

# Check we're running under cygwin
UNAME=`uname -s`
[[ $UNAME[0,6] == 'CYGWIN' ]]
CYGWIN=$?
unset $UNAME
if [[ $CYGWIN == 1 ]]; then
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

