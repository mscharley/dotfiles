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
  changing anything. `~/.bash` is worse: it is a link to a directory in the checkout, so with a backup extension set
  anything that tried to write inside it would rename the files in your checkout to `*.backup`.
- Neovim and the `git-cleanup`/`git-cleanup-remotes`/`git-main` scripts come from Nix packages instead, so their
  old `install.pl` links aren't replaced. The command above removes those as well.
- Bash and fish are configured and enabled by this module through `programs.{bash,fish}`, instead of linking the
  `install.pl` files (`~/.profile`, `~/.bashrc`, `~/.config/fish/*` and so on). The command above removes the old
  links. Zsh is fully configured but opt-in: set `programs.zsh.enable = true` to turn it on. Customise the shells from
  your home-manager configuration, since the `.local` files (`~/.bashrc.local`, `fish/functions.local`, `.zshrc.local`)
  are not read.
- On darwin the BSD tools stay the named tools; GNU coreutils is not put on `PATH`.

### Checks

`nix flake check` builds the home module twice, once with the defaults and once with `programs.zsh.enable = true`
(zsh is opt-in, so nothing else would evaluate it). The neovim package depends on `barbar.nvim`, which is unfree, and
this flake doesn't allow it itself, so run the checks with:

```shell
NIXPKGS_ALLOW_UNFREE=1 nix flake check --impure
```

## Installation (Windows)

Still not automated. For now, copy the PowerShell profile to `$profile` in PowerShell
and make sure your execution policy allows for running it.
