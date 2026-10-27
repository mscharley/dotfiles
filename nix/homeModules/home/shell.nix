{
  config,
  lib,
  pkgs,
  ...
}:
# Environment and tooling shared by every shell. Anything that needs a runtime decision lives in the
# per-shell modules (see shell-common.nix); everything else is evaluated here once, for bash, fish and zsh alike.
let
  configs = ../../../configs;
  inherit (pkgs.stdenv.hostPlatform) isDarwin;
  xdg = config.xdg;
in
{
  home.sessionVariables = lib.optionalAttrs isDarwin {
    # Node (and so Claude Code) doesn't read the system keychain; point it at the nix-darwin managed bundle, which is
    # the same file as NIX_SSL_CERT_FILE. Spelled out because that variable may not be set yet when this is sourced.
    NODE_EXTRA_CA_CERTS = "/etc/ssl/certs/ca-certificates.crt";
  } // {
    TZ = "Australia/Melbourne";
    LANG = "en_US.UTF-8";
    PAGER = lib.getExe config.dotfiles.pager;
    EDITOR = lib.getExe config.dotfiles.editor;
    GIT_EDITOR = "$EDITOR";
    CODE_HOME = lib.mkDefault "$HOME/Code";

    # ls colours: LSCOLORS = BSD, LS_COLORS = GNU (set by programs.dircolors).
    # https://geoff.greer.fm/lscolors/
    CLICOLOR = "1";
    LSCOLORS = "exgxfxdxcxDaDaCBcDEcEc";

    # Load some overrides for bash scripts.
    BASH_ENV = "$HOME/.bashenv";

    # Configure xz compression to smartly use available processing capacity.
    XZ_DEFAULTS = "-T 0";

    # Backport XDG into applications that can support it implicitly through configuration.
    DOCKER_CONFIG = "${xdg.configHome}/docker";
    ELINKS_CONFDIR = "${xdg.configHome}/elinks";
    ICEAUTHORITY = "${xdg.cacheHome}/ICEauthority";
    SCREENRC = "${xdg.configHome}/screen/screenrc";
    NODE_REPL_HISTORY = "${xdg.dataHome}/node/repl_history";
    NPM_CONFIG_USERCONFIG = "${xdg.configHome}/npm/npmrc";
    CARGO_HOME = "${xdg.dataHome}/cargo";
    RUSTUP_HOME = "${xdg.dataHome}/rustup";
    # hm-session-vars wraps values in double quotes without escaping, so these can't be quoted themselves.
    PERL_MB_OPT = "--install_base ${xdg.dataHome}/perl5";
    PERL_MM_OPT = "INSTALL_BASE=${xdg.dataHome}/perl5";

    ASDF_CONFIG_FILE = "${xdg.configHome}/asdf/asdfrc";
    ASDF_DATA_DIR = "${xdg.cacheHome}/asdf";
    ASDF_NODEJS_AUTO_ENABLE_COREPACK = "true";

    HOMEBREW_BUNDLE_FILE = "${xdg.configHome}/homebrew/Brewfile";
    HOMEBREW_INSTALL_BADGE = "🦄";
  };

  # XDG_*_HOME are exported by home-manager itself (xdg.enable is on in legacy.nix).
  home.sessionPath = [
    xdg.binHome
    "${xdg.dataHome}/perl5/bin"
    "${xdg.dataHome}/cargo/bin"
    "${xdg.cacheHome}/asdf/shims"
  ];

  # On darwin the BSD tools stay the named tools. GNU coreutils is deliberately not put on PATH.
  home.shellAliases = {
    ls = if isDarwin then "ls -GF" else "ls --color=auto -F";
    ll = if isDarwin then "ls -la@h" else "ls -lAh";
    la = "ls -A";
    nix-gc = "nix-collect-garbage --delete-older-than 14d";
  };

  home.file.".bashenv".text = ''
    PS4='+ '
  '';

  programs.dircolors = {
    enable = true;
    extraConfig = builtins.readFile (configs + "/xdg/config/dircolors");
  };

  # Only fish uses starship; bash and zsh keep the prompts they've always had.
  programs.starship = {
    enable = lib.mkDefault config.programs.fish.enable;
    enableTransience = true;
    enableBashIntegration = false;
    enableZshIntegration = false;
  };
}
