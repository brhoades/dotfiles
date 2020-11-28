{ ... }:
{
  home.packages = with (import <nixos-unstable> {}); [
    # wineWowPackages.stable
    # winetricks
  ];
}
