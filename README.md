# Dotfiles

Matthew Scharley \<matt@scharley.me\>

## Installation (Docker)

Want to take this repo for a test run in a project?

```shell
docker run -it --rm -v $(pwd):/home/ubuntu/$(basename `pwd`) ghcr.io/mscharley/dotfiles
```

## Installation (\*nix/OS X)

```shell
git clone https://github.com/mscharley/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.pl
```

### XDG support

If you wish to use non-standard XDG base directories, make sure to export `$XDG_CONFIG_HOME`, `$XDG_BIN_HOME` and `$XDG_DATA_HOME` before running the installer.

## Installation (Nix / home-manager)

Import `homeModules.home` from this flake into your home-manager configuration and set
`programs.git.settings.user.{name,email}`. It links the same files `install.pl` does, seeds the `.example` files once
(without overwriting existing copies) and writes `~/.config/dotfiles/home-manager`, after which `install.pl` refuses
to run.

Use Nix **or** `install.pl`, never both. If you are migrating from `install.pl`:

- Remove the old `install.pl` links before the first switch. This only deletes symlinks that point into the checkout's
  `configs/` directory, and asks about each one (adjust the path if your checkout isn't in `~/Code/mscharley/dotfiles`):

  ```shell
  find ~ -maxdepth 5 -not -path '*/Code/*' -not -path '*/.cache/*' -lname '*/path/to/dotfiles/configs/*' -exec rm -i \{\} \;
  ```

  Your shell configuration is missing until the switch finishes, so run the switch straight afterwards.
- `home-manager.backupFileExtension` is not a substitute for this. Home-manager skips old links whose contents already
  match, but refuses to replace directory links such as `~/.config/fish/conf.d`, and the whole switch fails without
  changing anything. `~/.bash` is worse: it is a link to a directory in the checkout and home-manager links the files
  inside it individually, so with a backup extension set it would rename the files in your checkout to `*.backup`.
- Neovim and the `git-cleanup`/`git-cleanup-remotes`/`git-main` scripts come from Nix packages instead, so their
  old `install.pl` links aren't replaced. The command above removes those as well.
- Don't enable `programs.{fish,zsh,bash,...}` in home-manager alongside this module, they'd collide with the linked
  shell configuration.

## Installation (Windows)

Still not automated. For now, copy the PowerShell profile to `$profile` in PowerShell
and make sure your execution policy allows for running it.
