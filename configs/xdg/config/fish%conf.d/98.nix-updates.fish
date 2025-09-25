if test -e $CODE_HOME/mscharley/nixos
	# Last modified more than one week ago (in seconds)
	if test (path mtime --relative $CODE_HOME/mscharley/nixos/flake.lock) -ge 604800
		echo (set_color --bold brred)"Updates for NixOS available."(set_color reset)
		echo
	end
end
