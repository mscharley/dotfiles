export HOMEBREW_BUNDLE_FILE=$XDG_CONFIG_HOME/homebrew/Brewfile
export HOMEBREW_INSTALL_BADGE="🦄"

if test -d /home/linuxbrew/.linuxbrew
	# Homebrew is installed on Linux
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else if test -d /opt/homebrew
	# Homebrew is installed on MacOS
	eval "$(/opt/homebrew/bin/brew shellenv)"
end
