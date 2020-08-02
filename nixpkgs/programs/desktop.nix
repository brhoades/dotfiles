{ pkgs, ... }:

{
  imports = [
    ./kitty.nix
    ./password-manager.nix
  ];

  home.packages = with pkgs; [
    feh fira
  ];

  gtk = {
    enable = false;
    font = {
      package = pkgs.fira;
      name = "Fira Code 10";
    };
  };
}
