{ pkgs, ... }: {
  imports = [
    ../common.nix
    ../../programs/development.nix
    ../../programs/emacs.nix

    ../../programs/desktop.nix
    ../../services/desktop.nix
    ../../services/keybase.nix
  ];

  user = {
    name = "Billy J Rhoades II";
    email = "me@brod.es";
    signing = { key = "F372D673E3A1FCFA!"; };
  };

  brodes = {
    windowManager.i3status_rs.blocks = {
      net = {
        enable = true;
        device = "wlp0s20f3";
        format = "{signal_strength} {ssid}";
      };

      battery.enable = true;

      temperature = {
        enable = true;
        device = "coretemp-isa-0000";
      };

      bluetooth = {
        enable = true;
        mac = "28:11:A5:35:50:04";
        label = " QC35";
      };
    };
  };

  home = {
    packages = with pkgs; [
      iw # used by i3status_rs to query rates
      networkmanager # nmtui nmcli
    ];

    username = "aaron";
    homeDirectory = "/home/aaron";

    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "20.09";
  };
}
