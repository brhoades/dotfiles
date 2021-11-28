{ pkgs, ... }:
let

  smlpkgs = import <nixos-unstable-small> { };
in {
  nixpkgs.config.packageOverrides = pkgs: {
    steam = (pkgs.steam.override {
      nativeOnly = true; # use nixos-provided libraries, not steam's.
      extraPkgs = (_:
        with smlpkgs; [
          mono
          gtk3
          gtk3-x11
          libgdiplus
          zlib
          steamPackages.steam-fonts
        ]);
    });
  };

  home.packages = with smlpkgs; [ steam steamPackages.steam-fonts ];
}
