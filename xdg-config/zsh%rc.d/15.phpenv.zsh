#!/usr/bin/env zsh

export PHPENV_ROOT=$XDG_CACHE_HOME/phpenv
if [[ (! -d $PHPENV_ROOT) ]]; then
	function get-phpenv {
		git clone https://github.com/phpenv/phpenv.git $PHPENV_ROOT
		git clone https://github.com/php-build/php-build $PHPENV_ROOT/plugins/php-build
		git clone https://github.com/ngyuki/phpenv-composer.git $PHPENV_ROOT/plugins/phpenv-composer
		echo You will need to reload your shell now.
	}
else
	prepend-path "$PHPENV_ROOT/bin"
	eval "$(phpenv init -)"
fi
