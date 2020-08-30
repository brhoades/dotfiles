{ pkgs, ... }:

{
  imports = [
    ./kitty.nix
    ./password-manager.nix
    ./firefox.nix
    ./i3.nix
  ];

  home.packages = with pkgs; [
    feh 
    pavucontrol

    google-chrome
    thunderbird

    signal-desktop discord slack

    barrier
    xorg.xrandr xorg.xkill scrot

    fira fira-code fira-code-symbols roboto

    # i3-status-rust requires 4
    font-awesome_4
    lm_sensors # i3-status-rust queries for temps
  ];

  gtk = {
    enable = false;
    font = {
      package = pkgs.roboto;
      name = "Roboto 12";
    };
  };

  fonts.fontconfig.enable = true;

  programs.rofi = {
    enable = true;

    theme = "Monokai";

    extraConfig = ''
      run-shell-command: {terminal} -e zsh -c "{cmd}"
      rofi.run-command: ${pkgs.zsh}/bin/zsh -i -c '{cmd}'
      rofi.glob: true
      rofi.regex: true
      rofi.window-command:                 xkill -id {window}
    '';

  };

  xresources.properties = {
    # This mirrors ikaia's DPI.
    "Xft.dpi" = 192; 
    "*.dpi" = 192; 
    "Xft.antialias" = true;
    # "Xft.hinting" = 1;
  };

  xsession = {
    numlock.enable = true;
    pointerCursor = {
      name = "Vanilla-DMZ";
      package = pkgs.vanilla-dmz;
      size = 64;  
    };
  };

}

