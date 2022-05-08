{ config, pkgs, ... }:

{
  imports = [
    ../common.nix
    ../../programs/desktop.nix
    ../../programs/development.nix
    ../../services/desktop.nix
    ../../programs/steam.nix
    ../../programs/emacs.nix
    ../../programs/wine.nix
    ../../programs/dlux.nix
    ../../programs/bup.nix
    ../../programs/runelite.nix
    ./msmtp.nix
  ];

  user = {
    name = "Billy J Rhoades II";
    email = "me@brod.es";
    signing = { key = "6D052A5305F89A0E!"; };
  };

  brodes = {
    windowManager = {
      i3status_rs = {
        output = ''"Dell Inc. DELL U2917W 0PRH475QA29L"'';
        blocks = {
          net = {
            enable = true;
            device = "enp4s0";
          };

          temperature = {
            enable = true;
            device = "zenpower-pci-00c3";
          };

          bluetooth = {
            enable = true;
            mac = "28:11:A5:35:50:04";
            label = "QC35";
          };

          microphone.enable = true;
          notify.enable = false;

          weather = {
            enable = true;
            autolocate = false;
            service = ''
              { name = "openweathermap", place = "Seattle", api_key = "${
                builtins.readFile
                "${pkgs.inputs.user-secrets}/openweathermapkey"
              }", units = "imperial" }'';
          };
        };
      };

      swayidle = {
        enable = true;
        dpms.enable = true;

        lock = {
          idle = {
            enable = true;
            timeout = 6000;
          };
          sleep.enable = true;
        };
      };
    };

    xdgHack = {
      enable = true;
      configFile = "${pkgs.inputs.user-secrets}/xdghack.json";
    };
  };

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "aaron";
  home.homeDirectory = "/home/aaron";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.09";
}
