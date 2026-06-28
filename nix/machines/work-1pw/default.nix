{ pkgs, config, ... }: {
  imports = [
    ../common.nix
    ../../programs/desktop.nix
    ../../programs/development.nix
    ../../services/desktop.nix
    ../../programs/emacs

    ../../modules/update-latest-symlink.nix

    ../../services/desktop.nix
  ];

  home.packages = with pkgs; [
    mosh
    nix-index
  ];

  user = {
    name = "Billy J Rhoades II";
    email = "brhoades@agilebits.com";
    signing = {
      key = "F372D673E3A1FCFA!";
    };
  };

  home.username = "billy";
  home.homeDirectory = "/home/billy";
  home.stateVersion = "26.05";

  brodes = {
    windowManager = {
      monitors.primary = "DP-3";

      i3status_rs = {
        output = ''"DP-3"'';
        blocks = {
          net = {
            enable = true;
            device = "enx0c3796854659";
          };

          # networkmanager.enable = true;
          battery.enable = true;
          temperature = {
            enable = true;
            device = "*-isa-0000";
          };

          # bluetooth.enable = true;

          microphone.enable = true;
          notify.enable = false;

          # weather = {
          #   enable = true;
          #   autolocate = false;
          #   service = ''
          #     { name = "openweathermap", place = "Seattle", api_key = "${config.xdg.configHome}/openweathermap/key", units = "imperial" }'';
          # };
        };
      };

      lockCmd = "swaylock \"${config.brodes.windowManager.swaylock.background}\" -F -e -c grey --indicator-idle-visible";

      swayidle = {
        enable = true;
        dpms.enable = true;

        lock = {
          idle = {
            enable = true;
            timeout = 6000;
            cmd = "swayidle -f"; # use Debian's, NixOS never accepts pw
          };
          sleep.enable = true;
        };
      };
    };
  };
}
