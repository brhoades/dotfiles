{ pkgs, ... }:

{
  imports = [
    ./kitty.nix
    ./password-manager.nix
    ./firefox.nix
    ./wayland
    ./i3.nix
    ./i3status_rs.nix
    ./chat.nix
  ];

  # Home Manager setup
  home.sessionVariables = {
    # java apps in TWM don't reize right without this
    _JAVA_AWT_WM_NONREPARENTING = 1;
  };

  home.packages = with pkgs; [
    # feh use imv
    imv
    pavucontrol

    # (chromium.override { enableVaapi = true; })
    google-chrome
    thunderbird

    barrier
    xorg.xrandr
    xorg.xkill
    scrot

    fira-code
    fira-code-symbols
    roboto

    nixfmt

    # i3-status-rust requires 4
    font-awesome_4
    lm_sensors # i3-status-rust queries for temps

    xfce.thunar
    xfce.xfconf
    xfce.tumbler

    vlc
    evince
    # libreoffice 2022/02/27 - broken
    ffmpeg-full
    imagemagick
    gimp

    p7zip
    unzip
    ncdu

    qmk
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

    extraConfig = {
      run-shell-command = ''{terminal} -e zsh -c "{cmd}'';
      run-command = "${pkgs.zsh}/bin/zsh -i -c '{cmd}'";
      window-command = "xkill -id {window}";

      # sort = true;
      # sorting-method = "fzf";
      matching = "normal";

      # https://github.com/davatorium/rofi/wiki/WindowPosition
      position = 6;
    };
  };

  xresources.properties = {
    # This mirrors ikaia's DPI.
    "Xft.dpi" = 96;
    "*.dpi" = 96;
    "Xft.antialias" = true;
    # "Xft.hinting" = 1;
    "XTerm.vt100.saveLines" = 81920;
    "XTerm.vt100.foreground" = "white";
    "XTerm.vt100.background" = "black";
    "XTerm*faceName" = "Fira Code";
    "*.vt100.metaSendsEscape" = "true"; # allow alt
    "XTerm*vt100.translations" = ''
      #override \
          Shift Ctrl <Key> C: copy-selection(CLIPBOARD) \n\
          Shift Ctrl <Key> V: insert-selection(CLIPBOARD)'';
    "XTerm.*backarrowKey" = "false";
  };

  xsession = {
    numlock.enable = true;
    pointerCursor = {
      name = "Vanilla-DMZ";
      package = pkgs.vanilla-dmz;
      size = 32;
    };
  };

}

