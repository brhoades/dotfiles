{ pkgs, config, ... }: {
  imports = [
    ../common.nix
    ../../programs/development.nix
    ../../programs/emacs.nix

    ../../programs/desktop.nix
    ../../programs/steam.nix
    ../../services/desktop.nix
    ../../services/keybase.nix

    ../../modules/desktop-laptop-sync.nix
    ../../modules/update-latest-symlink.nix
  ];

  user = {
    name = "Billy J Rhoades II";
    email = "me@brod.es";
    signing = { key = "F372D673E3A1FCFA!"; };
  };

  brodes = {
    windowManager = {
      i3status_rs = {
        # x1 carbon display, eDP-1
        output = ''"Chimei Innolux Corporation 0x14E4 0x00000000"'';
        blocks = {
          net = {
            enable = true;
            device = "wlp0s20f3";
            format = "{signal_strength} {ssid}";
          };

          battery.enable = true;
          backlight = {
            enable = true;
            invertIcons = true; # otherwise it's bright when dim
          };

          temperature = {
            enable = true;
            device = "coretemp-isa-0000";
          };

          bluetooth = {
            enable = true;
            mac = "28:11:A5:35:50:04";
            label = " QC35";
          };

          weather = {
            enable = true;
            autolocate = false;
            service = ''
              { name = "openweathermap", place = "Seattle", api_key = "${config.xdg.configHome}/openweathermap/key", units = "imperial" }'';
          };
        };
      };

      swayidle = {
        enable = true;
        dpms.enable = true;

        lock = {
          idle = {
            enable = true;
            timeout = 900;
          };
          sleep.enable = true;
        };
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
