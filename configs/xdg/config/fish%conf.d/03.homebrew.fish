if test -d /home/linuxbrew/.linuxbrew
	# Homebrew is installed on Linux

	set -gx HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew"
	set -gx HOMEBREW_CELLAR "/home/linuxbrew/.linuxbrew/Cellar"
	set -gx HOMEBREW_REPOSITORY "/home/linuxbrew/.linuxbrew/Homebrew"
	set -gx PATH "/home/linuxbrew/.linuxbrew/bin" "/home/linuxbrew/.linuxbrew/sbin" $PATH
	set -q MANPATH; or set MANPATH ''
	set -gx MANPATH "/home/linuxbrew/.linuxbrew/share/man" $MANPATH
	set -q INFOPATH; or set INFOPATH ''
	set -gx INFOPATH "/home/linuxbrew/.linuxbrew/share/info" $INFOPATH

	# Homebrew asked for this in order to `brew upgrade`
	#set -gx HOMEBREW_GITHUB_API_TOKEN {api token goes here, don't remember where that's created}
else if test -d /opt/homebrew
	# Homebrew is installed on MacOS

	/opt/homebrew/bin/brew shellenv | source
end
