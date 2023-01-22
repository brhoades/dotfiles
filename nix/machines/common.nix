{ config, pkgs, ... }:

{
  imports =
    [ ../modules/default.nix ../programs/default.nix ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
  # Don't notify-send on every switch.
  news.display = "silent";

  programs.zsh.enableCompletion = true;

  home.sessionVariables = let editor = "vim";
  in {
    EDITOR = editor;
    GIT_EDITOR = editor;
    TERM = "screen-256color";
  };

  home.packages = with pkgs; [
    git
    wget
    rsync
    httpie
    curl
    perl
    nnn
    bat
    ripgrep
    rename # perl rename, not busybox.
    tmux
    screen

    inetutils
    htop
    lsof
    pciutils
  ] ++ (if lib.strings.hasInfix "linux" pkgs.system then [
    iotop
    ngrok
  ] else []);

  # broken in 2022/12
  # https://github.com/NixOS/nixpkgs/issues/196651 maybe?
  manual.manpages.enable = false;
}
