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
    email = "billy.rhoades@agilebits.com";
    signing = {
      key = "F372D673E3A1FCFA!";
    };
  };

  home.username = "billy";
  home.homeDirectory = "/home/billy";
  home.stateVersion = "26.05";

  # debian instead of nixos
  targets.genericLinux.enable = true;

  # debian instead of nixos
  systemd.user.sessionVariables = {
    PATH = "${config.home.homeDirectory}/.nix-profile/bin:/nix/var/nix/profiles/default/bin:\${PATH}";
    MOZ_ENABLE_WAYLAND = "1";
  };

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

      lockCmd = "swaylock -i \"${config.brodes.windowManager.swaylock.background}\" -F -e -c grey --indicator-idle-visible";

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
  };

  wayland.windowManager.sway.extraConfig = ''
    input "1133:16517:Logitech_G604" {
      accel_profile adaptive
      scroll_factor 0.4 # wheel too sensitive
    }
  '';
}
