{ pkgs, ... }:
{
  nixpkgs.overlays = [
    (self: super: rec {
      zoomUsFixed = super.overrideAttrs (old: {
        postFixup = old.postFixup + ''
          wrapProgram $out/bin/zoom-us --unset XDG_SESSION_TYPE
        '';});
      zoom-us = super.zoom-us.overrideAttrs (old: {
        postFixup = old.postFixup + ''
          wrapProgram $out/bin/zoom --unset XDG_SESSION_TYPE
        '';});
      zoom = zoom-us;
    })

  ];

  home.packages = with pkgs; [
    zoom-us
  ];
}
