if status is-interactive
	# Commands to run in interactive sessions can go here
	if type podman &> /dev/null
		abbr --add docker podman
		abbr --add dc 'podman compose'
	else
		abbr --add dc 'docker compose'
	end

	if type gls &> /dev/null
		alias ls="gls --color=tty -F"
	else
		alias ls="ls --color=tty -F"
	end
	alias ll="ls -lAh"
end
