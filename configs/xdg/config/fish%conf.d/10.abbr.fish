if type podman &> /dev/null
	abbr --add docker podman
	abbr --add dc 'podman compose'
else
	abbr --add dc 'docker compose'
end
