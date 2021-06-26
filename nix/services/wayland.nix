{ pkgs, ... }:

{
  home.packages = with pkgs;
    [
      # swaylock
      # swayidle
      # xwayland
    ];

  wayland.windowManager.sway = { enable = false; };
}
