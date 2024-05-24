#!/usr/bin/env zsh

export ASDF_CONFIG_FILE="${XDG_CONFIG_HOME}/asdf/asdfrc"
export ASDF_DIR="${XDG_DATA_HOME}/asdf"
export ASDF_DATA_DIR="${XDG_CACHE_HOME}/asdf"

if [ -s "$ASDF_DIR" ]; then
	. "${ASDF_DIR}/asdf.sh"
else
	function init-asdf {
		git clone https://github.com/asdf-vm/asdf.git "$ASDF_DIR"
		pushd $ASDF_DIR &> /dev/null
		git checkout "$(git tag --sort version:refname | tail -n 1)"
		popd &> /dev/null
		. "${ASDF_DIR}/asdf.sh"

		asdf plugin add nodejs
		asdf plugin add ruby
	}
fi
