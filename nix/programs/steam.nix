{ pkgs, ... }:
{
  nixpkgs.config.packageOverrides = pkgs: {
    # XXX: unstable has lib32 deps broken.
    steam = let
      # steam = (import <nixos-20.03> { }).steam;
      steam = (import <nixos> { }).steam;
    in (steam.override {
      # nativeOnly = true; # use nixos-provided libraries, not steam's.
      extraPkgs = pkgs: with pkgs; [ mono gtk3 gtk3-x11 libgdiplus zlib steamPackages.steam-fonts ];
      # nativeOnly = true;
    });
  };

  home.packages = with pkgs; [
    steam
    steamPackages.steam-fonts
  ];
}
