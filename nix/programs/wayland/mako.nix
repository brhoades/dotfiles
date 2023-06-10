{ lib, config, pkgs, ... }: {
  services.mako = {
    enable = true;

    font = "Roboto 12";
    anchor = "top-center";
    margin = "1"; # distance from top
    padding = "2"; # interior

    defaultTimeout = 5 * 1000;
    maxVisible = 1;

    output = config.brodes.windowManager.monitors.primary;

    # ../default.nix wayland
    # AA for slightly transparent
    backgroundColor = "#222222AA";
    textColor = "#FFFFFFFF";
    borderColor = "#333333BB";

    icons = false;
  };

  home.packages = with pkgs;
    [
      libnotify # notify-send
    ];

  # 2023/06/10: previously, mako would not come back up when its config
  # was swapped. Maybe now that it's a service it's fine?
  # xdg.configFile."mako/config".onChange =
  #   lib.mkIf config.programs.mako.enable ''
  #     systemctl --user restart mako.service
  #   '';
}
