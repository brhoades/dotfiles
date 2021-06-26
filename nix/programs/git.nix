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

        merge = { tool = "ediff"; };

        "protocol \"keybase\"" = { allow = "always"; };
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

    home.packages = with pkgs; [ delta ];
  };
}
