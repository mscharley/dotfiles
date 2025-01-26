export ASDF_CONFIG_FILE="$XDG_CONFIG_HOME/asdf/asdfrc"
export ASDF_DIR="$XDG_DATA_HOME/asdf"
export ASDF_DATA_DIR="$XDG_CACHE_HOME/asdf"
export ASDF_NODEJS_AUTO_ENABLE_COREPACK="true"

if test -s "$ASDF_DIR"
	if ! test -e "$ASDF_DIR/completions/asdf.fish"
		ln -s "$ASDF_DIR/completions/asdf.fish" "$XDG_CONFIG_HOME/fish/completions/asdf.fish"
	end
	source "$ASDF_DIR/asdf.fish"

	# asdf shims hide the real path to where corepack installs the binaries.
	abbr --add yarn "corepack yarn"
	abbr --add yarnpkg "corepack yarnpkg"
	abbr --add pnpm "corepack pnpm"
	abbr --add pnpx "corepack pnpx"
	abbr --add npm "corepack npm"
	abbr --add npx "corepack npx"
else
	function init-asdf
		git clone https://github.com/asdf-vm/asdf.git "$ASDF_DIR"
		pushd $ASDF_DIR &> /dev/null
		git checkout "$(git tag --sort version:refname | tail -n 1)"
		popd &> /dev/null
		ln -s "$ASDF_DIR/completions/asdf.fish" "$XDG_CONFIG_HOME/fish/completions/asdf.fish"
		source "$ASDF_DIR/asdf.fish"

		asdf plugin add nodejs
		asdf plugin add ruby

		# asdf shims hide the real path to where corepack installs the binaries.
		abbr --add yarn "corepack yarn"
		abbr --add yarnpkg "corepack yarnpkg"
		abbr --add pnpm "corepack pnpm"
		abbr --add pnpx "corepack pnpx"
		abbr --add npm "corepack npm"
		abbr --add npx "corepack npx"
	end
end
