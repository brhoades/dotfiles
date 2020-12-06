
{ pkgs, ... }:

{
  nixpkgs.config.packageOverrides = _pkgs: {
    # XXX: until 0.13 hits stable
    discord = import ../../../nixpkgs/pkgs/applications/networking/instant-messengers/discord { inherit pkgs; };
  };

  home.packages = with pkgs; [
    signal-desktop discord slack
  ];
}
