{ config, lib, ... }:
{
  programs.git = {
    enable = true;

    # Identity (`settings.user.{name,email}`) is deliberately not set here, it is required from
    # whoever consumes this module. See the assertion below. Signing is also left to the consumer
    # (`signing.{format,key,signer}`) since the signer depends on how 1Password is installed.
    signing.signByDefault = lib.mkDefault (config.programs.git.signing.key != null);

    settings = {
      core = {
        eol = "lf";
        autocrlf = false;
        compression = 9;
        loosecompression = 1;
        ignorecase = false;
      };
      init.defaultBranch = "main";
      checkout.defaultRemote = "origin";
      pull.rebase = false;
      push = {
        default = "upstream";
        autoSetupRemote = true;
      };
      rebase.autosquash = true;
      color = {
        diff = "auto";
        status = "auto";
        branch = "auto";
      };
      apply.whitespace = "nowarn";
      alias = {
        ff = "pull --ff-only";
        ff-merge = "merge --ff-only";
        recommit = "commit --amend";
        resign = "commit --amend --gpg-sign";
        workdir-or-cwd = "!echo $PWD";
        workdir = "rev-parse --show-toplevel";
        prune = "fetch --all --prune";
        explain = "log --pretty=oneline --patch";
        log-branch = "log --no-merges --first-parent";
        oneline-log = "log --pretty='%aI %h %s - %an <%ae>'";
        release-log = "log --first-parent --pretty=oneline --reverse";
        sync-master = "fetch origin master:master";
        sync = "fetch origin main:main";
        update-claude = "submodule update --remote .claude/shared";
      };
    };

    ignores = [
      # Editors and IDEs
      ".idea"
      "nbproject"
      ".redcar"
      ".metadata"
      ".classpath"
      ".project"
      ".settings"
      ".rakeTasks"
      ".ensime"
      "ensime.sbt"
      ".ensime_cache"
      ".nvim.lua"
      "atlassian-ide-plugin.xml"
      "*.iml"
      ".kateproject"
      ".kateproject.d"
      ".~lock.*"
      "*~"
      "/tags"
      "/TAGS"
      "/.tags_swap"

      # OS cruft
      "_notes"
      "thumbs.db"
      "Thumbs.db"
      ".DS_Store"
      ".nfs*"

      # Tool caches
      ".sass-cache"
      "fontconfig"
      ".versions.conf"

      # Other VCS and environments
      ".svn"
      ".hg"
      ".vagrant"

      # Claude
      "**/.claude/settings.local.json"
      "**/.claude/scheduled_tasks.lock"
      "*.local.md"
    ];
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
      # delta refuses to use `most` from $PAGER or $DELTA_PAGER and silently falls back to `less`. Only
      # its own `pager` option is honoured.
      pager = lib.getExe config.dotfiles.pager;
      # In `--color-only` mode (interactive.diffFilter, ie. `git add -p`) delta passes tabs through
      # untouched, and terminals don't paint background colour across the cells a tab skips. Expanding
      # them explicitly keeps the +/- highlighting continuous in hard-tab files.
      tabs = 4;
    };
  };

  assertions =
    let
      user = lib.attrByPath [ "user" ] { } config.programs.git.iniContent;
    in
    map
      (field: {
        assertion = (user.${field} or null) != null;
        message = "programs.git.settings.user.${field} must be set by whoever imports this module.";
      })
      [
        "name"
        "email"
      ];
}
