{ pkgs, config, ... }: {
  imports = [
    ../common.nix
    ../../programs/development.nix
    ../../programs/emacs
    ../../programs/bup.nix

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
      monitors.primary = "eDP-1";

      i3status_rs = {
        # x1 carbon display, eDP-1
        output = ''"Chimei Innolux Corporation 0x14E4 0x00000000"'';
        blocks = {
          net = {
            enable = true;
            format =
              "$ssid $signal_strength ^icon_net_down $speed_down.eng(3,B,K) ^icon_net_up $speed_up.eng(3,B,K) ";
            device = "wlan0";
          };

          battery.enable = true;
          backlight = {
            enable = true;
            invertIcons = true; # otherwise it's bright when dim
          };

          temperature = {
            enable = true;
            interval = 2;
            device = "coretemp-isa-0000";
          };

          bluetooth = {
            enable = true;
            mac = "28:11:A5:35:50:04";
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

  # 2023/04/17
  # multiple keyboards defined in sway config causes firefox crashes on reload.
  # and it has for over a year.
  # we'll define them on each machine until it's fixed :shrug:.
  # https://bugzilla.mozilla.org/show_bug.cgi?id=1652820#c28
  wayland.windowManager.sway.extraConfig = ''
    # x1carbon keyboard
    input "1:1:AT_Translated_Set_2_keyboard" {
      xkb_layout us
      xkb_variant altgr-intl
      xkb_options ctrl:nocaps
      xkb_numlock enabled
    }
  '';

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
