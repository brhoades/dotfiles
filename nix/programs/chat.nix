{ pkgs, ... }:

{
  nixpkgs.config.packageOverrides = _pkgs:
    {
      # XXX: discord update breaks everything.
      # discord = import ../../../nixpkgs/pkgs/applications/networking/instant-messengers/discord { inherit pkgs; };
    };

  home.packages = with pkgs; [ signal-desktop discord slack ];
}
