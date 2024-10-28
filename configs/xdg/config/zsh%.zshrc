#!/usr/bin/env zsh

# Run order.
# 1. zshenv (scripts finish here)
# 2. zprofile (login shells only)
# 3. zshrc
# 4. zlogin (login shells only)
# ...
# ?. zshlogout (maybe)

setopt NULL_GLOB

# Load subscripts
for f in $ZDOTDIR/rc.d/*.zsh; do
  [ -x $f ] && source $f
done

unset i
unset f
unsetopt NULL_GLOB
