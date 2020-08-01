{ config, pkgs, ... }:

{
  imports = [
    ../modules/default.nix
    ../programs/default.nix
    ../services/desktop.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
  # Don't notify-send on every switch.
  news.display = "silent";

  programs.zsh.enableCompletion = true;

  home.sessionVariables.EDITOR = "vim";
  home.packages = with pkgs; [
    git
    wget rsync httpie curl
    vim
    perl
    nnn bat
    ripgrep rename # perl rename, not busybox.
    tmux screen

    telnet
    htop iotop
    lsof
    pciutils

    ngrok
  ];
}
