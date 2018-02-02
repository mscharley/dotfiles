# Dotfiles

Matthew Scharley \<matt@scharley.me\>

## Installation (Docker)

Want to take this repo for a test run in a project?

    docker run -it --rm -v $(pwd):/home/ubuntu/$(basename `pwd`) mscharley/dotfiles

## Installation (\*nix/OS X)

    git clone git://github.com/mscharley/dotfiles ~/.dotfiles
    cd ~/.dotfiles
    ./install.pl

## Installation (Windows)

Still not automated. For now, copy the PowerShell profile to `$profile` in PowerShell
and make sure your execution policy allows for running it.
