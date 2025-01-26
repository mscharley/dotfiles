#!/usr/bin/env bash

echo
echo '!!! !!! !!! !!! !!! !!! !!! !!! !!! !!! !!! !!! !!! !!! !!! !!! !!! !!! !!! !!! !!! !!! !!! !!! !!! !!!'
if [ -n "$WAYLAND_DISPLAY" -o -n "$DISPLAY" ]; then
	echo 'This system appears to be a graphical terminal, you should run `fish -c init-desktop` to finish initialisation.'
else
	echo 'This system appears to be a server, you should run `fish -c init-terminal` to finish initialisation.'
fi
echo '!!! !!! !!! !!! !!! !!! !!! !!! !!! !!! !!! !!! !!! !!! !!! !!! !!! !!! !!! !!! !!! !!! !!! !!! !!! !!!'
