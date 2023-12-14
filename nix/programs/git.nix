{ config, lib, pkgs, ... }:

let user = config.user;
in {
  options.user = with lib; {
    name = mkOption {
      type = types.str;
      default = "Billy J Rhoades II";
    };

    email = mkOption {
      type = types.str;
      default = "me@brod.es";
    };

    signing = {
      force = mkOption {
        type = types.bool;
        default = false;
      };

      key = mkOption { type = types.nullOr types.str; };
    };
  };

  config = {
    programs.git = {
      enable = true;

      userName = user.name;
      userEmail = user.email;

      signing = {
        key = user.signing.key;
        signByDefault = user.signing.force;
      };

      extraConfig = {
        color = { ui = "auto"; };

        push = { default = "simple"; };

        credential = { helper = "cache --timeout=28800"; };

        merge = {
          tool = "vimdiff";
          conflictstyle = "diff3";
        };

        pull.ff = "only";

        "protocol \"keybase\"" = { allow = "always"; };

        init.defaultBrancch = "main";
      };

      ignores = [
        "/testers/"
        ".LOCAL$"
        "/.dir-locals.el"
        "/.ruby-version"
        "*.bak"
        "/.projectile"
        "/.ignore"
        "/.gitconfig"
        "node_modules"
        ".solargraph.yml"
      ];
    };

    home.packages = with pkgs; [ delta github-cli git-machete hub ];
    programs.zsh.shellAliases = {
      git = "hub";
      gm = "git machete";
    };

    programs.lazygit.enable = true;
  };
}
