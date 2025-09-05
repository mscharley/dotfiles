export ASDF_CONFIG_FILE="$XDG_CONFIG_HOME/asdf/asdfrc"
export ASDF_DATA_DIR="$XDG_CACHE_HOME/asdf"
export ASDF_NODEJS_AUTO_ENABLE_COREPACK="true"

# ASDF configuration code
if test -z $ASDF_DATA_DIR
	set _asdf_shims "$HOME/.asdf/shims"
else
	set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
	set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims

# asdf shims hide the real path to where corepack installs the binaries.
abbr --add yarn "corepack yarn"
abbr --add yarnpkg "corepack yarnpkg"
abbr --add pnpm "corepack pnpm"
abbr --add pnpx "corepack pnpx"
abbr --add npm "corepack npm"
abbr --add npx "corepack npx"
