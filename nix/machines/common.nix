{ config, pkgs, ... }:

{
  imports = [ ../modules/default.nix ../programs/default.nix ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
  # Don't notify-send on every switch.
  news.display = "silent";

  programs.zsh = {
    enable = true;
    enableCompletion = true;
  };

  home.sessionVariables = let editor = "vim";
  in {
    EDITOR = editor;
    GIT_EDITOR = editor;
    TERM = "alacritty";
  };

  # broken in 2022/12
  # https://github.com/NixOS/nixpkgs/issues/196651 maybe?
  # manual.manpages.enable = false;
}
