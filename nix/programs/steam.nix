{ pkgs, ... }:
{
  # nixpkgs.config.packageOverrides = pkgs: {
  # steam = let
  # steam = (import <nixos> { }).steam;
  # steam = (import <nixpkgs> { }).steam;
  # in (steam.override {
  # nativeOnly = true; # use nixos-provided libraries, not steam's.
  # extraPkgs = pkgs:
  # with pkgs; [
  # mono
  # gtk3
  # gtk3-x11
  # libgdiplus
  # zlib
  # steamPackages.steam-fonts
  # ];
  # });
  # };

  # programs.steam.enable = true;
  # home.packages = with pkgs; [ steam steamPackages.steam-fonts ];
}
