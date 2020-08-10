{ pkgs, ... }:
{
  imports = [
    ./zsh.nix
    ./tmux.nix
    ./pazi.nix
    ./direnv.nix
    ./vim.nix
  ];

  home.packages = with pkgs; [
    ytop
  ];
}
