# Dotfiles

Matthew Scharley \<matt@scharley.me\>

## Installation (Docker)

Want to take this repo for a test run in a project?

    docker run -it --rm -v $(pwd):/home/ubuntu/$(basename `pwd`) ghcr.io/mscharley/dotfiles

## Installation (\*nix/OS X)

    git clone https://github.com/mscharley/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
    ./install.pl

### XDG support

If you wish to use non-standard XDG base directories, make sure to export `$XDG_CONFIG_HOME`, `$XDG_BIN_HOME` and `$XDG_DATA_HOME` before running the installer.

## Installation (Windows)

Still not automated. For now, copy the PowerShell profile to `$profile` in PowerShell
and make sure your execution policy allows for running it.
