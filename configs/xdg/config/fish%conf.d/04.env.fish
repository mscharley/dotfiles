# This file mostly emulates the code in ~/.profile

# Setup environment
export TZ="Australia/Melbourne"
if type most &> /dev/null
	export PAGER="most"
else
	export PAGER="less"
end
if type nvim &> /dev/null
	export EDITOR=nvim
else
	export EDITOR=vim
end

# ls colors - LSCOLORS = BSD, LS_COLORS = GNU.
# https://geoff.greer.fm/lscolors/
export CLICOLOR=1
export LSCOLORS="exgxfxdxcxDaDaCBcDEcEc"
if type gdircolors &> /dev/null
	eval ( gdircolors -c $XDG_CONFIG_HOME/dircolors )
	export LS_COLORS
else if type dircolors &> /dev/null
	eval ( dircolors -c $XDG_CONFIG_HOME/dircolors )
	export LS_COLORS
else
	export LS_COLORS="rs=0:di=34:ln=36:so=35:pi=33:ex=32:bd=1;33;40:cd=1;33;40:su=1;32;1;41:sg=32;1;43:tw=1;34;42:ow=1;34;42"
end
