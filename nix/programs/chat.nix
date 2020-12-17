
{ pkgs, ... }:

{
  nixpkgs.config.packageOverrides = _pkgs: {
    # For future discord upgrades...
    # discord = import ../../../nixpkgs/pkgs/applications/networking/instant-messengers/discord { inherit pkgs; };
  };

  home.packages = with pkgs; [
    signal-desktop discord slack
  ];
}
